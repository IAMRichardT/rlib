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
    return rlib:translate( mod, ... )
end

/*
*	prefix ids
*/

local function pref( str, suffix )
    local state = not suffix and mod or isstring( suffix ) and suffix or false
    return rlib.get:pref( str, state )
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

local id_mdl                = perm( 'rcore_tools_mdlv' )
local id_pco                = perm( 'rcore_tools_pco' )

/*
*   check dependency
*
*   @param  : ply pl
*   @param  : str pid
*/

local function checkDependency( pl, pid )
    if not rlib or not rlib.modules:bInstalled( mod ) then
        local cat = perm( pid ).category or rlib.get:name( )
        rlib.msg:target( pl, cat, 'An error has occured with a required dependency. Contact the developer and we will summon the elves.' )
        return false
    end
    return true
end

/*
*   ulx > tools > model viewer
*
*	displays a simple model viewer
*
*   @param	: ply calling_ply
*/

function ulx.rcore_tools_mdlv( calling_ply )
    if not checkDependency( calling_pl, 'rcore_tools_mdlv' ) then return end

    net.Start   ( 'rlib.tools.mdlv' )
    net.Send    ( calling_ply       )

end
local rcore_tools_mdlv                  = ulx.command( id_mdl.category, id_mdl.id, ulx.rcore_tools_mdlv, id_mdl.pubcmds )
rcore_tools_mdlv:defaultAccess          ( access:ulx( 'rcore_tools_mdlv', mod ) )
rcore_tools_mdlv:help                   ( id_mdl.desc )

/*
*   ulx > tools > pco (player-client-optimizations)
*
*	toggles pco on/off for players
*
*   @param	: ply calling_ply
*   @param	: ply target_ply
*   @param  : bool toggle_options
*/

ulx.toggle_options          = { }
ulx.toggle_options[ 1 ]     = 'disabled'
ulx.toggle_options[ 2 ]     = 'enabled'

function ulx.rcore_tools_pco( calling_ply, target_ply, toggle_options )
    if not checkDependency( calling_pl, 'rcore_tools_pco' ) then return end

    if not cvar:GetBool( 'rlib_pco' ) then
        base:log( 3, lang( 'pco_disabled_debug' ) )
        return
    end

    local toggle = toggle_options == 'enabled' and true or false
    tools.pco:Run( target_ply, toggle, calling_ply )

end
local rcore_tools_pco                       = ulx.command( id_pco.category, id_pco.id, ulx.rcore_tools_pco, id_pco.pubcmds )
rcore_tools_pco:addParam                    { type = ULib.cmds.PlayerArg }
rcore_tools_pco:addParam                    { type = ULib.cmds.StringArg, completes = ulx.toggle_options, hint = 'option', error = 'invalid option \"%s\" specified', ULib.cmds.restrictToCompletes }
rcore_tools_pco:defaultAccess               ( access:ulx( 'rcore_tools_pco', mod ) )
rcore_tools_pco:help                        ( id_pco.desc )