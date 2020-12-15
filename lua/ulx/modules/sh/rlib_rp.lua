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

/*
*   req module
*/

if not mod then return end

/*
*   Localized translation func
*/

local function lang( ... )
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

local id_setjob             = perm( 'rcore_rp_setjob' )
local id_getjob             = perm( 'rcore_rp_getjob' )

/*
*   check dependency
*
*   @param  : ply pl
*   @param  : str pid
*/

local function checkDependency( pl, pid )
    if not base or not base.modules:bInstalled( mod ) then
        local cat = perm( pid ).category or base.get:name( )
        base.msg:target( pl, cat, 'An error has occured with a required dependency. Contact the developer and we will summon the elves.' )
        return false
    end
    return true
end

/*
*   ulx :: rp :: get job
*
*	forces a player to a specified rp job based on the job command defined
*
*   this is an alternative to darkrp_setjob since that command relies on the name which can
*   cause complications of multiple jobs contain similar names. whereas this method ensures the
*   correct job is found
*
*   @param	: ply calling_ply
*   @param  : ply target_ply
*   @param  : str job
*/

function ulx.rcore_rp_getjob( calling_ply, target_ply, job )
    if not checkDependency( calling_pl, 'rcore_rp_getjob' ) then return end

    if not RPExtraTeams then
        base.msg:route( calling_ply, false, id_setjob.id, 'RP jobs table missing -- are you running darkrp?' )
        return
    end

    base.msg:route( calling_ply, false, id_setjob.id, 'player:', base.settings.smsg.clrs.t3, target_ply:Name( ), base.settings.smsg.clrs.msg, 'job id:', base.settings.smsg.clrs.t3, tostring( target_ply:Team( ) ), base.settings.smsg.clrs.msg, 'job name:', base.settings.smsg.clrs.t3, tostring( team.GetName( target_ply:Team( ) ) ) )
end
local rcore_rp_getjob                       = ulx.command( id_getjob.category, id_getjob.ulx_id, ulx.rcore_rp_getjob, id_getjob.pubcmds )
rcore_rp_getjob:addParam                    { type = ULib.cmds.PlayerArg }
rcore_rp_getjob:defaultAccess               ( access:ulx( 'rcore_rp_getjob', mod ) )
rcore_rp_getjob:help                        ( id_setjob.desc )

/*
*   ulx :: rp :: set job
*
*	forces a player to a specified rp job based on the job command defined
*
*   this is an alternative to darkrp_setjob since that command relies on the name which can
*   cause complications of multiple jobs contain similar names. whereas this method ensures the
*   correct job is found
*
*   @param	: ply calling_ply
*   @param  : ply target_ply
*   @param  : str job
*/

function ulx.rcore_rp_setjob( calling_ply, target_ply, job )
    if not checkDependency( calling_pl, 'rcore_rp_setjob' ) then return end

    if not RPExtraTeams then
        base.msg:route( calling_ply, false, id_setjob.id, 'RP jobs table missing -- are you running darkrp?' )
        return
    end

    local job_c, job_res = helper.who:rpjob_custom( job )
    if not job_c or job_c == 0 then
        base.msg:route( calling_ply, false, id_setjob.id, 'Specified job with command does not exist' )
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

    target_ply:updateJob        ( n_job.name    )
    target_ply:setSelfDarkRPVar ( 'salary', n_job.salary )
    target_ply:SetTeam          ( n_num         )

    GAMEMODE:PlayerSetModel     ( target_ply    )
    GAMEMODE:PlayerLoadout      ( target_ply    )

    base.msg:route( calling_ply, false, id_setjob.id, 'Forced player', base.settings.smsg.clrs.t3, target_ply:Name( ), base.settings.smsg.clrs.msg, 'to job', base.settings.smsg.clrs.t3, n_job.name )
    base.msg:route( target_ply, false, id_setjob.id, 'You have been forced to job', base.settings.smsg.clrs.t3, n_job.name )

end
local rcore_rp_setjob                       = ulx.command( id_setjob.category, id_setjob.ulx_id, ulx.rcore_rp_setjob, id_setjob.pubcmds )
rcore_rp_setjob:addParam                    { type = ULib.cmds.PlayerArg }
rcore_rp_setjob:addParam                    { type = ULib.cmds.StringArg, hint = 'job cmd', ULib.cmds.takeRestOfLine }
rcore_rp_setjob:defaultAccess               ( access:ulx( 'rcore_rp_setjob', mod ) )
rcore_rp_setjob:help                        ( id_setjob.desc )