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
*	prefix ids
*/

local function pref( str, suffix )
    local state = not suffix and mod or isstring( suffix ) and suffix or false
    return base.get:pref( str, state )
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

local id_mute               = perm( 'rlib_user_mute_timed' )
local id_gag                = perm( 'rlib_user_gag_timed' )

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
*   ulx :: user :: timed mute
*
*	forces the player to select a new name before they can do anything else on the server. once they
*	submit a new first/last name, they must wait for an admin to accept the new name change before
*	the dialog box will close and they can continue playing.
*
*   @param	: ply call_pl
*   @param	: ply, tbl targ_pls
*   @param	: int dur
*   @param	: str reason
*	@param	: bool bUnmute
*/

local ID_MUTE = 2

function ulx.rlib_user_mute_timed( call_pl, targ_pls, dur, reason, bUnmute )
    if not checkDependency( call_pl, id_mute ) then return end

    dur = isnumber( dur ) and dur or 300
    dur = dur == 0 and 86400 or dur

    for i = 1, #targ_pls do
        local v     = targ_pls[ i ]
        local t_id  = string.format( 'ulx.player.mute.%s', v:SteamID64( ) )
        if bUnmute then
            v.gimp = nil
            timex.expire( t_id )
        else
            v.gimp = ID_MUTE
            if not timex.exists( t_id ) then
                timex.create( t_id, dur, 1, function( )
                    base.msg:route( v, false, 'Timed Mute', 'Expired. Additional mutes by an admin may last longer.' )
                    hook.Run( 'alogs.send', 'ulx mute', 'timed mute on player', base.settings.cmsg.clrs.target_tri, v:Name( ), base.settings.cmsg.clrs.msg, 'has expired' )
                end )
            end
        end
        v:SetNWBool( 'ulx_muted', not bUnmute )
    end

    if not bUnmute then
        if helper.str:valid( reason ) and reason ~= 'reason' then
            if dur == 0 or dur == 86400 then
                ulx.fancyLogAdmin( call_pl, '#A muted #T permanently for reason [ #s ]', targ_pls, reason )
            else
                ulx.fancyLogAdmin( call_pl, '#A muted #T for #s seconds for reason [ #s ]', targ_pls, dur, reason )
            end
        else
            if dur == 0 or dur == 86400 then
                ulx.fancyLogAdmin( call_pl, '#A muted #T permanently', targ_pls )
            else
                ulx.fancyLogAdmin( call_pl, '#A muted #T for #s seconds', targ_pls, dur )
            end
        end
    else
        ulx.fancyLogAdmin( call_pl, '#A unmuted #T', targ_pls )
    end

end
local rlib_user_mute_timed                  = ulx.command( id_mute.category, id_mute.ulx_id, ulx.rlib_user_mute_timed, id_mute.pubcmds )
rlib_user_mute_timed:addParam               { type = ULib.cmds.PlayersArg }
rlib_user_mute_timed:addParam               { type = ULib.cmds.NumArg, min = 0, max = 1800, default = 300, hint = 'Seconds to mute for / 0 = perm', ULib.cmds.optional, ULib.cmds.round }
rlib_user_mute_timed:addParam               { type = ULib.cmds.StringArg, hint = 'reason', ULib.cmds.optional, ULib.cmds.takeRestOfLine }
rlib_user_mute_timed:addParam               { type = ULib.cmds.BoolArg, invisible = true }
rlib_user_mute_timed:defaultAccess          ( access:ulx( id_mute, mod ) )
rlib_user_mute_timed:help                   ( id_mute.desc )

/*
*   ulx :: user :: timed gag
*
*	forces the player to select a new name before they can do anything else on the server. once they
*	submit a new first/last name, they must wait for an admin to accept the new name change before
*	the dialog box will close and they can continue playing.
*
*   @param	: ply call_pl
*   @param	: ply, tbl targ_pls
*   @param	: int dur
*   @param	: str reason
*	@param	: bool should_ungag
*/

function ulx.rlib_user_gag_timed( call_pl, targ_pls, dur, reason, should_ungag )
    if not checkDependency( call_pl, id_gag ) then return end

    dur = isnumber( dur ) and dur or 300
    dur = dur == 0 and 86400 or dur

    for i = 1, #targ_pls do
        local v         = targ_pls[ i ]
        v.ulx_gagged    = not should_ungag

        v:SetNWBool( 'ulx_gagged', v.ulx_gagged )

        local t_id = string.format( 'ulx.player.gag.%s', v:SteamID64( ) )
        if not should_ungag then
            if not timex.exists( t_id ) then
                timex.create( t_id, dur, 1, function( )
                    v.ulx_gagged = false
                    v:SetNWBool( 'ulx_gagged', v.ulx_gagged )
                    base.msg:route( v, false, 'Gag', 'Expired. Additional gags by an admin may last longer.' )
                    hook.Run( 'alogs.send', 'ulx gag', 'timed gag on player', base.settings.cmsg.clrs.target_tri, v:Name( ), base.settings.cmsg.clrs.msg, 'has expired' )
                end )
            end
        else
            timex.expire( t_id )
        end
    end

    if not should_ungag then
        if helper.str:valid( reason ) and reason ~= 'reason' then
            if dur == 0 or dur == 86400 then
                ulx.fancyLogAdmin( call_pl, '#A gagged #T permanently for reason [ #s ]', targ_pls, reason )
            else
                ulx.fancyLogAdmin( call_pl, '#A gagged #T for #s seconds for reason [ #s ]', targ_pls, dur, reason )
            end
        else
            if dur == 0 or dur == 86400 then
                ulx.fancyLogAdmin( call_pl, '#A gagged #T permanently', targ_pls )
            else
                ulx.fancyLogAdmin( call_pl, '#A gagged #T for #s seconds', targ_pls, dur )
            end
        end
    else
        ulx.fancyLogAdmin( call_pl, '#A ungagged #T', targ_pls )
    end

end
local rlib_user_gag_timed                   = ulx.command( id_gag.category, id_gag.ulx_id, ulx.rlib_user_gag_timed, id_gag.pubcmds )
rlib_user_gag_timed:addParam                { type = ULib.cmds.PlayersArg }
rlib_user_gag_timed:addParam                { type = ULib.cmds.NumArg, min = 0, max = 1800, default = 300, hint = 'Seconds to gag for / 0 = perm', ULib.cmds.optional, ULib.cmds.round }
rlib_user_gag_timed:addParam                { type = ULib.cmds.StringArg, hint = 'reason', ULib.cmds.optional, ULib.cmds.takeRestOfLine }
rlib_user_gag_timed:addParam                { type = ULib.cmds.BoolArg, invisible = true }
rlib_user_gag_timed:defaultAccess           ( access:ulx( id_gag, mod ) )
rlib_user_gag_timed:help                    ( id_gag.desc )