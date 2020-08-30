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
local helper                = base.h
local design                = base.d
local ui                    = base.i

/*
*   localization > misc
*/

local mf                    = base.manifest

/*
*	prefix ids
*/

local function pref( str, suffix )
    local state = ( isstring( suffix ) and suffix ) or ( base and mf.prefix ) or false
    return rlib.get:pref( str, state )
end

/*
*	panel
*/

local PANEL = { }

/*
*	init
*/

function PANEL:Init( )

    /*
    *	declarations
    */

    self:Declarations( )

    /*
    *	marker
    *
    *   displays a selected tab
    */

    self.marker                     = ui.new( 'pnl', self                   )
    :allowmouse                     ( false                                 )
    :tall                           ( self:GetMarkerY2( )                   )

                                    :draw( function( s, w, h )
                                        local m_padding     = self:GetMarkerPadding( )

                                        local pulse_a	    = math.abs( math.sin( CurTime( ) * 5 ) * 255 )
                                        pulse_a			    = math.Clamp( pulse_a, 200, 255 )

                                        local clr_marker    = self:GetClrMarker( )
                                        local clr_tab       = ColorAlpha( clr_marker, pulse_a )

                                        design.box( 0, m_padding, w, h - ( m_padding * 2 ), clr_tab )
                                    end )

                                    :logic( function( s )
                                        s:SetTall( self:GetMarkerY2( ) )
                                    end )

end

/*
*   FirstRun
*/

function PANEL:FirstRun( )
    if ui:ok( self ) then
        -- initialization actions
    end

    self.bInitialized = true
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

end

/*
*	SetAnimated
*/

function PANEL:SetAnimated( val )
    self.anim = val
end

/*
*	CreateTab
*/

function PANEL:CreateTab( name, elm )

    /*
    *	validate
    */

    if not isstring( name ) then return end

    /*
    *	check tab exists
    */

    if self:TabExists( name ) then
        return
    end

    /*
    *	default element type
    */

    elm = elm or 'pnl'

    /*
    *	insert tab
    */

    self.ind[ #self.ind + 1 ]       = name

    /*
    *	create tab
    */

    self.tab[ name ]                = ui.new( 'btn', self                   )
    :bsetup                         (                                       )
    :left                           ( 'm', self:GetMargin( ), 0, -self:GetMargin( ), 0 )
    :text                           ( name                                  )
    :font                           ( self:GetFont( )                       )
    :var                            ( 'clr_txt', self:GetClrInactive( )     )
    :anim_click_ol                  ( Color( 255, 255, 255, 30 ), 0.6, 4    )

                                    :draw( function( s, w, h )
                                        s:SetTextColor( s.clr_txt )
                                    end )

                                    :ocen( function( s )
                                        s:anim_lerp_clr( 'clr_txt', self:GetClrActive( ) )
                                    end )

                                    :ocex( function( s )
                                        if self.active == name then return end

                                        s:anim_lerp_clr( 'clr_txt', self:GetClrInactive( ) )
                                    end )

                                    :oc( function( s )
                                        self:SetActive( name )
                                    end )

    /*
    *	tab > width
    */

    local txt_w                     = self:GetTitleSize( name )
    local tab_w                     = calc.min( self:GetMinWide( ), txt_w + self:GetPadding( ) )

                                    self.tab[ name ]:SetWide( tab_w )

    /*
    *	pnl > create
    */

    self.tabs[ name ]               = ui.new( elm, self.parent              )
    :fill                           ( 'm', 5                                )
    :hide                           (                                       )

    /*
    *	register marker
    */

    self.markers[ name ] = self.tab[ name ]

    /*
    *	pnl > return
    */

    return self.tabs[ name ]
end

/*
*	DispatchTab
*
*   removes a specified panel
*
*   @param  : str name
*/

function PANEL:DispatchTab( name )

    /*
    *	validate
    */

    if not isstring( name ) then return end

    /*
    *	check tab exists
    */

    if not self:TabExists( name ) then return end

    /*
    *	dispatch
    */

    ui:hide( self.tabs[ name ] )
    ui:hide( self.markers[ name ] )
    self:SetActiveFirst( )

    /*
    *	delete key from index
    */

    local key   = self:Locate( name )
                self.ind[ key ] = nil
end

/*
*	Tab_OnPre
*
*   @param  : str name
*/

function PANEL:Tab_OnPre( name )
    -- under development
end

/*
*	Tab_OnPost
*
*   @param  : str name
*/

function PANEL:Tab_OnPost( name )
    -- under development
end

/*
*	get > tab
*
*   @param  : str name
*   @return : pnl
*/

function PANEL:GetTab( name )
    if not isstring( name ) then return end
    return self.tabs[ name ]
end

/*
*	Locate
*
*   locates a tab based on the name provided
*
*   @param  : str name
*   @return : int
*/

function PANEL:Locate( name )
    if not isstring( name ) then return false end
    for i, v in helper.get.table( self.ind, false ) do
        if v ~= name then continue end
        return i
    end
end

/*
*	TabExists
*
*   @param  : str name
*   @return : bool
*/

function PANEL:TabExists( name )
    if not isstring( name ) then return false end
    for i, v in helper.get.table( self.ind, false ) do
        if v ~= name then continue end
        return true
    end
    return false
end

/*
*	stage
*
*   displays the panel
*
*   @param  : str name
*/

function PANEL:Stage( name )
    if not isstring( name ) then return end
    if not self.tabs then return end

    local pnl               = self.tabs[ name ]
    :show                   (                           )
end

/*
*	unstage
*
*   hides the active panel
*/

function PANEL:Unstage( )
    if not self.tabs then return end

    local pnl               = self.tabs[ self.active ]
    :hide                   (                           )
end

/*
*	SetMarker_Norm
*
*   makes the marker go to the selected tab without any easing animation
*
*   @param  : str name
*/

function PANEL:SetMarker_Norm( name )
    if not isstring( name ) then return end

    local tab               = self.tab[ name ]
    tab.clr_txt             = self:GetClrActive( )

    local id                = self:Locate( name )
    local x                 = self:GetMargin( )
    x                       = x + self:GetPadding( ) / 2

    for k, v in helper.get.sorted_k( self.ind, ipairs ) do
        if k >= id then break end

        if k == id then
            local txt_w     = self:GetTitleSize( self.tab[ v ]:GetText( ) )
            x               = x + txt_w + self:GetPadding( )
        else
            x               = x + self.tab[ v ]:GetWide( )
        end
    end

    /*
    *	get > marker
    *
    *   set position
    */

    local marker 	        = ui.get( self.marker 			)
    :pos                    ( x, ( self:GetMarkerY( ) ) - self.marker:GetTall( ) )

    /*
    *	set marker width based on title size
    */

    local w                 = tab:GetWide( )
    w                       = self:GetTitleSize( tab:GetText( ) )

    self.marker:SetWide     ( w )
end

/*
*	SetMarker_Anim
*
*   makes the marker go to the selected tab with an easing animation
*
*   @param  : str name
*/

function PANEL:SetMarker_Anim( name )
    if not isstring( name ) then return end

    local tab               = self.tab[ name ]
    tab:anim_lerp_clr       ( 'clr_txt', self:GetClrActive( ) )

    local id 	            = self:Locate( name )
    local x 	            = self:GetMargin( )
    x                       = x + self:GetPadding( ) / 2

    for k, v in helper.get.sorted_k( self.ind, ipairs ) do
        if k >= id then break end

        if k == id then
            local txt_w     = self:GetTitleSize( self.tab[ v ]:GetText( ) )
            x               = x + txt_w
        else
            x               = x + self.tab[ v ]:GetWide( )
        end
    end

    /*
    *	get > marker
    */

    local marker 	        = ui.get( self.marker 			)
    :anim_lerp_x            ( x, 0.3, nil, calc.ease.tab 	)

    /*
    *	set marker width based on title size
    */

    local w                 = tab:GetWide( )
    w                       = self:GetTitleSize( tab:GetText( ) )

    /*
    *	lerp to width
    */

    self.marker:anim_lerp_w( w, 0.3, nil, calc.ease.tab )
end

/*
*	SetActive
*
*   @param  : str name
*/

function PANEL:SetActive( name )

    if not isstring( name ) then return end

    /*
    *	check current active
    */

    if self.active == name then return end

    /*
    *	Tab_OnPre
    */

    self:Tab_OnPre( name )

    /*
    *	check active loaded tab
    */

    local bLoaded = ui:ok( self.tab[ self.active ] )
    if self.tab[ self.active ] then
        self.tab[ self.active ]:anim_lerp_clr( 'clr_txt', self:GetClrInactive( ) )
    end

    /*
    *	unstage active tab
    */

    if self.tabs[ self.active ] then
        self:Unstage( )

        /*
        *	tab > fn > OnUnstage
        */

        if self:GetTab( name ).OnUnstage then
            self:GetTab( name ):OnUnstage( )
        end
    end

    self.active = name

    /*
    *	move marker to selected tab
    */

    if self.tab[ name ] then
        if bLoaded then
            self:SetMarker_Anim( name )
        else
            self:SetMarker_Norm( name )
        end
    end

    /*
    *	stage tab
    */

    if self:GetTab( name ) then
        self:Stage( name )

        /*
        *	tab > fn > OnStage
        */

        if self:GetTab( name ).OnStage then
            self:GetTab( name ):OnStage( name )
        end
    end

    /*
    *	tab > post onload
    */

    self:Tab_OnPost( name )
end

/*
*   SelectFirst
*
*	select first tab
*
*   @return : int
*/

function PANEL:SelectFirst( )
    return self.ind[ 1 ]
end

/*
*	SetActive > First
*
*   defaults to the first tab
*/

function PANEL:SetActiveFirst( )
    self:SetActive( self:SelectFirst( ) )
end

/*
*	Attach
*
*   tab body content
*
*   @param  : pnl pnl
*   @param  : str, int dock
*   @param  : int il
*   @param  : int it
*   @param  : int ir
*   @param  : int ib
*/

function PANEL:Attach( pnl, dock, il, it, ir, ib )
    dock                    = ( ( dock == 'm' or dock == 1 ) and 'm' ) or ( ( dock == 'p' or dock == 2 ) and 'p' )
    il                      = isnumber( il ) and il or 0

                            if not it then it, ir, ib = il, il, il end
                            if not ir then ir, ib = it, it end
                            if not ib then ib = ir end

    /*
    *	pnl > body
    */

    self.parent             = ui.new( 'pnl', pnl                    )
    :nodraw                 (                                       )
    :fill                   ( dock, il, it, ir, ib                  )

end

/*
*	GetActive
*
*   returns the current active tab
*
*   @return : pnl
*/

function PANEL:GetTabActive( )
    return self.tabs[ self.active ]
end

/*
*	get > title size
*
*   returns total width of tab text with added padding ( if specified )
*
*   @param  : mix src
*   @return : int, int
*/

function PANEL:GetTitleSize( src )
    return helper.str:len( src, self:GetFont( ) ) + self:GetTabPadding( )
end

/*
*	padding > set
*
*	@param	: int i
*	@return	: void
*/

function PANEL:SetPadding( i )
    self.padding = i
end

/*
*	padding > get
*
*	@return	: int
*/

function PANEL:GetPadding( )
    return isnumber( self.padding ) and self.padding or 2
end

/*
*	margin > set
*
*	@param	: int i
*	@return	: void
*/

function PANEL:SetMargin( i )
    self.margin = i
end

/*
*	margin > get
*
*	@return	: int
*/

function PANEL:GetMargin( )
    return isnumber( self.margin ) and self.margin or 4
end

/*
*	min wide > set
*
*	@param	: int i
*	@return	: void
*/

function PANEL:SetMinWide( i )
    self.tab_w_min = i
end

/*
*	min wide > get
*
*	@return	: int
*/

function PANEL:GetMinWide( )
    return isnumber( self.tab_w_min ) and self.tab_w_min or 0
end

/*
*	colors > set > marker
*
*	@param	: clr clr
*	@return	: void
*/

function PANEL:SetClrMarker( clr )
    self.clr_marker = clr
end

/*
*	colors > get > marker
*
*	@return	: clr
*/

function PANEL:GetClrMarker( )
    return ( IsColor( self.clr_marker ) and self.clr_marker ) or Color( 137, 48, 48, 255 )
end

/*
*	colors > set > active
*
*	@param	: clr clr
*	@return	: void
*/

function PANEL:SetClrActive( clr )
    self.clr_marker = clr
end

/*
*	colors > get > active
*
*	@return	: clr
*/

function PANEL:GetClrActive( )
    return ( IsColor( self.clr_active ) and self.clr_active ) or Color( 255, 255, 255, 255 )
end

/*
*   SetClrInactive
*
*   sets tab text inactive color
*
*   @param  : clr clr
*/

function PANEL:SetClrInactive( clr )
    self.clr_inactive = clr
end

/*
*   GetClrBoxH
*
*   gets tab text inactive color
*
*   @return : clr
*/

function PANEL:GetClrInactive( )
    return IsColor( self.clr_inactive ) and self.clr_inactive or Color( 0, 0, 0, 240 )
end

/*
*	marker > set > y pos
*
*	@param	: int pos
*	@return	: void
*/

function PANEL:SetMarkerY( pos )
    self.m_y1 = pos
end

/*
*	marker > get > y pos
*
*	@return	: int
*/

function PANEL:GetMarkerY( )
    return ( isnumber( self.m_y1 ) and self.m_y1 ) or self:GetParent( ):GetTall( )
end

/*
*	marker > set > y pos 2
*
*	@param	: int pos
*	@return	: void
*/

function PANEL:SetMarkerY2( pos )
    self.m_y2 = pos
end

/*
*	marker > get > y pos 2
*
*	@return	: int
*/

function PANEL:GetMarkerY2( )
    return ( isnumber( self.m_y2 ) and self.m_y2 ) or self:GetParent( ):GetTall( )
end

/*
*	marker > set > padding
*
*   amount of marker padding for top and bottom
*
*	@param	: int pos
*	@return	: void
*/

function PANEL:SetMarkerPadding( i )
    self.m_padding = i
end

/*
*	marker > get > padding
*
*   return amount of marker padding for top and bottom
*
*	@return	: int
*/

function PANEL:GetMarkerPadding( )
    return ( isnumber( self.m_padding ) and self.m_padding ) or 1
end

/*
*	tab > set > padding
*
*   amount of extra padding to add to each tabs width
*   useful for marker not riding text
*
*	@param	: int pos
*	@return	: void
*/

function PANEL:SetTabPadding( i )
    self.t_padding = i
end

/*
*	tab > get > padding
*
*	@return	: int
*/

function PANEL:GetTabPadding( )
    return ( isnumber( self.t_padding ) and self.t_padding ) or 0
end

/*
*	font > set
*
*	@param	: str str
*	@return	: void
*/

function PANEL:SetFont( str )
    self.font = str
end

/*
*	font > get
*
*	@return	: str
*/

function PANEL:GetFont( )
    return ( helper.str:ok( self.font ) and self.font ) or pref( 'elm_tab_name' )
end

/*
*	paint
*
*	@param	: w int
*	@param	: h int
*	@return	: void
*/

function PANEL:Paint( w, h ) end

/*
*   Declarations
*
*   all definitions associated to this panel
*/

function PANEL:Declarations( )

    /*
    *	declare > initialization
    */

    self.bInitialized       = false

    /*
    *	declare > general
    */

    self.ind 	            = { }
    self.tab 		        = { }
    self.tabs 		        = { }
    self.markers            = { }
    self.active 		    = 0

end

/*
*	register
*/

vgui.Register( 'rlib.ui.tab', PANEL )