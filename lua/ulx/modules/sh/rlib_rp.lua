/*
*   @package        : rcore
*   @module         : base
*	@extends		: ulx
*   @author         : Richard [http://steamcommunity.com/profiles/76561198135875727]
*   @copyright      : (c) 2018 - 2020
*   @since          : 1.0.0
*   @website        : https://rlib.io
*   @docs           : https://docs.rlib.io
*
*   MIT License
*
*   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
*   LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
*   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
*   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
*   WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

/*
*   standard tables and localization
*/

local base                  = rlib
local helper                = base.h
local access                = base.a

/*
*   module calls
*/

local mod, pf       	    = base.modules:req( 'base' )
local cfg               	= base.modules:cfg( mod )
local smsg                  = base.settings.smsg

/*
*   Localized translation func
*/

local function ln( ... )
    return base:translate( mod, ... )
end

/*
*   get access perm
*
*   @param  : str id
*	@return	: tbl
*/

local function perm( id )
    return access:getperm( id, mod )
end

/*
*   declare perm ids
*/

local id_setjob             = perm( 'rlib_rp_setjob' )
local id_setjob_cmd         = perm( 'rlib_rp_setjob_cmd' )
local id_getjob             = perm( 'rlib_rp_getjob' )

/*
*   check dependency
*
*   @param  : ply pl
*   @param  : str p
*/

local function checkDependency( pl, p )
    if not base or not base.modules:bInstalled( mod ) then
        p                   = isstring( p ) and helper.ok.str( p ) or istable( p ) and ( p.ulx or p.id ) or 'unknown command'
        local msg           = { smsg.clrs.t2, p, smsg.clrs.msg, '\nAn error has occured with the library. Contact the developer or sys admin.' }
        pl:push             ( '', 'Critical Error', 7, msg )
        return false
    end
    return true
end

/*
*   ulx > options > jobs
*/

ulx.lst_jobs = { }
local function populate_jobs( )
    for i, v in pairs( RPExtraTeams ) do
        table.insert( ulx.lst_jobs, v.command )
    end
end
rhook.new.rlib( 'rlib_initialize_post', 'rlib_ulx_jobs_populate', populate_jobs )

/*
*   ulx > rp > get job
*
*	forces a player to a specified rp job based on the job command defined
*
*   this is an alternative to darkrp_setjob since that command relies on the name which can
*   cause complications of multiple jobs contain similar names. whereas this method ensures the
*   correct job is found
*
*   @param	: ply call_pl
*   @param  : ply targ_pl
*   @param  : str job
*/

function ulx.rlib_rp_getjob( call_pl, targ_pl, job )
    if not checkDependency( call_pl, id_getjob ) then return end

    if not RPExtraTeams then
        base.msg:route( call_pl, false, id_getjob.id, 'RP jobs table missing -- are you running darkrp?' )
        return
    end

    base.msg:route( call_pl, false, id_getjob.id, 'player:', smsg.clrs.t3, targ_pl:palias( ), smsg.clrs.msg, 'job id:', smsg.clrs.t3, tostring( targ_pl:Team( ) ), smsg.clrs.msg, 'job name:', smsg.clrs.t3, tostring( team.GetName( targ_pl:Team( ) ) ) )
end
local rlib_rp_getjob                    = ulx.command( id_getjob.category, id_getjob.ulx_id, ulx.rlib_rp_getjob, id_getjob.pubcmds )
rlib_rp_getjob:addParam                 { type = ULib.cmds.PlayerArg }
rlib_rp_getjob:defaultAccess            ( access:ulx( id_getjob ) )
rlib_rp_getjob:help                     ( id_getjob.desc )

/*
*   ulx > rp > set job
*
*	forces a player to a specified rp job based on the job command defined
*
*   this is an alternative to darkrp_setjob since that command relies on the name which can
*   cause complications of multiple jobs contain similar names. whereas this method ensures the
*   correct job is found
*
*   @param	: ply call_pl
*   @param  : ply targ_pl
*   @param  : str job
*/

function ulx.rlib_rp_setjob( call_pl, targ_pl, job )
    if not checkDependency( call_pl, id_setjob ) then return end

    if not RPExtraTeams then
        base.msg:route( call_pl, false, id_setjob.id, 'RP jobs table missing -- are you running darkrp?' )
        return
    end

    local job_c, job_res = helper.who:rpjob_custom( job )
    if not job_c or job_c == 0 then
        base.msg:route( call_pl, false, id_setjob.id, 'Specified job with command does not exist' )
        return
    end

    local job_new = job_res[ 0 ]

    local n_num, n_job = nil, nil
    for i, v in pairs( RPExtraTeams ) do
        if v.command:lower( ) == job_new.command:lower( ) then
            n_num = i
            n_job = v
        end
    end

    targ_pl:updateJob           ( n_job.name    )
    targ_pl:setSelfDarkRPVar    ( 'salary', n_job.salary )
    targ_pl:SetTeam             ( n_num         )

    GAMEMODE:PlayerSetModel     ( targ_pl       )
    GAMEMODE:PlayerLoadout      ( targ_pl       )

    base.msg:route( call_pl, false, id_setjob.id, 'Forced player', smsg.clrs.t3, targ_pl:palias( ), smsg.clrs.msg, 'to job', smsg.clrs.t3, n_job.name )
    base.msg:route( targ_pl, false, id_setjob.id, 'You have been forced to job', smsg.clrs.t3, n_job.name )

end
local rlib_rp_setjob                    = ulx.command( id_setjob.category, id_setjob.ulx_id, ulx.rlib_rp_setjob, id_setjob.pubcmds )
rlib_rp_setjob:addParam                 { type = ULib.cmds.PlayerArg }
rlib_rp_setjob:addParam                 { type = ULib.cmds.StringArg, completes = ulx.lst_jobs, hint = 'select job...', error = 'invalid option \"%s\" specified', ULib.cmds.restrictToCompletes }
rlib_rp_setjob:defaultAccess            ( access:ulx( id_setjob ) )
rlib_rp_setjob:help                     ( id_setjob.desc )

/*
*   ulx > rp > set job
*
*	forces a player to a specified rp job based on the job command defined
*
*   this is an alternative to darkrp_setjob since that command relies on the name which can
*   cause complications of multiple jobs contain similar names. whereas this method ensures the
*   correct job is found
*
*   @param	: ply call_pl
*   @param  : ply targ_pl
*   @param  : str job
*/

function ulx.rlib_rp_setjob_cmd( call_pl, targ_pl, job )
    if not checkDependency( call_pl, id_setjob ) then return end

    if not RPExtraTeams then
        base.msg:route( call_pl, false, id_setjob.id, 'RP jobs table missing -- are you running darkrp?' )
        return
    end

    local job_c, job_res = helper.who:rpjob_custom( job )
    if not job_c or job_c == 0 then
        base.msg:route( call_pl, false, id_setjob.id, 'Specified job with command does not exist' )
        return
    end

    local job_new = job_res[ 0 ]

    local n_num, n_job = nil, nil
    for i, v in pairs( RPExtraTeams ) do
        if v.command:lower( ) == job_new.command:lower( ) then
            n_num = i
            n_job = v
        end
    end

    targ_pl:updateJob           ( n_job.name    )
    targ_pl:setSelfDarkRPVar    ( 'salary', n_job.salary )
    targ_pl:SetTeam             ( n_num         )

    GAMEMODE:PlayerSetModel     ( targ_pl       )
    GAMEMODE:PlayerLoadout      ( targ_pl       )

    base.msg:route( call_pl, false, id_setjob.id, 'Forced player', smsg.clrs.t3, targ_pl:palias( ), smsg.clrs.msg, 'to job', smsg.clrs.t3, n_job.name )
    base.msg:route( targ_pl, false, id_setjob.id, 'You have been forced to job', smsg.clrs.t3, n_job.name )

end
local rlib_rp_setjob_cmd                = ulx.command( id_setjob_cmd.category, id_setjob_cmd.ulx_id, ulx.rlib_rp_setjob_cmd, id_setjob_cmd.pubcmds )
rlib_rp_setjob_cmd:addParam             { type = ULib.cmds.PlayerArg }
rlib_rp_setjob_cmd:addParam             { type = ULib.cmds.StringArg, hint = 'job cmd', ULib.cmds.takeRestOfLine }
rlib_rp_setjob_cmd:defaultAccess        ( access:ulx( id_setjob_cmd ) )
rlib_rp_setjob_cmd:help                 ( id_setjob_cmd.desc )