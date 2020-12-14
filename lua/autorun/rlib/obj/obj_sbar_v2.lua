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
local access                = base.a
local helper                = base.h
local design                = base.d
local ui                    = base.i

/*
*   PANEL
*/

local PANEL = { }

/*
*   Init
*/

function PANEL:Init( )

    /*
    *	declarations
    */

    self:Declarations( )

    /*
    *   scrollbar
    */

    self.slider                     = ui.new( 'grip', self                  )
    :box                            ( Color( 255, 255, 255, 20 )            )

    /*
    *   parent
    */

    self                            = ui.get( self                          )
    :size                           ( 4                                     )
    :param                          ( 'SetAlwaysVisible', false             )

end

/*
*   SetEnabled
*/

function PANEL:SetEnabled( b )
    if not b then
        self.Offset         = 0
        self:SetScroll      ( 0 )
        self.HasChanged     = true
    end

    self:SetMouseInputEnabled( b )

    if not self:GetAlwaysVisible( ) then
        ui:setvisible( self, b )
    end

    if self.Enabled ~= b then
        self:GetParent( ):InvalidateLayout( )

        if self:GetParent( ).OnScrollbarAppear then
            self:GetParent( ):OnScrollbarAppear( )
        end
    end

    self.Enabled = b
end

/*
*   GetEnabled
*/

function PANEL:GetEnabled( )
    return self.Enabled
end

/*
*   Value
*/

function PANEL:Value( )
    return self.Pos
end

/*
*   BarScale
*/

function PANEL:BarScale( )
    if self.BarSize == 0 then return 1 end
    return self.BarSize / ( self.CanvasSize + self.BarSize )
end

/*
*   set up
*
*   @param  : int sz_bar
*   @param  : int sz_canvas
*/

function PANEL:SetUp( sz_bar, sz_canvas )
    self.BarSize            = sz_bar
    self.CanvasSize         = math.max( sz_canvas - sz_bar, 1 )

    self:SetEnabled         ( sz_canvas > sz_bar )

    self:InvalidateLayout   ( )
end

/*
*   OnMouseWheeled
*/

function PANEL:OnMouseWheeled( dlta )
    if not self:IsVisible( ) then return false end

    return self:AddScroll( dlta * -2 )
end

/*
*   AddScroll
*/

function PANEL:AddScroll( dlta )
    local old               = self:GetScroll( )
    dlta                    = dlta * 25

    self:SetScroll          ( self:GetScroll( ) + dlta )

    return old ~= self:GetScroll( )
end

/*
*   SetScroll
*/

function PANEL:SetScroll( scrll )
    if not self.Enabled then self.Scroll = 0 return end

    self.Scroll = math.Clamp( scrll, 0, self.CanvasSize + ( self.elastic_i or 65 ) )
    self:InvalidateLayout( )

    local func = self:GetParent( ).OnVScroll
    if func then
        func( self:GetParent( ), self:GetOffset( ) )
    else
        self:GetParent( ):InvalidateLayout( )
    end
end

/*
*   LimitScroll
*/

function PANEL:LimitScroll( )
    if ( self.Scroll > self.CanvasSize ) or ( self.Scroll < 0 ) then
        self.Scroll = math.Clamp( self.Scroll, -self.clamp, self.CanvasSize + self.clamp )
    end
end

/*
*   AnimateTo
*/

function PANEL:AnimateTo( scrll, len, delay, ease )
    local anim              = self:NewAnimation( len, delay, ease )
    anim.StartPos           = self.Scroll
    anim.TargetPos          = scrll
    anim.Think = function( anim, pnl, frac )
        pnl:SetScroll( Lerp( frac, anim.StartPos, anim.TargetPos ) )
    end
end

/*
*   GetScroll
*/

function PANEL:GetScroll( )
    if not self.Enabled then self.Scroll = 0 end
    return self.Scroll
end

/*
*   GetOffset
*/

function PANEL:GetOffset( )
    if not self.Enabled then return 0 end
    return self.Scroll * -1
end

/*
*   OnMousePressed
*/

function PANEL:OnMousePressed( )
    local _, y              = self:CursorPos( )
    local sz_page           = self.BarSize

    self:SetScroll          ( ( y > self.slider.y and self:GetScroll( ) + sz_page ) or self:GetScroll( ) - sz_page )
end

/*
*   OnMouseReleased
*/

function PANEL:OnMouseReleased( )
    self.Dragging           = false
    self.DraggingCanvas     = nil
    self:MouseCapture       ( false )

    self.slider.Depressed   = false
end

/*
*   OnCursorMoved
*/

function PANEL:OnCursorMoved( x, y )
    if not self.Enabled then return end
    if not self.Dragging then return end

    local _, y              = self:ScreenToLocal( 0, gui.MouseY( ) )
    y                       = y - self.HoldPos

    local sz_track          = self:GetTall( ) - self.slider:GetTall( )
    y                       = y / sz_track

    self:SetScroll          ( math.Clamp( y * self.CanvasSize, 0, self.CanvasSize ) )
end

/*
*   Grip
*/

function PANEL:Grip( )
    if not self.Enabled then return end
    if self.BarSize == 0 then return end

    self:MouseCapture       ( true )
    self.Dragging           = true

    local _, y              = self.slider:ScreenToLocal( 0, gui.MouseY( ) )
    self.HoldPos            = y

    self.slider.Depressed   = true
end

/*
*   PerformLayout
*
*   @param  : int w
*   @param  : int h
*/

function PANEL:PerformLayout( w, h )

    /*
    *   initialize only
    */

    if not self.bInitialized then
        self.elastic_i      = self:GetbElastic( ) and 65 or 0

        self.bInitialized   = true
    end

    /*
    *   limit scrolling
    */

    self:LimitScroll( )

    /*
    *   calculate sizes
    */

    local sz_scroll         = self:GetScroll( ) / self.CanvasSize
    local sz_bar            = math.max( self:BarScale( ) * self:GetTall( ), 10 )
    local sz_track          = self:GetTall( ) - sz_bar
    sz_track                = sz_track + 1
    sz_scroll               = sz_scroll * sz_track

    local bar_start         = math.max( sz_scroll, 0 )
    local bar_end           = math.min( sz_scroll + sz_bar, self:GetTall( ) )

    self.slider:SetPos      ( 0, bar_start )
    self.slider:SetSize     ( w, bar_end - bar_start )
end

/*
*   Think
*/

function PANEL:Think( )
    if self:GetbForceAlpha( ) then
        self.Alpha          = 255
    end
end

/*
*   Paint
*
*   @param  : int w
*   @param  : int h
*/

function PANEL:Paint( w, h )
    return true
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
*   Rehash
*
*   resets initialization
*/

function PANEL:Rehash( )
    self.bInitialize = false
end

/*
*   Declarations
*
*   all definitions associated to this panel
*/

function PANEL:Declarations( )

    /*
    *	declare > general
    */

    self.bInitialized       = false
    self.Offset             = 0
    self.Scroll             = 0
    self.CanvasSize         = 1
    self.BarSize            = 1
    self.clamp              = 100

end

/*
*   register
*/

vgui.Register( 'rlib.ui.sbar.v2', PANEL, 'DPanel' )
vgui.Register( 'rlib.elm.sb.v2', PANEL, 'DPanel' )