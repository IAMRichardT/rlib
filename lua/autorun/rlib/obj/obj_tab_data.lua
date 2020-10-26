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
*   loalization > misc
*/

local mf                    = base.manifest

/*
*	prefix ids
*/

local function pref( str, suffix )
    local state = ( isstring( suffix ) and suffix ) or ( base and mf.prefix ) or false
    return base.get:pref( str, state )
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
    *	parent
    */

    self:DockMargin                 ( 0, 0, 0, 0                            )
end

/*
*	get type
*
*	@param	: str elm
*   @return : str
*/

function PANEL:GetType( elm )

    local types =
    {
        [ 'txt' ]    		        = 'entry',
        [ 'dtext' ]    		        = 'entry',
        [ 'entry' ]    		        = 'entry',
        [ 'lbl' ]      		        = 'lbl',
        [ 'label' ]     	        = 'lbl',
        [ 'html' ]       	        = 'html',
        [ 'htm' ]       	        = 'html',
    }

    return types[ elm ] or 'txt'

end

/*
*	set data
*
*	@param	: str txt
*	@param	: str elm
*/

function PANEL:SetData( txt, elm , clr )

    /*
    *	validate
    */

    if not txt then return end

    /*
    *	declare
    */

    local clr_txt                   = IsColor( clr ) and clr or self:GetTextColor( ) or Color( 255, 255, 255, 255 )
    local font                      = self:GetFont( )

    /*
    *	element > get
    */

    local element 	                = self:GetType( elm )
    self.data 	                    = ui.new( element, self )
    :nodraw                         ( )

    /*
    *	element > label
    */

    if element == 'lbl' then
        self.data 				    = ui.get( self.data 			        )
        :font						( font 	                                )
        :clr						( clr_txt 		                        )
        :wrap						( true							        )
        :text						( txt						            )
        :autoverticle				( true							        )

        return
    end

    /*
    *	element > entry
    */

    if element == 'entry' then
        self.data 				    = ui.new( 'rlib.elm.text', self         )
        :nodraw                     (                                       )
        :fill                       (                                       )
        :param                      ( 'SetTextColor', clr_txt               )
        :param                      ( 'SetFont', font                       )
        :param                      ( 'SetData', txt                        )
        :param                      ( 'SetAlwaysVisible', self:GetAlwaysVisible( ) )

        return
    end

    /*
    *	element > html
    */

    if element == 'html' then
        txt = [[
            <header>
                <link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open%20Sans&display=swap'>

                <style>
                    body 						{ margin: 0; padding: 0; overflow: visible; color: rgb( ]] .. clr_txt.r .. [[, ]] .. clr_txt.g .. [[, ]] .. clr_txt.b .. [[ ); font-family: "Open Sans", sans-serif; font-size: 13px; }
                    .container 					{ width: 96%; height: 100%; }
                    ::-webkit-scrollbar 		{ width: 6px; }
                    ::-webkit-scrollbar-track 	{ background: none; }
                    ::-webkit-scrollbar-thumb 	{ background: rgb( 190, 78, 78 ); border-radius: 10px; }
                    a 							{ color: rgb( 190, 78, 78 ); }

                    h1, h2, h3, h4, h5, h6 		{ margin: 5px 0px 0px 0px; }
                    img							{ margin: 5px 0px 0px 0px; display: block; width: 100%; height: auto; }

                    ul 							{ margin-left: 10px; margin-top: 5px; padding-left: 20px; }
                    ul > li 					{ margin-left: 0px; padding-left: 0px; }
                    ul > li > ul 				{ margin-left: 0px; }

                    .d-block 					{ display: block; }
                    .d-none 					{ display: none; }

                    .mt-5 						{ margin-top: 5px; }
                    .mt-10 						{ margin-top: 10px; }
                    .pt-5 						{ padding-top: 5px; }
                    .pt-10 						{ padding-top: 10px; }
                </style>
            </header>
            <body>
                <div class="container">
                    ]] .. txt .. [[
                </div>
            </body>
        ]]

        self.data:SetHTML( txt )
    end

end

/*
*	PerformLayout
*
*   @param  : int w
*   @param  : int h
*/

function PANEL:PerformLayout( w, h )
    if not ui:ok( self.data ) then return end
    self.data:SetSize( w, h )
end

/*
*   GetFont
*
*   @return : str
*/

function PANEL:GetFont( )
    return isstring( self.font ) and self.font or pref( 'elm_text' )
end

/*
*   SetFont
*
*   @param  : str str
*/

function PANEL:SetFont( str )
    self.font = str
end

/*
*   GetTextColor
*
*   @return : clr
*/

function PANEL:GetTextColor( )
    return IsColor( self.clr_txt ) and self.clr_txt or Color( 255, 255, 255, 255 )
end

/*
*   SetFont
*
*   @param  : clr clr
*/

function PANEL:SetTextColor( clr )
    self.clr_txt = clr
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
*   Declarations
*
*   all definitions associated to this panel
*/

function PANEL:Declarations( )

    /*
    *   declare > general
    */

    self.bInitialize                = false

end

/*
*	register
*/

vgui.Register( 'rlib.ui.tab.data', PANEL )