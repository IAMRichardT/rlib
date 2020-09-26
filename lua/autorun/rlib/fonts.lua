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

rlib                    = rlib or { }
local base              = rlib
local mf                = base.manifest

/*
*   Localized glua routes
*/

local _f                = surface.CreateFont

/*
*	prefix ids
*/

local function pref( str, suffix )
    local state = ( isstring( suffix ) and suffix ) or ( base and mf.prefix ) or false
    return rlib.get:pref( str, state )
end

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
*    fonts > about
*/

    _f( pref( 'about_exit' ),                       { size = 24, weight = 800, antialias = true, font = 'Roboto' } )
    _f( pref( 'about_resizer' ),                    { size = 24, weight = 100, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'about_icon' ),                       { size = 24, weight = 100, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'about_name' ),                       { size = 44, weight = 100, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'about_title' ),                      { size = 16, weight = 600, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'about_entry' ),                      { size = 15, weight = 300, antialias = true, font = 'Roboto' } )
    _f( pref( 'about_entry_label' ),                { size = 14, weight = 800, antialias = true, font = 'Roboto' } )
    _f( pref( 'about_entry_value' ),                { size = 16, weight = 200, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'about_status' ),                     { size = 14, weight = 800, antialias = true, font = 'Roboto' } )
    _f( pref( 'about_status_conn' ),                { size = 14, weight = 400, antialias = true, font = 'Roboto' } )

/*
*    fonts > rcfg
*/

    _f( pref( 'rcfg_exit' ),                        { size = 36, weight = 800, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'rcfg_refresh' ),                     { size = 24, weight = 800, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'rcfg_resizer' ),                     { size = 24, weight = 100, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'rcfg_icon' ),                        { size = 24, weight = 100, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'rcfg_name' ),                        { size = 40, weight = 100, antialias = true, font = 'Segoe UI Light' } )
    _f( pref( 'rcfg_sub' ),                         { size = 16, weight = 100, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'rcfg_title' ),                       { size = 16, weight = 600, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'rcfg_entry' ),                       { size = 15, weight = 300, antialias = true, font = 'Roboto' } )
    _f( pref( 'rcfg_status' ),                      { size = 14, weight = 800, antialias = true, font = 'Roboto' } )
    _f( pref( 'rcfg_status_conn' ),                 { size = 14, weight = 400, antialias = true, font = 'Roboto' } )
    _f( pref( 'rcfg_lst_name' ),                    { size = 15, weight = 100, antialias = true, font = 'Roboto Lt' } )
    _f( pref( 'rcfg_lst_ver' ),                     { size = 13, weight = 500, antialias = true, font = 'Roboto Lt' } )
    _f( pref( 'rcfg_lst_rel' ),                     { size = 14, weight = 100, antialias = true, font = 'Segoe UI Light' } )
    _f( pref( 'rcfg_lst_desc' ),                    { size = 13, weight = 100, antialias = true, font = 'Roboto Lt' } )
    _f( pref( 'rcfg_sel_name' ),                    { size = 22, weight = 400, antialias = true, font = 'Roboto Lt' } )
    _f( pref( 'rcfg_sel_ver' ),                     { size = 16, weight = 600, antialias = true, font = 'Roboto Lt' } )
    _f( pref( 'rcfg_sel_rel' ),                     { size = 14, weight = 100, antialias = true, font = 'Segoe UI Light' } )
    _f( pref( 'rcfg_sel_desc' ),                    { size = 17, weight = 100, antialias = true, font = 'Roboto Lt' } )
    _f( pref( 'rcfg_footer_i' ),                    { size = 14, weight = 400, antialias = true, font = 'Roboto' } )
    _f( pref( 'rcfg_symbol' ),                      { size = 48, weight = 800, antialias = true, font = 'gmodsymbolic', extended = true } )
    _f( pref( 'rcfg_soon' ),                        { size = 36, weight = 100, antialias = true, font = 'Segoe UI Light' } )

/*
*    fonts > lang
*/

    _f( pref( 'lang_close' ),                       { size = 24, weight = 800, antialias = true, font = 'Roboto' } )
    _f( pref( 'lang_icon' ),                        { size = 24, weight = 100, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'lang_title' ),                       { size = 16, weight = 600, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'lang_desc' ),                        { size = 16, weight = 400, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'lang_item' ),                        { size = 16, weight = 400, antialias = true, font = 'Roboto Light' } )

/*
*   fonts > reports
*/

    _f( pref( 'report_exit' ),                      { size = 24, weight = 800, antialias = true, font = 'Roboto' } )
    _f( pref( 'report_resizer' ),                   { size = 24, weight = 100, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'report_btn_clr' ),                   { size = 15, weight = 800, antialias = true, font = 'Roboto' } )
    _f( pref( 'report_btn_auth' ),                  { size = 29, weight = 800, antialias = true, font = 'Roboto' } )
    _f( pref( 'report_btn_send' ),                  { size = 15, weight = 800, antialias = true, font = 'Roboto' } )
    _f( pref( 'report_err' ),                       { size = 14, weight = 800, antialias = true, font = 'Roboto' } )
    _f( pref( 'report_icon' ),                      { size = 24, weight = 100, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'report_title' ),                     { size = 16, weight = 600, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'report_desc' ),                      { size = 16, weight = 400, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'report_auth' ),                      { size = 16, weight = 400, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'report_auth_icon' ),                 { size = 24, weight = 100, antialias = true, font = 'Roboto Light' } )

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
*    fonts > konsole
*/

    _f( pref( 'konsole_exit' ),                     { size = 24, weight = 800, antialias = true, font = 'Roboto' } )
    _f( pref( 'konsole_icon' ),                     { size = 24, weight = 100, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'konsole_resizer' ),                  { size = 24, weight = 100, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'konsole_gear' ),                     { size = 32, weight = 800, antialias = true, font = 'Roboto' } )
    _f( pref( 'konsole_clear' ),                    { size = 20, weight = 800, antialias = true, font = 'Roboto' } )
    _f( pref( 'konsole_copy' ),                     { size = 20, weight = 100, antialias = true, font = 'Roboto' } )
    _f( pref( 'konsole_title' ),                    { size = 16, weight = 600, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'konsole_text' ),                     { size = 13, weight = 400, antialias = true, font = 'Roboto' } )
    _f( pref( 'konsole_textfield' ),                { size = 14, weight = 600, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'konsole_input_icon' ),               { size = 24, weight = 100, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'konsole_cbox_label' ),               { size = 13, weight = 400, antialias = true, font = 'Roboto' } )

/*
*    fonts > servinfo
*/

    _f( pref( 'diag_ctrl_exit' ),                   { size = 40, weight = 200, antialias = true, font = 'Roboto' } )
    _f( pref( 'diag_ctrl_min' ),                    { size = 40, weight = 200, antialias = true, font = 'Roboto' } )
    _f( pref( 'diag_title' ),                       { size = 19, weight = 200, antialias = true, font = 'Segoe UI Light' } )
    _f( pref( 'diag_value' ),                       { size = 30, weight = 600, antialias = true, font = 'Segoe UI Light' } )
    _f( pref( 'diag_hdr_value' ),                   { size = 14, weight = 400, antialias = true, font = 'Segoe UI Light' } )
    _f( pref( 'diag_chart_legend' ),                { size = 14, weight = 400, antialias = true, font = 'Segoe UI Light' } )
    _f( pref( 'diag_chart_value' ),                 { size = 23, weight = 600, antialias = true, font = 'Segoe UI Light' } )

/*
*    fonts > dc
*/

    _f( pref( 'dc_exit' ),                          { size = 24, weight = 800, antialias = true, font = 'Roboto' } )
    _f( pref( 'dc_icon' ),                          { size = 24, weight = 100, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'dc_name' ),                          { size = 24, weight = 100, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'dc_title' ),                         { size = 16, weight = 600, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'dc_msg' ),                           { size = 16, weight = 600, antialias = true, font = 'Roboto Light' } )
    _f( pref( 'dc_btn' ),                           { size = 22, weight = 200, antialias = true, font = 'Roboto' } )

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