/*
*   @package        : rlib
*   @author         : Richard [http://steamcommunity.com/profiles/76561198135875727]
*   @copyright      : (C) 2018 - 2020
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
local cvar                  = base.v

/*
*   localization > misc
*/

local cfg                   = base.settings

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
    *   declarations
    */

    self:_Declarations( )

    /*
    *   parent pnl
    */

    self                            = ui.get( self                          )
    :shadow                         ( true                                  )
    :sz                             ( self.ui_w, self.ui_h                  )
    :wmin                           ( self.ui_w * self.ui_w_min             )
    :hmin                           ( self.ui_h * self.ui_w_min             )
    :padding                        ( 2, 34, 2, 3                           )
    :popup                          (                                       )
    :notitle                        (                                       )
    :canresize                      ( true                                  )
    :canclose                       ( false                                 )
    :scrlock                        ( true                                  )
    :appear                         ( 3                                     )

    /*
    *   titlebar
    */

    self.lblTitle                   = ui.new( 'lbl', self                   )
    :notext                         (                                       )
    :font                           ( pref( 'diag_title' )                  )
    :clr                            ( Color( 255, 255, 255, self.Alpha )    )

                                    :draw ( function( s, w, h )
                                        draw.SimpleText( utf8.char( 9930 ), pref( 'diag_icon' ), 0, 8, self.clr_hdr_ico, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( self:GetTitle( ), pref( 'diag_title' ), 25, h / 2, Color( 237, 237, 237, self.Alpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   btn > close
    *
    *   to overwrite existing properties from the skin; do not change this buttons name to anything other
    *   than btnClose otherwise it wont inherit position/size properties
    */

    self.btnClose                   = ui.new( 'btn', self                   )
    :bsetup                         (                                       )
    :notext                         (                                       )
    :tip                            ( lang( 'ui_tip_close' )                )
    :ocr                            ( self                                  )

                                    :draw ( function( s, w, h )
                                        local clr_txt = s.hover and Color( 200, 55, 55, self.Alpha ) or Color( 237, 237, 237, self.Alpha )
                                        draw.SimpleText( helper.get:utf8( 'x' ), pref( 'diag_ctrl_exit' ), w / 2 - 1, 4, clr_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   btn > minimize
    *   replaces default derma self.btnMaxim
    *
    *   to overwrite existing properties from the skin; do not change this
    *   buttons name to anything other than btnClose otherwise it wont
    *   inherit position/size properties
    */

    self.btnMaxim                   = ui.new( 'btn', self                   )
    :bsetup                         (                                       )
    :notext                         (                                       )
    :tooltip                        ( lang( 'ui_tip_minimize' )             )

                                    :draw( function( s, w, h )
                                        local clr_txt = s.hover and Color( 200, 55, 55, self.Alpha ) or Color( 237, 237, 237, self.Alpha )
                                        draw.SimpleText( helper.get:utf8( 'close' ), pref( 'diag_ctrl_min' ), w / 2, 9, clr_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

                                    :oc( function( s )
                                        self:ActionHide( )
                                    end )

    /*
    *   subparent pnl
    */

    self.sub                        = ui.new( 'pnl', self                   )
    :nodraw                         (                                       )
    :fill                           ( 'm', 10, self.sz_sub_t, 10, self.sz_sub_b )

    /*
    *   header
    */

    self.hdr                        = ui.new( 'pnl', self.sub               )
    :top                            ( 'm', 0, 0, 0, self.sz_header_t        )
    :tall                           ( self.sz_header_h                      )

                                    :draw( function( s, w, h )
                                        design.rbox( 6, 0, 0, w, h, self.clr_g_hdr_box )
                                    end )

    /*
    *   header > left
    */

    self.hdr_l                      = ui.new( 'pnl', self.hdr               )
    :left                           ( 'm', 10, 0, 10, 0                     )
    :wide                           ( self.ui_w / 2                         )

                                    :draw( function( s, w, h )
                                        draw.SimpleText( self.v_servip, pref( 'diag_hdr_value' ), 5, h / 2, self.clr_g_hdr_txt, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   header > right
    */

    self.hdr_r                      = ui.new( 'pnl', self.hdr               )
    :right                          ( 'm', 10, 0, 10, 0                     )
    :wide                           ( self.ui_w / 2                         )

                                    :draw( function( s, w, h )
                                        draw.SimpleText( string.format( '%i x %i', ScrW( ), ScrH( ) ), pref( 'diag_hdr_value' ), w - 5, h / 2, self.clr_g_hdr_txt, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   header
    */

    self.body                       = ui.new( 'pnl', self.sub, 1            )
    :fill                           ( 'm', 0                                )

    /*
    *   commands > icon layout
    */

    self.seg                        = ui.new( 'dico', self.body             )
    :nodraw                         (                                       )
    :fill                           ( 'm', 0, 0, 0, 0                       )
    :spacing                        ( self.sz_dico_pad, self.sz_dico_pad    )

    /*
    *   segment > fps
    */

    self.seg.fps                    = ui.new( 'pnl', self.seg               )
    :size                           ( self.sz_dico_w, self.sz_dico_h        )

                                    :logic( function( s )
                                        if self.th_fps > CurTime( ) then return end
                                        self.gr_fps     = base.sys:GetFPS( true )
                                        self.th_fps     = CurTime( ) + ( self.cvar_val or 0.5 )
                                    end )

                                    :draw( function( s, w, h )
                                        design.rbox( 6, 0, 0, w, h, self.clr_g_seg_box )
                                        draw.SimpleText( lang( 'diag_lbl_fps' ), pref( 'diag_title' ), w / 2, h / 2 - 13, self.clr_g_seg_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( self.gr_fps, pref( 'diag_value' ), w / 2, h / 2 + 10, self.clr_g_seg_val, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   segment > players
    */

    self.seg.ply                    = ui.new( 'pnl', self.seg               )
    :size                           ( self.sz_dico_w, self.sz_dico_h        )

                                    :logic( function( s )
                                        if self.th_ply > CurTime( ) then return end
                                        self.sg_ply     = player.GetCount( )
                                        self.th_ply     = CurTime( ) + 5
                                    end )

                                    :draw( function( s, w, h )
                                        design.rbox( 6, 0, 0, w, h, self.clr_g_seg_box )
                                        draw.SimpleText( lang( 'diag_lbl_ply' ), pref( 'diag_title' ), w / 2, h / 2 - 13, self.clr_g_seg_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( self.sg_ply, pref( 'diag_value' ), w / 2, h / 2 + 10, self.clr_g_seg_val, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   segment > curtime
    */

    self.seg.cur                    = ui.new( 'pnl', self.seg               )
    :size                           ( self.sz_dico_w, self.sz_dico_h        )

                                    :logic( function( s )
                                        if self.th_cur > CurTime( ) then return end
                                        local cur       = CurTime( )
                                        self.sg_cur     = math.Round( cur )
                                        self.th_cur     = CurTime( ) + 1
                                    end )

                                    :draw( function( s, w, h )
                                        design.rbox( 6, 0, 0, w, h, self.clr_g_seg_box )
                                        draw.SimpleText( lang( 'diag_lbl_cur' ), pref( 'diag_title' ), w / 2, h / 2 - 13, self.clr_g_seg_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( self.sg_cur, pref( 'diag_value' ), w / 2, h / 2 + 10, self.clr_g_seg_val, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )


    /*
    *   segment > timers
    */

    self.seg.timers                 = ui.new( 'pnl', self.seg               )
    :size                           ( self.sz_dico_w, self.sz_dico_h        )

                                    :logic( function( s )
                                        if self.th_cti > CurTime( ) then return end
                                        self.sg_cti     = timex.count( true )
                                        self.th_cti     = CurTime( ) + 0.5
                                    end )

                                    :draw( function( s, w, h )
                                        design.rbox( 6, 0, 0, w, h, self.clr_g_seg_box )
                                        draw.SimpleText( lang( 'diag_lbl_timers' ), pref( 'diag_title' ), w / 2, h / 2 - 13, self.clr_g_seg_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( self.sg_cti, pref( 'diag_value' ), w / 2, h / 2 + 10, self.clr_g_seg_val, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   segment > net
    */

    self.seg.net                    = ui.new( 'pnl', self.seg               )
    :size                           ( self.sz_dico_w, self.sz_dico_h        )

                                    :logic( function( s )
                                        if self.th_net > CurTime( ) then return end
                                        self.sg_net     = rnet.count( )
                                        self.th_net     = CurTime( ) + 0.5
                                    end )

                                    :draw( function( s, w, h )
                                        design.rbox( 6, 0, 0, w, h, self.clr_g_seg_box )
                                        draw.SimpleText( lang( 'diag_lbl_net' ), pref( 'diag_title' ), w / 2, h / 2 - 13, self.clr_g_seg_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( self.sg_net, pref( 'diag_value' ), w / 2, h / 2 + 10, self.clr_g_seg_val, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   segment > hooks
    */

    self.seg.hooks                  = ui.new( 'pnl', self.seg               )
    :size                           ( self.sz_dico_w, self.sz_dico_h        )

                                    :logic( function( s )
                                        if self.th_hook > CurTime( ) then return end
                                        self.sg_hook    = rhook.count( )
                                        self.th_hook    = CurTime( ) + 0.5
                                    end )

                                    :draw( function( s, w, h )
                                        design.rbox( 6, 0, 0, w, h, self.clr_g_seg_box )
                                        draw.SimpleText( lang( 'diag_lbl_hook' ), pref( 'diag_title' ), w / 2, h / 2 - 13, self.clr_g_seg_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( self.sg_hook, pref( 'diag_value' ), w / 2, h / 2 + 10, self.clr_g_seg_val, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   graph > container
    */

    self.gr                         = ui.new( 'pnl', self.body, 1           )
    :bottom                         ( 'm', 0, self.sz_r1_t, 0, 0            )
    :tall                           ( self.sz_r1_h                          )

                                    :draw( function( s, w, h )
                                        design.rbox( 5, 0, 0, w, h, Color( 25, 25, 25, self.Alpha ) )
                                    end )

    /*
    *   graph > header
    */

    self.gr.h                       = ui.new( 'pnl', self.gr, 1             )
    :top                            ( 'm', 7, self.sz_r1_hdr_t, 7, 0        )
    :tall                           ( self.sz_r1_hdr_h                      )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, h, Color( 35, 35, 35, self.Alpha ) )
                                    end )

    /*
    *   slider > container
    */

    self.sli                        = ui.new( 'pnl', self.gr.h, 1           )
    :fill                           ( 'm', 10, 8, 25, 0                     )

    /*
    *   slider > ct
    */

    self.sli.amt                    = ui.new( 'lbl', self.sli, 1            )
    :left                           ( 'm', 0, 0, 5, 7                       )
    :wide                           ( 35                                    )
    :txt                            ( self.cvar_id:GetFloat( )              )
    :font                           ( pref( 'diag_chart_value' )            )
    :align                          ( 5                                     )

    /*
    *   slider > element
    */

    self.sli.elm                    = ui.new( 'rlib.ui.slider', self.sli    )
    :fill                           ( 'm', 10, 0, 0, 5                      )
    :minmax                         ( 0, 1                                  )
    :val                            ( self.cvar_id:GetFloat( )              )
    :param                          ( 'SetKnobColor', Color( 51, 169, 74 )  )
    :var                            ( 'convarname', self.cvar_id            )
    :param                          ( 'SetDecimals', 1                      )

                                    :ovc( function( s )
                                        self.cvar_id:SetFloat( s:GetValue( ) )
                                        self.sli.amt:SetText( s:GetValue( ) )
                                    end )

    self:GenGraph( )

    /*
    *   calc tall
    */

    self:SetTall                    ( self.ui_h )

end

/*
*   GetValue
*
*   validates the data
*
*   @param  : int int
*   @return : int
*/

function PANEL:GetValue( int )
    if ( not int ) or int ~= int or int == math.huge then return 'Bad Data' end

    return math.Round( int )
end

/*
*   GetFPS
*/

function PANEL:GetFPS( )
    self.gr_plots   = self.gr_plots or { }
                    if not istable( self.gr_plots ) then return end

    local point     = self.gr_bCalibrate and self.gr_calibrate_i or base.sys:GetFPS( true )
    self.gr_fps     = point

    table.insert( self.gr_plots, point )

    self.gr_fps_ch  = CurTime( ) + ( self.cvar_val or 0.5 )
end

/*
*   PlotGraph
*
*   @param  : tbl coords
*   @param  : int x
*   @param  : int y
*   @param  : int h
*   @param  : int z
*/

function PANEL:PlotGraph( coords, x, y, h, z )
    if not istable( coords ) then return end

    x                   = x or 0
    y                   = y or 0
    h                   = h or 0
    z                   = z or 0

    local y_pos         = y - 1
    local z_dif         = h - z

    for i, v in helper.get.table( coords, ipairs ) do
        local a, b 	    = coords[ i ], coords[ i + 1 ]
                        if i == #coords then b = v end

        /*
        *   double lines > thicc
        */

        local a_x, b_x  = a[ 1 ], b[ 1 ]

        local a_y       = a[ 2 ] + y_pos
        a_y             = math.Clamp( a_y, 0, z_dif )

        local b_y       = b[ 2 ] + y_pos
        b_y             = math.Clamp( b_y, 0, z_dif )

        design.line( a_x, a_y, b_x, b_y, self.clr_gr_plot )
        design.line( a_x, a_y + 1, b_x, b_y + 1, self.clr_gr_plot )
    end
end

/*
*   GenGraph
*/

function PANEL:GenGraph( )

    /*
    *   create graph labels
    */

    local labels    = { self.gr_val_min }
    for i = 2, self.gr_leg_i do
        labels[ i ] = math.Round( Lerp( i / self.gr_leg_i, self.gr_val_min, self.gr_val_max ) )
    end

    /*
    *   flip labels
    *
    *   lowest ( btm ) > highest ( top )
    */

    labels 			                = table.Reverse( labels )

    /*
    *   graph > container
    *
    *   left-side labels
    */

    self.gr.labels                  = ui.new( 'pnl', self.gr                )
    :fill                           ( 'm', 0                                )

                                    :draw( function( s, w, h )
                                        local y 		= self.gr_marg_t + self.gr_marg_o
                                        local sz 		= #labels or 0
                                        h 				= self.gr.plots:GetTall( )

                                        /*
                                        *   draw graph labels
                                        */

                                        for i, v in helper.get.table( labels, ipairs ) do
                                            local val = self:GetValue( v ) or 9

                                            draw.SimpleText( val, pref( 'diag_chart_legend' ), self.gr_lbl_w / 2, y, self.clr_txt_leg, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

                                            y = y + ( ( 1 / sz ) * h )
                                        end
                                    end )

    /*
    *   graph > container > plots
    */

    self.gr.plots                   = ui.new( 'pnl', self.gr.labels         )
    :fill                           ( 'm', self.gr_lbl_w, self.gr_marg_o    )

                                    :logic( function( s )

                                        self.coords = { }

                                        /*
                                        *   data
                                        */

                                        for i, v in helper.get.table( self.gr_plots, ipairs ) do
                                            local diff  = self.gr_val_max - self.gr_val_min
                                            local x 	= ( 1 + ( ( i + 1 ) * self.gr_mult ) ) - 1
                                            local y		= ( ( self.gr_val_min == self.gr_val_max ) and ( 1 - 1 ) * s.h ) or ( ( ( 1 - ( ( v - self.gr_val_min ) / diff ) ) * s.h ) + self.gr_oset ) or 0

                                            /*
                                            *   remove hold history if points exceed pnl width
                                            */

                                            if x >= s.w then
                                                table.remove( self.gr_plots, 1 )
                                            end

                                            table.insert( self.coords, { x, y } )
                                        end

                                        /*
                                        *   calc fps
                                        */

                                        if self.gr_fps_ch > CurTime( ) then return end

                                        /*
                                        *   get > fps
                                        */

                                        self:GetFPS( )
                                    end )

                                    :draw( function( s, w, h )
                                        s.h, s.w        = h, w
                                        local sz 		= #labels or 0
                                        local x         = 0
                                        local y 		= self.gr_marg_t

                                        /*
                                        *   graph lines
                                        */

                                        for i, v in helper.get.table( labels, ipairs ) do
                                            design.line( 0, y, w, y, self.clr_gr_lines )

                                            y = y + ( ( 1 / sz ) * h )
                                        end

                                        /*
                                        *   set y
                                        */

                                        y = self.gr_marg_t

                                        /*
                                        *   draw points
                                        */

                                        self:PlotGraph( self.coords, x, y, h )

                                    end )

end

/*
*   FirstRun
*/

function PANEL:FirstRun( )
    if ui:ok( self.sli.amt ) then
        local amt = math.Round( self.cvar_id:GetFloat( ), 1 )
        self.sli.amt:SetText( amt )
    end

    self.bInitialized = true
end

/*
*   Think
*/

function PANEL:Think( )

    /*
    *   disable think when hidden
    */

    if self.Alpha < 1 then return end

    /*
    *   modify zpos when hidden
    */

    if not self.is_visible then self:MoveToBack( ) end

    /*
    *   base class
    */

    self.BaseClass.Think( self )

    /*
    *   force on top
    */

    self:SetDrawOnTop( true )

    /*
    *   deckare < cvar val
    *   apply min, max
    */

    local calc_rfr  = math.Clamp( self.cvar_id:GetFloat( ), 0.05, 1 )
    self.cvar_val   = calc_rfr

    /*
    *   max height
    */

    if self:GetTall( ) > self.ui_h then
        self:SetTall( self.ui_h )
    end

    /*
    *   dragging
    */

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

    /*
    *   sizing
    */

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
    self.Dragging   = nil
    self.Sizing     = nil
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

    self.lblTitle:SetPos    ( 11 + titlePush, 7 )
    self.lblTitle:SetSize   ( self:GetWide( ) - 25 - titlePush, 20 )

    self.btnClose:SetPos    ( self:GetWide( ) - 32, 7 )
    self.btnClose:SetSize   ( 22, 20 )

    self.btnMaxim:SetPos    ( self:GetWide( ) - 32 - 10 - 22, 7 )
    self.btnMaxim:SetSize   ( 22, 20 )
end

/*
*   Paint
*
*   @param  : int w
*   @param  : int h
*/

function PANEL:Paint( w, h )
    if self.Alpha < 1 then return end

    design.rbox( 4, 0, 0, w, h, Color( 35, 35, 35, self.Alpha ) )
    design.rbox_adv( 4, 2, 2, w - 4, 34 - 4, Color( 26, 26, 26, self.Alpha ), true, true, false, false )

    -- resizing arrow
    draw.SimpleText( utf8.char( 9698 ), pref( 'diag_resizer' ), w - 3, h - 7, Color( 240, 72, 133, self.Alpha ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
    draw.SimpleText( utf8.char( 9698 ), pref( 'diag_resizer' ), w - 5, h - 9, Color( 40, 40, 40, self.Alpha ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
end

/*
*   ActionHide
*/

function PANEL:ActionHide( )
    self.is_visible = false

    self:SetState( )
    self:SetMouseInputEnabled       ( false )
    self:SetKeyboardInputEnabled    ( false )
end

/*
*   ActionShow
*/

function PANEL:ActionShow( )
    self.is_visible = true
    self:SetState( )
    self:SetMouseInputEnabled       ( true )
    self:SetKeyboardInputEnabled    ( true )
end

/*
*   ActionToggle
*/

function PANEL:ActionToggle( )
    if self.is_visible then
        self:ActionHide( )
    else
        self:ActionShow( )
    end
end

/*
*   SetState
*/

function PANEL:SetState( )
    self.Alpha = self.is_visible and 255 or 0
    if IsValid( self.btnClose ) then self.btnClose:SetAlpha( self.Alpha ) end
end

/*
*   GetTitle
*
*   @return : str
*/

function PANEL:GetTitle( )
    return ( helper.str:ok( self._title ) and self._title ) or lang( 'diag_title' )
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
*   Declarations
*
*   all definitions associated to this panel
*/

function PANEL:_Declarations( )

    /*
    *   declare > general
    */

    self.Alpha                      = 255
    self.is_visible                 = true
    self.v_servip                   = game.GetIPAddress( )
    self.cvar_id                    = GetConVar( 'rlib_diag_refreshrate' )

    /*
    *	declare > clrs
    */

    self.clr_hdr_ico                = Color( 240, 72, 133, 255 )
    self.clr_gr_lines               = Color( 255, 255, 255, 50 )
    self.clr_gr_plot                = Color( 229, 213, 35, 255 )
    self.clr_g_hdr_box              = Color( 25, 25, 25, 200 )
    self.clr_g_hdr_txt              = Color( 255, 255, 255, 255 )
    self.clr_g_seg_box              = Color( 25, 25, 25, 200 )
    self.clr_g_seg_txt              = Color( 194, 57, 83, 255 )
    self.clr_g_seg_val              = Color( 255, 255, 255, 255 )

    /*
    *	declare > graph vals
    */

    self.gr_bCalibrate              = false
    self.gr_calibrate_i             = 100
    self.gr_fps_ch 	                = 5
    self.gr_val_r1_h                = 230
    self.gr_val_r1_hdr_h            = 30
    self.gr_val_min                 = 0
    self.gr_val_max                 = 350
    self.gr_lbl_w                   = 35
    self.gr_marg_o                  = 16
    self.gr_marg_t                  = 8
    self.gr_mult                    = 2
    self.gr_plots 		            = { }
    self.gr_leg_i                   = 7
    self.gr_oset                    = 5
    self.gr_fps                     = 0
    self.gr_cv_reftime              = GetConVar( 'rlib_diag_refreshrate' )

    /*
    *	declare > segments > think
    */

    self.th_fps                     = 0
    self.th_cur                     = 0
    self.th_cti                     = 0
    self.th_ply                     = 0
    self.th_net                     = 0
    self.th_hook                    = 0

    /*
    *	declare > segments > data
    */

    self.sg_cur                     = 0
    self.sg_cti                     = 0
    self.sg_ply                     = 0
    self.sg_net                     = 0
    self.sg_hook                    = 0

    /*
    *   declare > rgba
    */

    self.state                      = 0
    self.r, self.g, self.b          = 0, 0, 0

    /*
    *   declare > sizing
    */

    self.sz_ui_w                    = 320                   -- main         : width, height
    self.ui_w_min                   = 1                     -- main         : width minimum
    self.sz_header_h                = 30                    -- header       : height
    self.sz_header_t                = 5                     -- header       : top margin
    self.sz_sub_t                   = 5                     -- sub          : top margin
    self.sz_sub_b                   = 10                    -- sub          : bottom margin
    self.sz_dico_h                  = 76                    -- dico         : item height
    self.sz_dico_w                  = 95                    -- dico         : item width
    self.sz_dico_pad                = 5                     -- dico         : spacing
    self.sz_r1_h                    = 230                   -- fps graph    : height
    self.sz_r1_t                    = 20                    -- fps graph    : top margin
    self.sz_r1_hdr_h                = 30                    -- fps graph    : header height
    self.sz_r1_hdr_t                = 7                     -- fps graph    : top margin

    /*
    *   declare > sizing > main
    */

    self.ui_w                       = self.sz_ui_w
    self.ui_h                       = self.sz_header_h + self.sz_header_t + self.sz_sub_t + self.sz_sub_b + ( self.sz_dico_h * 2 ) + ( self.sz_dico_pad * 2 ) + self.sz_r1_t + self.sz_r1_h + 20

end

/*
*   register
*/

vgui.Register( 'rlib.lo.diag', PANEL, 'DFrame' )