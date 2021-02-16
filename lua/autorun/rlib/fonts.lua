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

local base                  = rlib
local font                  = base.f
local mf                    = base.manifest

/*
*   Localized glua routes
*/

local _f                    = surface.CreateFont

/*
*	prefix ids
*/

local function pref( str, suffix )
    local state = ( isstring( suffix ) and suffix ) or ( base and mf.prefix ) or false
    return base.get:pref( str, state )
end

/*
*	font > gmod
*
*   @param  : str id
*   @param  : str name
*   @param  : int sz
*   @param  : int weight
*   @param  : bool bShadow
*   @param  : bool bExt
*/

function font.gmod( id, name, sz, wt, bShadow, bExt, bSym )
    _f( id, { font = name, size = sz, weight = wt, bShadow or false, antialias = true, extended = bExt or false, symbol = bSyn or false } )
end

/*
*	fonts > new
*
*   @param  : str id
*   @param  : str name
*   @param  : int sz
*   @param  : int weight
*   @param  : bool bShadow
*   @param  : bool bExt
*   @param  : bool bSym
*/

function font.new( id, name, sz, wt, bShadow, bExt, bSym )
    id = pref( id )
    _f( id, { font = name, size = sz, weight = wt, bShadow or false, antialias = true, extended = bExt or false, symbol = bSyn or false } )
end

/*
*	fonts > get
*
*   returns font id
*   all ids have rlib_suffix appended to the front
*
*   @example:   general_name
*               rlib.general.name
*
*   @param  : str id
*   @return : str
*/

function font.get( id )
    id = pref( id )
    return id
end

/*
*    fonts > rlib
*/

/*
*    fonts > uclass
*/

    _f( pref( 'ucl_font_def' ),                     { size = 16, weight = 400, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'ucl_tippy' ),                        { size = 15, weight = 200, antialias = true, shadow = false, font = 'Roboto Light' } )

/*
*    fonts > design
*/

    _f( pref( 'design_dialog_title' ),	            { size = 36, weight = 100, antialias = true, shadow = true, font = 'Roboto Light' } )
    _f( pref( 'design_dialog_msg' ),		        { size = 20, weight = 100, antialias = true, shadow = false, font = 'Roboto' } )
    _f( pref( 'design_dialog_qclose' ),	            { size = 16, weight = 100, antialias = true, shadow = true, font = 'Roboto Light' } )
    _f( pref( 'design_dialog_sli_title' ),          { size = 23, weight = 100, antialias = true, shadow = true, font = 'Roboto Light' } )
    _f( pref( 'design_dialog_sli_msg' ),            { size = 17, weight = 300, antialias = true, shadow = true, font = 'Roboto' } )
    _f( pref( 'design_dialog_sli_x' ),              { size = 42, weight = 800, antialias = true, shadow = false, font = 'Segoe UI Light' } )
    _f( pref( 'design_text_default' ),              { size = 16, weight = 100, antialias = true, shadow = false, font = 'Roboto Light' } )
    _f( pref( 'design_rsay_text' ),                 { size = 30, weight = 100, antialias = true, shadow = true, font = 'Roboto Light' } )
    _f( pref( 'design_rsay_text_sub' ),             { size = 20, weight = 100, antialias = true, shadow = true, font = 'Roboto Light' } )
    _f( pref( 'design_s1_indc' ),                   { size = 22, weight = 400, antialias = true, shadow = true, font = 'Roboto Light' } )
    _f( pref( 'design_s2_indc' ),                   { size = 40, weight = 400, antialias = true, shadow = true, font = 'Roboto Light' } )
    _f( pref( 'design_s2_indc_sub' ),               { size = 70, weight = 800, antialias = true, shadow = true, font = 'Roboto' } )
    _f( pref( 'design_draw_textscroll' ),           { size = 14, weight = 100, antialias = true, shadow = true, font = 'Roboto Light' } )
    _f( pref( 'design_notify_text' ),               { size = 18, weight = 400, antialias = true, shadow = false, font = 'Roboto Light' } )
    _f( pref( 'design_bubble_msg' ),                { size = 18, weight = 200, antialias = true, shadow = true, font = 'Montserrat Medium' } )
    _f( pref( 'design_bubble_msg_2' ),              { size = 18, weight = 200, antialias = true, shadow = true, font = 'Montserrat Medium' } )
    _f( pref( 'design_bubble_ico' ),                { size = 48, weight = 400, antialias = true, shadow = true, font = 'Roboto Condensed' } )

/*
*    fonts > elements
*/

    _f( pref( 'elm_tab_name' ),                     { size = 15, weight = 200, antialias = true, font = 'Raleway Light' } )
    _f( pref( 'elm_text' ),                         { size = 17, weight = 400, antialias = true, font = 'Segoe UI Light' } )

/*
*    fonts > lang
*/

    _f( pref( 'lang_close' ),                       { size = 24, weight = 800, antialias = true, font = 'Roboto' } )
    _f( pref( 'lang_icon' ),                        { size = 24, weight = 100, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'lang_title' ),                       { size = 16, weight = 600, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'lang_desc' ),                        { size = 16, weight = 400, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'lang_item' ),                        { size = 16, weight = 400, antialias = true, font = 'Roboto Light' } )

/*
*    fonts > mviewer
*/

    _f( pref( 'mdlv_exit' ),                        { size = 40, weight = 800, antialias = true, font = 'Roboto' } )
    _f( pref( 'mdlv_resizer' ),                     { size = 24, weight = 100, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'mdlv_icon' ),                        { size = 24, weight = 100, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'mdlv_name' ),                        { size = 44, weight = 100, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'mdlv_title' ),                       { size = 16, weight = 600, antialias = true, shadow = true, font = 'Roboto Light' } )
    _f( pref( 'mdlv_clear' ),                       { size = 20, weight = 800, antialias = true, font = 'Roboto' } )
    _f( pref( 'mdlv_enter' ),                       { size = 20, weight = 800, antialias = true, font = 'Roboto' } )
    _f( pref( 'mdlv_control' ),                     { size = 16, weight = 200, antialias = true, font = 'Roboto Condensed' } )
    _f( pref( 'mdlv_searchbox' ),                   { size = 18, weight = 100, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'mdlv_minfo' ),                       { size = 16, weight = 400, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'mdlv_copyclip' ),                    { size = 14, weight = 100, antialias = true, shadow = true, font = 'Roboto Light' } )

/*
*    fonts > servinfo
*/

    _f( pref( 'diag_icon' ),                        { size = 24, weight = 100, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'diag_ctrl_exit' ),                   { size = 40, weight = 200, antialias = true, font = 'Roboto' } )
    _f( pref( 'diag_ctrl_min' ),                    { size = 40, weight = 200, antialias = true, font = 'Roboto' } )
    _f( pref( 'diag_title' ),                       { size = 19, weight = 200, antialias = true, font = 'Segoe UI Light' } )
    _f( pref( 'diag_value' ),                       { size = 30, weight = 600, antialias = true, font = 'Segoe UI Light' } )
    _f( pref( 'diag_hdr_value' ),                   { size = 14, weight = 400, antialias = true, font = 'Segoe UI Light' } )
    _f( pref( 'diag_chart_legend' ),                { size = 14, weight = 400, antialias = true, font = 'Segoe UI Light' } )
    _f( pref( 'diag_chart_value' ),                 { size = 23, weight = 600, antialias = true, font = 'Segoe UI Light' } )
    _f( pref( 'diag_resizer' ),                     { size = 24, weight = 100, antialias = true, font = 'Roboto Light' } )

/*
*   fonts > welcome
*/

    _f( pref( 'welcome_exit' ),                     { size = 36, weight = 800, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'welcome_icon' ),                     { size = 24, weight = 100, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'welcome_title' ),                    { size = 16, weight = 600, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'welcome_name' ),                     { size = 40, weight = 100, antialias = true, font = 'Segoe UI Light' } )
    _f( pref( 'welcome_intro' ),                    { size = 20, weight = 100, antialias = true, font = 'Open Sans Light' } )
    _f( pref( 'welcome_ticker' ),                   { size = 14, weight = 100, antialias = true, font = 'Open Sans' } )
    _f( pref( 'welcome_btn' ),                      { size = 16, weight = 400, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'welcome_data' ),                     { size = 12, weight = 200, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'welcome_fx' ),                       { size = 150, weight = 100, antialias = true, font = 'Roboto Light' } )