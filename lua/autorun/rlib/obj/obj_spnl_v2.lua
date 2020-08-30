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
*   THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
*   LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
*   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
*   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
*   WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

/*
*   standard tables and localization
*/

local base                  = rlib
local cfg                   = base.settings
local helper                = base.h
local design                = base.d
local ui                    = base.i
local konsole			    = base.k

/*
*   PANEL
*/

local PANEL = { }

/*
*   AccessorFunc
*/

AccessorFunc( PANEL, 'Padding',     'Padding' )
AccessorFunc( PANEL, 'pnlCanvas',   'Canvas' )

/*
*   Init
*/

function PANEL:Init( )

    /*
    *   declarations
    */

    self:Declarations( )

    /*
    *   canvas
    */

    self.pnlCanvas                  = ui.new( 'pnl', self                   )
    :nodraw                         (                                       )
    :allowmouse                     ( true                                  )

                                    :ompd( function( s, c )
                                        self:GetParent( ):OnMousePressed( c )
                                    end )

                                    :pl( function( s, w, h )
                                        self:PerformLayout( )
                                        self:InvalidateParent( )
                                    end )

    /*
    *   vbar
    */

    self.VBar                       = ui.new( 'rlib.elm.sb.v2', self        )
    :right                          (                                       )
    :param                          ( 'SetbElastic', true                   )

    /*
    *   parent
    */

    self                            = ui.get( self                          )
    :spad                           (                                       )
    :allowmouse                     ( true                                  )
    :enginedraw                     ( false                                 )
    :param                          ( 'SetScrollDelta', 0                   )
    :param                          ( 'SetScrollDelay', 0                   )

    /*
    *   VBar
    */

    self.VBar                       = ui.get( self.VBar                     )
    :wide                           ( 8                                     )
    :param                          ( 'SetAlwaysVisible', true              )

                                    :draw( function( s, w, h )
                                        local clr_tr = self:GetTrackColor( )
                                        design.rbox( w / 2, 0, 0, w, h, Color( clr_tr.r, clr_tr.g, clr_tr.b, self:GetbKonsole( ) and self.KAlpha or clr_tr.a ) )
                                    end )

    /*
    *   VBar > scrollbar
    */

    self.VBar.slider                = ui.get( self.VBar.slider              )
    :var                            ( 'alpha', 0                            )

                                    :draw( function( s, w, h )
                                        s.alpha             = self.VBar:GetEnabled( ) and self:GetAlpha( true, s ) or self:GetAlpha( false, s )
                                        local alpha         = s.alpha * 255

                                        if self:GetbKonsole( ) then
                                            if self.VBar:GetEnabled( ) then
                                                alpha       = self.KAlpha
                                            else
                                                alpha       = self.KAlpha > 2 and 25 or 0
                                            end
                                        end

                                        local clr_sl        = self:GetGripColor( )
                                        design.rbox( w / 2, 0, 0, w, h, Color( clr_sl.r, clr_sl.g, clr_sl.b, alpha ) )
                                    end )

end

/*
*   GetAlpha
*
*   @param  : bool b
*   @param  : pnl pnl
*/

function PANEL:GetAlpha( b, pnl )
    return pnl.alpha + ( b and 1 or 0 - pnl.alpha ) * FrameTime( ) * 5
end

/*
*   AddItem
*
*   @param  : pnl pnl
*/

function PANEL:AddItem( pnl )
    pnl:SetParent( self:GetCanvas( ) )
end

/*
*   OnChildAdded
*
*   @param  : pnl ch
*/

function PANEL:OnChildAdded( ch )
    self:AddItem( ch )
end

/*
*   SizeToContents
*/

function PANEL:SizeToContents( )
    self:SetSize( self.pnlCanvas:GetSize( ) )
end

/*
*   GetVBar
*
*   @return : pnl
*/

function PANEL:GetVBar( )
    return self.VBar
end

/*
*   GetCanvas
*
*   @return : pnl
*/

function PANEL:GetCanvas( )
    return self.pnlCanvas
end

/*
*   InnerWidth
*
*   @return : int
*/

function PANEL:InnerWidth( )
    return self:GetCanvas( ):GetWide( )
end

/*
*   Think
*/

function PANEL:Think( )

    /*
    *   check think time
    */

    self.lth                = isnumber( self.lth ) and self.lth or CurTime( )

    /*
    *   declare > times
    */

    local i                 = CurTime( ) - self.lth
    self.lth                = CurTime( )

    /*
    *   delta < 0
    */


    if self.scrdlta < 0 then
        self.VBar:OnMouseWheeled( self.scrdlta / 2 )

        if self.VBar.Scroll <= self.VBar.CanvasSize then
            self.scrdlta = calc:eq( self.scrdlta ):add( 10 ):mul( i ):res( )
        end

        if self.scrdlta > 0 then self.scrdlta = 0 end

    /*
    *   delta > 0
    */

    elseif self.scrdlta > 0 then
        self.VBar:OnMouseWheeled( self.scrdlta / 2 )

        if self.VBar.Scroll >= 0 then
            self.scrdlta = calc:eq( self.scrdlta ):sub( 10 ):mul( i ):res( )
        end

        if self.scrdlta < 0 then self.scrdlta = 0 end
    end

    /*
    *   return wait < 1
    */

    if self.scrdelay < 1 then
        self.scrdelay       = self.scrdelay + ( 10 * i )

    /*
    *   return wait > 1
    */

    elseif self.scrdelay >= 1 then
        if self.VBar.Scroll < 0 then
            if self.VBar.Scroll <= -100 and self.scrdlta > 0 then
                self.scrdlta = self.scrdlta / 2
            end

            self.scrdlta    = self.scrdlta + ( ( self.VBar.Scroll / self:GetElasticAmt( ) ) - 0.001 ) * ( i * 200 )

        elseif self.VBar.Scroll > self.VBar.CanvasSize then
            if self.VBar.Scroll >= self.VBar.CanvasSize + 100 and self.scrdlta < 0 then
                self.scrdlta = self.scrdlta / 2
            end

            self.scrdlta    = self.scrdlta + ( ( self.VBar.Scroll - self.VBar.CanvasSize ) / self:GetElasticAmt( ) + 0.001 ) * ( i * 200 )
        end

    /*
    *   return else
    */

    else
        self.scrdelay       = 0
        self.scrdlta        = self.scrdlta or 0
    end

    /*
    *   kconsole > alpha
    */

    if self:GetbForceAlpha( ) then
        self.KAlpha         = 255
        self.VBar:SetbForceAlpha( self:GetbForceAlpha( ) )
    else
        if IsValid( konsole.pnl ) then
            self.KAlpha     = konsole.pnl.is_visible and 255 or 0
        end
    end
end

/*
*   OnVScroll
*
*   @param  : int diff
*/

function PANEL:OnVScroll( diff )
    self.pnlCanvas:SetPos( 0, diff )
end

/*
*   OnMouseWheeled
*
*   @param  : int dlta
*   @param  : int amt
*/

function PANEL:OnMouseWheeled( dlta, amt )
    if ( dlta > 0 and self.VBar.Scroll <= self.VBar.CanvasSize * 0.005 ) or ( dlta < 0 and self.VBar.Scroll >= self.VBar.CanvasSize * 0.995 ) then
        self.scrdlta = self.scrdlta + dlta / 10
        return
    end

    local i                 = isnumber( amt ) and amt or 0.4
    amt                     = calc.min( i, 0 )
    self.scrdlta            = dlta / amt -- lower number higher sensitivity
    self.scrdelay           = 0
end

/*
*   ScrollToChild
*
*   @param  : pnl pnl
*/

function PANEL:ScrollToChild( pnl )
    self:PerformLayout( )

    local _, y              = self.pnlCanvas:GetChildPosition( pnl )
    local _, h              = pnl:GetSize( )
    y                       = y + h * 0.5
    y                       = y - self:GetTall( ) * 0.5

    self.VBar:AnimateTo     ( y, 0.5, 0, 0.5 )
end

/*
*   PerformLayout
*/

function PANEL:PerformLayout( )

    /*
    *   initialize only
    */

    if not self.bInitialized then
        self.VBar:SetbElastic       ( self:GetbElastic( ) and true or false )
        self.VBar:SetAlwaysVisible  ( self:GetAlwaysVisible( ) and true or false )

        local dock          = self:GetDockLeft( ) and LEFT or RIGHT
                            self.VBar:Dock          ( dock )
                            self.VBar:DockMargin    ( self.m_il, self.m_it, self.m_ir, self.m_ib )
    end

    /*
    *   define > cache width
    */

    self._cache_w           = self._cache_w or self.VBar:GetWide( )

    /*
    *   dimensions
    */

    local w                 = self:GetWide( ) - self:GetSBMLeft( )
    local pos_x             = 0
    local pos_y             = 0

    self.VBar:SetUp         ( self:GetTall( ), self.pnlCanvas:GetTall( ) )
    pos_y                   = self.VBar:GetOffset( )

    /*
    *   autosize
    */

    if not self.VBar.Enabled and not self:GetAlwaysVisible( ) then
        self.VBar:SetWide( 0 )
    else
        self.VBar:SetWide( self._cache_w )
    end

    /*
    *   offset
    */

    if self.VBar.Enabled or not self:GetHasOffset( ) then
        w                   = w - self.VBar:GetWide( ) - self:GetSBMLeft( )

        if self:GetDockLeft( ) then
            pos_x           = self.VBar:GetWide( ) + self:GetSBMLeft( )
        end
    end

    /*
    *   update canvas
    */

    self:RebuildCanvas      ( pos_x, pos_y, w )

end

/*
*   SetAlwaysVisible
*
*   sets if scrollbar will always be visible, even if
*   not enough content to scroll
*
*   @param  : bool b
*/

function PANEL:SetAlwaysVisible( b )
    self.bAlwaysVisible = helper:val2bool( b )
end

/*
*   GetAlwaysVisible
*
*   @return : bool
*/

function PANEL:GetAlwaysVisible( )
    return self.bAlwaysVisible or false
end

/*
*   SetOffset
*/

function PANEL:SetHasOffset( b )
    self.bOffset = helper:val2bool( b )
end

/*
*   GetOffset
*/

function PANEL:GetHasOffset( )
    return self.bOffset or false
end

/*
*   SetDockLeft
*
*   only two positions; LEFT or RIGHT
*   RIGHT used by default
*
*   @param  : bool b
*/

function PANEL:SetDockLeft( b )
    self.bDockLeft = helper:val2bool( b )
end

/*
*   GetDockLeft
*
*   @return : bool
*/

function PANEL:GetDockLeft( )
    return self.bDockLeft or false
end

/*
*   SetSBMLeft
*
*   set scroll-bar left padding
*
*   @param  : int i
*/

function PANEL:SetSBMLeft( i )
    self.sbm_left = i
end

/*
*   GetSBMLeft
*
*   return scroll-bar left padding
*
*   @return : int
*/

function PANEL:GetSBMLeft( )
    return isnumber( self.sbm_left ) and self.sbm_left or 0
end

/*
*   SetVMargin
*
*   sets margin for vbar
*
*   @param  : int il
*   @param  : int it
*   @param  : int ir
*   @param  : int ib
*/

function PANEL:SetVMargin( il, it, ir, ib )
    il = isnumber( il ) and il or 0

    if not it then it, ir, ib = il, il, il end
    if not ir then ir, ib = it, it end
    if not ib then ib = ir end

    self.m_il   = il
    self.m_it   = it
    self.m_ir   = ir
    self.m_ib   = ib
end

/*
*   SetbKonsole
*
*   set if being utilized for rlib konsole
*
*   @param  : bool b
*/

function PANEL:SetbKonsole( b )
    self.bKonsole = helper:val2bool( b )
end

/*
*   GetbKonsole
*
*   get if being utilized for rlib konsole
*
*   @return : bool
*/

function PANEL:GetbKonsole( )
    return self.bKonsole or false
end

/*
*   SetbElastic
*
*   determines if scrollbar will use elastic scrolling
*
*   @param  : bool b
*/

function PANEL:SetbElastic( b )
    self.bElastic = helper:val2bool( b )
end

/*
*   GetbElastic
*
*   returns if scrollbar will use elastic scrolling
*
*   @return : bool
*/

function PANEL:GetbElastic( )
    return self.bElastic or false
end

/*
*   SetElasticAmt
*
*   determines if scrollbar will use elastic scrolling
*
*   @param  : int i
*/

function PANEL:SetElasticAmt( i )
    self.elastic_amt = i
end

/*
*   GetElasticAmt
*
*   returns if scrollbar will use elastic scrolling
*
*   @return : int
*           : min ( 900 )
*/

function PANEL:GetElasticAmt( )
    local def = 900
    local amt = isnumber( self.elastic_amt ) and self.elastic_amt or def
    return calc.min( amt, def )
end

/*
*   SetScrollDelta
*
*   @param  : int i
*/

function PANEL:SetScrollDelta( i )
    self.scrdlta = i
end

/*
*   GetScrollDelta
*
*   returns if scrollbar will use elastic scrolling
*
*   @return : int
*           : min ( 900 )
*/

function PANEL:GetScrollDelta( )
    return self.scrdlta
end

/*
*   SetScrollDelay
*
*   @param  : int i
*/

function PANEL:SetScrollDelay( i )
    self.scrdelay = i
end

/*
*   GetScrollDelay
*
*   @return : int
*/

function PANEL:GetScrollDelay( )
    return self.scrdelay
end

/*
*   SetbForceAlpha
*
*   forces alpha for particular panels
*   should only be utilized in cirsumtances like
*   rlib konsole
*
*   @param  : bool b
*/

function PANEL:SetbForceAlpha( b )
    self.bForceAlpha = helper:val2bool( b )
end

/*
*   GetbForceAlpha
*
*   @return : bool
*/

function PANEL:GetbForceAlpha( )
    return self.bForceAlpha
end

/*
*   SetTrackColor
*
*   defines the track color for scrollbar
*
*   @param  : clr clr
*/

function PANEL:SetTrackColor( clr )
    self.clr_track = IsColor( clr ) and clr or cfg.elm.clrs.sbar_track_v2
end

/*
*   GetTrackColor
*
*   returns current scrollbar track color
*
*   @return : clr
*/

function PANEL:GetTrackColor( )
    return IsColor( self.clr_track ) and self.clr_track or cfg.elm.clrs.sbar_track_v2
end

/*
*   SetGripColor
*
*   defines the slider ( grip ) color for scrollbar
*
*   @param  : clr clr
*/

function PANEL:SetGripColor( clr )
    self.clr_grip = IsColor( clr ) and clr or cfg.elm.clrs.sbar_grip_v2
end

/*
*   GetGripColor
*
*   returns current scrollbar slider ( grip ) color
*
*   @return : clr
*/

function PANEL:GetGripColor( )
    return IsColor( self.clr_grip ) and self.clr_grip or cfg.elm.clrs.sbar_grip_v2
end

/*
*   Rehash
*
*   resets initialization
*/

function PANEL:Rehash( )
    self.bInitialize = false
end

/*
*   Clear
*
*   @return : pnl
*/

function PANEL:Clear( )
    return self.pnlCanvas:Clear( )
end

/*
*   Rebuild
*/

function PANEL:Rebuild( )
    self:GetCanvas( ):SizeToChildren( false, true )

    if self.m_bNoSizing and self:GetCanvas( ):GetTall( ) < self:GetTall( ) then
        self:GetCanvas( ):SetPos( 0, ( self:GetTall( ) - self:GetCanvas( ):GetTall( ) ) * 0.5 )
    end
end

/*
*   RebuildCanvas
*
*   @param  : int x
*   @param  : int y
*   @param  : int w
*   @param  : int h
*/

function PANEL:RebuildCanvas( x, y, w, h )
    self.pnlCanvas:SetPos           ( x, y  )
    self.pnlCanvas:SetWide          ( w     )

    if isnumber( h ) then
        self.pnlCanvas:SetWide      ( w     )
    end

    /*
    *   rebuild panels
    */

    self:Rebuild( )
end

/*
*   Paint
*
*   @param  : int w
*   @param  : int h
*/

function PANEL:Paint( w, h ) end

/*
*   Declarations
*
*   all definitions associated to this panel
*/

function PANEL:Declarations( )

    /*
    *	declare > general
    */

    self.bInitialized               = false
    self.m_il                       = 0
    self.m_it                       = 0
    self.m_ir                       = 0
    self.m_ib                       = 0

end

/*
*   register
*/

vgui.Register( 'rlib.ui.spnl.v2', PANEL, 'DPanel' )
vgui.Register( 'rlib.elm.sp.v2', PANEL, 'DPanel' )