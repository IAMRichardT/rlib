/*
*   @package        : rlib
*   @author         : Richard [http://steamcommunity.com/profiles/76561198135875727]
*   @copyright      : (C) 2018 - 2020
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
local mf                    = base.manifest

/*
*   Localized rlib routes
*/

local helper                = base.h
local access                = base.a
local storage               = base.s

/*
*   localized glua
*/

local sf                    = string.format

/*
*   rcc > rp_setjob
*
*   forces a player to a specific job
*   requires darkrp
*/

local function rcc_rp_setjob( admin, cmd, args )

    /*
    *   perms
    */

    if not access:bIsRoot( admin ) then return end

    /*
    *   rcc id
    */

    local rcc_id = 'rp_setjob'

    /*
    *	check > rp gamemode
    */

    if not RPExtraTeams then
        base.msg:route( admin, rcc_id, 'Not a supported gamemode. Requires a darkrp derived.' )
        return ''
    end

    /*
    *	declare > arg > player
    */

    local _user = args[ 1 ] and args[ 1 ]:lower( )
    if not _user then
        base.msg:route( admin, rcc_id, 'Invalid player specified' )
        return ''
    end

    /*
    *	check > arg > job > empty
    */

    if _user:len( ) < 2 then
        base.msg:route( admin, rcc_id, 'player name must be at least two characters' )
        return ''
    end

    /*
    *	find player result
    */

    local i_user, user = helper.who:name_wc( _user )

    /*
    *	no results found
    */

    if i_user < 1 then
        base.msg:route( admin, rcc_id, 'No player found' )
        return ''
    end

    /*
    *	more than one user found
    */

    if i_user > 1 then
        base.msg:route( admin, rcc_id, 'More than one player found, please provide a full name' )
        return ''
    end

    /*
    *	extra check for invalid player user
    */

    if not helper.ok.ply( user[ 0 ] ) then
        base.msg:route( admin, rcc_id, 'Could not locate a valid player with the name, please try again' )
        return ''
    end

    /*
    *	declare > arg > player
    */

    user = user[ 0 ]

    /*
    *	declare > arg > job
    */

    local job = args and args[ 2 ] and args[ 2 ]:lower( )

    /*
    *	check > arg > job > empty
    */

    if not job then
        base.msg:route( admin, rcc_id, 'No job specified' )
        return ''
    end

    /*
    *	check > arg > job > empty
    */

    if job:len( ) < 2 then
        base.msg:route( admin, rcc_id, 'job must be at least two characters' )
        return ''
    end

    /*
    *	check > arg > job > no exist
    */

    local job_c, job_res    = helper.who:rpjob_custom( job )
    if not job_c or job_c == 0 then
        base.msg:route( admin, rcc_id, 'Specified job with command does not exist' )
        return
    end

    /*
    *	declare > arg > job
    */

    local job_new = job_res[ 0 ]

    local n_num, n_job = nil, nil
    for i, v in pairs( RPExtraTeams ) do
        if v.command:lower( ) == job_new.command:lower( ) then
            n_num = i
            n_job = v
        end
    end

    /*
    *	execute action
    */

    if n_job and n_num then
        local admin_name            = base.con:Is( admin ) and 'CONSOLE' or admin:palias( )
        local resp                  = sf( '%s switched %s to %s', admin_name  or 'a', user:palias( ), n_job.name )
                                    hook.Run( 'asay.broadcast', rcc_id, resp )

        user:updateJob              ( n_job.name                )
        user:setSelfDarkRPVar       ( 'salary', n_job.salary    )
        user:SetTeam                ( n_num                     )

        GAMEMODE:PlayerSetModel     ( user                      )
        GAMEMODE:PlayerLoadout      ( user                      )
    end

end
rcc.new.gmod( 'rlib_setjob', rcc_rp_setjob )

/*
*   rcc > rp_getjob
*
*   returns player current job
*   requires darkrp
*/

local function rcc_rp_getjob( admin, cmd, args )

    /*
    *   perms
    */

    if not access:bIsRoot( admin ) then return end

    /*
    *   rcc id
    */

    local rcc_id = 'rp_setjob'

    /*
    *	check > rp gamemode
    */

    if not RPExtraTeams then
        base.msg:route( admin, rcc_id, 'Not a supported gamemode. Requires a darkrp derived.' )
        return ''
    end

    /*
    *	declare > arg > player
    */

    local _user = args[ 1 ] and args[ 1 ]:lower( )
    if not _user then
        base.msg:route( admin, rcc_id, 'Invalid player specified' )
        return ''
    end

    /*
    *	check > arg > job > empty
    */

    if _user:len( ) < 2 then
        base.msg:route( admin, rcc_id, 'player name must be at least two characters' )
        return ''
    end

    /*
    *	find player result
    */

    local i_user, user = helper.who:name_wc( _user )

    /*
    *	no results found
    */

    if i_user < 1 then
        base.msg:route( admin, rcc_id, 'No player found' )
        return ''
    end

    /*
    *	more than one user found
    */

    if i_user > 1 then
        base.msg:route( admin, rcc_id, 'More than one player found, please provide a full name' )
        return ''
    end

    /*
    *	extra check for invalid player user
    */

    if not helper.ok.ply( user[ 0 ] ) then
        base.msg:route( admin, rcc_id, 'Could not locate a valid player with the name, please try again' )
        return ''
    end

    /*
    *	declare > arg > player
    */

    user = user[ 0 ]

    /*
    *	execute action
    */

    base.msg:route( admin, rcc_id, sf( '[PLAYER] %s [JOB] %s', user:palias( ), user:getjob( ) ) )

end
rcc.new.gmod( 'rlib_getjob', rcc_rp_getjob )