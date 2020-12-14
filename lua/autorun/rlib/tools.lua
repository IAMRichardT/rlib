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

rlib                        = rlib or { }
local base                  = rlib
local mf                    = base.manifest
local prefix                = mf.prefix
local cfg                   = base.settings

/*
*   Localized rlib routes
*/

local helper                = base.h
local access                = base.a
local ui                    = base.i
local tools                 = base.t

/*
*   Localized translation func
*/

local function lang( ... )
    return base:lang( ... )
end

/*
*	prefix ids
*/

local function pid( str, suffix )
    local state = ( isstring( suffix ) and suffix ) or ( base and prefix ) or false
    return rlib.get:pref( str, state )
end

/*
*	tools > diag > run
*
*	diag interface
*/

function tools.diag:Run( )
    if not access:bIsDev( LocalPlayer( ) ) then return end
    if ui:ok( tools.diag.pnl ) then
        tools.diag.pnl:ActionToggle( )
        return
    end
    tools.diag.pnl = vgui.Create( 'rlib.lo.diag' )
end
rcc.new.gmod( pid( 'diag' ), tools.diag.Run )

/*
*	tools > lang > run
*
*	language selection interface
*/

function tools.lang:Run( )
    if ui:ok( tools.lang.pnl ) then
        ui:dispatch( tools.lang.pnl )
        return
    end

    tools.lang.pnl          = ui.new( 'rlib.lo.language'        )
    :title                  ( lang( 'lang_sel_title' )          )
    :actshow                (                                   )
end
rcc.new.gmod( pid( 'lang' ), tools.lang.Run )

/*
*	tools > mdlv > run
*
*	model viewer interface
*/

function tools.mdlv:Run( )
    if ui:visible( tools.mdlv.pnl ) then
        ui:dispatch( tools.mdlv.pnl )
    end

    tools.mdlv.pnl          = ui.new( 'rlib.lo.mdlv'        )
    :title                  ( lang( 'mdlv_title' )          )
    :actshow                (                               )
end
rcc.new.gmod( pid( 'mview' ), tools.mdlv.Run )

/*
*   tools > pco > run
*
*   optimization tool which helps adjust a few game vars in order to cut back and save frames.
*   should only be used if you actually know what changes this makes
*
*   @param  : bool bEnable
*/

function tools.pco:Run( bEnable )
    bEnable = bEnable or false

    for k, v in pairs( helper._pco_cvars ) do
        local val = ( bEnable and ( v.on or 1 ) ) or ( v.off or 0 )
        rcc.run.gmod( v.id, val )
    end

    if cfg.pco.hooks then
        for k, v in pairs( helper._pco_hooks ) do
            if bEnable then
                hook.Remove( v.event, v.name )
            else
                hook.Add( v.event, v.name )
            end
        end
    end

    hook.Add( 'OnEntityCreated', 'rlib_widget_entcreated', function( ent )
        if ent:IsWidget( ) then
            hook.Add( 'PlayerTick', 'rlib_widget_tick', function( pl, mv )
                widgets.PlayerTick( pl, mv )
            end )
            hook.Remove( 'OnEntityCreated', 'rlib_widget_entcreated' )
        end
    end )
end

/*
*	tools > welcome > run
*
*	welcome interface for ?setup
*/

function tools.welcome:Run( )
    if not access:bIsRoot( LocalPlayer( ) ) then return end

    /*
    *   destroy existing pnl
    */

    if ui:ok( tools.welcome.pnl ) then
        ui:dispatch( tools.welcome.pnl )
        return
    end

    /*
    *   about > network update check
    */

    net.Start               ( 'rlib.welcome'    )
    net.SendToServer        (                   )

    /*
    *   create / show parent pnl
    */

    tools.welcome.pnl       = ui.new( 'rlib.lo.welcome'         )
    :title                  ( lang( 'welcome_title' )           )
    :actshow                (                                   )
end
rcc.new.gmod( pid( 'welcome' ), tools.welcome.Run, nil, nil, FCVAR_PROTECTED )

/*
*   netlib > tools > lang
*
*   initializes lang selector ui
*/

local function netlib_lang( )
    tools.lang:Run( )
end
net.Receive( 'rlib.tools.lang', netlib_lang )

/*
*   netlib > tools > mviewer
*
*   net.Receive to open model viewer
*/

local function netlib_mdlv( )
    tools.mdlv:Run( )
end
net.Receive( 'rlib.tools.mdlv', netlib_mdlv )

/*
*   netlib > tools > pco
*
*   player-client-optimizations
*/

local function netlib_pco( )
    local b = net.ReadBool( )
    tools.pco:Run( b )
end
net.Receive( 'rlib.tools.pco', netlib_pco )

/*
*   netlib > tools > diag
*
*   initializes diag ui
*/

local function netlib_diag( )
    if not access:bIsRoot( LocalPlayer( ) ) then return end

    tools.diag:Run( )
end
net.Receive( 'rlib.tools.diag', netlib_diag )

/*
*	think > keybinds > diag
*
*	checks to see if the assigned keys are being pressed to activate the diag ui
*/

local i_th_diag = 0
local function th_binds_diag( )
    if not access:bIsRoot( LocalPlayer( ) ) then
        hook.Remove( 'Think', pid( 'keybinds.diag' ) )
        return
    end

    if gui.IsConsoleVisible( ) then return end

    local iKey1, iKey2      = cfg.diag.binds.key1, cfg.diag.binds.key2
    local b_Keybfocus       = vgui.GetKeyboardFocus( )

    if LocalPlayer( ):IsTyping( ) or b_Keybfocus then return end

    helper.get.keypress( iKey1, iKey2, function( )
        if i_th_diag > CurTime( ) then return end
        tools.diag:Run( )
        i_th_diag = CurTime( ) + 1
    end )
end
hook.Add( 'Think', pid( 'keybinds.diag' ), th_binds_diag )