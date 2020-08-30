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
local cfg                   = base.settings
local helper                = base.h
local design                = base.d
local ui                    = base.i
local cvar                  = base.v
local sf                    = string.format

/*
*   Localized translation func
*/

local function lang( ... )
    return base:lang( ... )
end

/*
*	prefix ids
*/

local function pref( str, suffix )
    local state = ( isstring( suffix ) and suffix ) or ( base and base.manifest.prefix ) or false
    return rlib.get:pref( str, state )
end

/*
*   interface settings storage
*/

local cvar_lst =
{
    { id = 'rlib_mdlv_banim',       name = 'Rotate Animation',  desc = 'enable/disable model rotating',     type = 'checkbox',  default = 0,    values = { } },
    { id = 'rlib_mdlv_fov',         name = 'Field of View',     desc = 'Field of view',                     type = 'slider',    default = 100,  values = { },   min = 0,        max = 180 },
    { id = 'rlib_mdlv_campos_x',    name = 'campos x',          desc = 'Camera pos x',                      type = 'slider',    default = 100,  values = { },   min = -1000,    max = 1000 },
    { id = 'rlib_mdlv_campos_y',    name = 'campos y',          desc = 'Camera pos y',                      type = 'slider',    default = 0,    values = { },   min = -1000,    max = 1000 },
    { id = 'rlib_mdlv_campos_z',    name = 'campos z',          desc = 'Camera pos z',                      type = 'slider',    default = 0,    values = { },   min = -1000,    max = 1000 },
    { id = 'rlib_mdlv_lookat_x',    name = 'lookat x',          desc = 'Lookat pos x',                      type = 'slider',    default = 0,    values = { },   min = -1000,    max = 1000 },
    { id = 'rlib_mdlv_lookat_y',    name = 'lookat y',          desc = 'Lookat pos y',                      type = 'slider',    default = 0,    values = { },   min = -1000,    max = 1000 },
    { id = 'rlib_mdlv_lookat_z',    name = 'lookat z',          desc = 'Lookat pos z',                      type = 'slider',    default = 0,    values = { },   min = -1000,    max = 1000 },
}

/*
*   cycle setup convars
*/

local function setup_convars( )
    for k, v in pairs( cvar_lst ) do
        cvar:Setup( v.type, v.id, v.default, v.values )
    end
end
setup_convars( )

/*
*   panel
*/

local PANEL = { }

/*
*   accessorfunc
*/

AccessorFunc( PANEL, 'm_bDraggable', 'Draggable', FORCE_BOOL )

/*
*   initialize
*/

function PANEL:Init( )

    /*
    *   sizing
    */

    self.sc_w, self.sc_h            = ui:scalesimple( 0.85, 0.85, 0.90 ), ui:scalesimple( 0.85, 0.85, 0.90 )
    self.ui_w, self.ui_h            = self.sc_w * cfg.mdlv.ui.width, self.sc_h * cfg.mdlv.ui.height

    /*
    *   parent
    */

    self:SetPaintShadow             ( true                                  )
    self:SetSize                    ( self.ui_w, self.ui_h                  )
    self:SetMinWidth                ( self.ui_w                             )
    self:SetMinHeight               ( self.ui_h                             )
    self:MakePopup                  (                                       )
    self:SetTitle                   ( ''                                    )
    self:SetSizable                 ( true                                  )
    self:ShowCloseButton            ( false                                 )
    self:DockPadding                ( 0, 34, 0, 0                           )

    /*
    *   declarations
    */

    self.bInitialized               = false

    /*
    *   animated text scroll for clipboard btn
    */

    self.clipb_data                 = { }
    self.clipb_delay                = 0
    self._anim_scrtxt               = design.anim_scrolltext( lang( 'copied_to_clipboard' ), 'rlib_lo_mdlv_overlay_copy', self.clipb_data, pref( 'mdlv_copyclip' ), Color( 255, 255, 255, 255 ), 0.5, 2 )

    /*
    *   bIsValidOnly
    *
    *   utilizes util.IsValidModel
    *
    *   if turned on, however this is extremely unreliable for detecting a valid model due to the
    *   restrictions it has. it is recommended to keep this off unless you need to see if the game sees
    *   a particular model as valid
    *
    *   A model is considered invalid in following cases:
    *       : Starts with a space or maps
    *       : Doesn't start with models
    *       : On server: If the model isn't precached, if the model file doesn't exist on the disk
    *       : If precache failed
    *       : Model is the error model
    *       : Contains any of the following:
    *           - _gestures
    *           - _animations
    *           - _postures
    *           - _gst
    *           - _pst
    *           - _shd
    *           - _ss
    *           - _anm
    *           - .bsp
    *           - cs_fix
    */

    self.bIsValidOnly               = false

    /*
    *   declarations > mdl
    */

    self.mdl_default                = 'models/props_interiors/VendingMachineSoda01a.mdl'
    self.mdl_path                   = 'none'
    self.mdl_load                   = self.mdl_default or lang( 'mdlv_search_def' )

    /*
    *   display parent :: static || animated
    */

    if cvar:GetBool( 'rlib_animations_enabled' ) then
        self:SetPos( ( ScrW( ) / 2 ) - ( self.ui_w / 2 ), ScrH( ) + self.ui_h )
        self:MoveTo( ( ScrW( ) / 2 ) - ( self.ui_w / 2 ), ( ScrH( ) / 2 ) - (  self.ui_h / 2 ), 0.4, 0, -1 )
    else
        self:SetPos( ( ScrW( ) / 2 ) - ( self.ui_w / 2 ), ( ScrH( ) / 2 ) - (  self.ui_h / 2 ) )
    end

    /*
    *   titlebar
    */

    self.lblTitle                   = ui.new( 'lbl', self                   )
    :notext                         (                                       )
    :font                           ( pref( 'mdlv_title' )                  )
    :clr                            ( Color( 255, 255, 255, 255 )           )

                                    :draw( function( s, w, h )
                                        draw.SimpleText( utf8.char( 9930 ), pref( 'mdlv_icon' ), 0, 8, Color( 240, 72, 133, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( self:GetTitle( ), pref( 'mdlv_title' ), 25, h / 2, Color( 237, 237, 237, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   close button
    *
    *   to overwrite existing properties from the skin; do not change this
    *   buttons name to anything other than btnClose otherwise it wont
    *   inherit position/size properties
    */

    self.btnClose                   = ui.new( 'btn', self                   )
    :bsetup                         (                                       )
    :notext                         (                                       )
    :tooltip                        ( lang( 'tooltip_close' )               )
    :ocr                            ( self                                  )

                                    :draw( function( s, w, h )
                                        local clr_txt = s.hover and Color( 200, 55, 55, 255 ) or Color( 237, 237, 237, 255 )
                                        draw.SimpleText( helper.get:utf8( 'close' ), pref( 'mdlv_exit' ), w / 2 - 5, h / 2 + 5, clr_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   subparent pnl
    */

    self.ct_sub                     = ui.new( 'pnl', self, 1                )
    :fill                           ( 'm', 0                                )

    /*
    *   dmodel
    */

    self.mdl_elm                    = ui.new( 'mdl', self.ct_sub            )
    :fill                           ( 'm', 0                                )
    :mdl                            ( self.mdl_default                      )

                                    :le( function( ent, s )
                                        if not cvar:GetBool( 'rlib_mdlv_banim' ) then
                                            s:SetAngles( Angle( 0, 0, 0 ) )
                                            return
                                        end

                                        if ( self.mdl_elm.bAnimated ) then
                                            self.mdl_elm:RunAnimation( )
                                        end

                                        s:SetAngles( Angle( 0, RealTime( ) * 10 % 360, 0 ) )
                                    end )

                                    :logic( function( s )
                                        if s:GetModel( ) == self.mdl_default then
                                            s:SetFOV    ( 62                        )
                                            s:SetCamPos ( Vector( 187, -107, 93 )   )
                                            s:SetLookAt ( Vector( 20, 13, 13 )      )
                                            return
                                        end
                                        s:SetFOV        ( cvar:GetInt( 'rlib_mdlv_fov' ) )
                                        s:SetCamPos     ( Vector( cvar:GetInt( 'rlib_mdlv_campos_x' ), cvar:GetInt( 'rlib_mdlv_campos_y' ), cvar:GetInt( 'rlib_mdlv_campos_z' ) ) )
                                        s:SetLookAt     ( Vector( cvar:GetInt( 'rlib_mdlv_lookat_x' ), cvar:GetInt( 'rlib_mdlv_lookat_y' ), cvar:GetInt( 'rlib_mdlv_lookat_z' ) ) )
                                    end )

                                    :po( function( s, w, h )
                                        local pos_x, pos_y, pos_z       = cvar:GetInt( 'rlib_mdlv_campos_x' ), cvar:GetInt( 'rlib_mdlv_campos_y' ), cvar:GetInt( 'rlib_mdlv_campos_z' )
                                        local look_x, look_y, look_z    = cvar:GetInt( 'rlib_mdlv_lookat_x' ), cvar:GetInt( 'rlib_mdlv_lookat_y' ), cvar:GetInt( 'rlib_mdlv_lookat_z' )
                                        local fov, bAnim                = cvar:GetInt( 'rlib_mdlv_fov' ), cvar:GetBool( 'rlib_mdlv_banim' ) and 'ON' or 'OFF'
                                        local bValidOnly                = self.bIsValidOnly and 'ON' or 'OFF'
                                        local y_pos                     = 10

                                        local clr_label                 = Color( 200, 200, 200, 255 )
                                        local clr_value                 = Color( 93, 180, 255, 255 )

                                        local w_sz, h_sz                = w, h
                                        draw.TexturedQuad { texture = surface.GetTextureID( helper._mat[ 'grad_up' ] ), color = Color( 0, 0, 0, 200 ), x = 0, y = h_sz - 100, w = w_sz, h = 100 }

                                        -- stats :: top left :: labels
                                        draw.SimpleText( 'cam', pref( 'mdlv_minfo' ), 85, y_pos + 10, clr_label, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( 'lookat', pref( 'mdlv_minfo' ), 85, y_pos + 30, clr_label, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( 'fov', pref( 'mdlv_minfo' ), 85, y_pos + 50, clr_label, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )

                                        -- stats :: top left :: values
                                        draw.SimpleText( sf( '%sx %sy %sz', pos_x, pos_y, pos_z ), pref( 'mdlv_minfo' ), 110, y_pos + 10, clr_value, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( sf( '%sx %sy %sz', look_x, look_y, look_z ), pref( 'mdlv_minfo' ), 110, y_pos + 30, clr_value, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( sf( '%s', fov ), pref( 'mdlv_minfo' ), 110, y_pos + 50, clr_value, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

                                        -- stats :: top right :: labels
                                        draw.SimpleText( 'Animations', pref( 'mdlv_minfo' ), w - 105, y_pos + 10, clr_label, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( 'Show valid only', pref( 'mdlv_minfo' ), w - 105, y_pos + 30, clr_label, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )

                                        -- stats :: top right :: values
                                        draw.SimpleText( sf( '%s', bAnim ), pref( 'mdlv_minfo' ), w - 55, y_pos + 10, clr_value, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( sf( '%s', bValidOnly ), pref( 'mdlv_minfo' ), w - 55, y_pos + 30, clr_value, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   controls pnl
    */

    self.p_ctrls                    = ui.new( 'pnl', self, 1                )
    :bottom                         ( 'm', 20, 8, 20, 0                     )
    :tall                           ( self.ui_h * 0.35                      )

    /*
    *   btm block
    */

    self.ct_blk_btm                 = ui.new( 'pnl', self.p_ctrls           )
    :top                            ( 'm', 0, 0, 0, 15                      )
    :tall                           ( 35                                    )

                                    :draw( function( s, w, h )
                                        design.rbox( 4, 2, 2, w - 4, h - 4, Color( 31, 31, 31, 255 ) )
                                    end )

    /*
    *   btn > copy
    */

    self.b_copy                     = ui.new( 'btn', self.ct_blk_btm        )
    :bsetup                         (                                       )
    :left                           ( 'm', 0, 0, 0, 0                       )
    :wide                           ( 53                                    )
    :tip                            ( lang( 'mdlv_btn_copytoclip' )         )

                                    :draw( function( s, w, h )
                                        local btn_txt   = s.hover and lang( 'mdlv_btn_copy' ) or lang( 'mdlv_btn_path' )
                                        local btn_clr   = s.hover and Color( 156, 4, 81, 255 ) or Color( 31, 133, 222, 255 )

                                        design.rbox_adv( 4, 2, 2, w - 4, h - 4, Color( 25, 25, 25, 255 ), true, false, true, false )
                                        design.rbox_adv( 4, 2, 2, 50, h - 4, btn_clr, true, false, true, false )

                                        local getmodel  = self.mdl_elm:GetModel( ) and tostring( self.mdl_elm:GetModel( ) ) or ''
                                        self.mdl_path   = ( self.bIsValidOnly and util.IsValidModel( getmodel ) and getmodel ) or ( not self.bIsValidOnly and getmodel ) or getmodel or 'invalid model path'

                                        draw.SimpleText( btn_txt, pref( 'mdlv_minfo' ), ( 53 / 2 ), h / 2 - 1, clr_label, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( sf( '%s', self.mdl_path ), pref( 'mdlv_minfo' ), 60, h / 2, clr_value, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                    end )

                                    :oc( function( s )
                                        SetClipboardText( self.mdl_path )
                                        self.clipb_delay = CurTime( ) + 0.5
                                    end )

    /*
    *   search box
    */

    self.dt_searchbox               = ui.new( 'entry', self.ct_blk_btm      )
    :fill                           ( 'm', 10, 5, 4, 5                      )
    :mline	                        ( false 				                )
    :textclr                        ( Color( 255, 255, 255, 255 )           )
    :scur	                        ( Color( 255, 255, 255, 255 ), 'beam'   )
    :enabled                        ( true                                  )
    :allowascii                     ( false                                 )
    :canedit                        ( true                                  )
    :autoupdate	                    ( true 					                )
    :txt	                        ( self.mdl_load, Color( 255, 255, 255, 255 ), pref( 'mdlv_searchbox' ) )
    :drawentry                      ( clr_text, clr_cur, clr_hl             )
    :ocnf                           ( true                                  )

                                    :onenter( function( s )
                                        local val   = s:GetValue( )
                                        val         = helper.str:clean_ws( val )

                                        if ui:ok( self.mdl_elm ) then
                                            if self.bIsValidOnly and util.IsValidModel( self.mdl_elm:GetModel( ) ) or not self.bIsValidOnly then
                                                self.mdl_elm:SetModel( val )
                                            else
                                                self.mdl_elm:SetModel( self.mdl_default )
                                            end
                                        end
                                    end )

                                    :ogfocus( function( s )
                                        if s:GetValue( ) == lang( 'mdlv_search_def' ) then
                                            s:SetValue( '' )
                                        end
                                    end )

    /*
    *   btn > search > clear
    */

    self.b_clear                    = ui.new( 'btn', self.dt_searchbox      )
    :bsetup                         (                                       )
    :right                          ( 'm', 0, 3, 5, 3                       )
    :wide                           ( 21                                    )
    :tip                            ( lang( 'mdlv_btn_tip_clear' )          )

                                    :draw( function( s, w, h )
                                        local clr_box = s.hover and Color( 15, 15, 15, 100 ) or Color( 200, 55, 55, 255 )
                                        design.rbox( 6, 0, 0, w, h, clr_box )

                                        draw.SimpleText( 'x', pref( 'mdlv_clear' ), w / 2, h / 2 - 2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

                                    :oc( function( s )
                                        s:GetParent( ):SetValue( self.mdl_default )
                                    end )

    /*
    *   btn > search > submit
    */


    self.b_submit                   = ui.new( 'btn', self.dt_searchbox      )
    :bsetup                         (                                       )
    :right                          ( 'm', 0, 3, 5, 3                       )
    :wide                           ( 21                                    )
    :tip                            ( lang( 'mdlv_btn_tip_search' )         )

                                    :draw( function( s, w, h )
                                        local clr_box = s.hover and Color( 15, 15, 15, 100 ) or Color( 70, 140, 84, 255 )
                                        design.rbox( 6, 0, 0, w, h, clr_box )
                                        draw.SimpleText( '>', pref( 'mdlv_enter' ), w / 2, h / 2 - 2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

                                    :oc( function( s )
                                        local val   = self.dt_searchbox:GetValue( )
                                        val         = helper.str:clean_ws( val )

                                        if ui:ok( self.mdl_elm ) then
                                            if self.bIsValidOnly and util.IsValidModel( self.mdl_elm:GetModel( ) ) or not self.bIsValidOnly then
                                                self.mdl_elm:SetModel( val )
                                            else
                                                self.mdl_elm:SetModel( self.mdl_default )
                                            end
                                        end
                                    end )

    /*
    *   scroll pnl
    */

    self.dsp                        = ui.new( 'rlib.elm.sp.v2', self.p_ctrls, 1 )
    :fill                           ( 'm', 5                                )
    :param                          ( 'SetbKonsole', false                  )
    :param                          ( 'SetbElastic', true                   )

    /*
    *   cvar > declarations > clrs
    */

    local clr_txt_n                 = Color( 255, 255, 255, 255 )
    local clr_txt_h                 = Color( 31, 133, 222, 255 )
    local clr_spcr                  = Color( 44, 44, 44, 255 )

    /*
    *   cvar > loop
    */

    for k, v in helper.get.table( cvar_lst, pairs ) do

        /*
        *   cvar > declarations
        */

        local class 	            = v.type
        local ident		            = tostring( k )
        local gcv		            = GetConVar( v.id )

        /*
        *   cvar > parent
        */

        self.ct_parent              = ui.new( 'pnl', self.dsp, 1            )
        :top                        ( 'm', 0, 2, 20, 2                      )

        /*
        *   type > slider
        */

        if class == 'slider' then

            /*
            *   slider > container > main
            */

            self.ct_slid            = ui.new( 'pnl', self.ct_parent, 1      )
            :fill                   ( 'm', 0, 0, 0, 0                       )

            /*
            *   slider > label
            */

            self.l_name             = ui.new( 'btn', self.ct_slid           )
            :bsetup                 (                                       )
            :left                   ( 'm', 0, 0, 0, 0                       )
            :font                   ( pref( 'mdlv_control' )                )
            :text                   ( v.desc                                )
            :clr                    ( Color( 255, 255, 255, 255 )           )
            :autosize               (                                       )

                                    :draw( function( s, w, h )
                                        local clr = s.hover and clr_txt_h or clr_txt_n
                                        s:SetTextColor( clr )
                                    end )

            /*
            *   slider > right > container
            */

            self.ct_r               = ui.new( 'pnl', self.ct_parent, 1      )
            :fill                   ( 'm', 5, 3, 20, 0                      )
            :wide                   ( 300                                   )

            /*
            *   slider > right > elm
            */

            self.elm                = ui.new( 'rlib.ui.slider', self.ct_r   )
            :right                  ( 'm', 0, 0, 0, 0                       )
            :wide                   ( 300                                   )
            :minmax                 ( v.min, v.max                          )
            :val                    ( gcv:GetFloat( )                       )
            :param                  ( 'SetKnobColor', Color( 51, 169, 74 )  )
            :var                    ( 'convarname', gcv                     )

                                    :ovc( function( s )
                                        gcv:SetInt( s:GetValue( ) )
                                    end )

        end

        /*
        *   type > checkbox
        */

        if class == 'checkbox' then

            /*
            *   chkbox > container > main
            */

            self.ct_cbox            = ui.new( 'pnl', self.ct_parent, 1      )
            :fill                   ( 'm', 0, 0, 0, 5                       )

            /*
            *   chkbox > lbl
            */

            self.l_name             = ui.new( 'btn', self.ct_cbox           )
            :bsetup                 (                                       )
            :left                   ( 'm', 0, 0, 0, 0                       )
            :font                   ( pref( 'mdlv_control' )                )
            :clr                    ( Color( 255, 255, 255, 255 )           )
            :text                   ( v.name                                )
            :autosize               (                                       )

                                    :draw( function( s, w, h )
                                        local clr = s.hover and clr_txt_h or clr_txt_n
                                        s:SetTextColor( clr )
                                    end )

            /*
            *   chkbox > container > right
            */

            self.ct_r               = ui.new( 'pnl', self.ct_cbox, 1        )
            :fill                   ( 'm', 5, 0, 20, 0                      )
            :autosize               (                                       )

            /*
            *   chkbox > element
            */

            self.elm                = ui.new( 'rlib.ui.toggle', self.ct_r   )
            :right                  ( 'm', 0                                )
            :var                    ( 'enabled', gcv:GetBool( ) or false    )

                                    :ooc( function( s )
                                        gcv:SetBool( s.enabled )
                                    end )

        end

        /*
        *   spacer
        */

        self.spcr                   = ui.new( 'pnl', self.dsp               )
        :top                        ( 'm', 0                                )
        :tall                       ( 1                                     )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, h, clr_spcr )
                                    end )

    end

end

/*
*   FirstRun
*/

function PANEL:FirstRun( )
    self.bInitialized = true
end

/*
*   Think
*/

function PANEL:Think( )
    self.BaseClass.Think( self )

    local mousex = math.Clamp( gui.MouseX( ), 1, ScrW( ) - 1 )
    local mousey = math.Clamp( gui.MouseY( ), 1, ScrH( ) - 1 )

    if self.Dragging then
        local x = mousex - self.Dragging[ 1 ]
        local y = mousey - self.Dragging[ 2 ]

        if self:GetScreenLock( ) then
            x = math.Clamp( x, 0, ScrW( ) - self:GetWide( ) )
            y = math.Clamp( y, 0, ScrH( ) - self:GetTall( ) )
        end

        self:SetPos( x, y )
    end

    if self.Sizing then
        local x = mousex - self.Sizing[ 1 ]
        local y = mousey - self.Sizing[ 2 ]
        local px, py = self:GetPos( )

        if ( x < self.m_iMinWidth ) then x = self.m_iMinWidth elseif ( x > ScrW( ) - px and self:GetScreenLock( ) ) then x = ScrW( ) - px end
        if ( y < self.m_iMinHeight ) then y = self.m_iMinHeight elseif ( y > ScrH( ) - py and self:GetScreenLock( ) ) then y = ScrH( ) - py end

        self:SetSize( x, y )
        self:SetCursor( 'sizenwse' )
        return
    end

    if ( self.Hovered and self.m_bSizable and mousex > ( self.x + self:GetWide( ) - 20 ) and mousey > ( self.y + self:GetTall( ) - 20 ) ) then
        self:SetCursor( 'sizenwse' )
        return
    end

    if ( self.Hovered and self:GetDraggable( ) and mousey < ( self.y + 24 ) ) then
        self:SetCursor( 'sizeall' )
        return
    end

    self:SetCursor( 'arrow' )

    if self.y < 0 then self:SetPos( self.x, 0 ) end
end

/*
*   OnMousePressed
*/

function PANEL:OnMousePressed( )
    if ( self.m_bSizable and gui.MouseX( ) > ( self.x + self:GetWide( ) - 20 ) and gui.MouseY( ) > ( self.y + self:GetTall( ) - 20 ) ) then
        self.Sizing =
        {
            gui.MouseX( ) - self:GetWide( ),
            gui.MouseY( ) - self:GetTall( )
        }
        self:MouseCapture( true )
        return
    end

    if ( self:GetDraggable( ) and gui.MouseY( ) < ( self.y + 24 ) ) then
        self.Dragging =
        {
            gui.MouseX( ) - self.x,
            gui.MouseY( ) - self.y
        }
        self:MouseCapture( true )
        return
    end
end

/*
*   OnMouseReleased
*/

function PANEL:OnMouseReleased( )
    self.Dragging = nil
    self.Sizing = nil
    self:MouseCapture( false )
end

/*
*   PerformLayout
*/

function PANEL:PerformLayout( )

    /*
    *   initialize only
    */

    if not self.bInitialized then
        self:FirstRun( )
    end

    local titlePush = 0
    self.BaseClass.PerformLayout( self )

    self.lblTitle:SetPos( 11 + titlePush, 7 )
    self.lblTitle:SetSize( self:GetWide( ) - 25 - titlePush, 20 )
end

/*
*   Paint
*
*   @param  : int w
*   @param  : int h
*/

function PANEL:Paint( w, h )
    design.rbox( 4, 0, 0, w, h, Color( 40, 40, 40, 255 ) )
    design.rbox_adv( 0, 0, 0, w, 34, Color( 30, 30, 30, 255 ), true, true, false, false )

    local remaining   = math.Round( self.clipb_delay - CurTime( ) ) or 0
    local limit       = math.Clamp( remaining, 0, 5 )

    if limit == 1 and #self.clipb_data == 0 then
        timex.simple( 'rlib_lo_mdlv_copy_anim', 0.1, function( )
            if #self.clipb_data == 0 then
                local pos_x, pos_y  = self.b_copy:LocalToScreen( )
                local exp           = CurTime( ) + ( self._anim_scrtxt or 2 )

                pos_x = pos_x
                pos_y = pos_y - 20

                table.insert( self.clipb_data, { pos = pos_x, x = pos_x, y = pos_y, expires = exp } )
            end
        end )
    end

    -- resizing arrow
    draw.SimpleText( utf8.char( 9698 ), pref( 'mdlv_resizer' ), w - 3, h - 7, Color( 240, 72, 133, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
    draw.SimpleText( utf8.char( 9698 ), pref( 'mdlv_resizer' ), w - 5, h - 9, Color( 40, 40, 40, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
end

/*
*   ActionHide
*/

function PANEL:ActionHide( )
    self:SetMouseInputEnabled( false )
    self:SetKeyboardInputEnabled( false )
end

/*
*   ActionShow
*/

function PANEL:ActionShow( )
    self:SetMouseInputEnabled( true )
    self:SetKeyboardInputEnabled( true )
end

/*
*   GetbValidOnly
*/

function PANEL:GetbValidOnly( )
    return self.bIsValidOnly
end

/*
*   bValidOnly
*
*   @param  : bool b
*/

function PANEL:bValidOnly( b )
    self.bIsValidOnly = b
end

/*
*   GetTitle
*
*   @return : str
*/

function PANEL:GetTitle( )
    return ( helper.str:ok( self._title ) and self._title ) or lang( 'mdlv_title' )
end

/*
*   SetTitle
*
*   @param  : str str
*/

function PANEL:SetTitle( str )
    self.lblTitle:SetText( '' )
    self._title = str
end

/*
*   Destroy
*/

function PANEL:Destroy( )
    ui:destroy( self, true, true )
end

/*
*   SetVisible
*
*   @param  : bool bVisible
*/

function PANEL:SetVisible( bVisible )
    if bVisible then
        ui:show( self, true )
    else
        ui:hide( self, true )
    end
end

/*
*   register
*/

vgui.Register( 'rlib.lo.mdlv', PANEL, 'DFrame' )