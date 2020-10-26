/*
*   @package        : rlib
*   @author         : Richard [http://steamcommunity.com/profiles/76561198135875727]
*   @copyright      : (C) 2020 - 2020
*   @since          : 3.0.0
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
local access                = base.a
local helper                = base.h
local design                = base.d
local ui                    = base.i
local tools                 = base.t
local cvar                  = base.v

/*
*   localization > misc
*/

local cfg                   = base.settings
local mf                    = base.manifest

/*
*   localization > glua
*/

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
    local state = ( isstring( suffix ) and suffix ) or ( base and mf.prefix ) or false
    return base.get:pref( str, state )
end

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

    local ui_w, ui_h                = cfg.rcfg.ui.width, cfg.rcfg.ui.height

    /*
    *   declarations > parent pnl
    */

    self:SetPaintShadow             ( true                                  )
    self:SetSize                    ( ui_w, ui_h                            )
    self:SetMinWidth                ( ui_w                                  )
    self:SetMinHeight               ( ui_h                                  )
    self:MakePopup                  (                                       )
    self:SetTitle                   ( ''                                    )
    self:SetSizable                 ( false                                 )
    self:ShowCloseButton            ( false                                 )
    self:DockPadding                ( 0, 34, 0, 0                           )

    /*
    *   declarations > misc
    */

    self.hdr_title                  = 'rcfg'
    self.clr_hdr_ico                = Color( 240, 72, 133, 255 )
    self.clr_hdr_txt                = Color( 237, 237, 237, 255 )
    self.clr_hdr_btn_n              = Color( 237, 237, 237, 255 )
    self.clr_hdr_btn_h              = Color( 200, 55, 55, 255 )
    self.clr_title                  = Color( 38, 175, 99 )
    self.clr_ver_box                = Color( 194, 43, 84, 255 )
    self.clr_ver_txt                = Color( 255, 255, 255, 255 )
    self.clr_rel_txt                = Color( 255, 255, 255, 150 )
    self.clr_des_txt                = Color( 230, 230, 230, 255 )
    self.clr_pnl_ftr_box            = Color( 30, 30, 30, 255 )
    self.clr_pnl_ftr_txt            = Color( 150, 150, 150, 255 )
    self.clr_item_img_box           = Color( 255, 255, 255, 25 )
    self.clr_item_hvr_box           = Color( 231, 103, 81, 255 )

    /*
    *   display parent
    */

    self                            = ui.get( self                          )
    self:anim_fadein                ( 0.2, 2                                )

    /*
    *   titlebar
    *
    *   to overwrite existing properties from the skin; do not change this
    *   labels name to anything other than lblTitle otherwise it wont
    *   inherit position/size properties
    */

    self.lblTitle                   = ui.new( 'lbl', self                   )
    :notext                         (                                       )
    :font                           ( pref( 'rcfg_title' )                  )
    :clr                            ( Color( 255, 255, 255, 255 )           )

                                    :draw( function( s, w, h )
                                        if not self.title or self.title == '' then self.title = 'rcfg' end
                                        draw.SimpleText( utf8.char( 9930 ), pref( 'rcfg_icon' ), 0, 8, self.clr_hdr_ico, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( self.title, pref( 'rcfg_title' ), 25, h / 2, self.clr_hdr_txt, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   button > close
    *
    *   to overwrite existing properties from the skin; do not change this
    *   buttons name to anything other than btnClose otherwise it wont
    *   inherit position/size properties
    */

    self.btnClose                   = ui.new( 'btn', self                   )
    :bsetup                         (                                       )
    :notext                         (                                       )
    :tooltip                        ( lang( 'tooltip_close' )               )

                                    :draw( function( s, w, h )
                                        local clr_txt = s.hover and self.clr_hdr_btn_h or self.clr_hdr_btn_n
                                        draw.SimpleText( helper.get:utf8( 'close' ), pref( 'rcfg_exit' ), w / 2 - 7, h / 2 + 4, clr_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

                                    :oc( function( s )
                                        local parent = ui.get( self )
                                        :anim_fadeout( 0.2, 0, function( )
                                            ui:dispatch( self )
                                        end )
                                    end )

    /*
    *   button > maximize ( refresh )
    *
    *   to overwrite existing properties from the skin; do not change this
    *   buttons name to anything other than btnClose otherwise it wont
    *   inherit position/size properties
    */

    self.btnMaxim                   = ui.new( 'btn', self                   )
    :bsetup                         (                                       )
    :notext                         (                                       )
    :tooltip                        ( lang( 'tooltip_act_refresh' )         )
    :ocr                            ( self                                  )

                                    :draw( function( s, w, h )
                                        local clr_txt = s.hover and self.clr_hdr_btn_h or self.clr_hdr_btn_n
                                        draw.SimpleText( helper.get:utf8( 'arrow_c' ), pref( 'rcfg_refresh' ), w / 2 - 7, h / 2 + 4, clr_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

                                    :oc( function( s )
                                        ui:dispatch( self )
                                        timex.simple( 0.5, function( )
                                            tools.rcfg:Run( )
                                        end )
                                    end )

    /*
    *   header
    */

    self.p_hdr                      = ui.new( 'pnl', self                   )
    :top                            ( 'm', 0                                )
    :tall                           ( 70                                    )

                                    :draw( function( s, w, h )
                                        design.rbox( 0, 5, 0, w - 10, h, Color( 47, 47, 47, 255 ) )

                                        local pulse     = math.abs( math.sin( CurTime( ) * 1.2 ) * 255 )
                                        pulse           = math.Clamp( pulse, 125, 255 )

                                        draw.SimpleText( self.hdr_title:upper( ), pref( 'rcfg_name' ), 23, h / 2 - 8, Color( 200, 200, 200, pulse ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( 'MODULE MANAGEMENT', pref( 'rcfg_sub' ), 26, h / 2 + 14, Color( 200, 200, 200, pulse ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( '', pref( 'rcfg_symbol' ), w - 25, h / 2, Color( 255, 255, 255, 5 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   subparent pnl
    */

    self.ct_sub                     = ui.new( 'pnl', self                   )
    :fill                           ( 'm', 5, 0, 5, 0                       )
    :padding                        ( 0                                     )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, h, Color( 38, 38, 38, 255 ) )
                                    end )

    /*
    *   content pnl
    */

    self.ct_content                 = ui.new( 'pnl', self.ct_sub            )
    :fill                           ( 'm', 0                                )
    :padding                        ( 3                                     )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, h, Color( 41, 41, 41, 255 ) )
                                    end )

    /*
    *   item > right
    */

    self.ct_left                    = ui.new( 'pnl', self.ct_content        )
    :nodraw                         (                                       )
    :left                           ( 'm', 0, 0, 0, 0                       )
    :wide                           ( 300                                   )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, h, Color( 35, 35, 35, 255 ) )
                                    end )

    /*
    *   sel > right
    */

    self.ct_right                   = ui.new( 'pnl', self.ct_content        )
    :nodraw                         (                                       )
    :fill                           ( 'm', 0, 0, 0, 0                       )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, h, Color( 25, 25, 25, 255 ) )
                                    end )

    /*
    *   sel > right > content
    */

    self.ct_right_cont              = ui.new( 'pnl', self.ct_content        )
    :nodraw                         (                                       )
    :fill                           ( 'm', 10                               )

    /*
    *   sel > right > content > coming soon
    */

    self.ct_soon                    = ui.new( 'pnl', self.ct_right_cont     )
    :nodraw                         (                                       )
    :fill                           ( 'm', 0, 0, 0, 0                       )

                                    :draw( function( s, w, h )
                                        design.text( 'Select a module', w / 2, h / 2, Color( 255, 255, 255, 20 ), pref( 'rcfg_soon' ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   scroll panel
    */

    self.dsp                        = ui.new( 'rlib.ui.scrollpanel', self.ct_left )
    :fill                           ( 'm', 5, 5, 5, 0                       )
    :var                            ( 'AlphaOR', true                       )
    :var                            ( 'KnobColor', Color( 68, 114, 71, 255 ) )

    /*
    *   declarations
    */

    local sz_item                   = 52
    local i_modules                 = table.Count( base.modules:list( ) )
    local str_modules               = sf( '%i modules installed', i_modules )
    local item_sb_oset              = 15

    /*
    *   loop modules
    */

    local i = 0
    for k, v in SortedPairs( base.modules:list( ) ) do

        local clr_box               = i % 2 == 0 and Color( 0, 0, 0, 25 ) or Color( 255, 255, 255, 1 )
        local clr_box_border        = i % 2 == 0 and Color( 255, 255, 255, 0 ) or Color( 255, 255, 255, 3 )
        local clr_mat               = i % 2 == 0 and Color( 255, 255, 255, 0 ) or Color( 255, 255, 255, 3 )

        /*
        *   declare modules data
        */

        local m_name                = isstring( v.name ) and v.name or v.id
        local m_ver                 = sf( '%s', rlib.get:ver2str_mf( v ) )
        local m_rel                 = v.released and os.date( '%m.%d.%y', v.released )
        local m_def                 = 'http://cdn.rlib.io/gms/env.png'
        local m_img                 = ( isstring( v.icon ) and v.icon ~= '' and v.icon ) or m_def
        local m_url                 = ( isstring( v.url ) and v.url ) or mf.site
        local m_desc                = isstring( v.desc ) and v.desc or 'No description'
        m_desc                      = helper.str:truncate( m_desc, 60, '...' ) or lang( 'err' )
        m_desc                      = helper.str:ucfirst( m_desc )

        /*
        *   item > parent
        */

        self.lst_i                  = ui.new( 'pnl', self.dsp               )
        :nodraw                     (                                       )
        :top                        ( 'm', 0, 0, 15, 1                      )
        :tall                       ( sz_item - 10                          )

                                    :draw( function( s, w, h )
                                        design.rbox( 4, 0, 0, w - item_sb_oset, h, clr_box )
                                        design.obox( 0, 0, w - item_sb_oset, h, Color( 35, 35, 35, 0 ), clr_box_border )

                                        local w_sz, h_sz = w, h
                                        draw.TexturedQuad { texture = surface.GetTextureID( helper._mat[ 'grad_down' ] ), color = clr_mat, x = 0, y = 1, w = w_sz - item_sb_oset, h = h_sz * 1 }
                                    end )

                                    :logic_sl( 0.5, function( s )
                                        if not ui:ok( self.dsp ) then return end

                                        local sbar              = self.dsp:GetVBar( )
                                        local mar_r_s           = ui:visible( sbar ) and 15 or 0
                                        local mar_r_dsp         = ui:visible( sbar ) and 5 or 0

                                        s:DockMargin            ( 0, 0, mar_r_s, 0  )
                                        self.dsp:DockMargin     ( 5, 5, mar_r_dsp, 0 )
                                    end )

        /*
        *   item > sub
        */

        self.lst_i_sub              = ui.new( 'pnl', self.lst_i             )
        :nodraw                     (                                       )
        :fill                       ( 'm', 0                                )

        /*
        *   item > right
        */

        self.lst_i_r                = ui.new( 'pnl', self.lst_i_sub         )
        :nodraw                     (                                       )
        :fill                       ( 'm', 0                                )

                                    :draw( function( s, w, h )
                                        design.text( m_name:upper( ), 5, h / 2, self.clr_title, pref( 'rcfg_lst_name' ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                    end )

        /*
        *   item > ver
        */

        self.lst_i_r_ver            = ui.new( 'pnl', self.lst_i_sub         )
        :nodraw                     (                                       )
        :right                      ( 'm', 0                                )
        :wide                       ( 100                                   )

                                    :draw( function( s, w, h )
                                        design.rbox( 4, ( w / 2 ) - ( 74 / 2 ), ( h / 2 ) - ( 15 / 2 ) - 8, 74, 14, self.clr_ver_box )
                                        design.text( m_ver, w / 2, h / 2 - 8, self.clr_ver_txt, pref( 'rcfg_lst_ver' ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                        design.text( m_rel, w / 2 - 1, h / 2 + 8, self.clr_rel_txt, pref( 'rcfg_lst_rel' ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

        /*
        *   image > container
        */

        self.lst_i_ct_img           = ui.new( 'pnl', self.lst_i_sub         )
        :left                       ( 'm', 4                                )
        :wide                       ( sz_item - 15                          )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, h, self.clr_item_img_box)
                                    end )

        /*
        *   image > dhtml src
        */

        self.lst_i_av_url           = ui.new( 'dhtml', self.lst_i_ct_img    )
        :nodraw                     (                                       )
        :fill                       ( 'm', 1                                )
        :sbar                       ( false                                 )

                                    self.lst_i_av_url:SetHTML(
                                    [[
                                        <body style='overflow: hidden; height: 100%; width: 100%; margin:0px;'>
                                            <img width='100%' height='100%' style='width:100%;height:100%;' src=']] .. m_img .. [['>
                                        </body>
                                    ]])

        /*
        *   image > dhtml src
        */

        self.lst_i_av_def           = ui.new( 'dhtml', self.lst_i_ct_img    )
        :nodraw                     (                                       )
        :fill                       ( 'm', 1                                )
        :sbar                       ( false                                 )

                                    self.lst_i_av_url:SetHTML(
                                    [[
                                        <body style='overflow: hidden; height: 100%; width: 100%; margin:0px;'>
                                            <img width='100%' height='100%' style='width:100%;height:100%;' src=']] .. m_def .. [['>
                                        </body>
                                    ]])

        /*
        *   image > btn
        */

        self.lst_i_b_hover          = ui.new( 'btn', self.lst_i             )
        :bsetup                     (                                       )
        :notext                     (                                       )
        :fill                       ( 'm', 0                                )

                                    :draw( function( s, w, h )
                                        if s.hover then
                                            design.rbox( 4, w - 5, 0, 5, h, self.clr_item_hvr_box )
                                        end
                                    end )

                                    :oc( function( s )
                                        self:SetData( v )
                                    end )

        /*
        *   count loop progress
        */

        i = i + 1

        /*
        *   hide spacer if last item in list
        */

        if i == i_modules then
            ui:hide( self.sp )
        end

    end

    /*
    *   spacer > bottom
    */

    self.ct_ftr_sp                  = ui.new( 'pnl', self.dsp               )
    :nodraw                         (                                       )
    :top                            ( 'm', 0                                )
    :tall                           ( 0                                     )

    /*
    *   footer
    */

    self.ct_ftr                     = ui.new( 'pnl', self                   )
    :bottom                         ( 'm', 5, 0, 5, 0                       )
    :tall                           ( 25                                    )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, h, self.clr_pnl_ftr_box )
                                        draw.SimpleText( str_modules, pref( 'rcfg_footer_i' ), w - 6, h / 2, self.clr_pnl_ftr_txt, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
                                    end )

end

/*
*   SetData
*
*   @param  : tbl module
*/

function PANEL:SetData( module )

    /*
    *   declare > parent
    */

    local parent                    = self.ct_right_cont
                                    parent:Clear( )

    /*
    *   declare > module info
    */

    local sel_name                  = module.name or 'Untitled Module'
    local sel_ver                   = sf( '%s', rlib.get:ver2str_mf( module ) )
    local sel_desc                  = module.desc or 'No description'
    local sel_sid                   = module.owner or 'Unregistered'
    local sel_id                    = module.script_id or '0000'

    /*
    *   declare > parent
    */

    local sel_oid = nil
    steamworks.RequestPlayerInfo( sel_sid, function( steamName )
        sel_oid = helper.str:ok( steamName )  and steamName or 'Unregistered'
    end )

    /*
    *   module > selected > name
    */

    self.sel_par                    = ui.new( 'pnl', parent                 )
    :nodraw                         (                                       )
    :top                            ( 'm', 5, 0, 15, 0                      )
    :tall                           ( 50                                    )

    /*
    *   module > selected > name
    */

    self.sel_name                   = ui.new( 'dt', self.sel_par            )
    :fill                           ( 'm', 0, 0, 0, 0                       )
    :tall                           ( 31                                    )
    :drawbg                         ( false                                 )
    :mline	                        ( false 				                )
    :ascii	                        ( false 				                )
    :canedit	                    ( false 				                )
    :scur	                        ( Color( 255, 255, 255, 255 ), 'beam'   )
    :txt	                        ( sel_name, Color( 31, 133, 222, 210 ), pref( 'rcfg_sel_name' ) )
    :ocnf                           ( true                                  )

    /*
    *   module > selected > ver
    */

    self.sel_ver                    = ui.new( 'lbl', self.sel_par           )
    :right                          ( 'm', 0, 0, 0, 0                       )
    :tall                           ( 20                                    )
    :mline	                        ( false 				                )
    :txt	                        ( sel_ver, Color( 222, 222, 222, 244 ), pref( 'rcfg_sel_ver' ) )
    :align                          ( 6                                     )
    :wide                           ( 100                                   )

    /*
    *   module > selected > desc
    */


    self.sel_desc 				    = ui.new( 'rlib.elm.text', parent       )
    :fill                           ( 'm', 5, 0, 0, 0                       )
    :param                          ( 'SetTextColor', Color( 255, 255, 255, 100 ) )
    :param                          ( 'SetFont', pref( 'rcfg_sel_desc' )    )
    :paramv                         ( 'SetData', sel_desc, 15               )
    :param                          ( 'SetAlwaysVisible', true              )

    /*
    *   module > selected > owner
    */

    self.sel_oid                    = ui.new( 'pnl', parent                 )
    :nodraw                         (                                       )
    :bottom                         ( 'm', 5, 0, 0, 0                       )
    :tall                           ( 30                                    )

                                    :draw( function( s, w, h )
                                        draw.SimpleText( 'Owner:', pref( 'rcfg_sel_ver' ), 0, 5, Color( 176, 83, 83, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( sel_oid, pref( 'rcfg_sel_ver' ), 50, 5, Color( 222, 222, 222, 244 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

                                        draw.SimpleText( 'Script:', pref( 'rcfg_sel_ver' ), 0, 23, Color( 176, 83, 83, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( sel_id, pref( 'rcfg_sel_ver' ), 50, 23, Color( 222, 222, 222, 244 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                    end )

end

/*
*   Think
*/

function PANEL:Think( )
    self.BaseClass.Think( self )

    local mousex    = math.Clamp( gui.MouseX( ), 1, ScrW( ) - 1 )
    local mousey    = math.Clamp( gui.MouseY( ), 1, ScrH( ) - 1 )

    if self.Dragging then
        local x     = mousex - self.Dragging[ 1 ]
        local y     = mousey - self.Dragging[ 2 ]

        if self:GetScreenLock( ) then
            x       = math.Clamp( x, 0, ScrW( ) - self:GetWide( ) )
            y       = math.Clamp( y, 0, ScrH( ) - self:GetTall( ) )
        end

        self:SetPos ( x, y )
    end

    if self.Sizing then
        local x         = mousex - self.Sizing[ 1 ]
        local y         = mousey - self.Sizing[ 2 ]
        local px, py    = self:GetPos( )

        if ( x < self.m_iMinWidth ) then x = self.m_iMinWidth elseif ( x > ScrW( ) - px and self:GetScreenLock( ) ) then x = ScrW( ) - px end
        if ( y < self.m_iMinHeight ) then y = self.m_iMinHeight elseif ( y > ScrH( ) - py and self:GetScreenLock( ) ) then y = ScrH( ) - py end

        self:SetSize    ( x, y )
        self:SetCursor  ( 'sizenwse' )
        return
    end

    if ( self.Hovered and self.m_bSizable and mousex > ( self.x + self:GetWide( ) - 20 ) and mousey > ( self.y + self:GetTall( ) - 20 ) ) then
        self:SetCursor  ( 'sizenwse' )
        return
    end

    if ( self.Hovered and self:GetDraggable( ) and mousey < ( self.y + 24 ) ) then
        self:SetCursor  ( 'sizeall' )
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
    self.Dragging           = nil
    self.Sizing             = nil
    self:MouseCapture       ( false )
end

/*
*   PerformLayout
*/

function PANEL:PerformLayout( )
    local titlePush         = 0
    self.BaseClass.PerformLayout( self )

    self.lblTitle:SetPos    ( 17 + titlePush, 7 )
    self.lblTitle:SetSize   ( self:GetWide( ) - 25 - titlePush, 20 )
end

/*
*   Paint
*
*   @param  : int w
*   @param  : int h
*/

function PANEL:Paint( w, h )
    design.rbox( 4, 5, 0, w - 10, h - 8, Color( 44, 49, 55, 255 ) )
    design.rbox_adv( 0, 5, 0, w - 10, 34, Color( 30, 30, 30, 255 ), true, true, false, false )
end

/*
*   ActionHide
*/

function PANEL:ActionHide( )
    self:SetMouseInputEnabled       ( false )
    self:SetKeyboardInputEnabled    ( false )
end

/*
*   ActionShow
*/

function PANEL:ActionShow( )
    self:SetMouseInputEnabled       ( true )
    self:SetKeyboardInputEnabled    ( true )
end

/*
*   GetTitle
*
*   @return : str
*/

function PANEL:GetTitle( )
    return self.title
end

/*
*   SetTitle
*
*   @param  : str title
*/

function PANEL:SetTitle( title )
    self.lblTitle:SetText( '' )
    self.title = title
end

/*
*   Destroy
*/

function PANEL:Destroy( )
    timex.expire( 'rlib_udm_check' )
    ui:destroy( self, true, true )
end

/*
*   SetState
*
*   @param  : bool bVisible
*/

function PANEL:SetState( bVisible )
    if bVisible then
        ui:show( self, true )
    else
        ui:hide( self, true )
    end
end

/*
*   register
*/

vgui.Register( 'rlib.lo.rcfg', PANEL, 'DFrame' )