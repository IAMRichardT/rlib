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
local cvar                  = base.v
local tools                 = base.t

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

local id_mdl                = perm( 'rlib_tools_mdlv' )
local id_pco                = perm( 'rlib_tools_pco' )

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
*   ulx > tools > model viewer
*
*	displays a simple model viewer
*
*   @param	: ply call_pl
*/

function ulx.rlib_tools_mdlv( call_pl )
    if not checkDependency( call_pl, id_mdl ) then return end

    net.Start   ( 'rlib.tools.mdlv' )
    net.Send    ( call_pl           )

end
local rlib_tools_mdlv                   = ulx.command( id_mdl.category, id_mdl.ulx_id, ulx.rlib_tools_mdlv, id_mdl.pubcmds )
rlib_tools_mdlv:defaultAccess           ( access:ulx( id_mdl, mod ) )
rlib_tools_mdlv:help                    ( id_mdl.desc )

/*
*   ulx > tools > pco (player-client-optimizations)
*
*	toggles pco on/off for players
*
*   @param	: ply call_pl
*   @param	: ply targ_pl
*   @param  : bool opts
*/

local opt   = { }
opt[ 1 ]    = 'disabled'
opt[ 2 ]    = 'enabled'

function ulx.rlib_tools_pco( call_pl, targ_pl, opts )
    if not checkDependency( call_pl, id_pco ) then return end

    if not cvar:GetBool( 'rlib_pco' ) then
        base:log( 3, ln( 'pco_disabled_debug' ) )
        return
    end

    local b = helper:val2bool( opts )
    tools.pco:Run( targ_pl, b, call_pl )

end
local rlib_tools_pco                    = ulx.command( id_pco.category, id_pco.ulx_id, ulx.rlib_tools_pco, id_pco.pubcmds )
rlib_tools_pco:addParam                 { type = ULib.cmds.PlayerArg }
rlib_tools_pco:addParam                 { type = ULib.cmds.StringArg, completes = opt, hint = 'option', error = 'invalid option \"%s\" specified', ULib.cmds.restrictToCompletes }
rlib_tools_pco:defaultAccess            ( access:ulx( id_pco, mod ) )
rlib_tools_pco:help                     ( id_pco.desc )