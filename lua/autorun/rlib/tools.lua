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
local konsole               = base.k

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
*	tools > disconnect > run
*
*	disconnect interface
*/

function tools.dc:Run( )
    if not access:bIsDev( LocalPlayer( ) ) and not access:bIsRoot( LocalPlayer( ) ) then return end

    if ui:ok( tools.dc.pnl ) then
        ui:dispatch( tools.dc.pnl )
        return
    end

    tools.dc.pnl        = ui.new( 'rlib.lo.dc'                  )
    :title              ( lang( 'dc_title' )                    )
    :actshow            (                                       )
end
rcc.new.gmod( pid( 'dc' ), tools.dc.Run )

/*
*	konsole > run
*
*	rlib konsole
*/

function tools.konsole:Run( )
    if not access:bIsDev( LocalPlayer( ) ) then return end
    if not ui:ok( konsole.pnl ) then
        konsole.pnl = vgui.Create( 'rlib.lo.konsole' )
    end
    konsole.pnl:ActionShow( )
end
rcc.new.gmod( pid( 'konsole' ), tools.konsole.Run )

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
    if not access:bIsDev( LocalPlayer( ) ) and not access:bIsRoot( LocalPlayer( ) ) then return end

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
*	tools > rcfg > run
*
*	rcfg interface
*/

function tools.rcfg:Run( )
    if not access:bIsDev( LocalPlayer( ) ) and not access:bIsRoot( LocalPlayer( ) ) then return end

    /*
    *   destroy existing pnl
    */

    if ui:ok( tools.rcfg.pnl ) then
        ui:dispatch( tools.rcfg.pnl )
        return
    end

    /*
    *   create / show parent pnl
    */

    tools.rcfg.pnl          = ui.new( 'rlib.lo.rcfg'            )
    :title                  ( lang( 'lib_addons_title' )        )
    :actshow                (                                   )
end
rcc.new.gmod( pid( 'rcfg' ), tools.rcfg.Run )

/*
*	tools > rlib > run
*
*	rlib main / about interface
*/

function tools.rlib:Run( )
    if not access:bIsDev( LocalPlayer( ) ) and not access:bIsRoot( LocalPlayer( ) ) then return end

    /*
    *   about > network update check
    */

    net.Start               ( 'rlib.udm.check'  )
    net.SendToServer        (                   )

    /*
    *   destroy existing pnl
    */

    if ui:ok( tools.rlib.pnl ) then
        ui:dispatch( tools.rlib.pnl )
        return
    end

    /*
    *   create / show parent pnl
    */

    tools.rlib.pnl          = ui.new( 'rlib.lo.main'            )
    :title                  ( lang( 'title_about' )             )
    :actshow                (                                   )
end
rcc.new.gmod( pid( 'about' ), tools.rlib.Run )

/*
*	tools > report > run
*
*	report bug / diagnostics interface
*/

function tools.report:Run( )
    if not access:bIsDev( LocalPlayer( ) ) and not access:bIsRoot( LocalPlayer( ) ) then return end

    /*
    *   destroy existing pnl
    */

    if ui:ok( tools.report.pnl ) then
        ui:dispatch( tools.report.pnl )
        return
    end

    /*
    *   create / show parent pnl
    */

    tools.report.pnl        = ui.new( 'rlib.lo.report'          )
    :title                  ( lang( 'reports_title' )           )
    :actshow                (                                   )
end
rcc.new.gmod( pid( 'report' ), tools.report.Run )

/*
*	tools > welcome > run
*
*	welcome interface for ?setup
*/

function tools.welcome:Run( )
    if not access:bIsDev( LocalPlayer( ) ) and not access:bIsRoot( LocalPlayer( ) ) then return end

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
*   netlib > konsole
*
*   prompts an in-game notification for issues
*/

local function netlib_konsole( )
    local cat   = net.ReadInt( 4 )
    local msg   = net.ReadString( )

    cat         = cat or 1
    msg         = msg or lang( 'debug_receive_err' )

    konsole:send( cat, msg )
end
net.Receive( 'rlib.konsole', netlib_konsole )

/*
*   netlib > tools > dc
*
*   initializes dc ui
*/

local function netlib_tools_dc( )
    tools.dc:Run( )
end
net.Receive( 'rlib.tools.dc', netlib_tools_dc )

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
*   netlib > tools > rcfg
*
*   initializes rcfg ui
*/

local function netlib_tools_rcfg( )
    tools.rcfg:Run( )
end
net.Receive( 'rlib.tools.rcfg', netlib_tools_rcfg )

/*
*   netlib > tools > rlib main ui
*
*   run rlib ui
*/

local function netlib_tools_rlib( )
    tools.rlib:Run( )
end
net.Receive( 'rlib.tools.rlib', netlib_tools_rlib )

/*
*   netlib > tools > diag
*
*   initializes diag ui
*/

local function netlib_diag( )
    tools.diag:Run( )
end
net.Receive( 'rlib.tools.diag', netlib_diag )

/*
*	think > keybinds > konsole
*
*	checks to see if the assigned keys are being pressed to activate the developer console
*/

local i_th_konsole = 0
local function th_binds_konsole( )
    if not access:bIsDev( LocalPlayer( ) ) and not access:bIsAdmin( LocalPlayer( ) ) then
        hook.Remove( 'Think', pid( 'keybinds.konsole' ) )
        return
    end

    if gui.IsConsoleVisible( ) then return end

    local iKey1, iKey2      = cfg.konsole.binds.key1, cfg.konsole.binds.key2
    local b_Keybfocus       = vgui.GetKeyboardFocus( )

    if LocalPlayer( ):IsTyping( ) or b_Keybfocus then return end

    helper.get.keypress( iKey1, iKey2, function( )
        if i_th_konsole > CurTime( ) then return end
        tools.konsole:Run( )
        i_th_konsole = CurTime( ) + 1
    end )
end
hook.Add( 'Think', pid( 'keybinds.konsole' ), th_binds_konsole )

/*
*	think > keybinds > send report
*
*	checks to see if the assigned keys are being pressed to activate the report ui
*/

local i_th_report = 0
local function th_binds_report( )
    if not access:bIsDev( LocalPlayer( ) ) and not access:bIsRoot( LocalPlayer( ) ) then
        hook.Remove( 'Think', pid( 'keybinds.report' ) )
        return
    end

    if gui.IsConsoleVisible( ) then return end

    local iKey1, iKey2      = cfg.report.binds.key1, cfg.report.binds.key2
    local b_Keybfocus       = vgui.GetKeyboardFocus( )

    if LocalPlayer( ):IsTyping( ) or b_Keybfocus then return end

    helper.get.keypress( iKey1, iKey2, function( )
        if i_th_report > CurTime( ) then return end
        tools.report:Run( )
        i_th_report = CurTime( ) + 1
    end )
end
hook.Add( 'Think', pid( 'keybinds.report' ), th_binds_report )

/*
*   think > keybinds > rlib main
*
*   checks to see if the assigned keys are being pressed to activate the about ui
*/

local i_th_rlib = 0
local function th_binds_rlib( )
    if not access:bIsDev( LocalPlayer( ) ) and not access:bIsRoot( LocalPlayer( ) ) then
        hook.Remove( 'Think', pid( 'keybinds.rlib' ) )
        return
    end

    if gui.IsConsoleVisible( ) then return end

    local iKey1, iKey2      = cfg.rlib.binds.key1, cfg.rlib.binds.key2
    local b_Keybfocus       = vgui.GetKeyboardFocus( )

    if LocalPlayer( ):IsTyping( ) or b_Keybfocus then return end

    helper.get.keypress( iKey1, iKey2, function( )
        if i_th_rlib > CurTime( ) then return end
        tools.rlib:Run( )
        i_th_rlib = CurTime( ) + 1
    end )

end
hook.Add( 'Think', pid( 'keybinds.rlib' ), th_binds_rlib )

/*
*   think > keybinds > rcfg
*
*   checks to see if the assigned keys are being pressed to activate the rcfg ui
*/

local i_th_rcfg = 0
local function th_binds_rcfg( )
    if not access:bIsDev( LocalPlayer( ) ) and not access:bIsRoot( LocalPlayer( ) ) then
        hook.Remove( 'Think', pid( 'keybinds.rcfg' ) )
        return
    end

    if gui.IsConsoleVisible( ) then return end
    if not cfg.rcfg.binds.enabled then return end

    local iKey1, iKey2      = cfg.rcfg.binds.key1, cfg.rcfg.binds.key2
    local b_Keybfocus       = vgui.GetKeyboardFocus( )

    if LocalPlayer( ):IsTyping( ) or b_Keybfocus then return end

    helper.get.keypress( iKey1, iKey2, function( )
        if i_th_rcfg > CurTime( ) then return end
        tools.rcfg:Run( )
        i_th_rcfg = CurTime( ) + 1
    end )
end
hook.Add( 'Think', pid( 'keybinds.rcfg' ), th_binds_rcfg )

/*
*	think > keybinds > diag
*
*	checks to see if the assigned keys are being pressed to activate the diag ui
*/

local i_th_diag = 0
local function th_binds_diag( )
    if not access:bIsDev( LocalPlayer( ) ) and not access:bIsAdmin( LocalPlayer( ) ) then
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