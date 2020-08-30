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
local konsole               = base.k
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
    *   sizing
    */

    local state, r, g, b            = 0, 255, 0, 0          -- rgb
    local sz_ui_w                   = 320                   -- main         : width, height
    local ui_w_min                  = 1                     -- main         : width minimum
    local sz_header_h               = 30                    -- header       : height
    local sz_header_t               = 5                     -- header       : top margin
    local sz_sub_t                  = 5                     -- sub          : top margin
    local sz_sub_b                  = 10                    -- sub          : bottom margin
    local sz_dico_h                 = 76                    -- dico         : item height
    local sz_dico_w                 = 95                    -- dico         : item width
    local sz_dico_pad               = 5                     -- dico         : spacing
    local sz_r1_h                   = 230                   -- fps graph    : height
    local sz_r1_t                   = 20                    -- fps graph    : top margin
    local sz_r1_hdr_h               = 30                    -- fps graph    : header height
    local sz_r1_hdr_t               = 7                     -- fps graph    : top margin

    self.ui_w                       = sz_ui_w
    self.ui_h                       = sz_header_h + sz_header_t + sz_sub_t + sz_sub_b + ( sz_dico_h * 2 ) + ( sz_dico_pad * 2 ) + sz_r1_t + sz_r1_h + 20

    /*
    *   localized colorization
    */

    local clr_header                = Color( 255, 255, 255, 255 )
    local clr_title                 = Color( 194, 57, 83, 255 )
    local clr_value                 = Color( 255, 255, 255, 255 )

    /*
    *   parent pnl
    */

    self:SetPaintShadow             ( true                                  )
    self:SetSize                    ( self.ui_w, self.ui_h                  )
    self:SetMinWidth                ( self.ui_w * ui_w_min                  )
    self:SetMinHeight               ( self.ui_h * ui_w_min                  )
    self:DockPadding                ( 2, 34, 2, 3                           )
    self:MakePopup                  (                                       )
    self:SetTitle                   ( ''                                    )
    self:SetSizable                 ( true                                  )
    self:ShowCloseButton            ( false                                 )
    self:SetScreenLock              ( true                                  )

    /*
    *   defaults
    */

    self.Alpha                      = 255
    self.is_visible                 = true
    self.v_servip                   = game.GetIPAddress( )
    self.cvar_id                    = GetConVar( 'rlib_diag_refreshrate' )
    self.th_fps_ch 	                = 0
    self.th_fps                     = 0
    self.th_cur                     = 0
    self.th_cti                     = 0
    self.th_ply                     = 0
    self.th_net                     = 0
    self.th_hook                    = 0
    self.v_cur                      = 0
    self.v_fps                      = 0
    self.v_cti                      = 0
    self.v_ply                      = 0
    self.v_net                      = 0
    self.v_hook                     = 0
    self.ghistory 		            = { }

    /*
    *   display parent :: static || animated
    */

    if cvar:GetBool( 'rlib_animations_enabled' ) then
        self:SetPos( ScrW( ) - self.ui_w - 20, ScrH( ) + self.ui_h )
        self:MoveTo( ScrW( ) - self.ui_w - 20, ScrH( ) - self.ui_h - 20, 0.4, 0, -1 )
    else
        self:SetPos( ScrW( ) - self.ui_w - 20, ScrH( ) - self.ui_h - 20 )
    end

    /*
    *   titlebar
    */

    self.lblTitle                   = ui.new( 'lbl', self                   )
    :notext                         (                                       )
    :font                           ( pref( 'konsole_title' )               )
    :clr                            ( Color( 255, 255, 255, self.Alpha )    )

                                    :draw ( function( s, w, h )
                                        if ( state == 0 ) then
                                            g = g + 1
                                            if ( g == 255 ) then state = 1 end
                                        elseif ( state == 1 ) then
                                            r = r - 1
                                            if ( r == 0 ) then state = 2 end
                                        elseif ( state == 2 ) then
                                            b = b + 1
                                            if ( b == 255 ) then state = 3 end
                                        elseif ( state == 3 ) then
                                            g = g - 1
                                            if ( g == 0 ) then state = 4 end
                                        elseif ( state == 4 ) then
                                            r = r + 1
                                            if ( r == 255 ) then state = 5 end
                                        elseif ( state == 5 ) then
                                            b = b - 1
                                            if ( b == 0 ) then state = 0 end
                                        end

                                        local clr_rgb = Color( r, g, b, self.Alpha )

                                        draw.SimpleText( utf8.char( 9930 ), pref( 'konsole_icon' ), 0, 8, clr_rgb, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( self:GetTitle( ), pref( 'konsole_title' ), 25, h / 2, Color( 237, 237, 237, self.Alpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
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

                                    :draw ( function( s, w, h )
                                        local clr_txt = s.hover and Color( 200, 55, 55, self.Alpha ) or Color( 237, 237, 237, self.Alpha )
                                        draw.SimpleText( helper.get:utf8( 'x' ), pref( 'diag_ctrl_exit' ), w / 2 - 1, 4, clr_txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

                                    :oc( function( s )
                                        self:Destroy( )
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
    :fill                           ( 'm', 10, sz_sub_t, 10, sz_sub_b )

    /*
    *   header
    */

    self.hdr                        = ui.new( 'pnl', self.sub               )
    :top                            ( 'm', 0, 0, 0, sz_header_t             )
    :tall                           ( sz_header_h                           )

                                    :draw( function( s, w, h )
                                        design.rbox( 6, 0, 0, w, h, Color( 25, 25, 25, 200 ) )
                                    end )

    /*
    *   header > left
    */

    self.hdr_l                      = ui.new( 'pnl', self.hdr               )
    :left                           ( 'm', 10, 0, 10, 0                     )
    :wide                           ( sz_ui_w / 2                           )

                                    :draw( function( s, w, h )
                                        draw.SimpleText( self.v_servip, pref( 'diag_hdr_value' ), 5, h / 2, clr_header, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   header > right
    */

    self.hdr_r                      = ui.new( 'pnl', self.hdr               )
    :right                          ( 'm', 10, 0, 10, 0                     )
    :wide                           ( sz_ui_w / 2                           )

                                    :draw( function( s, w, h )
                                        draw.SimpleText( string.format( '%i x %i', ScrW( ), ScrH( ) ), pref( 'diag_hdr_value' ), w - 5, h / 2, clr_header, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   header
    */

    self.body                       = ui.new( 'pnl', self.sub, 1            )
    :fill                           ( 'm', 0                                )

    /*
    *   commands > icon layout
    */

    self.dico                       = ui.new( 'dico', self.body             )
    :nodraw                         (                                       )
    :fill                           ( 'm', 0, 0, 0, 0                       )
    :spacing                        ( sz_dico_pad, sz_dico_pad              )

                                    :logic( function ( s )
                                        --local x = self.spnl.VBar.Enabled and 10 or 0
                                        --s:DockMargin( 0, 0, x, 0 )
                                    end )

    /*
    *   element > fps
    */

    self.fps                        = ui.new( 'pnl', self.dico, 1           )
    :size                           ( sz_dico_w, sz_dico_h                  )

                                    :logic( function( s )
                                        if self.th_fps > CurTime( ) then return end
                                        self.v_fps = base.sys:GetFPS( true )
                                        self.th_fps = CurTime( ) + ( self.cvar_val or 0.5 )
                                    end )

                                    :draw( function( s, w, h )
                                        design.rbox( 6, 0, 0, w, h, Color( 25, 25, 25, 200 ) )
                                        draw.SimpleText( lang( 'diag_lbl_fps' ), pref( 'diag_title' ), w / 2, h / 2 - 13, clr_title, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( self.v_fps, pref( 'diag_value' ), w / 2, h / 2 + 10, clr_value, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   element > players
    */

    self.ply                        = ui.new( 'pnl', self.dico, 1           )
    :size                           ( sz_dico_w, sz_dico_h                  )

                                    :logic( function( s )
                                        if self.th_ply > CurTime( ) then return end
                                        self.v_ply      = player.GetCount( )
                                        self.th_ply     = CurTime( ) + 5
                                    end )

                                    :draw( function( s, w, h )
                                        design.rbox( 6, 0, 0, w, h, Color( 25, 25, 25, 200 ) )
                                        draw.SimpleText( lang( 'diag_lbl_ply' ), pref( 'diag_title' ), w / 2, h / 2 - 13, clr_title, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( self.v_ply, pref( 'diag_value' ), w / 2, h / 2 + 10, clr_value, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   element > curtime
    */

    self.cur                        = ui.new( 'pnl', self.dico, 1           )
    :size                           ( sz_dico_w, sz_dico_h                  )

                                    :logic( function( s )
                                        if self.th_cur > CurTime( ) then return end
                                        local cur       = CurTime( )
                                        self.v_cur      = math.Round( cur )
                                        self.th_cur     = CurTime( ) + 1
                                    end )

                                    :draw( function( s, w, h )
                                        design.rbox( 6, 0, 0, w, h, Color( 25, 25, 25, 200 ) )
                                        draw.SimpleText( lang( 'diag_lbl_cur' ), pref( 'diag_title' ), w / 2, h / 2 - 13, clr_title, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( self.v_cur, pref( 'diag_value' ), w / 2, h / 2 + 10, clr_value, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )


    /*
    *   element > timers
    */

    self.timers                     = ui.new( 'pnl', self.dico, 1           )
    :size                           ( sz_dico_w, sz_dico_h                  )

                                    :logic( function( s )
                                        if self.th_cti > CurTime( ) then return end
                                        self.v_cti      = timex.count( true )
                                        self.th_cti     = CurTime( ) + 0.5
                                    end )

                                    :draw( function( s, w, h )
                                        design.rbox( 6, 0, 0, w, h, Color( 25, 25, 25, 200 ) )
                                        draw.SimpleText( lang( 'diag_lbl_timers' ), pref( 'diag_title' ), w / 2, h / 2 - 13, clr_title, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( self.v_cti, pref( 'diag_value' ), w / 2, h / 2 + 10, clr_value, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )


    /*
    *   element > net
    */

    self.net                        = ui.new( 'pnl', self.dico, 1           )
    :size                           ( sz_dico_w, sz_dico_h                  )

                                    :logic( function( s )
                                        if self.th_net > CurTime( ) then return end
                                        self.v_net      = rnet.count( )
                                        self.th_net     = CurTime( ) + 0.5
                                    end )

                                    :draw( function( s, w, h )
                                        design.rbox( 6, 0, 0, w, h, Color( 25, 25, 25, 200 ) )
                                        draw.SimpleText( lang( 'diag_lbl_net' ), pref( 'diag_title' ), w / 2, h / 2 - 13, clr_title, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( self.v_net, pref( 'diag_value' ), w / 2, h / 2 + 10, clr_value, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   element > hooks
    */

    self.hooks                      = ui.new( 'pnl', self.dico, 1           )
    :size                           ( sz_dico_w, sz_dico_h                  )

                                    :logic( function( s )
                                        if self.th_hook > CurTime( ) then return end
                                        self.v_hook     = rhook.count( )
                                        self.th_hook    = CurTime( ) + 0.5
                                    end )

                                    :draw( function( s, w, h )
                                        design.rbox( 6, 0, 0, w, h, Color( 25, 25, 25, 200 ) )
                                        draw.SimpleText( lang( 'diag_lbl_hook' ), pref( 'diag_title' ), w / 2, h / 2 - 13, clr_title, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                        draw.SimpleText( self.v_hook, pref( 'diag_value' ), w / 2, h / 2 + 10, clr_value, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                                    end )

    /*
    *   row > 2
    */

    self.r1                         = ui.new( 'pnl', self.body, 1           )
    :bottom                         ( 'm', 0, sz_r1_t, 0, 0                 )
    :tall                           ( sz_r1_h                               )

                                    :draw( function( s, w, h )
                                        design.rbox( 5, 0, 0, w, h, Color( 25, 25, 25, self.Alpha ) )
                                    end )

    /*
    *   row 1 > header
    */

    self.r1.hdr                     = ui.new( 'pnl', self.r1, 1             )
    :top                            ( 'm', 7, sz_r1_hdr_t, 7, 0             )
    :tall                           ( sz_r1_hdr_h                           )

                                    :draw( function( s, w, h )
                                        design.box( 0, 0, w, h, Color( 35, 35, 35, self.Alpha ) )
                                    end )

    /*
    *   slider > ct
    */

    self.slider                     = ui.new( 'pnl', self.r1.hdr, 1         )
    :fill                           ( 'm', 10, 8, 25, 0                     )

    /*
    *   slider > ct
    */

    self.slider.amt                 = ui.new( 'lbl', self.slider, 1         )
    :left                           ( 'm', 0, 0, 5, 7                       )
    :wide                           ( 35                                    )
    :txt                            ( self.cvar_id:GetFloat( )              )
    :font                           ( pref( 'diag_chart_value' )            )
    :align                          ( 5                                     )

    /*
    *   slider > element
    */

    self.slider.elm                 = ui.new( 'rlib.ui.slider', self.slider )
    :fill                           ( 'm', 10, 0, 0, 5                      )
    :minmax                         ( 0, 1                                  )
    :val                            ( self.cvar_id:GetFloat( )              )
    :param                          ( 'SetKnobColor', Color( 51, 169, 74 )  )
    :var                            ( 'convarname', self.cvar_id            )
    :param                          ( 'SetDecimals', 1                      )

                                    :ovc( function( s )
                                        self.cvar_id:SetFloat( s:GetValue( ) )
                                        self.slider.amt:SetText( s:GetValue( ) )
                                    end )

    self:MakeChart( )

    /*
    *   calc tall
    */

    self:SetTall                    ( self.ui_h )

end

/*
*   VData
*
*   validates the data
*
*   @param  : int i
*   @return : int
*/

function PANEL:VData( i )
    if i ~= i or i == math.huge then
        return 'No data'
    end

    return math.Round( i )
end

/*
*   GetFPS
*/

function PANEL:GetFPS( )
    self.ghistory = self.ghistory or { }
    if not istable( self.ghistory ) then return end

    local fps = base.sys:GetFPS( true )
    table.insert( self.ghistory, fps )

    self.th_fps_ch = CurTime( ) + ( self.cvar_val or 0.5 )
end

/*
*   DrawPoints
*
*   @param  : tbl tbl
*   @param  : int x
*   @param  : int y
*/

function PANEL:DrawPoints( tbl, x, y )
    if not istable( tbl ) then return end
    x = isnumber( x ) and x or 0

    local clr_line  = Color( 229, 213, 35, 255 )

    for i, v in helper.get.table( tbl, ipairs ) do
        local ch_sta 	    = tbl[ i ]
        local ch_end 		= tbl[ i + 1 ]
        if i == #tbl then
            ch_end 		= v
        end

        design.line( ch_sta[ 1 ], ch_sta[ 2 ] + y, ch_end[ 1 ], ch_end[ 2 ] + y, clr_line )
        design.line( ch_sta[ 1 ], ch_sta[ 2 ] + 1 + y, ch_end[ 1 ], ch_end[ 2 ] + 1 + y, clr_line )
        design.line( ch_sta[ 1 ], ch_sta[ 2 ] - 1 + y, ch_end[ 1 ], ch_end[ 2 ] - 1 + y, clr_line )
    end
end

/*
*   MakeChart
*/

function PANEL:MakeChart( )

    local rm            = table.remove

    local data 	        = table.Reverse( self.ghistory )
    local a 	        = 0     -- grid : lowest
    local b 	        = 350   -- grid : highest
    local axis_y_w      = 45    -- y axis label width
    local margin_y      = 16
    local top_y         = 8     -- top padding for y axis
    local mult 		    = 2     -- multiple for graph points. lower = more detail, causes performance issues with table storing too much
    local clr_axis      = Color( 255, 255, 255, 50 )

    for _, v in helper.get.table( data, ipairs ) do
        if v < a then a = v continue end
        if v > b then b = v continue end
    end

    local legend_i  = 7
    local axis_y 	= { a }
    for i = 2, legend_i do
        axis_y[ i ] = math.Round( Lerp( i / legend_i, a, b ) )
    end
    axis_y 			= table.Reverse( axis_y )

    /*
    *   chart
    */

    self.chart                      = ui.new( 'pnl', self.r1                )
    :fill                           ( 'm', 0                                )

                                    :draw( function( s, w, h )
                                        local y 		= top_y + margin_y
                                        local size 		= #axis_y
                                        h 				= s.sub:GetTall( )

                                        -- left side grid labels
                                        for i, v in helper.get.table( axis_y, ipairs ) do
                                            local str = self:VData( v )
                                            draw.SimpleText( str, pref( 'diag_chart_legend' ), axis_y_w / 2, y, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

                                            local frac 	= i / size
                                            y 			= y + ( ( 1 / size ) * h )
                                        end
                                    end )

    /*
    *   chart
    */

    self.chart.sub                  = ui.new( 'pnl', self.chart             )
    :fill                           ( 'm', axis_y_w, margin_y               )

                                    :draw( function( s, w, h )
                                        local size 		= #axis_y
                                        local y 		= top_y

                                        for i, v in helper.get.table( axis_y, ipairs ) do
                                            design.line( 0, y, w, y, clr_axis )

                                            local frac 	= i / size
                                            y 			= y + ( ( 1 / size ) * h )
                                        end

                                        y = top_y
                                        h = h - y * 2

                                        /*
                                        *   data
                                        */

                                        local tbl 	    = { }
                                        for i, v in helper.get.table( self.ghistory, ipairs ) do
                                            local x 	= -7 + ( 1 + ( ( i + 1 ) * mult ) )
                                            local y		= 0

                                            if a == b then
                                                y 		= ( 1 - 1 ) * h
                                            else
                                                y 		= ( 1 - ( ( v - a ) / ( b - a ) ) ) * h
                                            end

                                            if x >= w then
                                                rm( self.ghistory, 1 )
                                            end

                                            table.insert( tbl, { x, y } )
                                        end

                                        /*
                                        *   draw points
                                        */

                                        self:DrawPoints( tbl, x, y )

                                        /*
                                        *   calc fps
                                        */

                                        if self.th_fps_ch > CurTime( ) then return end
                                        self:GetFPS( )
                                    end )

end

/*
*   FirstRun
*/

function PANEL:FirstRun( )
    if ui:ok( self.slider.amt ) then
        local amt = math.Round( self.cvar_id:GetFloat( ), 1 )
        self.slider.amt:SetText( amt )
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
    draw.SimpleText( utf8.char( 9698 ), pref( 'konsole_resizer' ), w - 3, h - 7, Color( 240, 72, 133, self.Alpha ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
    draw.SimpleText( utf8.char( 9698 ), pref( 'konsole_resizer' ), w - 5, h - 9, Color( 40, 40, 40, self.Alpha ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
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

vgui.Register( 'rlib.lo.diag', PANEL, 'DFrame' )