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

local base                          = rlib
local mf                            = base.manifest
local prefix                        = mf.prefix
local cfg                           = base.settings

/*
*   simplifiy funcs
*/

local function log( ... ) base:log( ... ) end

/*
*   Localized rlib routes
*/

local helper                        = base.h
local design                        = base.d
local ui                            = base.i
local cvar                          = base.v
local font                          = base.f
local res                           = base.resources

/*
*   Localized lua funcs
*
*   absolutely hate having to do this, but for squeezing out every bit of performance, we need to.
*/

local pairs                         = pairs
local type                          = type
local tostring                      = tostring
local IsValid                       = IsValid
local istable                       = istable
local isfunction                    = isfunction
local isnumber                      = isnumber
local IsColor                       = IsColor
local Color                         = Color
local ScreenScale                   = ScreenScale
local gui                           = gui
local vgui                          = vgui
local table                         = table
local math                          = math
local surface                       = surface
local draw                          = draw
local string                        = string
local sf                            = string.format

/*
*   helper > predefined materials
*
*   list of internal gmod mat paths
*/

helper._vgui =
{
    [ 'avatarimage' ]               = 'AvatarImage',
    [ 'avatar' ]                    = 'AvatarImage',
    [ 'av' ]                        = 'AvatarImage',
    [ 'dbinder' ]                   = 'DBinder',
    [ 'binder' ]                    = 'DBinder',
    [ 'dbubblecontainer' ]          = 'DBubbleContainer',
    [ 'bubble' ]                    = 'DBubbleContainer',
    [ 'dbutton' ]                   = 'DButton',
    [ 'button']                     = 'DButton',
    [ 'btn']                        = 'DButton',
    [ 'dcategorylist' ]             = 'DCategoryList',
    [ 'catlst' ]                    = 'DCategoryList',
    [ 'catlist' ]                   = 'DCategoryList',
    [ 'dcheckbox' ]                 = 'DCheckBox',
    [ 'checkbox' ]                  = 'DCheckBox',
    [ 'cbox' ]                      = 'DCheckBox',
    [ 'dcb' ]                       = 'DCheckBox',
    [ 'cb' ]                        = 'DCheckBox',
    [ 'dcollapsiblecategory' ]      = 'DCollapsibleCategory',
    [ 'catexpand' ]                 = 'DCollapsibleCategory',
    [ 'dcolorcombo' ]               = 'DColorCombo',
    [ 'clrcombo' ]                  = 'DColorCombo',
    [ 'clrcbo' ]                    = 'DColorCombo',
    [ 'dcolorcube' ]                = 'DColorCube',
    [ 'clrcube' ]                   = 'DColorCube',
    [ 'dcolormixer' ]               = 'DColorMixer',
    [ 'clrmixer' ]                  = 'DColorMixer',
    [ 'dcolorpalette' ]             = 'DColorPalette',
    [ 'clrpal' ]                    = 'DColorPalette',
    [ 'dcolumnsheet' ]              = 'DColumnSheet',
    [ 'colsheet' ]                  = 'DColumnSheet',
    [ 'dcombobox' ]                 = 'DComboBox',
    [ 'combobox' ]                  = 'DComboBox',
    [ 'cbo' ]                       = 'DComboBox',
    [ 'dfilebrowser' ]              = 'DFileBrowser',
    [ 'file' ]                      = 'DFileBrowser',
    [ 'dform' ]                     = 'DForm',
    [ 'form' ]                      = 'DForm',
    [ 'DFrame' ]                    = 'DFrame',
    [ 'frame' ]                     = 'DFrame',
    [ 'frm' ]                       = 'DFrame',
    [ 'dgrid' ]                     = 'DGrid',
    [ 'grid' ]                      = 'DGrid',
    [ 'dhtml' ]                     = 'DHTML',
    [ 'dweb' ]                      = 'DHTML',
    [ 'html' ]                      = 'HTML',
    [ 'web' ]                       = 'HTML',
    [ 'dhtmlcontrols' ]             = 'DHTMLControls',
    [ 'dhtmlctrls' ]                = 'DHTMLControls',
    [ 'ctrls' ]                     = 'DHTMLControls',
    [ 'dhtmctrl' ]                  = 'DHTMLControls',
    [ 'htmctrl' ]                   = 'DHTMLControls',
    [ 'dcbar' ]                     = 'DHTMLControls',
    [ 'diconlayout' ]               = 'DIconLayout',
    [ 'iconlayout' ]                = 'DIconLayout',
    [ 'dico' ]                      = 'DIconLayout',
    [ 'ilayout' ]                   = 'DIconLayout',
    [ 'il' ]                        = 'DIconLayout',
    [ 'dimage' ]                    = 'DImage',
    [ 'img' ]                       = 'DImage',
    [ 'dlabel' ]                    = 'DLabel',
    [ 'label' ]                     = 'DLabel',
    [ 'lbl' ]                       = 'DLabel',
    [ 'dlistlayout' ]               = 'DListLayout',
    [ 'lstlayout' ]                 = 'DListLayout',
    [ 'lstlo' ]                     = 'DListLayout',
    [ 'listview' ]                  = 'DListView',
    [ 'lstview' ]                   = 'DListView',
    [ 'dmenu' ]                     = 'DMenu',
    [ 'menu' ]                      = 'DMenu',
    [ 'dmenubar' ]                  = 'DMenuBar',
    [ 'menubar' ]                   = 'DMenuBar',
    [ 'mnubar' ]                    = 'DMenuBar',
    [ 'menuopt' ]                   = 'DMenuOption',
    [ 'mnuopt' ]                    = 'DMenuOption',
    [ 'menucvar' ]                  = 'DMenuOptionCVar',
    [ 'dmodelpanel' ]               = 'DModelPanel',
    [ 'model' ]                     = 'DModelPanel',
    [ 'mdl' ]                       = 'DModelPanel',
    [ 'mdlimg' ]                    = 'ModelImage',
    [ 'mdl_img' ]                   = 'ModelImage',
    [ 'modelselect' ]               = 'DModelSelect',
    [ 'mdlsel' ]                    = 'DModelSelect',
    [ 'notify' ]                    = 'DNotify',
    [ 'numscale' ]                  = 'DNumberScratch',
    [ 'numscratch' ]                = 'DNumberScratch',
    [ 'numwang' ]                   = 'DNumberWang',
    [ 'numslider' ]                 = 'DNumSlider',
    [ 'dpanel' ]                    = 'DPanel',
    [ 'pnl' ]                       = 'DPanel',
    [ 'dpanellist' ]                = 'DPanelList',
    [ 'dpl' ]                       = 'DPanelList',
    [ 'dprogress' ]                 = 'DProgress',
    [ 'progress' ]                  = 'DProgress',
    [ 'prog' ]                      = 'DProgress',
    [ 'dproperties' ]               = 'DProperties',
    [ 'prop' ]                      = 'DProperties',
    [ 'psheet' ]                    = 'DPropertySheet',
    [ 'rgb' ]                       = 'DRGBPicker',
    [ 'dscrollpanel' ]              = 'DScrollPanel',
    [ 'scrollpanel' ]               = 'DScrollPanel',
    [ 'scrollpnl' ]                 = 'DScrollPanel',
    [ 'spanel' ]                    = 'DScrollPanel',
    [ 'spnl' ]                      = 'DScrollPanel',
    [ 'dsp' ]                       = 'DScrollPanel',
    [ 'sgrip' ]                     = 'DScrollBarGrip',
    [ 'grip' ]                      = 'DScrollBarGrip',
    [ 'autosize' ]                  = 'DSizeToContents',
    [ 'dslider' ]                   = 'DSlider',
    [ 'slider' ]                    = 'DSlider',
    [ 'spawnicon' ]                 = 'SpawnIcon',
    [ 'spico' ]                     = 'SpawnIcon',
    [ 'sico' ]                      = 'SpawnIcon',
    [ 'sprite' ]                    = 'DSprite',
    [ 'tab' ]                       = 'DTab',
    [ 'dtextentry' ]                = 'DTextEntry',
    [ 'dte' ]                       = 'DTextEntry',
    [ 'entry' ]                     = 'DTextEntry',
    [ 'txt' ]                       = 'DTextEntry',
    [ 'dt' ]                        = 'DTextEntry',
    [ 'dtilelayout' ]               = 'DTileLayout',
    [ 'tlayout' ]                   = 'DTileLayout',
    [ 'tlo' ]                       = 'DTileLayout',
    [ 'tip' ]                       = 'DTooltip',
    [ 'tooltip' ]                   = 'DTooltip',
    [ 'dtree' ]                     = 'DTree',
    [ 'tree' ]                      = 'DTree',
    [ 'treenode' ]                  = 'DTree_Node',
    [ 'node' ]                      = 'DTree_Node',
    [ 'treebtn' ]                   = 'DTree_Node_Button',
    [ 'nodebtn' ]                   = 'DTree_Node_Button',
    [ 'vdivider' ]                  = 'DVerticalDivider',
    [ 'verdiv' ]                    = 'DVerticalDivider',
    [ 'vsbar' ]                     = 'DVScrollBar',
    [ 'geditable' ]                 = 'EditablePanel',
    [ 'gpanel' ]                    = 'Panel',
    [ 'material' ]                  = 'Material',
    [ 'mat' ]                       = 'Material',
    [ 'panellist' ]                 = 'PanelList',
    [ 'pnllist' ]                   = 'PanelList',
    [ 'rtxt' ]                      = 'RichText',
    [ 'rt' ]                        = 'RichText',
}

/*
*   helper > ui > id preferences
*/

helper._vgui_id =
{
    [ 1 ]                           = 'DFrame',
    [ 2 ]                           = 'DPanel',
    [ 3 ]                           = 'Panel',
    [ 4 ]                           = 'EditablePanel',
}

/*
*   dock definitions
*
*   in addition to default glua enums assigned to docking,
*   the following entries can be used.
*/

helper._dock =
{
    [ 'fill' ]      = FILL,
    [ 'left' ]      = LEFT,
    [ 'top' ]       = TOP,
    [ 'right' ]     = RIGHT,
    [ 'bottom' ]    = BOTTOM,

    [ 'f' ]         = FILL,
    [ 'l' ]         = LEFT,
    [ 't' ]         = TOP,
    [ 'r' ]         = RIGHT,
    [ 'b' ]         = BOTTOM,
}

/*
*   interface > cvars > define
*
*   cvars to be used throughout the interface
*/

ui.cvars =
{
    { sid = 1, stype = 'dropdown', is_visible = false,  id = 'rlib_language',           name = 'Preferred language',            desc = 'default interface language',    forceset = false, default = 'en' },
    { sid = 1, stype = 'checkbox', is_visible = true,   id = 'rlib_animations_enabled', name = 'Animations enabled',            desc = 'interface animations',          forceset = false, default = 1 },
    { sid = 2, stype = 'checkbox', is_visible = true,   id = 'console_timestamps',      name = 'Show timestamps in console',    desc = 'show timestamp in logs',        forceset = false, default = 0 },
}

/*
*   Localized translation func
*/

local function lang( ... )
    return base:lang( ... )
end

/*
*	prefix ids
*/

local function pid( str, suffix )
    local state = ( isstring( suffix ) and suffix ) or ( base and base.manifest.prefix ) or false
    return rlib.get:pref( str, state )
end

/*
*   metatables
*/

local dmeta = FindMetaTable( 'Panel' )

/*
*   ui > element
*
*   gets the correct element based on the class provided
*
*   @param  : str class
*   @return : str
*/

function ui.element( class )
    class = helper.str:clean( class )
    return ( class and helper._vgui and helper._vgui[ class ] or class ) or false
end

/*
*   ui > getscale
*/

function ui:GetScale( )
    return math.Clamp( ScrH( ) / 1080, 0.75, 1 )
end

/*
*   ui > scale
*
*   standard scaling
*
*   @param  : int iclamp
*   @return : int
*/

function ui:scale( iclamp )
    return math.Clamp( ScrW( ) / 1920, iclamp or 0.75, 1 )
end

/*
*   ui > Scale640
*
*   works similar to glua ScreenScale( )
*
*   @param  : int val
*   @param  : int iMax
*   @return : int
*/

function ui:Scale640( val, iMax )
    iMax = isnumber( iMax ) and iMax or ScrW( )
    return val * ( iMax / 640.0 )
end

/*
*   ui > controlled scale
*
*   a more controlled solution to screen scaling because I dislike how doing simple ScreenScaling never
*   makes things perfect.
*
*   yes I know, an rather odd way, but it works for the time being.
*
*   -w 800 -h 600
*   -w 1024 -h 768
*   -w 1280 -h 720
*   -w 1366 -h 768
*   -w 1920 -h -1080
*
*   @note   : deprecated in a future version with new system
*
*   @param  : bool bSimple
*   @param  : int i800
*   @param  : int i1024
*   @param  : int i1280
*   @param  : int i1366
*   @param  : int i1600
*   @param  : int i1920
*   @param  : int i2xxx
*   @return : int
*/

function ui:cscale( bSimple, i800, i1024, i1280, i1366, i1600, i1920, i2xxx )
    if not isbool( bSimple ) then
        log( 2, 'func [ %s ]: bSimple not bool', debug.getinfo( 1, 'n' ).name )
    end

    if not i800 then
        log( 2, 'func [ %s ]: no scale int specified', debug.getinfo( 1, 'n' ).name )
    end

    if not i1024 then i1024, i1280, i1366, i1600, i1920, i2xxx = i800, i800, i800, i800, i800, i800 end
    if not i1280 then i1280, i1366, i1600, i1920, i2xxx = i800, i800, i800, i800, i800 end
    if not i1366 then i1366, i1600, i1920, i2xxx = i1280, i1280, i1280, i1280 end
    if not i1600 then i1600, i1920, i2xxx = i1366, i1366, i1366 end
    if not i1920 then i1920, i2xxx = i1600, i1600 end
    if not i2xxx then i2xxx = i1920 end

    if ScrW( ) <= 800 then
        return bSimple and i800 or ScreenScale( i800 )
    elseif ScrW( ) > 800 and ScrW( ) <= 1024 then
        return bSimple and i1024 or ScreenScale( i1024 )
    elseif ScrW( ) > 1024 and ScrW( ) <= 1280 then
        return bSimple and i1280 or ScreenScale( i1280 )
    elseif ScrW( ) > 1280 and ScrW( ) <= 1366 then
        return bSimple and i1366 or ScreenScale( i1366 )
    elseif ScrW( ) > 1366 and ScrW( ) <= 1600 then
        return bSimple and i1600 or ScreenScale( i1600 )
    elseif ScrW( ) > 1600 and ScrW( ) <= 1920 then
        return bSimple and i1920 or ScreenScale( i1920 )
    elseif ScrW( ) > 1920 and ScrW( ) <= 2560 then
        return bSimple and i2xxx or ScreenScale( i2xxx )
    elseif ScrW( ) > 2560 then
        return bSimple and i2xxx or self:Scale640( i2xxx, 2560 )
    end
end

/*
*   ui > controlled scale
*
*   a more controlled solution to screen scaling because I dislike how doing simple ScreenScaling never
*   makes things perfect.
*
*   yes I know, an rather odd way, but it works for the time being.
*
*   -w 800 -h 600
*   -w 1024 -h 768
*   -w 1280 -h 720
*   -w 1366 -h 768
*   -w 1920 -h -1080
*
*   @param  : bool bSimple
*   @param  : int 640
*   @param  : int i800
*   @param  : int i1024
*   @param  : int i1280
*   @param  : int i1366
*   @param  : int i1600
*   @param  : int i1920
*   @param  : int i2xxx
*   @return : int
*/

function ui:SmartScale( bSimple, i640, i800, i1024, i1280, i1366, i1600, i1920, i2xxx )
    if not isbool( bSimple ) then
        log( 2, 'func [ %s ]: bSimple not bool', debug.getinfo( 1, 'n' ).name )
    end

    if not i640 then
        log( 2, 'func [ %s ]: no scale int specified', debug.getinfo( 1, 'n' ).name )
    end

    if istable( i640 ) then
        local vals  = i640
        local a1    = vals[ 1 ] or 0
        i640, i800, i1024, i1280, i1366, i1600, i1920, i2xxx = vals[ 1 ], vals[ 2 ] or a1, vals[ 3 ] or a1, vals[ 4 ] or a1, vals[ 5 ] or a1, vals[ 6 ] or a1, vals[ 7 ] or a1, vals[ 8 ] or a1
    end

    if not i800 then i800, i1024, i1280, i1366, i1600, i1920, i2xxx = i640, i640, i640, i640, i640, i640, i640, i640 end
    if not i1024 then i1024, i1280, i1366, i1600, i1920, i2xxx = i800, i800, i800, i800, i800, i800 end
    if not i1280 then i1280, i1366, i1600, i1920, i2xxx = i800, i800, i800, i800, i800 end
    if not i1366 then i1366, i1600, i1920, i2xxx = i1280, i1280, i1280, i1280 end
    if not i1600 then i1600, i1920, i2xxx = i1366, i1366, i1366 end
    if not i1920 then i1920, i2xxx = i1600, i1600 end
    if not i2xxx then i2xxx = i1920 end

    if ScrW( ) <= 640 then
        return bSimple and i640 or ScreenScale( i640 )
    elseif ScrW( ) > 640 and ScrW( ) <= 800 then
        return bSimple and i800 or ScreenScale( i800 )
    elseif ScrW( ) > 800 and ScrW( ) <= 1024 then
        return bSimple and i1024 or ScreenScale( i1024 )
    elseif ScrW( ) > 1024 and ScrW( ) <= 1280 then
        return bSimple and i1280 or ScreenScale( i1280 )
    elseif ScrW( ) > 1280 and ScrW( ) <= 1366 then
        return bSimple and i1366 or ScreenScale( i1366 )
    elseif ScrW( ) > 1366 and ScrW( ) <= 1600 then
        return bSimple and i1600 or ScreenScale( i1600 )
    elseif ScrW( ) > 1600 and ScrW( ) <= 1920 then
        return bSimple and i1920 or ScreenScale( i1920 )
    elseif ScrW( ) > 1920 and ScrW( ) <= 2560 then
        return bSimple and i2xxx or ScreenScale( i2xxx )
    elseif ScrW( ) > 2560 then
        return bSimple and i2xxx or self:Scale640( i2xxx, 2560 )
    end
end

/*
*   ui > controlled scale > height
*
*   a more controlled solution to screen scaling because I dislike how doing simple ScreenScaling never
*   makes things perfect.
*
*   -w 640 -h 480
*   -w 800 -h 600
*   -w 1024 -h 768
*   -w 1152 -h 864
*   -w 1280 -h -960
*
*   @param  : bool bSimple
*   @param  : int i480
*   @param  : int i600
*   @param  : int i768
*   @param  : int i864
*   @param  : int i960
*   @param  : int i1024
*   @param  : int i1080
*   @param  : int i1440
*   @return : int
*/

function ui:SmartScaleH( bSimple, i480, i600, i768, i864, i960, i1024, i1080, i1440 )
    if not isbool( bSimple ) then
        log( 2, 'func [ %s ]: bSimple not bool', debug.getinfo( 1, 'n' ).name )
    end

    if not i480 then
        log( 2, 'func [ %s ]: no scale int specified', debug.getinfo( 1, 'n' ).name )
    end

    if istable( i480 ) then
        local vals  = i480
        local a1    = vals[ 1 ] or 0
        i480, i600, i768, i864, i960, i1024, i1080, i1440 = vals[ 1 ], vals[ 2 ] or a1, vals[ 3 ] or a1, vals[ 4 ] or a1, vals[ 5 ] or a1, vals[ 6 ] or a1, vals[ 7 ] or a1, vals[ 8 ] or a1
    end

    if not i600 then i600, i768, i864, i960, i1024, i1080, i1440 = i480, i480, i480, i480, i480, i480, i480, i480 end
    if not i768 then i768, i864, i960, i1024, i1080, i1440 = i600, i600, i600, i600, i600, i600 end
    if not i864 then i864, i960, i1024, i1080, i1440 = i600, i600, i600, i600, i600 end
    if not i960 then i960, i1024, i1080, i1440 = i864, i864, i864, i864 end
    if not i1024 then i1024, i1080, i1440 = i960, i960, i960 end
    if not i1080 then i1080, i1440 = i1024, i1024 end
    if not i1440 then i1440 = i1080 end

    if ScrH( ) <= 480 then
        return bSimple and i480 or ScreenScale( i480 )
    elseif ScrH( ) > 480 and ScrH( ) <= 600 then
        return bSimple and i600 or ScreenScale( i600 )
    elseif ScrH( ) > 600 and ScrH( ) <= 768 then
        return bSimple and i768 or ScreenScale( i768 )
    elseif ScrH( ) > 768 and ScrH( ) <= 864 then
        return bSimple and i864 or ScreenScale( i864 )
    elseif ScrH( ) > 864 and ScrH( ) <= 960 then
        return bSimple and i960 or ScreenScale( i960 )
    elseif ScrH( ) > 960 and ScrH( ) <= 1024 then
        return bSimple and i1024 or ScreenScale( i1024 )
    elseif ScrH( ) > 1024 and ScrH( ) <= 1080 then
        return bSimple and i1080 or ScreenScale( i1080 )
    elseif ScrH( ) > 1080 and ScrH( ) <= 1440 then
        return bSimple and i1440 or ScreenScale( i1440 )
    elseif ScrH( ) > 1440 then
        return bSimple and i1440 or self:Scale640( i1440, 1440 )
    end
end

/*
*   ui > ScrW( )
*
*   @return : int
*/

function ui:ScrW( )
    local w = ScrW( )
    if w > 3840 then w = 3840 end
    return w
end

/*
*   ui > ScrH( )
*
*   @return : int
*/

function ui:ScrH( )
    local h = ScrH( )
    if h > 2160 then h = 2160 end
    return h
end

/*
*   ui > GetScaleW
*
*   @param  : flo mult
*   @return : int
*/

function ui:GetScaleW( mult )
    mult = mult or 0.4
    return mult * ( self:ScrW( ) / 640.0 )
end

/*
*   ui > GetScaleH
*
*   @param  : flo mult
*   @return : int
*/

function ui:GetScaleH( mult )
    mult = mult or 0.4
    return mult * ( self:ScrH( ) / 480.0 )
end

/*
*   ui > iScaleW
*
*   @param  : int size
*   @param  : int min
*   @param  : int max
*   @param  : flo mult
*   @return : flo
*/

function ui:iScaleW( size, min, max, mult )
    local m         = mult or 0.4
    local scale     = self:GetScaleW( m )
    local amt       = size * scale

    if min and amt < min then
        amt = min
    end

    if max and amt > max then
        amt = max
    end

    return amt
end

/*
*   ui > iScaleW > divide
*
*   @param  : int size
*   @param  : int min
*   @param  : int max
*   @param  : flo mult
*   @return : flo
*/

function ui:iScaleWD( size, min, max, mult )
    local m         = mult or 0.4
    local scale     = self:GetScaleW( m )
    local amt       = size / scale

    if min and amt < min then
        amt = min
    end

    if max and amt > max then
        amt = max
    end

    return amt
end

/*
*   ui > iScaleH
*
*   @param  : int size
*   @param  : int min
*   @param  : int max
*   @param  : flo mult
*   @return : flo
*/

function ui:iScaleH( size, min, max, mult )
    local m         = mult or 0.4
    local scale     = self:GetScaleH( m )
    local amt       = size * scale

    if min and amt < min then
        amt = min
    end

    if max and amt > max then
        amt = max
    end

    return amt
end

/*
*   ui > iScaleH > divide
*
*   @param  : int size
*   @param  : int min
*   @param  : int max
*   @param  : flo mult
*   @return : flo
*/

function ui:iScaleHD( size, min, max, mult )
    local m         = mult or 0.4
    local scale     = self:GetScaleH( m )
    local amt       = size / scale

    if min and amt < min then
        amt = min
    end

    if max and amt > max then
        amt = max
    end

    return amt
end

/*
*   ui > clamp scale
*
*   scale utilizing a clamped w and h value
*
*   @param  : int w
*   @param  : int h
*   @return : int w, h
*/

function ui:ClampScale( w, h )
    h = isnumber( h ) and h or w
    return math.Clamp( 1920, 0, ScrW( ) / w ), math.Clamp( 1080, 0, ScrH( ) / h )
end

/*
*   ui > clamp scale > width
*
*   clamp a width value
*
*   @param  : int w
*   @param  : int min
*   @param  : int max
*   @return : int
*/

function ui:ClampScale_w( w, min, max )
    w = isnumber( w ) and w or ScrW( )
    return math.Clamp( ScreenScale( w ), min or 0, max or ScreenScale( w ) )
end

/*
*   ui > clamp scale > height
*
*   clamp a height value
*
*   @param  : int h
*   @param  : int min
*   @param  : int max
*   @return : int
*/

function ui:ClampScale_h( h, min, max )
    h = isnumber( h ) and h or ScrH( )
    return math.Clamp( ScreenScale( h ), min or 0, max or ScreenScale( h ) )
end

/*
*   ui > basic scale
*
*   basic scaling control
*
*   @note   : deprecated in future
*
*   @param  : int s
*   @param  : int m
*   @param  : int l
*   @return : int
*/

function ui:bscale( s, m, l )
    if not m then m = s end
    if not l then l = s end

    if ScrW( ) <= 1280 then
        return ScreenScale( s )
    elseif ScrW( ) >= 1281 and ScrW( ) <= 1600 then
        return ScreenScale( m )
    elseif ScrW( ) >= 1601 then
        return ScreenScale( l )
    else
        return s
    end
end

/*
*   ui > scalesimple
*
*   simple scaling
*
*   @note   : deprecated in future
*
*   @param  : int s
*   @param  : int m
*   @param  : int l
*   @return : int
*/

function ui:scalesimple( s, m, l )
    if not m then m = s end
    if not l then l = s end

    if ScrW( ) <= 1280 then
        return s
    elseif ScrW( ) >= 1281 and ScrW( ) <= 1600 then
        return m
    elseif ScrW( ) >= 1601 then
        return l
    else
        return s
    end
end

/*
*   ui > setscale
*
*   calculates the screenscaled size (w, h) of a panel
*
*   @param  : int w
*   @param  : int h
*   @return : int, int
*/

function ui:setscale( w, h )
    w = isnumber( w ) and w or 300
    h = isnumber( h ) and h or w

    local sc_w, sc_h        = self:scalesimple( 0.85, 0.85, 0.90 ), self:scalesimple( 0.85, 0.85, 0.90 )
    local pnl_w, pnl_h      = w, h
    local ui_w, ui_h        = sc_w * pnl_w, sc_h * pnl_h

    return ui_w, ui_h
end

/*
*   ui > position
*
*   returns w, h position for a specified pnl
*   based on the string, int pos desired
*
*   @ex     : ui:GetPosition( pnl, 5, 20 )
*             gets pnl pos based on center-screen with padding of 20
*
*   @param  : pnl pnl
*   @param  : str, int pos
*   @param  : int pad
*/

function ui:GetPosition( pnl, pos, pad )

    /*
    *   check > valid pnl
    */

    if not self:valid( pnl ) then return 0, 0 end

    /*
    *   validate > vars
    */

    pos                     = isnumber( pos ) and pos or isstring( pos ) and pos or 5
    pad                     = isnumber( pad ) and pad or 0

    /*
    *   define > vars
    */

    local pnl_w, pnl_h      = pnl:GetSize( )
    local w, h              = 0, 0

    /*
    *   top
    */

    if ( pos == 't' or pos == 8 ) then
        w, h        = ScrW( ) / 2 - pnl_w / 2, pad

    /*
    *   top-right
    */

    elseif ( pos == 'tr' or pos == 9 ) then
        w, h        = ScrW( ) - pnl_w - 20, pad

    /*
    *   right
    */

    elseif ( pos == 'r' or pos == 6 ) then
        w, h        = ScrW( ) - pnl_w - pad, ( ( ScrH( ) / 2 ) - ( pnl_h / 2 ) )

    /*
    *   bottom-right
    */

    elseif ( pos == 'br' or pos == 3 ) then
        w, h        = ScrW( ) - pnl_w - pad, ScrH( ) - pnl_h - pad

    /*
    *   bottom
    */

    elseif ( pos == 'b' or pos == 2 ) then
        w, h        = ScrW( ) / 2 - pnl_w / 2, ScrH( ) - pnl_h - pad

    /*
    *   bottom-left
    */

    elseif ( pos == 'bl' or pos == 1 ) then
        w, h        = pad, ScrH( ) - pnl_h - pad

    /*
    *   left
    */

    elseif ( pos == 'l' or pos == 4 ) then
        w, h        = pad, ( ( ScrH( ) / 2 ) - ( pnl_h / 2 ) )

    /*
    *   top-left
    */

    elseif ( pos == 'tl' or pos == 7 ) then
        w, h        = pad, pad

    /*
    *   center
    */

    elseif ( pos == 'c' or pos == 5 ) then
        w, h        = ( ( ScrW( ) / 2 ) - ( pnl_w / 2 ) ), ( ( ScrH( ) / 2 ) - ( pnl_h / 2 ) )
    end

    return w, h

end

/*
*   ui > valid
*
*   checks validation of a panel
*   uses this vs isvalid for future control
*
*   @param  : pnl pnl
*   @return : bool
*/

function ui:valid( pnl )
    if not pnl or type( pnl ) ~= 'Panel' then return false end
    if not IsValid( pnl ) then return false end
    return true
end

/*
*   ui > registered
*
*   similar to ui:valid( ); however, checks it
*   as a registered rlib panel
*
*   @ex     : ui:registered( 'pnl_root', mod )
*           : ui:registered( global_panel )
*
*   @param  : str, pnl id
*   @param  : tbl mod
*   @return : bool
*/

function ui:registered( id, mod )
    if not helper.str:valid( id ) or not istable( mod ) then
        return self:ok( id ) and true or false
    end

    local pnl       = self:call( id, mod )

    return self:ok( pnl ) and true or false
end

/*
*   ui > update
*
*   executes invalidatelayout if pnl valid
*
*   @alias  : rehash, invalidate
*
*   @param  : str, pnl id
*   @param  : tbl mod
*   @return : void
*/

function ui:rehash( id, mod )
    if not helper.str:valid( id ) or not istable( mod ) then
        if not self:ok( id ) then return end
        id:InvalidateLayout( )
        return
    end

    local pnl       = self:call( id, mod )
                    if not self:ok( pnl ) then return false end

    pnl:InvalidateLayout( )
end
ui.invalidate = ui.rehash

/*
*   ui > clear
*
*   clears an interface
*
*   @param  : str, pnl id
*   @param  : tbl mod
*/

function ui:clear( id, mod )
    if not helper.str:valid( id ) or not istable( mod ) then
        if not self:ok( id ) then return end
        id:Clear( )
        return
    end

    local pnl       = self:call( id, mod )
                    if not self:ok( pnl ) then return false end

    pnl:Clear( )
end

/*
*   ui > close
*
*   hides or removes the DFrame, and calls DFrame:OnClose.
*   to set whether the frame is hidden or removed, use DFrame:SetDeleteOnClose.
*
*   @param  : str, pnl id
*   @param  : tbl mod
*/

function ui:close( id, mod )
    if not helper.str:valid( id ) or not istable( mod ) then
        if not self:ok( id ) then return end
        id:Close( )
        return
    end

    local pnl       = self:call( id, mod )
                    if not self:ok( pnl ) then return false end

    pnl:Close( )
end

/*
*   ui > visible
*
*   checks a panel for validation and if currently visible
*
*   @ex     : ui:visible( 'pnl_root', mod )
*           : ui:visible( global_panel )
*
*   @param  : str, pnl id
*   @param  : tbl mod
*   @return : bool
*/

function ui:visible( id, mod )
    if not helper.str:valid( id ) or not istable( mod ) then
        return self:ok( id ) and id:IsVisible( ) and true or false
    end

    local pnl       = self:call( id, mod )
                    if not self:ok( pnl ) then return false end

    return pnl:IsVisible( ) and true or false
end

/*
*   ui > destroy
*
*   checks a panel for validation and then removes it completely.
*
*   @param  : pnl pnl
*   @param  : bool halt
*   @param  : bool bMouse [optional]
*   @param  : pnl subpanel [optional]
*/

function ui:destroy( pnl, halt, bMouse, sub )
    if sub and not self:ok( sub ) then return end
    if self:ok( pnl ) then pnl:Remove( ) end
    if bMouse then
        gui.EnableScreenClicker( false )
    end
    if halt then return false end
end

/*
*   ui > destroy visible
*
*   checks a panel for validation and visible then removes it completely.
*
*
*   @ex     : ui:destroy_visible( 'pnl_root', mod )
*           : ui:destroy_visible( global_panel )
*
*   @param  : str, pnl id
*   @param  : tbl mod
*/

function ui:destroy_visible( id, mod )
    if not helper.str:valid( id ) or not istable( mod ) then
        if self:ok( id ) and self:visible( id ) then
            id:Remove( )
        end
        return
    end

    local pnl       = self:call( id, mod )
                    if not self:ok( pnl ) then return false end

    if self:visible( pnl ) then
        pnl:Remove( )
    end
end

/*
*   ui > hide
*
*   checks a panel for validation and if its currently visible and then sets panel visibility to false.
*
*   @param  : pnl pnl
*   @param  : bool bMouse
*/

function ui:hide( pnl, bMouse )
    if self:ok( pnl ) then
        pnl:SetVisible( false )
        if bMouse then
            gui.EnableScreenClicker( false )
        end
    end
end

/*
*   ui > autosize
*
*   applies SizeToContents( ) to specified pnl
*
*   @param  : str, pnl id
*   @param  : tbl mod
*/

function ui:autosize( id, mod )
    if not helper.str:valid( id ) or not istable( mod ) then
        if not self:ok( id ) then return end
        id:SizeToContents( )
        return
    end

    local pnl       = self:call( id, mod )
                    if not self:ok( pnl ) then return false end

    pnl:SizeToContents( )
end

/*
*   ui > hide visible
*
*   checks a panel for validation and if its currently visible and then sets panel visibility to false.
*
*   @param  : pnl pnl
*   @param  : bool bMouse
*/

function ui:hide_visible( pnl, bMouse )
    if self:ok( pnl ) and self:visible( pnl ) then
        pnl:SetVisible( false )
        if bMouse then
            gui.EnableScreenClicker( false )
        end
    end
end

/*
*   ui > show
*
*   checks a panel for validation and if its not currently visible and then sets panel to visible.
*
*   @param  : pnl pnl
*   @param  : bool bMouse
*/

function ui:show( pnl, bMouse )
    if self:ok( pnl ) and not self:visible( pnl ) then
        pnl:SetVisible( true )
        if bMouse then
            gui.EnableScreenClicker( true )
        end
    end
end

/*
*   ui > visibility flip
*
*   determines if a panel is currently either visible or not and then flips the panel visibility status.
*
*   providing a sub panel will check both the parent and sub for validation, but only flip the sub panel
*   if the parent panel is valid.
*
*   @param  : pnl pnl
*   @param  : pnl sub
*/

function ui:visible_flip( pnl, sub )
    if not self:ok( pnl ) then return end

    if sub then
        if not self:ok( sub ) then return end
    else
        sub = pnl
    end

    if self:visible( pnl ) then
        sub:SetVisible( false )
    else
        sub:SetVisible( true )
    end
end

/*
*   ui > set visible
*
*   allows for a bool to be passed to determine if the pnl should be visible or not
*
*   @param  : pnl pnl
*   @param  : bool b
*/

function ui:setvisible( pnl, b )
    if not self:ok( pnl ) then return end
    pnl:SetVisible( helper:val2bool( b ) or false )
end

/*
*   ui > setpos
*
*   checks an obj for validation and sets its position
*
*   @param  : pnl pnl
*   @param  : int x
*   @param  : int y
*/

function ui:pos( pnl, x, y )
    x = x or 0
    y = y or 0

    if not self:visible( pnl ) then return end
    pnl:SetPos( x, y )
end

/*
*   ui > settext
*
*   method to setting text
*
*   @param  : pnl pnl
*   @param  : str text
*   @param  : str face
*/

function ui:settext( pnl, text, face )
    if not self:ok( pnl ) then return end
    text = isstring( text ) and text or ''

    if face then
        pnl:SetFont( face )
    end
    pnl:SetText( text )
end

/*
*   ui > get panel
*
*   returns the call name of a registered panel from the module's manifest file
*   returns nil if not registered
*
*   registered pnls in > base.p[ mod ][ panel_id ]
*
*   @ex     : ui:register( 'pnl_theme', mod )
*
*   @param  : str id
*   @param  : str mod
*   @return : str
*/

function ui:getpnl( id, mod )
    if not helper.str:valid( id ) then
        log( 2, lang( 'inf_reg_id_invalid' ) )
        return false
    end

    local _cache    = id

    id              = helper.str:clean( id )
    mod             = ( isstring( mod ) and mod ) or ( istable( mod ) and mod.id ) or prefix
    base.p          = istable( base.p ) and base.p or { }

    local name      = res:exists( mod, 'pnl', id )

    if not name then
        return id
    end

    return name
end

/*
*   ui > register panel
*
*   creates a usable panel that may need to be accessed globally. Do not store local panels using
*   this method.
*
*   places registered pnl in > base.p[ mod ][ panel_id ]
*
*   @ex     : ui:register( 'themes', mod, pnl_theme, 'themes pnl' )
*
*   @param  : str id
*   @param  : str mod
*   @param  : pnl pnl
*   @param  : str desc
*/

function ui:register( id, mod, panel, desc )
    if not helper.str:valid( id ) then
        log( 2, lang( 'inf_reg_id_invalid' ) )
        return false
    end

    id              = helper.str:clean( id )
    mod             = ( isstring( mod ) and mod ) or ( istable( mod ) and mod.id ) or prefix
    base.p          = istable( base.p ) and base.p or { }

    local name      = rlib:resource( mod, 'pnl', id )

    if ui:ok( panel ) then
        base.p[ mod ] = base.p[ mod ] or { }
        base.p[ mod ][ name ] =
        {
            pnl     = panel,
            desc    = desc or lang( 'none' )
        }
        log( 6, lang( 'inf_registered', name ) )
    end
end

/*
*   ui > registered > load
*
*   loads a previously registered panel
*
*   @ex     :       local content = ui:load( 'pnl.parent.content', 'xtask' )
^                   if not content or not ui:valid( content.pnl ) then return end
^                   content.pnl:Clear( )
*
*   @param  : str id
*   @param  : str, tbl mod
*   @return : tbl
*/

function ui:load( id, mod )
    if not helper.str:valid( id ) then
        log( 2, lang( 'inf_load_id_invalid' ) )
        return false
    end

    id              = helper.str:clean( id )
    mod             = ( isstring( mod ) and mod ) or ( istable( mod ) and mod.id ) or prefix

    local name      = rlib:resource( mod, 'pnl', id )

    if not istable( base.p ) then
        log( 2, lang( 'inf_load_tbl_invalid' ) )
        return false
    end

    if not istable( base.p[ mod ] ) or not istable( base.p[ mod ][ name ] ) then return name end
    return self:ok( base.p[ mod ][ name ].pnl ) and base.p[ mod ][ name ] or false
end

/*
*   ui > registered > call panel
*
*   calls a previously registered panel similar to ui.load
*   but this validates and calls just the panel.
*
*   @ex     :   local pnl = ui:call( id, mod )
*               if not pnl then return end
*
*   @param  : str id
*   @param  : str, tbl mod
*   @return : tbl
*/

function ui:call( id, mod )
    if not helper.str:valid( id ) then
        log( 2, lang( 'inf_load_id_invalid' ) )
        return false
    end

    id              = helper.str:clean( id )
    mod             = ( isstring( mod ) and mod ) or ( istable( mod ) and mod.id ) or prefix

    local name      = rlib:resource( mod, 'pnl', id )

    if not istable( base.p ) then
        log( 2, lang( 'inf_load_tbl_invalid' ) )
        return false
    end

    if not istable( base.p[ mod ] ) or not istable( base.p[ mod ][ name ] ) then return end -- return nothing since invalid pnl
    return self:ok( base.p[ mod ][ name ].pnl ) and base.p[ mod ][ name ].pnl or false
end

/*
*   ui > unregister panel
*
*   removes a registered panel from the library
*
*   @param  : str id
*   @param  : str, tbl mod
*/

function ui:unregister( id, mod )
    if not helper.str:valid( id ) then
        log( 2, lang( 'inf_unreg_id_invalid' ) )
        return false
    end

    mod = isstring( mod ) and mod or prefix

    if not istable( base.p ) then
        log( 2, lang( 'inf_unreg_tbl_invalid' ) )
        return false
    end

    id              = helper.str:clean( id )
    local name      = rlib:resource( mod, 'pnl', id )

    if base.p[ mod ] and base.p[ mod ][ name ] then
        base.p[ mod ][ name ] = nil
        log( 6, lang( 'inf_unregister', name ) )
    end
end

/*
*   ui > create
*
*   utilities vgui.Register as a shortcut
*   used for pnls registered under the rlib:resources( ) method
*
*   if no class provided; defaults to DFrame
*
*   @ex     : ui:create( mod, 'bg', PANEL, 'pnl' )
*           : ui:create( mod, 'bg', PANEL )
*           : ui:create( mod, 'bg', PANEL, 1 )
*           : ui:create( mod, 'bg', PANEL, 2 )
*
*   @param  : tbl mod
*   @param  : str id
*   @param  : pnl pnl
*   @param  : str, int class
*/

function ui:create( mod, id, pnl, class )
    if not id or not pnl then return end

    local call = rlib:resource( mod, 'pnl', id )

    if isnumber( class ) then
        class = helper._vgui_id[ class ]
    elseif isstring( class ) then
        class = ( class and ui.element( class ) )
    else
        class = 'DFrame'
    end

    vgui.Register( call, pnl, class )
end

/*
*   ui > validate registered pnl
*
*   determines if a registered pnl is valid
*
*   @param  : str, pnl id
*   @param  : tbl mod
*   @return : bool
*/

function ui:ok( id, mod )
    if mod then
        local pnl       = self:call( id, mod )
                        if self:ok( pnl ) then return true end
    end

    if self:valid( id ) then return true end
    return ( istable( id ) and self:valid( id.pnl ) and true ) or false
end

/*
*   ui > registered > dispatch
*
*   destroys a registered pnl
*   ensures a pnl is a valid pnl first
*
*   @param  : str id
*   @param  : str, tbl mod
*   @param  : bool bMouse
*   @return : void
*/

function ui:dispatch( id, mod, bMouse )
    if not helper.str:valid( id ) or not istable( mod ) then
        self:destroy( id )

        if bMouse then
            gui.EnableScreenClicker( false )
        end
        return
    end

    local pnl       = self:call( id, mod )
                    if not self:ok( pnl ) then return false end

    self:unregister ( id, mod )
    self:destroy    ( pnl )

    if bMouse then
        gui.EnableScreenClicker( false )
    end
end

/*
*   ui > registered > stage
*
*   shows a registered pnl
*   ensures a pnl is a valid pnl first
*
*   @param  : str id
*   @param  : str, tbl mod
*   @param  : bool bMouse
*   @return : void
*/

function ui:stage( id, mod, bMouse )
    if not helper.str:valid( id ) or not istable( mod ) then
        self:show( id )

        if bMouse then
            gui.EnableScreenClicker( true )
        end

        return
    end

    local pnl       = self:call( id, mod )
                    if not self:ok( pnl ) then return false end

    self:show( pnl )

    if bMouse then
        gui.EnableScreenClicker( true )
    end
end

/*
*   ui > registered > unstage
*
*   hides a registered pnl
*   ensures a pnl is a valid pnl first
*
*   @param  : str id
*   @param  : str, tbl mod
*   @param  : bool bMouse
*   @return : void
*/

function ui:unstage( id, mod, bMouse )
    if not helper.str:valid( id ) or not istable( mod ) then
        self:hide( id )

        if bMouse then
            gui.EnableScreenClicker( false )
        end

        return
    end

    local pnl       = self:call( id, mod )
                    if not self:ok( pnl ) then return false end

    self:hide( pnl )

    if bMouse then
        gui.EnableScreenClicker( false )
    end
end

/*
*   ui > create fonts
*
*   creates a generic set of fonts to be used with the library
*
*   @param  : str suffix
*   @param  : str face
*   @param  : bool bShadow
*   @param  : int scale [ optional ]
*/

function ui:fonts_register( suffix, face, bShadow, scale )
    suffix          = isstring( suffix ) and suffix or prefix
    face            = isstring( face ) and face or pid( 'ucl_font_def' )
    bShadow         = bShadow or false
    scale           = isnumber( scale ) and scale or self:scale( )

    local char_last = string.sub( suffix, -1 )

    local font_sz =
    {
        [ 12 ] = '12',
        [ 14 ] = '14',
        [ 16 ] = '16',
        [ 18 ] = '18',
        [ 20 ] = '20',
        [ 22 ] = '22',
        [ 24 ] = '24',
        [ 32 ] = '32',
        [ 36 ] = '36',
    }

    local weights =
    {
        [ 100 ] = '100',
        [ 200 ] = '200',
        [ 400 ] = '400',
        [ 600 ] = '600',
        [ 800 ] = '800',
    }

    if char_last ~= '_' then
        suffix = suffix .. '_'
    end

    for sz, sz_name in pairs( font_sz ) do
        local calc_sz   = sz * scale
        local name      = sf( '%s%s', suffix, sz_name )
        surface.CreateFont( name, { font = face, size = calc_sz, shadow = bShadow, antialias = true } )
        for wg, wg_name in pairs( weights ) do
            name        = sf( '%s%s_%s', suffix, sz_name, wg_name )
            surface.CreateFont( name, { font = face, size = calc_sz, weight = wg_name, shadow = bShadow, antialias = true } )
        end
    end
end

/*
*   ui > html > img > full
*
*   returns an html element supporting outside images
*   typically used for ui backgrounds
*
*   @param  : tbl, str src
*   @param  : bool bRand
*   @return : str
*/

function ui:html_img_full( src, bRand )
    local resp = bRand and table.Random( src ) or isstring( src ) and src
    return [[
		<body style='overflow: hidden; height: auto; width: auto;'>
			<img src=']] .. resp .. [[' style='position: absolute; height: 100%; width: 100%; top: 0%; left: 0%; margin: auto;'>
		</body>
    ]]
end

/*
*   ui > html > img
*
*   returns an html element supporting outside images
*   typically used for ui backgrounds
*
*   @param  : tbl, str src
*   @param  : bool bRand
*   @return : str
*/

function ui:html_img( src, bRand )
    local resp = bRand and table.Random( src ) or isstring( src ) and src
    return [[
        <body style='overflow: hidden; height: 100%; width: 100%; margin:0px;'>
            <img width='100%' height='100%' src=']] .. resp .. [['>
        </body>
    ]]
end

/*
*   ui > html > size
*
*   returns an html element supporting outside images
*   allows for specific size to be provided
*
*   @param  : str src
*   @param  : int w
*   @param  : int h
*   @return : str
*/

function ui:html_img_sz( src, w, h )
    local resp = isstring( src ) and src or tostring( src )
    h = isnumber( h ) and h or w
    return [[
        <body style='overflow: hidden; height: 100%; width: 100%; margin:0px;'>
            <img width=']] .. w .. [[' height=']] .. h .. [[' src=']] .. resp .. [['>
        </body>
    ]]
end

/*
*   ui > html > iframe
*
*   returns an html element supporting outside sites
*   typically used for ui backgrounds / live wallpapers
*
*   @param  : tbl, str src
*   @param  : bool bRand
*   @return : str
*/

function ui:html_iframe( src, bRand )
    local resp = bRand and table.Random( src ) or isstring( src ) and src
    return [[
        <body style='overflow: hidden; height: 100%; width: 100%; margin:0px;'>
            <iframe width='100%' frameborder='0' height='100%' src=']] .. resp .. [['></iframe>
        </body>
    ]]
end

/*
*   ui > get > svg
*
*   utilized for svg resources
*
*   @param  : tbl, str src
*   @param  : bool bShow
*   @return : str
*/

function ui:getsvg( src, bShow )
    src = isstring( src ) and src or ''
    local display = not bShow and 'display:none;' or ''
    return [[
        <body style='overflow: hidden; height: 100%; width: 100%; margin:0px;]] .. display .. [['>
            <iframe width='100%' frameborder='0' height='100%' src=']] .. src .. [['></iframe>
        </body>
    ]]
end

/*
*   ui > onhover
*/

ui.OnHover = function( s )
    return s:IsHovered( )
end

ui.OnHoverChild = function( s )
    return s:IsHovered( ) or s:IsChildHovered( )
end

/*
*   ui > append Override
*/

ui.SetAppendOverwrite = function( s, fn )
    s.AppendOverwrite = fn
end

ui.ClearAppendOverwrite = function( s )
    s.AppendOverwrite = nil
end

/*
*   ui classes
*
*   credit to threebow for the idea as he utilized such a method in tdlib.
*   it makes creating new panels a lot more clean thanks to metatables
*
*   ive obviously made my own changes and taken a slightly different
*   direction, but the original idea is thanks to him
*
*   this dude is the apple to my pie; and the straw to my berry.
*
*   @source :   https://github.com/Threebow/tdlib
*/

local uclass = { }

    /*
    *   uclass > Run
    *
    *   @param  : str name
    *   @param  : func fn
    */

    function uclass.run( pnl, name, fn )
        if not name then return end
        if not isfunction( fn ) then return end

        name = pnl.AppendOverwrite or name

        local orig = pnl[ name ]
        pnl[ name ] = function( s, ... )
            if isfunction( orig ) then
                orig( s, ... )
            end
            fn( s, ... )
        end
    end

    /*
    *   uclass > setup
    *
    *   @param  : func fn
    */

    function uclass.setup( pnl, fn )
        pnl.bInitialized    = false

        if pnl._Fonts then
            pnl:_Fonts( )
        end

        if pnl._Lang then
            pnl:_Lang( )
        end

        if pnl._Declare then
            pnl:_Declare( )
        end

        if pnl._Colorize then
            pnl:_Colorize( )
        end

        if pnl._Call then
            pnl:_Call( )
        end

        if isfunction( fn ) then
            fn( pnl )
        end
    end
    uclass.onload = uclass.setup

    /*
    *   uclass > NoDraw
    */

    function uclass.nodraw( pnl )
        pnl.Paint = nil
    end
    uclass.nopaint = uclass.nodraw

    /*
    *   uclass > Draw
    *
    *   @param  : func fn
    */

    function uclass.draw( pnl, fn )
        if not isfunction( fn ) then return end
        uclass.nodraw( pnl )
        pnl[ 'Paint' ] = fn
    end
    uclass.paint = uclass.draw

    /*
    *   uclass > SaveDraw
    *
    *   @param  : func fn
    */

    function uclass.savedraw( pnl )
        pnl.OldPaint = pnl.Paint
    end

    /*
    *   uclass > GetDraw
    *
    *   @param  : func fn
    */

    function uclass.getdraw( pnl )
        if not pnl.OldPaint then return end
        pnl[ 'Paint' ] = pnl.OldPaint
    end

    /*
    *   uclass > DrawManual
    *
    *   @param  : bool b
    */

    function uclass.drawmanual( pnl, b )
        pnl:SetPaintedManually( helper:val2bool( b ) )
    end

    /*
    *   uclass > Panel > Name
    *
    *   @param  : str name
    */

    function uclass.name( pnl, name )
        if not name then return end
        pnl:SetName( name )
    end

    /*
    *   uclass > Panel > SetConVar
    *
    *   @param  : str id
    */

    function uclass.convar( pnl, name )
        name = isstring( name ) and name or ''
        pnl:SetConVar( name )
    end

    /*
    *   uclass > Panel > ConVarChanged
    *
    *   @param  : str val
    */

    function uclass.cvar_chg( pnl, val )
        val = isstring( val ) and val or ''
        pnl:ConVarChanged( val )
    end

    /*
    *   uclass > Panel > ConVarNumberThink
    */

    function uclass.cvar_th_int( pnl )
        pnl:ConVarNumberThink( )
    end

    /*
    *   uclass > Panel > ConVarStringThink
    */

    function uclass.cvar_th_str( pnl )
        pnl:ConVarStringThink( )
    end

    /*
    *   uclass > convarname
    *
    *   @alias  : cvar
    *
    *   @param  : str name
    */

    function uclass.cvar( pnl, name )
        name = isstring( name ) and name or ''
        pnl.convarname = name
    end
    uclass.cvarname = uclass.cvar

    /*
    *   uclass > assign
    *
    *   @alias  : assign
    *
    *   @param  : str id
    *   @param  : mix data
    */

    function uclass.assign( pnl, id, data )
        if not id then return end
        data        = data or ''
        pnl[ id ]   = data
    end

    /*
    *   uclass > attach
    *
    *   @alias  : attach
    *
    *   @param  : pnl child
    *   @param  : bool bNoDestroy
    */

    function uclass.attach( pnl, child, bNoDestroy )
        if not ui:ok( child ) then return end
        pnl:Attach( child )
        if bNoDestroy and pnl.NoDestroy then
            pnl:NoDestroy( )
        end
    end

    /*
    *   uclass > attach > parent
    *
    *   @alias  : attach
    *
    *   @param  : pnl parent
    *   @param  : bool bNoDestroy
    */

    function uclass.attachpar( pnl, parent, bNoDestroy )
        if not ui:ok( parent ) then return end
        parent:Attach( pnl )
        if bNoDestroy and parent.NoDestroy then
            parent:NoDestroy( )
        end
    end

    /*
    *   uclass > action
    *
    *   @alias  : action
    *
    *   @param  : func fn
    */

    function uclass.action( pnl, fn )
        if not isfunction( fn ) then return end
        pnl:SetAction( fn )
    end

    /*
    *   uclass > slider > barcolor
    *
    *   @alias  : clr_bar
    *
    *   @param  : clr clr
    */

    function uclass.clr_bar( pnl, clr )
        if not clr then return end
        pnl.BarColor = clr
    end

    /*
    *   uclass > paint > over
    *
    *   @alias  : drawover, po
    *
    *   @param  : func fn
    */

    function uclass.drawover( pnl, fn )
        if not isfunction( fn ) then return end
        pnl[ 'PaintOver' ] = fn
    end
    uclass.po       = uclass.drawover

    /*
    *   uclass > paint > box
    *
    *   @alias  : paintbox, box, drawbox, pb
    *
    *   @param  : clr clr
    *   @param  : int x
    *   @param  : int y
    *   @param  : int w
    *   @param  : int h
    */

    function uclass.box( pnl, clr, x, y, w, h )
        clr         = ( IsColor( clr ) and clr or isnumber( clr ) and clr ) or Color( 25, 25, 25, 255 )

                    if isnumber( clr ) then
                        clr = Color( clr, clr, clr, 255 )
                    end

        x           = isnumber( x ) and x or 0
        y           = isnumber( y ) and y or 0

        local sz_w  = w or 'f'
        local sz_h  = h or 'f'

        uclass.nodraw( pnl )
        pnl[ 'Paint' ] = function( s, w2, h2 )
            local def_w = ( ( sz_w ~= 'f' ) and sz_w ) or w2
            local def_h = ( ( sz_h ~= 'f' ) and sz_h ) or h2

            design.box( x, y, def_w, def_h, clr )
        end
    end
    uclass.drawbox    = uclass.box
    uclass.pb         = uclass.box

    /*
    *   uclass > paint > entry
    *
    *   @alias  : paintentry, drawentry
    *
    *   @param  : clr clr_text
    *   @param  : clr clr_cur
    *   @param  : clr clr_hl
    */

    function uclass.drawentry( pnl, clr_text, clr_cur, clr_hl )
        clr_text    = IsColor( clr_text ) and clr_text or Color( 255, 255, 255, 255 )
        clr_cur     = IsColor( clr_cur ) and clr_cur or Color( 150, 150, 150, 255 )
        clr_hl      = IsColor( clr_hl ) and clr_hl or Color( 25, 25, 25, 255 )

        pnl[ 'Paint' ] = function( s, w, h )
            s:SetTextColor      ( clr_text      )
            s:SetCursorColor    ( clr_cur       )
            s:SetHighlightColor ( clr_hl        )
            s:DrawTextEntryText ( s:GetTextColor( ), s:GetHighlightColor( ), s:GetCursorColor( ) )
        end
    end

    /*
    *   uclass > paint > rounded box
    *
    *   @alias  : paintrbox, drawrbox, rbox
    *
    *   @param  : clr clr
    *   @param  : int x
    *   @param  : int y
    *   @param  : int w
    *   @param  : int h
    */

    function uclass.rbox( pnl, clr, r, x, y, w, h )
        clr         = ( IsColor( clr ) and clr or isnumber( clr ) and clr ) or Color( 25, 25, 25, 255 )

                    if isnumber( clr ) then
                        clr = Color( clr, clr, clr, 255 )
                    end

        r           = isnumber( r ) and r or 4
        x           = isnumber( x ) and x or 0
        y           = isnumber( y ) and y or 0

        local sz_w  = w or 'f'
        local sz_h  = h or 'f'

        uclass.nodraw( pnl )
        pnl[ 'Paint' ] = function( s, w2, h2 )
            local def_w = ( ( sz_w ~= 'f' ) and sz_w ) or w2
            local def_h = ( ( sz_h ~= 'f' ) and sz_h ) or h2

            design.rbox( r, x, y, def_w, def_h, clr )
        end
    end
    uclass.box_r        = uclass.rbox

    /*
    *   uclass > box > thick
    *
    *   adds blur and a single box to the pnl paint hook
    *
    *   @param  : clr clr
    *             clr for box
    *
    *   @param  : int th [ optional ]
    *             thickness of line
    *
    *   @param  : int x
    *   @param  : int y
    *   @param  : int w
    *   @param  : int h
    */

    function uclass.thbox( pnl, clr, th, x, y, w, h )
        clr         = ( IsColor( clr ) and clr or isnumber( clr ) and clr ) or Color( 25, 25, 25, 255 )

                    if isnumber( clr ) then
                        clr = Color( clr, clr, clr, 255 )
                    end

        th          = isnumber( th ) and th or 1
        x           = isnumber( x ) and x or 0
        y           = isnumber( y ) and y or 0

        local sz_w  = w or 'f'
        local sz_h  = h or 'f'

        uclass.nodraw( pnl )
        pnl[ 'Paint' ] = function( s, w2, h2 )
            local def_w = ( ( sz_w ~= 'f' ) and sz_w ) or w2
            local def_h = ( ( sz_h ~= 'f' ) and sz_h ) or h2

            design.obox_th( x, y, def_w, def_h, clr, th )
        end
    end
    uclass.box_th       = uclass.thbox

    /*
    *   uclass > debug > where
    *
    *   applies a simple painted box to the specified element to determine
    *   location on the screen
    *
    *   @alias  : debug_where, where
    *
    *   @param  : clr clr
    */

    function uclass.debug_where( pnl, clr )
        clr = IsColor( clr ) and clr or Color( 255, 255, 255, 255 )

        uclass.nodraw( pnl )
        pnl[ 'PaintOver' ] = function( s, w, h )
            design.box( 0, 0, w, h, clr )
        end
    end
    uclass.where = uclass.debug_where

    /*
    *   uclass > PerformLayout
    *
    *   @alias  : performlayout, pl
    *
    *   @param  : func fn
    */

    function uclass.performlayout( pnl, fn )
        if not isfunction( fn ) then return end

        local name = 'PerformLayout'
        local orig = pnl[ name ]

        pnl[ name ] = function( s, ... )
            if isfunction( orig ) then orig( s, ... ) end
            fn( s, ... )
        end
    end
    uclass.pl = uclass.performlayout

    /*
    *   uclass > DoClick
    *
    *   @alias  : onclick, oc
    *
    *   @param  : func fn
    */

    function uclass.onclick( pnl, fn )
        if not isfunction( fn ) then return end

        local name = 'DoClick'
        local orig = pnl[ name ]

        pnl[ name ] = function( s, ... )
            if isfunction( orig ) then orig( s, ... ) end
            fn( s, ... )
        end
    end
    uclass.oc = uclass.onclick

    /*
    *   uclass > DoRightClick
    *
    *   @alias  : onrclick, orc
    *
    *   @param  : func fn
    */

    function uclass.onrclick( pnl, fn )
        if not isfunction( fn ) then return end

        local name = 'DoRightClick'
        local orig = pnl[ name ]

        pnl[ name ] = function( s, ... )
            if isfunction( orig ) then orig( s, ... ) end
            fn( s, ... )
        end
    end
    uclass.orc = uclass.onrclick

    /*
    *   uclass > DoMiddleClick
    *
    *   @alias  : onmclick, omc
    *
    *   @param  : func fn
    */

    function uclass.onmclick( pnl, fn )
        if not isfunction( fn ) then return end

        local name = 'DoMiddleClick'
        local orig = pnl[ name ]

        pnl[ name ] = function( s, ... )
            if isfunction( orig ) then orig( s, ... ) end
            fn( s, ... )
        end
    end
    uclass.omc = uclass.onmclick

    /*
    *   uclass > connect
    *
    *   @alias  : connect, conn
    *
    *   @param  : ply pl
    *   @param  : str ip
    */

    function uclass.connect( pnl, pl, ip )
        if not isstring( ip ) then return end
        if not helper.ok.ply( pl ) then return end

        pnl[ 'DoClick' ] = function( s, ... )
            pl:ConCommand( 'connect ' .. ip )
        end
    end
    uclass.conn = uclass.connect

    /*
    *   uclass > onclick > rem
    *
    *   @alias  : onclick_r, ocr, click_r
    *
    *   @param  : pnl panel
    *   @param  : bool bHide
    */

    function uclass.onclick_r( pnl, panel, bHide )
        pnl[ 'DoClick' ] = function( s, ... )
            if not ui:ok( panel ) then return end
            if bHide then
                ui:hide( panel )
            else
                ui:destroy( panel )
            end
        end
    end
    uclass.ocr        = uclass.onclick_r

    /*
    *   uclass > onclick > rem visible
    *
    *   @alias  : onclick_rv, ocrv
    *
    *   @param  : pnl panel
    *   @param  : bool bHide
    */

    function uclass.onclick_rv( pnl, panel, bHide )
        pnl[ 'DoClick' ] = function( s, ... )
            if not ui:ok( panel ) then return end
            if bHide then
                ui:hide( panel )
            else
                ui:destroy_visible( panel )
            end
        end
    end
    uclass.ocrv       = uclass.onclick_rv

    /*
    *   uclass > onclick > fade out
    *
    *   @alias  : onclick_fadeout, ocfo
    *
    *   @param  : pnl panel
    *   @param  : int delay
    *   @param  : bool bHide
    */

    function uclass.onclick_fadeout( pnl, panel, delay, bHide )
        pnl[ 'DoClick' ] = function( s, ... )
            if not ui:ok( panel ) then return end
            delay   = isnumber( delay ) and delay or 0.2

            panel:AlphaTo( 0, delay, 0, function( )
                if bHide then
                    ui:hide( panel )
                else
                    ui:destroy( panel )
                end
            end )
        end
    end
    uclass.ocfo = uclass.onclick_fadeout

    /*
    *   uclass > onremove
    *
    *   @alias  : onremove, remove, orem
    *
    *   @param  : func fn
    */

    function uclass.onremove( pnl, fn )
        if not isfunction( fn ) then return end

        local name = 'OnRemove'
        local orig = pnl[ name ]

        pnl[ name ] = function( s, ... )
            if isfunction( orig ) then orig( s, ... ) end
            fn( s, ... )
        end
    end
    uclass.remove     = uclass.onremove
    uclass.orem       = uclass.onremove

    /*
    *   uclass > OnTextChanged
    *
    *   @alias  : ontxtchg, otch
    *
    *   @param  : func fn
    */

    function uclass.ontxtchg( pnl, fn )
        if not isfunction( fn ) then return end

        local name = 'OnTextChanged'
        local orig = pnl[ name ]

        pnl[ name ] = function( s, ... )
            if isfunction( orig ) then orig( s, ... ) end
            fn( s, ... )
        end
    end
    uclass.otch       = uclass.ontxtchg

    /*
    *   uclass > DTextEntry > noedit
    *
    *   supplying bNoEdit will automatically reset text each time text changed.
    *   used as a workaround for times when SetEditable simply doesnt work.
    *
    *   bNoEdit = true      : causes entry to not be scrolled or used at all
    *
    *   @alias  : noedit, tlock, txtlock
    *
    *   @param  : func fn
    *   @param  : str orig
    */

    function uclass.noedit( pnl, orig )
        pnl[ 'OnTextChanged' ] = function( s, ... )
            if isstring( orig ) then
                s:SetText( orig )
            end
        end
    end
    uclass.tlock    = uclass.noedit
    uclass.txtlock  = uclass.noedit

    /*
    *   uclass > DTextEntry > SetEditable
    *
    *   @param  : bool b
    */

    function uclass.canedit( pnl, b )
        pnl:SetEditable( helper:val2bool( b ) or false )
    end

    /*
    *   uclass > DTextEntry > SetEditable
    */

    function uclass.lbllock( pnl )
        pnl:SetEditable( false )
    end

    /*
    *   uclass > DTextEntry > no input
    *
    *   uses AllowInput in order to restrict dtextentry text editing
    *
    *   @alias  : noedit, tlock
    *
    *   @param  : bool
    */

    function uclass.noinput( pnl )
        pnl[ 'AllowInput' ] = function( s, ... )
            return true
        end
    end

    /*
    *   uclass > DTextEntry > AllowInput
    *
    *   @param  : func fn
    */

    function uclass.allowinput( pnl, fn )
        local name = 'AllowInput'
        local orig = pnl[ name ]

        pnl[ name ] = function( s, ... )
            if isfunction( orig ) then orig( s, ... ) end
            fn( s, ... )
        end
    end

    /*
    *   uclass > openurl
    *
    *   @alias  : openurl, ourl
    *
    *   @param  : str uri
    */

    function uclass.openurl( pnl, uri )
        if not isstring( uri ) then return end
        pnl[ 'DoClick' ] = function( s )
            gui.OpenURL( uri )
        end
    end
    uclass.ourl   = uclass.openurl

    /*
    *   uclass > OnSelect
    *
    *   @alias  : onselect, osel
    *
    *   @param  : func fn
    */

    function uclass.onselect( pnl, fn )
        if not isfunction( fn ) then return end

        local name = 'OnSelect'
        local orig = pnl[ name ]

        pnl[ name ] = function( s, ... )
            if isfunction( orig ) then orig( s, ... ) end
            fn( s, ... )
        end
    end
    uclass.osel = uclass.onselect

    /*
    *   uclass > DComboBox > doclick
    *
    *   @alias  : cboclick, odc
    *
    *   @param  : func fn
    */

    function uclass.cboclick( pnl, fn )
        if not isfunction( fn ) then return end

        pnl[ 'DoClick' ] = function( s, ... )
            if s:IsMenuOpen( ) then return s:CloseMenu( ) end
            fn( s, ... )
        end
    end
    uclass.obc = uclass.cboclick

    /*
    *   uclass > DComboBox > OpenMenu
    *
    *   @alias  : omenu
    *
    *   @param  : func fn
    */

    function uclass.omenu( pnl, fn )
        if not isfunction( fn ) then return end

        local name = 'OpenMenu'
        local orig = pnl[ name ]

        pnl[ name ] = function( ... )
            if isfunction( orig ) then orig( ... ) end
            fn( ... )
        end
    end

    /*
    *   uclass > DTextEntry > m_bLoseFocusOnClickAway
    *
    *   @alias  : onclick_nofocus, ocnf
    *
    *   @param  : bool b
    */

    function uclass.onclick_nofocus( pnl, b )
        pnl.m_bLoseFocusOnClickAway = helper:val2bool( b ) or false
    end
    uclass.ocnf = uclass.onclick_nofocus

    /*
    *   uclass > OnGetFocus
    *
    *   @alias  : ongetfocus, ogfo, getfocus
    *
    *   @param  : func fn
    */

    function uclass.ongetfocus( pnl, fn )
        if not isfunction( fn ) then return end

        local name = 'OnGetFocus'
        local orig = pnl[ name ]

        pnl[ name ] = function( s, ... )
            if isfunction( orig ) then orig( s, ... ) end
            fn( s, ... )
        end
    end
    uclass.ogfo         = uclass.ongetfocus
    uclass.getfocus     = uclass.ongetfocus
    uclass.ogfocus      = uclass.ongetfocus

    /*
    *   uclass > DNum > OnValueChanged
    *
    *   @alias  : onvaluechanged, ovc
    *
    *   @param  : func fn
    */

    function uclass.onvaluechanged( pnl, fn )
        if not isfunction( fn ) then return end

        local name = 'OnValueChanged'
        local orig = pnl[ name ]

        pnl[ name ] = function( s, ... )
            if isfunction( orig ) then orig( s, ... ) end
            fn( s, ... )
        end
    end
    uclass.ovc = uclass.onvaluechanged

    /*
    *   uclass > DTextEntry > OnChange
    *
    *   @alias  : onchange, ochg
    *
    *   @param  : func fn
    */

    function uclass.onchange( pnl, fn )
        if not isfunction( fn ) then return end
        pnl[ 'OnChange' ] = fn
    end
    uclass.ochg = uclass.onchange

    /*
    *   uclass > onOptionChanged
    *
    *   @alias  : onoptchange, ooc
    *
    *   @param  : func fn
    */

    function uclass.onoptchange( pnl, fn )
        if not isfunction( fn ) then return end

        local name = 'onOptionChanged'
        local orig = pnl[ name ]

        pnl[ name ] = function( s, ... )
            if isfunction( orig ) then orig( s, ... ) end
            fn( s, ... )
        end
    end
    uclass.ooc = uclass.onoptchange

    /*
    *   uclass > enabled > check
    *
    *   @alias  : enabled_chk, echk
    *
    *   @param  : func fn
    */

    function uclass.enabled_chk( pnl, fn )
        if not isfunction( fn ) then return end

        local name = 'enabled'
        local orig = pnl[ name ]

        pnl[ name ] = function( s, ... )
            if isfunction( orig ) then orig( s, ... ) end
            fn( s, ... )
        end
    end
    uclass.echk = uclass.enabled_chk

    /*
    *   uclass > onclose
    *
    *   @alias  : onclose
    *
    *   @param  : func fn
    */

    function uclass.onclose( pnl, fn )
        if not isfunction( fn ) then return end

        local name = 'OnClose'
        local orig = pnl[ name ]

        pnl[ name ] = function( s, ... )
            if isfunction( orig ) then orig( s, ... ) end
            fn( s, ... )
        end
    end

    /*
    *   uclass > think
    *
    *   @alias  : think, logic
    *
    *   @param  : func fn
    */

    function uclass.think( pnl, fn )
        if not isfunction( fn ) then return end

        local name = 'Think'
        local orig = pnl[ name ]

        pnl[ name ] = function( s, ... )
            if isfunction( orig ) then orig( s, ... ) end
            fn( s, ... )
        end
    end
    uclass.logic = uclass.think

    /*
    *   uclass > think > slow
    *
    *   calls 'think' but with a firing delay.
    *   used for calculations that dont need to happen every single tick
    *
    *   either dur or fn can be the function
    *   dur defaults to 0.5 if actual fn not supplied
    *
    *   @alias  : think_sl, logic_sl
    *
    *   @param  : int, func dur
    *   @param  : func fn
    */

    function uclass.think_sl( pnl, dur, fn )
        if not isfunction( fn ) and not isfunction( dur ) then return end
        fn  = isfunction( fn ) and fn or isfunction( dur ) and dur
        dur = isnumber( dur ) and dur or isfunction( dur ) and 0.5

        local name = 'Think'
        local orig = pnl[ name ]

        pnl[ name ] = function( s, ... )
            if s.nextlogic and s.nextlogic > CurTime( ) then return end
            if isfunction( orig ) then orig( s, ... ) end
            fn( s, ... )
            s.nextlogic = CurTime( ) + dur
        end
    end
    uclass.logic_sl = uclass.think_sl

    /*
    *   uclass > DModelPanel > norotate
    *
    *   forces dmodelpanel to not auto-rotate the model
    *
    *   @alias  : norotate
    */

    function uclass.norotate( pnl )
        pnl[ 'LayoutEntity' ] = function( s, ... ) return end
    end

    /*
    *   uclass > DModelPanel > LayoutEntity
    *
    *   @alias  : norotate, le
    */

    function uclass.layoutent( pnl, fn )
        if not isfunction( fn ) then return end

        local name = 'LayoutEntity'
        local orig = pnl[ name ]

        pnl[ name ] = function( s, ... )
            if isfunction( orig ) then orig( s, ... ) end
            fn( s, ... )
        end
    end
    uclass.le = uclass.layoutent

    /*
    *   uclass > DModelPanel > onmousepress
    *
    *   rerouted action to define particular mouse definitions
    *
    *   @alias  : onmouse, omp
    */

    function uclass.onmouse( pnl )
        pnl[ 'OnMousePressed' ] = function( s, act )
            if pnl:IsHovered( ) or s.hover then
                if act == MOUSE_LEFT and pnl.DoClick then pnl:DoClick( ) end
                if act == MOUSE_RIGHT and pnl.DoRightClick then pnl:DoRightClick( ) end
                if act == MOUSE_MIDDLE and pnl.DoMiddleClick  then pnl:DoMiddleClick( ) end
            end
        end
    end
    uclass.omp            = uclass.onmouse

    /*
    *   uclass > DModelPanel > onmousepress > defined
    *
    *   rerouted action to define particular mouse definitions
    *
    *   @alias  : onmouse, omp
    */

    function uclass.onmouse_d( pnl, fn )
        if not isfunction( fn ) then return end

        local name = 'OnMousePressed'
        local orig = pnl[ name ]

        pnl[ name ] = function( s, ... )
            if isfunction( orig ) then orig( s, ... ) end
            fn( s, ... )
        end
    end
    uclass.ompd         = uclass.onmouse_d

    /*
    *   uclass > Dock
    *
    *   @alias  : dock, static
    *
    *   @param  : int pos
    */

    function uclass.dock( pnl, pos )
        pos = ( type( pos ) == 'number' and pos ) or ( helper._dock[ pos ] ) or FILL
        pnl:Dock( pos )
    end
    uclass.static = uclass.dock

    /*
    *   uclass > Dock > left
    *
    *   @alias  : left
    *
    *   @param  : str, int t
    *   @param  : int il
    *   @param  : int it
    *   @param  : int ir
    *   @param  : int ib
    */

    function uclass.left( pnl, t, il, it, ir, ib )
        pnl:Dock( LEFT )
        if ( t == 'm' or t == 1 ) or ( t == 'p' or t == 2 ) then
            il = isnumber( il ) and il or 0

            if not it then it, ir, ib = il, il, il end
            if not ir then ir, ib = it, it end
            if not ib then ib = ir end

            if t == 'm' or t == 1 then
                pnl:DockMargin( il, it, ir, ib )
            elseif t == 'p' or t == 2 then
                pnl:DockPadding( il, it, ir, ib )
            end
        end
    end

    /*
    *   uclass > Dock > top
    *
    *   @alias  : top
    *
    *   @param  : str, int t
    *   @param  : int il
    *   @param  : int it
    *   @param  : int ir
    *   @param  : int ib
    */

    function uclass.top( pnl, t, il, it, ir, ib )
        pnl:Dock( TOP )
        if ( t == 'm' or t == 1 ) or ( t == 'p' or t == 2 ) then
            il = isnumber( il ) and il or 0

            if not it then it, ir, ib = il, il, il end
            if not ir then ir, ib = it, it end
            if not ib then ib = ir end

            if t == 'm' or t == 1 then
                pnl:DockMargin( il, it, ir, ib )
            elseif t == 'p' or t == 2 then
                pnl:DockPadding( il, it, ir, ib )
            end
        end
    end

    /*
    *   uclass > Dock > right
    *
    *   @alias  : right
    *
    *   @param  : str, int t
    *   @param  : int il
    *   @param  : int it
    *   @param  : int ir
    *   @param  : int ib
    */

    function uclass.right( pnl, t, il, it, ir, ib )
        pnl:Dock( RIGHT )
        if ( t == 'm' or t == 1 ) or ( t == 'p' or t == 2 ) then
            il = isnumber( il ) and il or 0

            if not it then it, ir, ib = il, il, il end
            if not ir then ir, ib = it, it end
            if not ib then ib = ir end

            if t == 'm' or t == 1 then
                pnl:DockMargin( il, it, ir, ib )
            elseif t == 'p' or t == 2 then
                pnl:DockPadding( il, it, ir, ib )
            end
        end
    end

    /*
    *   uclass > Dock > bottom
    *
    *   @alias  : bottom
    *
    *   @param  : str, int t
    *   @param  : int il
    *   @param  : int it
    *   @param  : int ir
    *   @param  : int ib
    */

    function uclass.bottom( pnl, t, il, it, ir, ib )
        pnl:Dock( BOTTOM )
        if ( t == 'm' or t == 1 ) or ( t == 'p' or t == 2 ) then
            il = isnumber( il ) and il or 0

            if not it then it, ir, ib = il, il, il end
            if not ir then ir, ib = it, it end
            if not ib then ib = ir end

            if t == 'm' or t == 1 then
                pnl:DockMargin( il, it, ir, ib )
            elseif t == 'p' or t == 2 then
                pnl:DockPadding( il, it, ir, ib )
            end
        end
    end

    /*
    *   uclass > Dock > fill
    *
    *   @alias  : fill
    *
    *   @param  : str, int t
    *   @param  : int il
    *   @param  : int it
    *   @param  : int ir
    *   @param  : int ib
    */

    function uclass.fill( pnl, t, il, it, ir, ib )
        pnl:Dock( FILL )
        if ( t == 'm' or t == 1 ) or ( t == 'p' or t == 2 ) then
            il = isnumber( il ) and il or 0

            if not it then it, ir, ib = il, il, il end
            if not ir then ir, ib = it, it end
            if not ib then ib = ir end

            if t == 'm' or t == 1 then
                pnl:DockMargin( il, it, ir, ib )
            elseif t == 'p' or t == 2 then
                pnl:DockPadding( il, it, ir, ib )
            end
        end
    end

    /*
    *   uclass > Dock, DockMargin
    *
    *   @alias  : docker, docker_m
    *
    *   @param  : int pos
    *   @param  : int il
    *   @param  : int it
    *   @param  : int ir
    *   @param  : int ib
    */

    function uclass.docker( pnl, pos, il, it, ir, ib )
        pos = ( type( pos ) == 'number' and pos ) or ( helper._dock[ pos ] ) or FILL

        il = isnumber( il ) and il or 0

        if not it then it, ir, ib = il, il, il end
        if not ir then ir, ib = it, it end
        if not ib then ib = ir end

        pnl:Dock( pos )
        pnl:DockMargin( il, it, ir, ib )
    end
    uclass.docker_m = uclass.docker
    uclass.mdock    = uclass.docker

    /*
    *   uclass > Dock, DockPadding
    *
    *   @alias  : docker_p
    *
    *   @param  : int pos
    *   @param  : int il
    *   @param  : int it
    *   @param  : int ir
    *   @param  : int ib
    */

    function uclass.docker_p( pnl, pos, il, it, ir, ib )
        pos = ( type( pos ) == 'number' and pos ) or ( helper._dock[ pos ] ) or FILL

        il = isnumber( il ) and il or 0

        if not it then it, ir, ib = il, il, il end
        if not ir then ir, ib = it, it end
        if not ib then ib = ir end

        pnl:Dock( pos )
        pnl:DockPadding( il, it, ir, ib )
    end
    uclass.pdock    = uclass.docker_p

    /*
    *   uclass > DockPadding
    *
    *   @alias  : padding, dock_p
    *
    *   @param  : int val
    */

    function uclass.setpadding( pnl, val )
        val = isnumber( val ) and val or 0

        pnl:SetPadding( val )
    end
    uclass.spad = uclass.setpadding

    /*
    *   uclass > DockPadding
    *
    *   @alias  : padding, dock_p
    *
    *   @param  : int il
    *   @param  : int it
    *   @param  : int ir
    *   @param  : int ib
    */

    function uclass.padding( pnl, il, it, ir, ib )
        il = isnumber( il ) and il or 0

        if not it then it, ir, ib = il, il, il end
        if not ir then ir, ib = it, it end
        if not ib then ib = ir end

        pnl:DockPadding( il, it, ir, ib )
    end
    uclass.dock_p = uclass.padding

    /*
    *   uclass > DockMargin
    *
    *   @alias  : margin, dock_m
    *
    *   @param  : int il
    *   @param  : int it
    *   @param  : int ir
    *   @param  : int ib
    */

    function uclass.margin( pnl, il, it, ir, ib )
        il = isnumber( il ) and il or 0

        if not it then it, ir, ib = il, il, il end
        if not ir then ir, ib = it, it end
        if not ib then ib = ir end

        pnl:DockMargin( il, it, ir, ib )
    end
    uclass.dock_m = uclass.margin

    /*
    *   uclass > Panel > SetPadding
    *
    *   @alias  : offset, oset
    *
    *   @param  : int i
    */

    function uclass.offset( pnl, i )
        i = isnumber( i ) and i or 0
        pnl:SetPadding( i )
    end
    uclass.oset = uclass.offset

    /*
    *   uclass > SetWide
    *
    *   @alias  : wide, width
    *
    *   @param  : int w
    */

    function uclass.wide( pnl, w, err )
        if isstring( w ) and w == 'screen' then
            pnl:SetWide( ScrW( ) )
            return
        end

        w = isnumber( w ) and w or 25
        pnl:SetWide( w )
    end
    uclass.width  = uclass.wide

    /*
    *   uclass > SetMinWidth
    *
    *   @alias  : minwide, wmin
    *
    *   @param  : int w
    */

    function uclass.minwide( pnl, w )
        w = isnumber( w ) and w or 30
        pnl:SetMinWidth( w )
    end
    uclass.wmin = uclass.minwide

    /*
    *   uclass > SetTall
    *
    *   @alias  : tall, height
    *
    *   @param  : int h
    */

    function uclass.tall( pnl, h )
        if isstring( h ) and h == 'screen' then
            pnl:SetTall( ScrH( ) )
            return
        end

        h = isnumber( h ) and h or 25
        pnl:SetTall( h )
    end
    uclass.height = uclass.tall

    /*
    *   uclass > SetMinHeight
    *
    *   @alias  : mintall, hmin
    *
    *   @param  : int h
    */

    function uclass.mintall( pnl, h )
        h = isnumber( h ) and h or 30
        pnl:SetMinHeight( h )
    end
    uclass.hmin = uclass.mintall

    /*
    *   uclass > SetSize
    *
    *   term 'scr' || w, h blank        : autosize fullscreen based on resolution
    *   term 'scr'                      : autosize one particular dimension to full monitor resolution
    *
    *   @alias  : size, sz
    *
    *   @param  : int w, str
    *   @param  : int h, str
    */

    function uclass.size( pnl, w, h )
        if not w or ( isstring( w ) and ( ( w == 'screen' ) or ( w == 'scr' ) ) ) then
            pnl:SetSize( ScrW( ), ScrH( ) )
            return
        end
        w = ( isnumber( w ) and w ) or ( isstring( w ) and ( w == 'screen' or w == 'scr' ) and ScrW( ) ) or 25
        h = ( isnumber( h ) and h ) or ( isstring( h ) and ( h == 'screen' or h == 'scr' ) and ScrH( ) ) or w
        pnl:SetSize( w, h )
    end
    uclass.sz = uclass.size

    /*
    *   uclass > SetPos
    *
    *   @alias  : pos
    *
    *   @param  : int x
    *   @param  : int y
    */

    function uclass.pos( pnl, x, y )
        x = isnumber( x ) and x or 0
        y = isnumber( y ) and y or isnumber( x ) and x or 0
        pnl:SetPos( x, y )
    end

    /*
    *   uclass > SetPos
    *
    *   positions based on table index / key
    *
    *   @param  : int x
    *   @param  : int y
    */

    function uclass.pos_table_x( pnl, x, y )
        x = isnumber( x ) and x or 0
        y = isnumber( y ) and y or isnumber( x ) and x or 0
        x = x * ( pnl.pos_ind or 0 )
        pnl:SetPos( x, y )
    end

    /*
    *   uclass > SetPos
    *
    *   positions based on table index / key
    *
    *   @param  : int x
    *   @param  : int y
    */

    function uclass.pos_table_y( pnl, x, y )
        x = isnumber( x ) and x or 0
        y = isnumber( y ) and y or isnumber( x ) and x or 0
        y = y * ( pnl.pos_ind or 0 )
        pnl:SetPos( x, y )
    end

    /*
    *   uclass > insert to table
    *
    *   @param  : func fn
    *   @param  : tbl tbl
    *   @param  : int pos
    */

    function uclass.insert( pnl, tbl, pos )
        if not istable( tbl ) then return end
        local where = 0
        if isnumber( pos ) then
            where = table.insert( tbl, pos, pnl )
        else
            where = table.insert( tbl, pnl )
        end
        pnl.pos_ind = where
    end

    /*
    *   uclass > SetSpaceX
    *
    *   @alias  : space_x
    *
    *   @param  : int i
    */

    function uclass.space_x( pnl, i )
        i = isnumber( i ) and i or 0
        pnl:SetSpaceX( i )
    end

    /*
    *   uclass > SetSpaceY
    *
    *   @alias  : space_y
    *
    *   @param  : int i
    */

    function uclass.space_y( pnl, i )
        i = isnumber( i ) and i or 0
        pnl:SetSpaceY( i )
    end

    /*
    *   uclass > SetSpaceX, SetSpaceY
    *
    *   @alias  : spacing, space_xy
    *
    *   @param  : int x
    *   @param  : int y
    */

    function uclass.spacing( pnl, x, y )
        x = isnumber( x ) and x or 0
        y = isnumber( y ) and y or isnumber( x ) and x or 0
        pnl:SetSpaceX( x )
        pnl:SetSpaceY( y )
    end
    uclass.space_xy = uclass.spacing

    /*
    *   uclass > DPanelList > SetSpacing
    *
    *   sets distance between list items
    *
    *   @alias  : dspace
    *
    *   @param  : int amt
    */

    function uclass.dspace( pnl, amt )
        amt = isnumber( amt ) and amt or 0
        pnl:SetSpacing( amt )
    end

    /*
    *   uclass > DIconLayout > SetLayoutDir
    *
    *   sets the direction that it will be layed out, using the DOCK_ Enums.
    *   currently only TOP and LEFT are supported.
    *
    *   @alias  : lodir, lod
    *
    *   @param  : int enum
    */

    function uclass.lodir( pnl, enum )
        enum = isnumber( enum ) and enum or LEFT
        pnl:SetLayoutDir( enum )
    end
    uclass.lod    = uclass.lodir

    /*
    *   uclass > SetColor
    *
    *   @alias  : clr, color
    *
    *   @param  : clr clr
    */

    function uclass.clr( pnl, clr )
        clr = IsColor( clr ) and clr or Color( 255, 255, 255, 255 )
        pnl:SetColor( clr )
    end
    uclass.color = uclass.clr

    /*
    *   uclass > DTextEntry > SetCursorColor
    *
    *   @alias  : cursorclr, cclr
    *
    *   @param  : clr clr
    */

    function uclass.cursorclr( pnl, clr )
        clr = IsColor( clr ) and clr or Color( 255, 255, 255, 255 )
        pnl:SetCursorColor( clr )
    end
    uclass.cclr = uclass.cursorclr

    /*
    *   uclass > DTextEntry > SetHighlightColor
    *
    *   @alias  : highlightclr, hlclr
    *
    *   @param  : clr clr
    */

    function uclass.highlightclr( pnl, clr )
        clr = IsColor( clr ) and clr or Color( 255, 255, 255, 255 )
        pnl:SetHighlightColor( clr )
    end
    uclass.hlclr = uclass.highlightclr

    /*
    *   uclass > Panel > CursorPos
    *
    *   @alias  : cursorpos, cpos
    */

    function uclass.cursorpos( pnl )
        pnl:CursorPos( )
    end
    uclass.cpos = uclass.cursorpos

    /*
    *   uclass > Panel > SetSteamID
    *
    *   @alias  : steamid, sid
    *
    *   @param  : int sid
    *             64bit SteamID of the player to load avatar of
    *
    *   @param  : int size
    *             Size of the avatar to use. Acceptable sizes are 32, 64, 184.
    */

    function uclass.steamid( pnl, sid, size )
        pnl:SetSteamID( sid, size )
    end
    uclass.sid = uclass.steamid

    /*
    *   uclass > Panel > SetCursor
    *
    *   @alias  : cursor, cur
    *
    *   @param  : str str
    */

    function uclass.cursor( pnl, str )
        str = isstring( str ) and str or 'none'
        pnl:SetCursor( str )
    end
    uclass.cur = uclass.cursor

    /*
    *   uclass > Panel > SetCursorColor
    *
    *   @alias  : cursor_clr, curclr
    *
    *   @param  : clr clr
    */

    function uclass.cursor_clr( pnl, clr )
        clr = IsColor( clr ) and clr or Color( 255, 255, 255, 255 )
        pnl:SetCursorColor( clr )
    end
    uclass.curclr = uclass.setcursor_clr

    /*
    *   uclass > Panel > SetCursorColor, SetCursor
    *
    *   @param  : clr clr
    *   @param  : str str
    */

    function uclass.setcursor( pnl, clr, str )
        clr = IsColor( clr ) and clr or Color( 255, 255, 255, 255 )
        str = isstring( str ) and str or 'none'
        pnl:SetCursorColor( clr )
        pnl:SetCursor( str )
    end
    uclass.scur = uclass.setcursor

    /*
    *   uclass > DHTML > SetScrollbars
    *
    *   @param  : bool b
    */

    function uclass.sbar( pnl, b )
        pnl:SetScrollbars( helper:val2bool( b ) or false )
    end

    /*
    *   uclass > DTextEntry, RichText > SetVerticalScrollbarEnabled
    *
    *   @param  : bool b
    */

    function uclass.vsbar( pnl, b )
        pnl:SetVerticalScrollbarEnabled( helper:val2bool( b ) or false )
    end

    /*
    *   uclass > DScrollPanel > GetVBar
    *
    *   returns the vertical scroll bar of the panel.
    *
    *   @param  : bool bRemove
    *             removes vbar
    */

    function uclass.vbar( pnl, bRemove )
        if not bRemove then
            pnl:GetVBar( )
        else
            pnl:GetVBar( ):Remove( )
        end
    end

    /*
    *   uclass > DTextEntry, RichText > SetVerticalScrollbarEnabled
    */

    function uclass.noscroll( pnl )
        pnl:SetVerticalScrollbarEnabled( false )
    end

    /*
    *   uclass > Panel > SetMultiline
    *
    *   @param  : bool b
    */

    function uclass.multiline( pnl, b )
        pnl:SetMultiline( helper:val2bool( b ) or false )
    end
    uclass.mline = uclass.multiline

    /*
    *   uclass > Panel > focus
    */

    function uclass.focus( pnl )
        pnl:RequestFocus( )
    end

    /*
    *   uclass > OnFocusChanged
    *
    *   @param  : func fn
    */

    function uclass.onfocuschg( pnl, fn )
        if not isfunction( fn ) then return end
        pnl[ 'OnFocusChanged' ] = fn
    end
    uclass.focuschg = uclass.onfocuschg

    /*
    *   uclass > DTextEntry > OnEnter
    *
    *   @param  : func fn
    */

    function uclass.onenter( pnl, fn )
        local name = 'OnEnter'
        local orig = pnl[ name ]

        pnl[ name ] = function( s, ... )
            if isfunction( orig ) then orig( s, ... ) end
            fn( s, ... )
        end
    end

    /*
    *   uclass > DProgress > SetFraction
    *
    *   @param  : int i
    */

    function uclass.fraction( pnl, i )
        i = isnumber( i ) and i or 1
        pnl:SetFraction( i )
    end
    uclass.frac = uclass.fraction

    /*
    *   uclass > DLabel, DTextEntry > SetFont
    *
    *   @param  : str str
    */

    function uclass.setfont( pnl, str )
        str = isstring( str ) and str or pid( 'ucl_font_def' )
        pnl:SetFont( str )
    end
    uclass.font = uclass.setfont

    /*
    *   uclass > DLabel, DTextEntry > SetFont
    *
    *   @param  : str face
    */

    function uclass.setfont( pnl, face )
        face = isstring( face ) and face or pid( 'ucl_font_def' )
        pnl:SetFont( face )
    end
    uclass.font = uclass.setfont

    /*
    *   uclass > DLabel, DTextEntry > SetInternalFont
    *
    *   @param  : str face
    */

    function uclass.internalfont( pnl, face )
        face = isstring( face ) and face or pid( 'ucl_font_def' )
        pnl:SetFontInternal( face )
    end

    /*
    *   uclass > RichText > SetInternalFont
    *
    *   @param  : str face
    */

    function uclass.richfont( pnl, face )
        face = isstring( face ) and face or pid( 'ucl_font_def' )

        local name  = 'PerformLayout'
        local orig  = pnl[ name ]

        pnl[ name ] = function( s, ... )
            if isfunction( orig ) then orig( s, ... ) end
            pnl:SetFontInternal( face )
        end
    end

    /*
    *   uclass > DLabel, DTextEntry > typeface
    *
    *   sets a font, but with a registered font prefix
    *
    *   @param  : str str
    */

    function uclass.face( pnl, mod, str )
        str         = isstring( str ) and str or pid( 'ucl_font_def' )
        local _f    = font.get( mod, str )

        pnl:SetFont( _f )
    end

    /*
    *   uclass > Panel > SizeToChildren
    *
    *   resizes the panel to fit the bounds of its children
    *
    *   panel must have its layout updated (Panel:InvalidateLayout) for this function to work properly
    *   size_w and size_h parameters are false by default. calling this function with no arguments will result in a no-op.
    *
    *   @param  : int w
    *           : adjust width of pnl
    *
    *   @param  : int h
    *           : adjust height of pnl
    */

    function uclass.autosize_child( pnl, w, h )
        pnl:SizeToChildren( w, h )
    end
    uclass.aszch = uclass.autosize_child

    /*
    *   uclass > Panel > SizeToContents
    *
    *   resizes the panel so that its width and height fit all of the content inside
    *
    *   must call AFTER setting text/font or adjusting child panels
    */

    function uclass.autosize( pnl )
        pnl:SizeToContents( )
    end
    uclass.asz    = uclass.autosize
    uclass.autosz = uclass.autosize

    /*
    *   uclass > Panel > SizeToContentsX
    *
    *   resizes the panel objects width to accommodate all child objects/contents
    *
    *   only works on Label derived panels such as DLabel by default, and on any
    *   panel that manually implemented Panel:GetContentSize method.
    *
    *   must call AFTER setting text/font or adjusting child panels
    *
    *   @param  : int val
    *           : number of extra pixels to add to the width. Can be a negative number, to reduce the width.
    */

    function uclass.autosize_x( pnl, val )
        val = isnumber( val ) and val or 0
        pnl:SizeToContentsX( val )
    end
    uclass.asz_x      = uclass.autosize_x
    uclass.autosz_x   = uclass.autosize_x

    /*
    *   uclass > Panel > SizeToContentsY
    *
    *   resizes the panel object's height to accommodate all child objects/contents
    *
    *   only works on Label derived panels such as DLabel by default, and on any
    *   panel that manually implemented Panel:GetContentSize method
    *
    *   must call AFTER setting text/font or adjusting child panels
    *
    *   @param  : int val
    *           : number of extra pixels to add to the height. Can be a negative number, to reduce the height
    */

    function uclass.autosize_y( pnl, val )
        val = isnumber( val ) and val or 0
        pnl:SizeToContentsY( val )
    end
    uclass.asz_y      = uclass.autosize_y
    uclass.autosz_y   = uclass.autosize_y

    /*
    *   uclass > Panel > SizeTo
    *
    *   uses animation to resize the panel to the specified size
    *
    *   @param  : int w
    *           : arget width of the panel. Use -1 to retain the current width
    *
    *   @param  : int h
    *           : target height of the panel. Use -1 to retain the current height
    *
    *   @param  : int time
    *           : time to perform the animation within
    *
    *   @param  : int delay
    *           : delay before the animation starts
    *
    *   @param  : int ease
    *           : easing of the start and/or end speed of the animation. See Panel:NewAnimation for how this works
    *
    *   @param  : fn cb
    *           : function to be called once the animation finishes. Arguments are:
    *               ( tbl ) : animData - The AnimationData structure that was used
    *               ( pnl ) : panel object that was resized
    */

    function uclass.tosize( pnl, w, h, time, delay, ease, cb )
        pnl:SizeTo( w, h, time, delay, ease, cb )
    end
    uclass.tosz = uclass.tosize

    /*
    *   uclass > Panel > SetContentAlignment
    *
    *   sets the alignment of the contents
    *
    *   @param  : int int
    *           : direction of the content, based on the number pad.
    *
    *               1   : bottom-left
    *               2   : bottom-center
    *               3   : bottom-right
    *               4   : middle-left
    *               5   : center
    *               6   : middle-right
    *               7   : top-left
    *               8   : top-center
    *               9   : top-right
    */

    function uclass.align( pnl, int )
        int = isnumber( int ) and int or 4
        pnl:SetContentAlignment( int )
    end

    /*
    *   uclass > Panel > AlignTop
    *
    *   aligns the panel on the top of its parent with the specified offset
    *
    *   @param  : int int
    *           : align offset
    */

    function uclass.aligntop( pnl, int )
        int = isnumber( int ) and int or 0
        pnl:AlignTop( int )
    end

    /*
    *   uclass > Panel > AlignBottom
    *
    *   aligns the panel on the bottom of its parent with the specified offset
    *
    *   @param  : int int
    *           : align offset
    */

    function uclass.alignbottom( pnl, int )
        int = isnumber( int ) and int or 0
        pnl:AlignBottom( int )
    end

    /*
    *   uclass > Panel > AlignLeft
    *
    *   aligns the panel on the left of its parent with the specified offset
    *
    *   @param  : int int
    *           : align offset
    */

    function uclass.alignleft( pnl, int )
        int = isnumber( int ) and int or 0
        pnl:AlignLeft( int )
    end

    /*
    *   uclass > Panel > AlignRight
    *
    *   aligns the panel on the right of its parent with the specified offset
    *
    *   @param  : int int
    *           : align offset
    */

    function uclass.alignright( pnl, int )
        int = isnumber( int ) and int or 0
        pnl:AlignRight( int )
    end

    /*
    *   uclass > Panel > LocalToScreen
    *
    *   absolute screen position of the position specified relative to the panel.
    *
    *   @param  : int x
    *           : x coordinate of the position on the panel to translate
    *
    *   @param  : int y
    *           : y coordinate of the position on the panel to translate
    */

    function uclass.local2scr( pnl, x, y )
        x = isnumber( x ) and x or 0
        y = isnumber( y ) and y or 0
        pnl:LocalToScreen( x, y )
    end
    uclass.l2s = uclass.local2scr

    /*
    *   uclass > Panel > ScreenToLocal
    *
    *   translates global screen coordinate to coordinates relative to the panel
    *
    *   @param  : int x
    *           : x coordinate of the screen position to be translated
    *
    *   @param  : int y
    *           : y coordinate of the screed position be to translated
    */

    function uclass.scr2local( pnl, x, y )
        x = isnumber( x ) and x or 0
        y = isnumber( y ) and y or 0
        pnl:ScreenToLocal( x, y )
    end
    uclass.s2l = uclass.scr2local

    /*
    *   uclass > Panel > SetDrawOnTop
    *
    *   @param  : bool b
    *           : whether or not to draw the panel in front of all others
    */

    function uclass.drawtop( pnl, b )
        pnl:SetDrawOnTop( helper:val2bool( b ) or false )
    end

    /*
    *   uclass > Panel > SetFocusTopLevel
    *
    *   @param  : bool b
    *           : sets the panel that owns this FocusNavGroup to be the root in the focus traversal hierarchy.
    */

    function uclass.focustop( pnl, b )
        pnl:SetFocusTopLevel( helper:val2bool( b ) or false )
    end

    /*
    *   uclass > DHTML > SetHTML
    *
    *   set HTML code within a panel
    *
    *   @param  : str str
    *           : html code to set
    */

    function uclass.html( pnl, str )
        pnl:SetHTML( str )
    end

    /*
    *   uclass > DHTML > Loader
    *
    *   draws a loading material to display for dhtml panels
    *
    *   @param  : int sz
    *   @param  : clr clr
    */

    function uclass.loader( pnl, sz, clr )
        sz  = isnumber( sz ) and sz or 100
        clr = IsColor( clr ) and clr or Color( 255, 255, 255, 255 )
        pnl[ 'Paint' ] = function( s, w, h )
            design.loader( w / 2, h / 2, sz, clr )
        end
    end

    /*
    *   uclass > DHTML > AddressBar
    *
    *   sets the address bar for a dhtml panel
    *
    *   @param  : str str
    *           : address to set
    */

    function uclass.addr( pnl, addr )
        if not ui:ok( pnl.AddressBar ) then return end
        pnl.AddressBar:SetText( addr )
    end

    /*
    *   uclass > DHTML > SetHTML
    *
    *   sets html code in DHTML pnl to display a full-size img from an external site
    *
    *   @param  : str str
    *           : html code to set
    */

    function uclass.imgsrc( pnl, str )
        local code = ui:html_img( str )
        pnl:SetHTML( code )
    end

    /*
    *   uclass > svg
    *
    *   loads an outside svg file
    *   typically used for stats
    *
    *   @param  : str src
    *           : html code to set
    */

    function uclass.svg( pnl, src, bShow )
        src = isstring( src ) and src or ''
        local html = ui:getsvg( src, bShow )
        pnl:SetHTML( html )
    end

    /*
    *   uclass > Panel > CenterHorizontal
    *
    *   centers the panel horizontally with specified fraction
    *
    *   @param  : flt flt
    *           : center fraction.
    */

    function uclass.center_h( pnl, flt )
        flt = isnumber( flt ) and flt or 0.5
        pnl:CenterHorizontal( flt )
    end

    /*
    *   uclass > Panel > CenterVertical
    *
    *   centers the panel vertically with specified fraction
    *
    *   @param  : flt flt
    *           : center fraction.
    */

    function uclass.center_v( pnl, flt )
        flt = isnumber( flt ) and flt or 0.5
        pnl:CenterVertical( flt )
    end

    /*
    *   uclass > DTextEntry, DLabel > SetTextColor
    *
    *   sets the text color of the DLabel. This will take precedence
    *   over DLabel:SetTextStyleColor
    *
    *   @param  : clr clr
    *           : text color. Uses the Color structure.
    */

    function uclass.textclr( pnl, clr )
        clr = IsColor( clr ) and clr or Color( 255, 255, 255, 255 )
        pnl:SetTextColor( clr )

        pnl[ 'Think' ] = function( s, ... )
            s:SetTextColor( clr )
        end
    end

    /*
    *   uclass > DLabel > SetText
    *
    *   sets the text value of a panel object containing text, such as a Label,
    *   TextEntry or RichText and their derivatives, such as DLabel, DTextEntry or DButton
    *
    *   @param  : str str
    *           : text value to set.
    *
    *   @param  : bool bautosz
    *           : enables SizeToContents( )
    */

    function uclass.text( pnl, str, bautosz )
        str = isstring( str ) and str or ''
        pnl:SetText( str )
        if bautosz then
            pnl:SizeToContents( )
        end
    end

    /*
    *   uclass > DLabel > SetText, SetTextColor
    *
    *   set text clr, font, and string
    *
    *   @param  : clr clr
    *           : text color. Uses the Color structure
    *
    *   @param  : str face
    *           : font of the label
    *
    *   @param  : str text
    *           : text to display
    *
    *   @param  : bool bautosz
    *           : enables SizeToContents( )
    *
    *   @param  : int align
    *           : SetContentAlignment( )
    */

    function uclass.txt( pnl, text, clr, face, bautosz, align )
        text        = isstring( text ) and text or ''
        clr         = IsColor( clr ) and clr or Color( 255, 255, 255, 255 )
        face        = isstring( face ) and face or pid( 'ucl_font_def' )

        pnl:SetTextColor    ( clr   )
        pnl:SetFont         ( face  )
        pnl:SetText         ( text  )

        if bautosz then
            pnl:SizeToContents( )
        end

        if align then
            pnl:SetContentAlignment ( align )
        end

        pnl[ 'Think' ] = function( s, ... )
            s:SetTextColor( clr )
        end
    end

    /*
    *   uclass > DLabel > Language
    *
    *   set text clr, font, and string
    *   supports registered fonts
    *
    *   @param  : str face
    *           : font of the label
    *
    *   @param  : clr clr
    *           : text color. Uses the Color structure
    *
    *   @param  : str text
    *           : text to display
    *
    *   @param  : bool bautosz
    *           : enables SizeToContents( )
    *
    *   @param  : int align
    *           : SetContentAlignment( )
    */

    function uclass.lng( pnl, mod, text, face, clr, bautosz, align )
        text        = isstring( text ) and text or ''
        face        = isstring( face ) and face
        clr         = IsColor( clr ) and clr or Color( 255, 255, 255, 255 )

        local _f    = font.get( mod, face )

        pnl:SetTextColor    ( clr   )

        if face then
            pnl:SetFont     ( _f    )
        end

        pnl:SetText         ( text  )

        if bautosz then
            pnl:SizeToContents( )
        end

        if align then
            pnl:SetContentAlignment ( align )
        end

        pnl[ 'Think' ] = function( s, ... )
            s:SetTextColor( clr )
        end
    end

    /*
    *   uclass > DLabel > SetText, SetTextColor
    *
    *   set text clr, font, and string
    *
    *   @param  : clr clr
    *           : text color. Uses the Color structure
    *
    *   @param  : str face
    *           : font of the label
    *
    *   @param  : str text
    *           : text to display
    *
    *   @param  : bool bautosz
    *           : enables SizeToContents( )
    */

    function uclass.textadv( pnl, clr, face, text, bautosz )
        clr         = IsColor( clr ) and clr or Color( 255, 255, 255, 255 )
        face        = isstring( face ) and face or pid( 'ucl_font_def' )
        text        = isstring( text ) and text or ''

        pnl:SetTextColor    ( clr   )
        pnl:SetFont         ( face  )
        pnl:SetText         ( text  )

        if bautosz then
            pnl:SizeToContents( )
        end

        pnl[ 'Think' ] = function( s, ... )
            s:SetTextColor( clr )
        end
    end

    /*
    *   uclass > DLabel > SetText, SetTextColor
    *
    *   set text clr, font, and string
    *
    *   @param  : str face
    *           : font of the label
    *
    *   @param  : str text
    *           : text to display
    *
    *   @param  : clr clr
    *           : text color. Uses the Color structure
    *
    *   @param  : bool bautosz
    *           : enables SizeToContents( )
    */

    function uclass.lngadv( pnl, mod, face, text, clr, bautosz )
        face        = isstring( face ) and face or pid( 'ucl_font_def' )
        text        = isstring( text ) and text or ''
        clr         = IsColor( clr ) and clr or Color( 255, 255, 255, 255 )

        local _f    = font.get( mod, face )

        pnl:SetTextColor    ( clr   )
        pnl:SetFont         ( _f    )
        pnl:SetText         ( text  )

        if bautosz then
            pnl:SizeToContents( )
        end

        pnl[ 'Think' ] = function( s, ... )
            s:SetTextColor( clr )
        end
    end

    /*
    *   uclass > DLabel > SetText, SetTextColor
    *
    *   set text clr, font, and string
    *
    *   @param  : str text
    *           : text to display
    *
    *   @param  : clr clr
    *           : text color. Uses the Color structure
    *
    *   @param  : str face
    *           : font of the label
    *
    *   @param  : bool bautosz
    *           : enables SizeToContents( )
    *
    *   @param  : int align
    *           : set content alignment
    */

    function uclass.label( pnl, text, clr, face, bautosz, align )
        text        = isstring( text ) and text or ''
        clr         = IsColor( clr ) and clr or Color( 255, 255, 255, 255 )
        face        = isstring( face ) and face or pid( 'ucl_font_def' )
        bautosz     = bautosz or false
        align       = isnumber( align ) and align or 4

        pnl:SetText             ( text  )
        pnl:SetColor            ( clr   )
        pnl:SetFont             ( face  )

        if bautosz then
            pnl:SizeToContents( )
        end

        if align then
            pnl:SetContentAlignment ( align )
        end

        pnl[ 'Think' ] = function( s, ... )
            s:SetColor( clr )
        end
    end

    /*
    *   uclass > Panel > AlphaTo
    *
    *   animation to transition the current alpha value of a panel to a new alpha, over a set period of time and after a specified delay.
    *
    *   @param  : int alpha
    *           : alpha value (0-255) to approach
    *
    *   @param  : int dur
    *           : time in seconds it should take to reach the alpha
    *
    *   @param  : int delay
    *           : delay before the animation starts.
    *
    *   @param  : func cb
    *           : function to be called once the animation finishes
    */

    function uclass.alphato( pnl, alpha, dur, delay, cb )
        alpha   = isnumber( alpha ) and alpha or 255
        dur     = isnumber( dur ) and dur or 1
        delay   = isnumber( delay ) and delay or 0

        pnl:AlphaTo( alpha, dur, delay, cb )
    end
    uclass.a2 = uclass.alphato

    /*
    *   uclass > DLabel > SetText
    *
    *   sets the text value of a panel object containing text, such as a Label,
    *   TextEntry or RichText and their derivatives, such as DLabel, DTextEntry or DButton
    */

    function uclass.notext( pnl )
        pnl:SetText( '' )
    end

    /*
    *   uclass > Panel > SetEnabled
    *
    *   Sets the enabled state of a disable-able panel object, such as a DButton or DTextEntry.
    *   See Panel:IsEnabled for a function that retrieves the "enabled" state of a panel
    *
    *   @param  : bool b
    *           : Whether to enable or disable the panel object
    */

    function uclass.enabled( pnl, b )
        pnl:SetEnabled( helper:val2bool( b ) or false )
    end
    uclass.on         = uclass.enabled
    uclass.seton      = uclass.enabled
    uclass.enable     = uclass.enabled

    /*
    *   uclass > DMenuBar, DPanel > SetDisabled
    *
    *   sets whether or not to disable the panel
    *
    *   @param  : bool b
    *           : true to disable the panel (mouse input disabled and background
    *             alpha set to 75), false to enable it (mouse input enabled and background alpha set to 255).
    */

    function uclass.disabled( pnl, b )
        pnl:SetDisabled( helper:val2bool( b ) or false )
    end
    uclass.off        = uclass.disabled
    uclass.setoff     = uclass.disabled

    /*
    *   uclass > Panel > SetParent
    *
    *   sets the parent of the panel
    *
    *   @param  : pnl parent
    *           : new parent of the panel
    */

    function uclass.parent( pnl, parent )
        pnl:SetParent( parent )
    end

    /*
    *   uclass > Panel > HasFocus
    *
    *   returns if the panel is focused
    *
    *   @return : bool
    *           : hasFocus
    */

    function uclass.hasfocus( pnl )
        pnl:HasFocus( )
    end

    /*
    *   uclass > Panel > HasParent
    *
    *   returns whether the panel is a descendent of the given panel
    *
    *   @param  : pnl parent
    *           : parent pnl
    *
    *   @return : bool
    *           : true if the panel is contained within parent
    */

    function uclass.hasparent( pnl, parent )
        pnl:HasParent( parent )
    end

    /*
    *   uclass > Panel > HasChildren
    *
    *   returns whenever the panel has child panels
    *
    *   @return : bool
    *           : true if the panel has children
    */

    function uclass.haschild( pnl )
        pnl:HasChildren( )
    end

    /*
    *   uclass > Panel > SetWrap
    *
    *   sets whether text wrapping should be enabled or disabled on Label and
    *   DLabel panels. Use DLabel:SetAutoStretchVertical to automatically correct
    *   vertical size; Panel:SizeToContents will not set the correct height
    *
    *   @param  : bool b
    *           : true to enable text wrapping, false otherwise.
    */

    function uclass.wrap( pnl, b )
        pnl:SetWrap( helper:val2bool( b ) or false )
    end

    /*
    *   uclass > Label > SetAutoStretchVertical
    *
    *   automatically adjusts the height of the label dependent of the height of the text inside of it.
    *
    *   @param  : bool b
    *           : true to enable auto stretching, false otherwise.
    */

    function uclass.autoverticle( pnl, b )
        pnl:SetAutoStretchVertical( helper:val2bool( b ) )
    end

    /*
    *   uclass > Panel > OnCursorEntered, OnCursorExited
    *
    *   shortcut for oncursor hover functions
    *       : s.hover
    */

    function uclass.onhover( pnl )
        pnl.OnCursorEntered = function( s ) s.hover = true end
        pnl.OnCursorExited = function( s ) s.hover = false end
    end
    uclass.ohover = uclass.onhover
    uclass.ohvr   = uclass.onhover

    /*
    *   uclass > Panel > OnCursorEntered
    *
    *   shortcut for oncursor enter functions
    *       : s.hover
    */

    function uclass.oncur_enter( pnl, fn )
        if not isfunction( fn ) then return end

        local name = 'OnCursorEntered'
        local orig = pnl[ name ]

        pnl[ name ] = function( s, ... )
            if isfunction( orig ) then orig( s, ... ) end
            fn( s, ... )
        end
    end
    uclass.ocen = uclass.oncur_enter

    /*
    *   uclass > Panel > OnCursorEntered
    *
    *   shortcut for oncursor enter functions
    *       : s.hover
    */

    function uclass.oncur_exit( pnl, fn )
        if not isfunction( fn ) then return end

        local name = 'OnCursorExited'
        local orig = pnl[ name ]

        pnl[ name ] = function( s, ... )
            if isfunction( orig ) then orig( s, ... ) end
            fn( s, ... )
        end
    end
    uclass.ocex = uclass.oncur_exit

    /*
    *   uclass > Panel > OnCursorEntered, OnCursorExited > dim
    *
    *   dims the btn when mouse cursor hovers
    *
    *   @param  : clr clr
    */

    function uclass.onhover_dim( pnl, clr, x, y, w, h )
        uclass.onhover( pnl )

        clr = IsColor( clr ) and clr or Color( 0, 0, 0, 200 )
        x   = isnumber( x ) and x or 0
        y   = isnumber( y ) and y or x or 0
        w   = isnumber( w ) and w or nil
        h   = isnumber( h ) and h or nil

        pnl.PaintOver = function( s, sz_w, sz_h )
            if s.hover then
                sz_w = isnumber( w ) and w or sz_w
                sz_h = isnumber( h ) and h or sz_h
                design.box( x, y, sz_w, sz_h, clr )
            end
        end
    end
    uclass.ohoverdim  = uclass.onhover_dim
    uclass.ohvrdim    = uclass.onhover_dim
    uclass.odim       = uclass.onhover_dim

    /*
    *   uclass > Panel > OnDisabled
    *
    *   sets a local pnl var to check if pnl is disabled or not
    *       :   s.disabled
    */

    function uclass.ondisabled( pnl )
        pnl.Think = function( s )
            if s:GetDisabled( ) then
                s.disabled = true
            else
                s.disabled = false
            end
        end
    end

    /*
    *   uclass > Chkbox > GetChecked
    *
    *   sets a local pnl var to check if pnl is disabled or not
    *       :   s.disabled
    */

    function uclass.onchk( pnl )
        pnl.Think = function( s )
            if s:GetChecked( ) then
                s.chk = true
            else
                s.chk = false
            end
        end
    end
    uclass.ochk = uclass.onchk

    /*
    *   uclass > DButton, DImage > SetImage
    *
    *   sets an image to be displayed as the button's background.
    *
    *   @param  : str img
    *           : image file to use, relative to /materials. If this is nil, the image background is removed.
    *
    *   @param  : str img2
    *           : backup img
    */

    function uclass.setimg( pnl, img, img2 )
        img2 = isstring( img2 ) and img2 or 'vgui/avatar_default'
        pnl:SetImage( img, img2 )
    end
    uclass.img = uclass.setimg

    /*
    *   uclass > DTextEntry > GetUpdateOnType
    *
    *   returns whether the DTextEntry is set to run DTextEntry:OnValueChange every
    *   time a character is typed or deleted or only when Enter is pressed.
    */

    function uclass.autoupdate( pnl )
        pnl:GetUpdateOnType( )
    end

    /*
    *   uclass > DTextEntry > SetUpdateOnType
    *
    *   sets whether we should fire DTextEntry:OnValueChange
    *   every time we type or delete a character or only when Enter is pressed.
    */

    function uclass.setautoupdate( pnl, b )
        pnl:SetUpdateOnType( helper:val2bool( b ) or false )
    end

    /*
    *   uclass > Panel > SetAllowNonAsciiCharacters
    *
    *   configures a text input to allow user to type characters that are not included in
    *   the US-ASCII (7-bit ASCII) character set.
    *
    *   characters not included in US-ASCII are multi-byte characters in UTF-8. They can be
    *   accented characters, non-Latin characters and special characters.
    *
    *   @param  : bool b
    *           : true in order not to restrict input characters.
    */

    function uclass.allowascii( pnl, b )
        pnl:SetAllowNonAsciiCharacters( helper:val2bool( b ) or false )
    end
    uclass.ascii = uclass.allowascii

    /*
    *   uclass > DPropertySheet > AddSheet
    *
    *   adds a new tab.
    *
    *   @param  : str name
    *           : name of the tab
    *
    *   @param  : pnl panel
    *           : panel to be used as contents of the tab. This normally should be a DPanel
    *
    *   @param  : str ico
    *           : icon for the tab. This will ideally be a silkicon, but any material name can be used.
    *
    *   @param  : bool bnostretchx
    *           : should DPropertySheet try to fill itself with given panel horizontally.
    *
    *   @param  : bool bnostretchy
    *           : should DPropertySheet try to fill itself with given panel vertically.
    *
    *   @param  : str tip
    *           : tooltip for the tab when user hovers over it with his cursor
    */

    function uclass.newsheet( pnl, name, panel, ico, bnostretchx, bnostretchy, tip )
        name            = isstring( name ) and name or 'untitled'
        panel           = ui:ok( panel ) and panel or nil
        ico             = isstring( ico ) and ico or ''
        bnostretchx     = bnostretchx or false
        bnostretchy     = bnostretchy or false
        tip             = isstring( tip ) and tip or ''

        pnl:AddSheet( name, panel, ico, bnostretchx, bnostretchy, tip )
    end

    /*
    *   uclass > DColumnSheet > AddSheet
    *
    *   adds a new column/tab.
    *
    *   @param  : str name
    *           : name of the column/tab
    *
    *   @param  : pnl panel
    *           : panel to be used as contents of the tab. This normally would be a DPanel
    *
    *   @param  : str ico
    *           : icon for the tab. This will ideally be a silkicon, but any material name can be used.
    */

    function uclass.newsheet_col( pnl, name, panel, ico )
        name            = isstring( name ) and name or 'untitled'
        panel           = ui:ok( panel ) and panel or nil
        ico             = isstring( ico ) and ico or ''

        pnl:AddSheet( name, panel, ico )
    end

    /*
    *   uclass > Panel > Clear
    *
    *   marks all of the panel's children for deletion.
    */

    function uclass.clear( pnl )
        pnl:Clear( )
    end

    /*
    *   uclass > DFrame > Close
    *
    *   hides or removes DFrame, calls DFrame:OnClose.
    */

    function uclass.close( pnl )
        pnl:Close( )
    end

    /*
    *   uclass > DFrame > DeleteOnClose
    *
    *   destroys pnl when closed
    *
    *   @param  : bool b
    */

    function uclass.delonclose( pnl, b )
        pnl:SetDeleteOnClose( helper:val2bool( b ) )
    end
    uclass.doc = uclass.delonclose

    /*
    *   uclass > DComboBox > SetValue
    *
    *   sets the text shown in the combo box when the menu is not collapsed.
    *
    *   @param  : str opt
    */

    function uclass.value( pnl, opt )
        pnl:SetValue( opt )
    end
    uclass.val = uclass.value

    /*
    *   uclass > DComboBox > SetValue
    */

    function uclass.novalue( pnl )
        pnl:SetValue( '' )
    end
    uclass.noval = uclass.novalue

    /*
    *   uclass > DCheckBox > SetValue
    *
    *   sets checked state of checkbox, calls the checkbox's DCheckBox:OnChange and Panel:ConVarChanged methods.
    *
    *   @param  : bool opt
    */

    function uclass.cbox_val( pnl, b )
        pnl:SetValue( helper:val2bool( b ) or false )
    end
    uclass.cbval = uclass.cbox_val

    /*
    *   uclass > DComboBox > choose
    *
    *   sets the text shown in the combo box when the menu is not collapsed.
    *
    *   @param  : str opt
    *   @param  : int ind
    */

    function uclass.option( pnl, opt, ind )
        pnl:ChooseOption( opt, ind )
    end
    uclass.opt = uclass.option

    /*
    *   uclass > Panel > GetValue
    *
    *   returns the value the obj holds
    *
    *   @return : str
    */

    function uclass.getvalue( pnl )
        pnl:GetValue( )
    end
    uclass.gval = uclass.getvalue

    /*
    *   uclass > DCheckBox > SetChecked
    *
    *   sets the checked state of the checkbox. Does not call the checkbox's
    *   DCheckBox:OnChange and Panel:ConVarChanged methods, unlike DCheckBox:SetValue.
    *
    *   @param  : bool b
    */

    function uclass.checked( pnl, b )
        pnl:SetChecked( helper:val2bool( b ) or false )
    end
    uclass.schk       = uclass.checked
    uclass.toggle     = uclass.checked

    /*
    *   uclass > DComboBox > AddChoice
    *
    *   adds a choice to the combo box.
    *
    *   @param  : str str
    *   @param  : mix data
    *   @param  : bool bsel
    *   @param  : pnl icon
    */

    function uclass.newchoice( pnl, str, data, bsel, icon )
        pnl:AddChoice( str, data, bsel, icon )
    end

    /*
    *   uclass > Panel > Destroy
    *
    *   completely removes the specified panel
    */

    function uclass.destroy( pnl )
        ui:destroy( pnl )
    end

    /*
    *   uclass > Panel > Show
    *
    *   shows the specified panel
    */

    function uclass.show( pnl )
        ui:show( pnl )
    end

    /*
    *   uclass > Panel > Hide
    *
    *   hides the specified panel
    */

    function uclass.hide( pnl )
        ui:hide( pnl )
    end

    /*
    *   uclass > Panel > state
    *
    *   toggles panel based on bool
    */

    function uclass.state( pnl, b )
        local state = helper:val2bool( b )
        if state then
            ui:show( pnl )
        else
            ui:hide( pnl )
        end
    end

    /*
    *   uclass > onclick > dispatch
    *
    *   @ex     : :dispatch( self, 'pnl.ticker', mod )
    *             :dispatch( self, 'pnl.ticker', mod, 1 )
    *
    *   @alias  : dispatch
    *
    *   @param  : pnl panel
    *   @param  : str id
    *   @param  : str, tbl mod
    *   @param  : int delay
    */

    function uclass.dispatch( pnl, panel, id, mod, delay )
        pnl[ 'DoClick' ] = function( s, ... )
            delay = isnumber( delay ) and delay or 0
            panel:AlphaTo( 0, delay, 0, function( )
                ui:dispatch( id, mod )
            end )
        end
    end

    /*
    *   uclass > stage
    *
    *   @param  : pnl panel
    *   @param  : str, tbl mod
    *   @param  : bool bMouse
    */

    function uclass.stage( pnl, mod, bMouse )
        ui:stage( pnl, mod, bMouse )
    end

    /*
    *   uclass > unstage
    *
    *   @param  : pnl panel
    *   @param  : str, tbl mod
    *   @param  : bool bMouse
    */

    function uclass.unstage( pnl, mod, bMouse )
        ui:unstage( pnl, mod, bMouse )
    end

    /*
    *   uclass > Panel > MakePopup
    *
    *   focuses the panel and enables it to receive input.
    *   automatically calls Panel:SetMouseInputEnabled and Panel:SetKeyboardInputEnabled
    *   and sets them to true.
    *
    *   :   bKeyDisabled
    *       set TRUE to disable keyboard input
    *
    *   :   bMouseDisabled
    *       set TRUE to disable mouse input
    */

    function uclass.popup( pnl, bKeyDisabled, bMouseDisabled )
        pnl:MakePopup( )
        if bKeyDisabled then
            pnl:SetKeyboardInputEnabled( false )
        end
        if bMouseDisabled then
            pnl:SetMouseInputEnabled( false )
        end
    end

    /*
    *   uclass > DFrame > SetDraggable
    *
    *   sets whether the frame should be draggable by the user.
    *   DFrame can only be dragged from its title bar.
    *
    *   @param  : bool b
    */

    function uclass.candrag( pnl, b )
        pnl:SetDraggable( helper:val2bool( b ) or false )
    end
    uclass.draggable  = uclass.candrag
    uclass.drag       = uclass.candrag

    /*
    *   uclass > DFrame > SetDraggable
    *
    *   forces frame to not allow dragging
    */

    function uclass.nodrag( pnl )
        pnl:SetDraggable( false )
    end

    /*
    *   uclass > DFrame > SetSizable
    *
    *   sets whether or not the DFrame can be resized by the user.
    *   this is achieved by clicking and dragging in the bottom right corner of the frame.
    *
    *   @param  : bool b
    */

    function uclass.canresize( pnl, b )
        pnl:SetSizable( helper:val2bool( b ) or false )
    end
    uclass.resizable  = uclass.canresize
    uclass.resize     = uclass.canresize

    /*
    *   uclass > DFrame > SetScreenLock
    *
    *   sets whether the DFrame is restricted to the boundaries of the screen resolution.
    *
    *   @param  : bool b
    */

    function uclass.lockscreen( pnl, b )
        pnl:SetScreenLock( helper:val2bool( b ) or false )
    end
    uclass.ls         = uclass.lockscreen
    uclass.scrlock    = uclass.lockscreen

    /*
    *   uclass > DFrame > SetPaintShadow
    *
    *   sets whether or not the shadow effect bordering the DFrame should be drawn.
    *
    *   @param  : bool b
    */

    function uclass.shadow( pnl, b )
        pnl:SetPaintShadow( helper:val2bool( b ) or false )
    end

    /*
    *   uclass > DFrame > IsActive
    *
    *   determines if the frame or one of its children has the screen focus.
    */

    function uclass.isactive( pnl )
        pnl:IsActive( )
    end

    /*
    *   uclass > blur
    *
    *   adds blur to the specified pnl
    *
    *   @param  : int amt [ optional ]
    *           : how intense blur will be
    */

    function uclass.blur( pnl, amt )
        amt = isnumber( amt ) and amt or 10

        uclass.nodraw( pnl )
        pnl[ 'Paint' ] = function( s, w, h )
            design.blur( s, amt )
        end
    end

    /*
    *   uclass > blurbox
    *
    *   adds blur and a single box to the pnl paint hook
    *
    *   @param  : clr, int clr
    *           : clr for box
    *
    *   @param  : int amt [ optional ]
    *           : how intense blur will be
    */

    function uclass.blurbox( pnl, clr, amt )
        clr     = ( IsColor( clr ) and clr or isnumber( clr ) and clr ) or Color( 25, 25, 25, 255 )
        amt     = isnumber( amt ) and amt or 10

                if isnumber( clr ) then
                    clr = Color( clr, clr, clr, 255 )
                end

        uclass.nodraw( pnl )
        pnl[ 'Paint' ] = function( s, w, h )
            design.blur( s, amt )
            design.box( 0, 0, w, h, clr )
        end
    end

    /*
    *   uclass > DFrame > SetBackgroundBlur
    *
    *   blurs background behind the frame.
    *
    *   @param  : bool b
    *           : whether or not to create background blur or not.
    */

    function uclass.blur_bg( pnl, b )
        pnl:SetBackgroundBlur( helper:val2bool( b ) or false )
    end

    /*
    *   uclass > DFrane > SetTitle
    *
    *   sets the title of the frame.
    *
    *   @param  : str str
    *           : text to set as title for frame
    */

    function uclass.title( pnl, str )
        str = isstring( str ) and str or ''
        pnl:SetTitle( str )
    end

    /*
    *   uclass > DFrane > SetLabel
    *
    *   sets the title of the frame.
    *   replaces uclass.title
    *
    *   @param  : str str
    *           : text to set as title for frame
    */

    function uclass.lbl( pnl, str )
        str = isstring( str ) and str or ''
        pnl:SetLabel( str )
    end

    /*
    *   uclass > DFrane > SetTitle
    *
    *   clears the dframe title
    */

    function uclass.notitle( pnl )
        pnl:SetTitle( '' )
    end

    /*
    *   uclass > DFrame > ShowCloseButton
    *
    *   determines whether the DFrame's control box (close, minimise and maximise buttons) is displayed.
    *
    *   @param  : bool b
    */

    function uclass.showclose( pnl, b )
        pnl:ShowCloseButton( helper:val2bool( b ) or false )
    end
    uclass.canclose = uclass.showclose

    /*
    *   uclass > DFrame > ShowCloseButton
    *
    *   automatically hides the close button on dframe pnls
    */

    function uclass.noclose( pnl )
        pnl:ShowCloseButton( false )
    end

    /*
    *   uclass > Panel > SetPaintBackground
    *
    *   sets whether or not to paint/draw the panel background.
    *
    *   @param  : bool b
    */

    function uclass.drawbg( pnl, b )
        pnl:SetPaintBackground( helper:val2bool( b ) or false )
    end

    /*
    *   uclass > Panel > SetPaintBackgroundEnabled
    *
    *   sets whenever all the default background of the panel should be drawn or not.
    *
    *   @param  : bool b
    */

    function uclass.drawbg_on( pnl, b )
        pnl:SetPaintBackgroundEnabled( helper:val2bool( b ) or false )
    end

    /*
    *   uclass > Panel > SetPaintBorderEnabled
    *
    *   sets whenever all the default border of the panel should be drawn or not.
    *
    *   @param  : bool b
    */

    function uclass.drawborder( pnl, b )
        pnl:SetPaintBorderEnabled( helper:val2bool( b ) or false )
    end

    /*
    *   uclass > Panel > SetPaintBackgroundEnabled, SetPaintBorderEnabled, SetPaintBackground
    *
    *   @param  : bool b
    */

    function uclass.enginedraw( pnl, b )
        local val = helper:val2bool( b ) or true
        pnl:SetPaintBackgroundEnabled   ( val )
        pnl:SetPaintBorderEnabled       ( val )
        pnl:SetPaintBackground          ( val )
    end

    /*
    *   uclass > DFrame > Center
    *
    *   centers the panel on its parent.
    */

    function uclass.center( pnl )
        pnl:Center( )
    end

    /*
    *   uclass > Panel > GetParent
    *
    *   returns the parent of the panel, returns nil if there is no parent.
    */

    function uclass.getparent( pnl )
        pnl:GetParent( )
    end

    /*
    *   uclass > Panel > GetChild
    *
    *   gets a child by its index.
    *
    *   @param  : int id
    */

    function uclass.getchild( pnl, id )
        id = isnumber( id ) and id or 0
        pnl:GetChild( id )
    end

    /*
    *   uclass > Panel > GetChildren
    *
    *   returns a table with all the child panels of the panel.
    */

    function uclass.getchildren( pnl )
        pnl:GetChildren( )
    end

    /*
    *   uclass > Panel > InvalidateLayout
    *
    *   causes the panel to re-layout in the next frame.
    *   during the layout process PANEL:PerformLayout will be called on the target panel.
    *
    *   @param  : bool b
    */

    function uclass.invalidate( pnl, b )
        pnl:InvalidateLayout( helper:val2bool( b ) or false )
    end
    uclass.nullify = uclass.invalidate

    /*
    *   uclass > Panel > InvalidateChildren
    *
    *   invalidates the layout of this panel object and all its children.
    *   this will cause these objects to re-layout immediately, calling PANEL:PerformLayout.
    *   if you want to perform the layout in the next frame, you will have loop manually through
    *   all children, and call Panel:InvalidateLayout on each.
    *
    *   @param  : bool b
    *           : true = the method will recursively invalidate the layout of all children. Otherwise, only immediate children are affected.
    */

    function uclass.invalidate_childen( pnl, b )
        pnl:InvalidateChildren( helper:val2bool( b ) or false )
    end
    uclass.nullify_ch = uclass.invalidate_childen

    /*
    *   uclass > Panel > InvalidateParent
    *
    *   invalidates the layout of the parent of this panel object.
    *   this will cause it to re-layout, calling PANEL:PerformLayout.
    *
    *   @param  : bool b
    *           : true = the re-layout will occur immediately, otherwise it will be performed in the next frame.
    */

    function uclass.invalidate_parent( pnl, b )
        pnl:InvalidateParent( helper:val2bool( b ) or false )
    end
    uclass.nullify_pa = uclass.invalidate_parent

    /*
    *   uclass > Panel > SetCookieName, SetCookie
    *
    *   @param  : str name
    *   @param  : str val
    */

    function uclass.cookie( pnl, name, val )
        if not name then return end
        pnl:SetCookieName( name )
        pnl:SetCookie( name, val )
    end

    /*
    *   uclass > Panel > DeleteCookie
    *
    *   @param  : str name
    */

    function uclass.delcookie( pnl, name )
        if not name then return end
        pnl:DeleteCookie( name )
    end

    /*
    *   uclass > Panel > MoveTo
    *
    *   @param  : int x
    *   @param  : int y
    *   @param  : int time
    *   @param  : int delay
    *   @param  : int ease
    *   @param  : fn cb
    */

    function uclass.moveto( pnl, x, y, time, delay, ease, cb )
        pnl:MoveTo( x, y, time, delay, ease, cb )
    end

    /*
    *   uclass > Panel > MoveToBack
    *
    *   @param  : bool b
    */

    function uclass.movetoback( pnl, b )
        pnl:MoveToBack( helper:val2bool( b ) or false )
    end
    uclass.m2b      = uclass.movetoback
    uclass.back     = uclass.movetoback

    /*
    *   uclass > Panel > MoveToFront
    */

    function uclass.movetofront( pnl )
        pnl:MoveToFront( )
    end
    uclass.m2f      = uclass.movetofront
    uclass.front    = uclass.movetofront

    /*
    *   uclass > Panel > MoveToFront ( Think )
    */

    function uclass.keeptop( pnl, zpos )
        pnl.Think = function( s )
            pnl:MoveToFront( )
            if isnumber( zpos ) then
                pnl:SetZPos( zpos )
            elseif tostring( zpos ) == 'true' then
                pnl:SetZPos( 1000 )
            end
        end
    end

    /*
    *   uclass > Panel > MoveToAfter
    *
    *   @param  : pnl panel
    */

    function uclass.movetoafter( pnl, panel )
        if not panel then return end
        pnl:MoveToAfter( panel )
    end
    uclass.m2af       = uclass.movetoafter
    uclass.after      = uclass.movetoafter

    /*
    *   uclass > Panel > MoveToBefore
    *
    *   @param  : pnl panel
    */

    function uclass.movetobefore( pnl, panel )
        if not panel then return end
        pnl:MoveToBefore( panel )
    end
    uclass.m2bf       = uclass.movetobefore
    uclass.before     = uclass.movetobefore

    /*
    *   uclass > Panel > MoveBelow
    *
    *   @param  : pnl panel
    */

    function uclass.movebelow( pnl, panel )
        if not panel then return end
        pnl:MoveBelow( panel )
    end
    uclass.mb         = uclass.movebelow
    uclass.below      = uclass.movebelow

    /*
    *   uclass > Panel > SetZPos
    *
    *   @param  : int pos
    */

    function uclass.zpos( pnl, pos )
        pos = isnumber( pos ) and pos or 1
        pnl:SetZPos( pos )
    end

    /*
    *   uclass > Panel > SetKeyboardInputEnabled
    *
    *   @param  : bool b
    */

    function uclass.allowkeyboard( pnl, b )
        pnl:SetKeyboardInputEnabled( helper:val2bool( b ) or false )
    end
    uclass.keys_ok = uclass.allowkeyboard

    /*
    *   uclass > Panel > SetMouseInputEnabled
    *
    *   @param  : bool b
    */

    function uclass.allowmouse( pnl, b )
        pnl:SetMouseInputEnabled( helper:val2bool( b ) or false )
    end
    uclass.mouse_ok = uclass.allowmouse

    /*
    *   uclass > EnableScreenClicker
    */

    function uclass.mouse0( )
        gui.EnableScreenClicker( false )
    end

    /*
    *   uclass > EnableScreenClicker
    */

    function uclass.mouse1( )
        gui.EnableScreenClicker( true )
    end

    /*
    *   uclass > Panel > MouseCapture
    *
    *   allows the panel to receive mouse input even if the mouse cursor
    *   is outside the bounds of the panel.
    *
    *   @param  : bool b
    */

    function uclass.capturemouse( pnl, b )
        pnl:MouseCapture( helper:val2bool( b ) or false )
    end

    /*
    *   uclass > Panel > SetRounded
    *
    *   @param  : bool b
    */

    function uclass.rounded( pnl, b )
        pnl:SetRounded( helper:val2bool( b ) or false )
    end

    /*
    *   uclass > Panel > SetOpacity
    *
    *   @param  : int i
    */

    function uclass.opacity( pnl, i )
        i = isnumber( i ) and i or 255
        pnl:SetOpacity( i )
    end

    /*
    *   uclass > Panel > SetAlpha
    *
    *   @param  : int int
    */

    function uclass.alpha( pnl, int )
        int = isnumber( int ) and int or 255
        pnl:SetAlpha( int )
    end

    /*
    *   uclass > Panel > SetHeader
    *
    *   @param  : str str
    */

    function uclass.header( pnl, str )
        str = isstring( str ) and str or 'Welcome'
        pnl:SetHeader( str )
    end

    /*
    *   uclass > Panel > ActionShow
    */

    function uclass.actshow( pnl )
        pnl:ActionShow( )
    end

    /*
    *   uclass > Panel > ActionHide
    */

    function uclass.acthide( pnl )
        pnl:ActionHide( )
    end

    /*
    *   uclass > Panel > Param
    *
    *   can be used to call panel child function
    *
    *   @ex     :   func in PANEL file:         PANEL:SetItemID( )
    *           :   call from pmeta:            :param( 'SetItemID', 293 )
    *
    *   @alias  : param
    *
    *   @param  : str name
    *   @param  : mix val
    */

    function uclass.param( pnl, name, val )
        if not name or not pnl[ name ] then return end
        val = val or ''
        pnl[ name ]( pnl, val )
    end

    /*
    *   uclass > Panel > paramv
    *
    *   @param  : str name
    *   @param  : varg { ... }
    */

    function uclass.paramv( pnl, name, ... )
        if not name or not pnl[ name ] then return end

        local args = { ... }
        pnl[ name ]( pnl, unpack( args ) )
    end

    /*
    *   uclass > Panel > var
    *
    *   @ex     : var( 'health', 0 )
    *
    *   @call   : self.item.health
    *           : item.health
    *
    *   @alias  : var
    *
    *   @param  : str name
    *   @param  : mix val
    */

    function uclass.var( pnl, name, val )
        val = val or ''
        pnl[ name ] = val
    end

    /*
    *   uclass > Panel > link
    *
    *   @param  : pnl parent
    *   @param  : str id
    */

    function uclass.link( pnl, parent, id )
        parent[ id ] = pnl
    end

    /*
    *   uclass > Panel > SetTooltip
    *
    *   displays tooltips via the default gmod method
    *
    *   @assoc  : tooltip
    *   @alias  : gtip
    *
    *   @param  : str str
    */

    function uclass.gtip( pnl, str )
        str = isstring( str ) and str or ''
        pnl:SetTooltip( str )
    end

    /*
    *   uclass > Panel > Tooltips
    *
    *   displays tooltips
    *   custom tooltip alternative to the default gmod SetTooltip func
    *
    *   @assoc  : gtooltip
    *   @alias  : tooltip, tip
    *
    *   @param  : str str
    *   @param  : clr clr_t
    *   @param  : clr clr_i
    *   @param  : clr clr_o
    */

    local pnl_tippy = false
    function uclass.tooltip( pnl, str, clr_t, clr_i, clr_o )

        /*
        *   validate tip
        */

        if not isstring( str ) or helper.str:isempty( str ) then return end

        /*
        *   define clrs
        */

        local clr_text  = IsColor( clr_t ) and clr_t or cfg.tips.clrs.text
        local clr_box   = IsColor( clr_i ) and clr_i or cfg.tips.clrs.inner
        local clr_out   = IsColor( clr_o ) and clr_o or cfg.tips.clrs.outline

        /*
        *   fn > draw tooltip
        *
        *   @param  : pnl parent
        */

        local function draw_tooltip( parent )

            /*
            *   check > existing tippy pnl
            */

            if pnl_tippy and ui:ok( pnl_tippy ) then return end

            /*
            *   define > cursor pos
            */

            local pos_x, pos_y      = input.GetCursorPos( )

            /*
            *   set / get font text size
            */

            surface.SetFont         ( pid( 'ucl_tippy' ) )
            local sz_w, sz_h        = surface.GetTextSize( str )
            sz_w                    = sz_w + 50

            /*
            *   create pnl
            */

            pnl_tippy               = ui.new( 'btn', pnl                    )
            :bsetup                 (                                       )
            :nodraw                 (                                       )
            :pos                    ( pos_x + 10, pos_y - 35                )
            :size                   ( sz_w, 25                              )
            :popup                  (                                       )
            :front                  (                                       )
            :m2f                    (                                       )
            :var                    ( 'TipWidth', sz_w                      )
            :zpos                   ( 9999                                  )
            :drawtop                ( true                                  )

                                    :logic( function( s )

                                        /*
                                        *   requires parent pnl
                                        */

                                        if not ui:ok( parent ) then
                                            ui:destroy( pnl_tippy )
                                            return
                                        end

                                        /*
                                        *   update mouse pos
                                        */

                                        local wid       = s.TipWidth or 0
                                        pos_x, pos_y    = input.GetCursorPos( )
                                        pos_x           = math.Clamp( pos_x, ( sz_w / 2 ) - 10, ScrW( ) - ( sz_w / 2 ) )
                                        pos_y           = math.Clamp( pos_y, 45, ScrH( ) - 0 )

                                        s:SetPos( pos_x + ( 15 / 2 ) - ( wid / 2 ), pos_y - 45 )
                                    end )

                                    :draw( function( s, w, h )
                                        design.rbox( 4, 0, 0, sz_w, 25, clr_out )
                                        design.rbox( 4, 1, 1, sz_w - 2, 25 - 2, clr_box )
                                        local resp      = not bUF8f and sf( '%s %s' , helper.get:utf8char( cfg.tips.clrs.utf ), str ) or sf( '%s' , str )
                                        local align     = not bUF8f and TEXT_ALIGN_LEFT or TEXT_ALIGN_CENTER
                                        local pos       = not bUF8f and 15 or ( w / 2 )
                                        draw.SimpleText( resp, pid( 'ucl_tippy' ), pos, ( 25 / 2 ), clr_text, align, TEXT_ALIGN_CENTER )
                                    end )

        end

        /*
        *   tippy > OnCursorEntered
        */

        pnl.OnCursorEntered = function( s )
            timex.expire    ( pid( 'tippy_destroy' ) )

            draw_tooltip    ( s )
            s.hover         = true

            /*
            *   tippy timer
            *
            *   creates a timer which ensures that tippy is destroyed
            */

            timex.create( pid( 'tippy_destroy' ), 5, 1, function( this )
                if not ui:ok( pnl_tippy ) then return end
                if ui:ok( pnl_tippy ) then
                    pnl_tippy:AlphaTo( 0, 0.3, 0.1, function( )
                        ui:destroy( pnl_tippy )
                    end )
                end
            end )
        end

        /*
        *   tippy > OnCursorExited
        */

        pnl.OnCursorExited = function( s )
            if s:IsChildHovered( ) and ui:ok( pnl_tippy ) then
                pnl_tippy:AlphaTo( 0, 0.3, 0.1, function( )
                    ui:destroy( pnl_tippy )
                end )

                return
            end

            ui:destroy      ( pnl_tippy )
            s.hover         = false

            timex.expire    ( pid( 'tippy_destroy' ) )
            timex.expire    ( pid( 'tippy_autohide' ) )
        end
    end
    uclass.tip      = uclass.tooltip

    /*
    *   uclass > DModel > SetModel
    *
    *   @alias  : model, mdl, setmdl
    *
    *   @param  : str str
    *   @param  : int skin
    *   @param  : str bodygrp
    */

    function uclass.model( pnl, str, skin, bodygrp )
        skin        = isnumber( skin ) and skin or 0
        bodygrp     = isstring( bodygrp ) and bodygrp or ''
        pnl:SetModel( str, skin, bodygrp )
    end
    uclass.mdl      = uclass.model
    uclass.setmdl   = uclass.model

    /*
    *   uclass > DModel > model autosize
    *
    *   @alias  : model, mdl, setmdl
    *
    *   @param  : str str
    *   @param  : int skin
    *   @param  : str bodygrp
    */

    function uclass.model_auto( pnl, fov, ofs )
        if not ui:ok( pnl.Entity ) then return end

        fov = isnumber( fov ) and fov or 40
        ofs = isnumber( ofs ) and ofs or 0.5

        local sz            = 0
        local mn, mx        = pnl.Entity:GetRenderBounds( )
        sz                  = math.max( sz, math.abs( mn.x ) + math.abs( mx.x ) )
        sz                  = math.max( sz, math.abs( mn.y ) + math.abs( mx.y ) )
        sz                  = math.max( sz, math.abs( mn.z ) + math.abs( mx.z ) )

        pnl:SetFOV          ( fov                   )
        pnl:SetCamPos       ( Vector( sz, sz, sz )  )
        pnl:SetLookAt       ( ( mn + mx ) * ofs     )
        pnl.Entity:SetPos   ( Vector( 0, 0, 0 )     )
    end
    uclass.mdl_auto = uclass.model_auto

    /*
    *   uclass > DModel > SetFOV
    *
    *   @alias  : fov, setfov
    *
    *   @param  : int i
    */

    function uclass.fov( pnl, i )
        i = isnumber( i ) and i or 120
        pnl:SetFOV( i )
    end
    uclass.setfov = uclass.fov

    /*
    *   uclass > DModel > SetAmbientLight
    *
    *   @param  : clr clr
    */

    function uclass.light( pnl, clr )
        clr = IsColor( clr ) and clr or Color( 255, 255, 255, 255 )
        pnl:SetAmbientLight( clr )
    end

    /*
    *   uclass > DModel > SetAnimSpeed
    *
    *   @param  : int val
    */

    function uclass.anim_speed( pnl, val )
        val = isnumber( val ) and val or 1
        pnl:SetAnimSpeed( val )
    end
    uclass.animsp = uclass.anim_speed

    /*
    *   uclass > anim > to center
    *
    *   animation to move panel to center
    *
    *   dframes may not allow top-down animations to work properly and start the panel off-screen, so the
    *   effect may not be as desired.
    *
    *   @param  : pnl pnl
    *   @param  : int time
    *   @param  : str, int from > [optional] > default left
    */

    function uclass.anim_tocenter( pnl, time, from )
        if not ui:ok( pnl ) then return end

        local bAnim     = cvar:GetBool( 'rlib_animations_enabled' )

        local w, h      = pnl:GetSize( )
        time            = ( bAnim and isnumber( time ) and time or 0 ) or 0
        from            = ( bAnim and isnumber( time ) and time or 3 ) or 3

        local sta_w, sta_h  = -w, ( ScrH( ) / 2 ) - ( h / 2 )
        local end_w, end_h  = ScrW( ) / 2 - w / 2, ScrH( ) / 2 - h / 2

        if ( from == 'top' or from == 2 ) then
            sta_w, sta_h    = ScrW( ) / 2 - w / 2, - h
        elseif ( from == 'right' or from == 3 ) then
            sta_w, sta_h    = ScrW( ) + w, ( ScrH( ) / 2 ) - ( h / 2 )
        elseif ( from == 'bottom' or from == 4 ) then
            sta_w, sta_h    = ScrW( ) / 2 - w / 2, ScrH( ) + h
        end

        -- just in case
        if not time then
            sta_w, sta_h    = end_w, end_h
        end

        pnl:SetPos  ( sta_w, sta_h )
        pnl:MoveTo  ( end_w, end_h, time, 0, -1 )
    end
    ui.anim_tocenter = uclass.anim_tocenter

    /*
    *   uclass > appear
    *
    *   makes pnl appear on-screen
    *   supports fading effect
    *
    *   @param  : pnl pnl
    *   @param  : int pos
    *   @param  : str, int from > [optional] > default center
    *   @param  : func fn
    */

    function uclass.appear( pnl, pos, time, fn )
        if not ui:ok( pnl ) then return end

        local bAnim         = cvar:GetBool( 'rlib_animations_enabled' )
        local pad           = 20

        pos                 = ( isnumber( pos ) and pos or isstring( pos ) and pos ) or 5
        time                = ( isnumber( time ) and time ) or 0.3

        /*
        *   declare > default size
        */

        local w, h          = ui:GetPosition( pnl, pos, pad )

        /*
        *   panel
        */

        pnl:SetAlpha        ( 0 )
        pnl:SetPos          ( w, h )
        pnl:AlphaTo         ( 255, bAnim and time or 0, 0,
                            function( )
                                if isfunction( fn ) then
                                    fn( )
                                else
                                    return
                                end
                            end )
    end

    /*
    *   uclass > Frame, Panel > fade in
    *
    *   fades in a panel
    *
    *   @param  : int dur
    *   @param  : int delay
    *   @param  : func fn
    */

    function uclass.anim_fadein( pnl, dur, delay, fn )
        if not ui:ok( pnl ) then return end

        dur     = isnumber( dur ) and dur or 0.2
        dur     = not cvar:GetBool( 'rlib_animations_enabled' ) and 0 or dur
        delay   = isnumber( delay ) and delay or 0
        fn      = isfunction( fn ) and fn or function( ) end

        pnl:SetAlpha        ( 0     )
        ui.anim_tocenter    ( pnl   )
        pnl:AlphaTo         ( 255, dur, delay, function( ) fn( ) end )
    end
    ui.anim_fadein = uclass.anim_fadein

    /*
    *   uclass > Frame, Panel > fade out
    *
    *   fades out a panel
    *
    *   @param  : int dur
    *   @param  : int delay
    *   @param  : func fn
    */

    function uclass.anim_fadeout( pnl, dur, delay, fn )
        if not ui:ok( pnl ) then return end

        dur     = dur or 0.2
        dur     = not cvar:GetBool( 'rlib_animations_enabled' ) and 0 or dur
        delay   = delay or 0
        fn      = isfunction( fn ) and fn or function( ) end

        pnl:SetAlpha        ( 255   )
        ui.anim_tocenter    ( pnl   )
        pnl:AlphaTo         ( 0, dur, delay, function( ) fn( ) end )
    end
    ui.anim_fadeout = uclass.anim_fadeout

    /*
    *   uclass > Frame, Panel > fade in
    *
    *   forces a pnl to center screen based on animation settings
    *
    *   @param  : int time
    *   @param  : str, int from > [optional] > default left
    */

    function uclass.anim_center( pnl, time, from )
        if not ui:ok( pnl ) then return end

        time = time or 0.4
        from = from or 4

        if cvar:GetBool( 'rlib_animations_enabled' ) then
            ui.anim_tocenter( pnl, time, from )
        else
            ui.anim_tocenter( pnl )
        end
    end
    ui.anim_center = uclass.anim_center

    /*
    *   uclass > DNum > SetMin
    *
    *   @alias  : min, setmin
    *
    *   @param  : int min
    */

    function uclass.min( pnl, min )
        min = isnumber( min ) and min or 0
        pnl:SetMin( min )
    end
    uclass.setmin = uclass.min

    /*
    *   uclass > DNum > SetMax
    *
    *   @alias  : max, setmax
    *
    *   @param  : int max
    */

    function uclass.max( pnl, max )
        max = isnumber( max ) and max or 1000
        pnl:SetMax( max )
    end
    uclass.setmax = uclass.max

    /*
    *   uclass > DNum > minmax
    *
    *   @alias  : minmax, setminmax
    *
    *   @param  : int min
    *   @param  : int max
    */

    function uclass.minmax( pnl, min, max )
        min = isnumber( min ) and min or 0
        pnl:SetMin( min )
        if max then
            pnl:SetMax( max )
        end
    end
    uclass.setminmax = uclass.minmax

    /*
    *   uclass > DModel > SetCamPos
    *
    *   @param  : vec pos
    */

    function uclass.cam( pnl, pos )
        pos = isvector( pos ) and pos or Vector( 0, 0, 0 )
        pnl:SetCamPos( pos )
    end

    /*
    *   uclass > DModel > SetLookAt
    *
    *   @param  : vec pos
    */

    function uclass.look( pnl, pos )
        pos = isvector( pos ) and pos or Vector( 0, 0, 0 )
        pnl:SetLookAt( pos )
    end

    /*
    *   uclass > DModel > SetLookAng
    *
    *   @param  : vec pos
    */

    function uclass.lookang( pnl, pos )
        pos = isvector( pos ) and pos or Vector( 0, 0, 0 )
        pnl:SetLookAng( pos )
    end

    /*
    *   uclass > ItemStore > SetContainerID
    *
    *   returns iventory id from itemstore addon from gmodstore
    *
    *   @param  : int id
    */

    function uclass.inventory_id( pnl, id )
        id = isnumber( id ) and id or 0
        pnl:SetContainerID( id )
    end
    uclass.inv_id = uclass.inventory_id

    /*
    *   uclass > Panel > OpenURL
    *
    *   returns iventory id from itemstore addon from gmodstore
    *
    *   @param  : str uri
    */

    function uclass.url( pnl, uri )
        uri = isstring( uri ) and uri or 'https://rlib.io/'
        pnl:OpenURL( uri )
    end

    /*
    *   uclass > DGrid > AddItem
    *
    *   @param  : pnl panel
    */

    function uclass.additem( pnl, panel )
        if not panel then return end
        pnl:AddItem( panel )
    end

    /*
    *   uclass > DGrid > SetCols
    *
    *   number of columns this panel should have.
    *
    *   @param  : int cols
    *           : desired number of columns
    */

    function uclass.col( pnl, cols )
        cols = isnumber( cols ) and cols or 1
        pnl:SetCols( cols )
    end

    /*
    *   uclass > DGrid > SetColWide
    *
    *   number of columns this panel should have.
    *
    *   @param  : int w
    *           : width of each column.
    */

    function uclass.col_wide( pnl, w )
        w = isnumber( w ) and w or 1
        pnl:SetColWide( w )
    end

    /*
    *   uclass > DGrid > colstall
    *
    *   height of each row.
    *   cell panels (grid items) will not be resized or centered.
    *
    *   @param  : int h
    *           : height of each column.
    */

    function uclass.col_tall( pnl, h )
        h = isnumber( h ) and h or 20
        pnl:SetRowHeight( h )
    end

    /*
    *   uclass > DHTML > img url
    *
    *   sets the img url to use for a dhtml element
    *   supports both a string url or a table of strings
    *
    *   @param  : int h
    *           : height of each column.
    */

    function uclass.imgurl( pnl, src, bRand )
        bRand = bRand or false
        local img = ui:html_img_full( src, bRand )
        pnl:SetHTML( img )
    end

    /*
    *   uclass > RichText > AppendText
    *
    *   @param  : str str
    */

    function uclass.appendtxt( pnl, str )
        str = isstring( str ) and str or ''
        pnl:AppendText( str )
    end

    /*
    *   uclass > RichText > InsertColorChange
    *
    *   @param  : clr clr
    */

    function uclass.appendclr( pnl, clr )
        clr = IsColor( clr ) and clr or Color( 255, 255, 255, 255 )
        local clr_append = clr
        pnl:InsertColorChange( clr_append.r, clr_append.g, clr_append.b, clr_append.a )
    end

    /*
    *   uclass > RichText > InsertColorChange
    *
    *   @param  : clr clr
    */

    function uclass.appendfont( pnl, face, clr )
        face    = isstring( face ) and face or ''
        clr     = IsColor( clr ) and clr or Color( 255, 255, 255, 255 )
        pnl[ 'PerformLayout' ] = function( s, ... )
            s:SetFontInternal( face )
            s:SetFGColor( clr )
        end
    end

    /*
    *   uclass > RichText > InsertColorChange, AppendText
    *
    *   @param  : str str
    *   @param  : clr clr
    */

    function uclass.append( pnl, str, clr )
        str = isstring( str ) and str or ''
        clr = IsColor( clr ) and clr or Color( 255, 255, 255, 255 )
        if IsColor( clr ) then
            local clr_append = clr
            pnl:InsertColorChange( clr_append.r, clr_append.g, clr_append.b, clr_append.a )
        end
        pnl:AppendText( str )
    end

    /*
    *   uclass > anim > hover > fill
    *
    *   animation causes box to slide in from the specified direction
    *
    *   @ex     :anim_hover_fill( Color( 255, 255, 255, 255 ), LEFT, 10 )
    *
    *   @param  : clr clr
    *   @param  : int, enum dir
    *   @param  : int sp
    *   @param  : bool bDrawRepl
    */

    function uclass.anim_hover_fill( pnl, clr, dir, sp, bDrawRepl )
        clr         = IsColor( clr ) and clr or Color( 5, 5, 5, 200 )
        dir         = dir or LEFT
        sp          = isnumber( sp ) and sp or 10
        mat         = isbool( mat )

        pnl:SetupAnim( 'OnHoverFill', sp, ui.OnHover )

        local function draw_action( s, w, h )
            local x, y, fw, fh
            if dir == LEFT then
                x, y, fw, fh    = 0, 0, math.Round( w * s.OnHoverFill ), h
            elseif dir == TOP then
                x, y, fw, fh    = 0, 0, w, math.Round( h * s.OnHoverFill )
            elseif dir == RIGHT then
                local prog      = math.Round( w * s.OnHoverFill )
                x, y, fw, fh    = w - prog, 0, prog, h
            elseif dir == BOTTOM then
                local prog      = math.Round( h * s.OnHoverFill )
                x, y, fw, fh    = 0, h - prog, w, prog
            end

            design.box( x, y, fw, fh, clr )
        end

        if not bDrawRepl then
            pnl:drawover( function( s, w, h )
                draw_action( s, w, h )
            end )
        else
            pnl:draw( function( s, w, h )
                draw_action( s, w, h )
            end )
        end

    end

    /*
    *   uclass > anim > hover > fade
    *
    *   displays a fade animation on hover
    *
    *   @ex     :anim_hover_fade( Color( 255, 255, 255, 255 ), 5, 0, false )
    *
    *   @param  : clr clr
    *   @param  : int sp
    *   @param  : int r
    *   @param  : bool bDrawRepl
    */

    function uclass.anim_hover_fade( pnl, clr, sp, r, bDrawRepl )
        clr         = IsColor( clr ) and clr or Color( 5, 5, 5, 200 )
        sp          = isnumber( sp ) and sp or 10

        pnl:SetupAnim( 'OnHoverFade', sp, ui.OnHover )

        local function draw_action( s, w, h )
            local da = ColorAlpha( clr, clr.a * s.OnHoverFade )

            if r and r > 0 then
                design.rbox( r, 0, 0, w, h, da )
            else
                design.box( 0, 0, w, h, da )
            end
        end

        if not bDrawRepl then
            pnl:drawover( function( s, w, h )
                draw_action( s, w, h )
            end )
        else
            pnl:draw( function( s, w, h )
                draw_action( s, w, h )
            end )
        end
    end

    /*
    *   uclass > anim > onclick circle
    *
    *   creates a simple onclick animation with a poly expanding outward while becoming transparent
    *   based on mouse position
    *
    *   @param  : clr clr
    *   @param  : int sp_r
    *   @param  : int sp_a
    *   @param  : int, bool a1      ( switch )
    *   @param  : bool a2           ( switch )
    */

    function uclass.anim_click_circle( pnl, clr, sp_r, sp_a, ... )
        clr                 = IsColor( clr ) and clr or Color( 5, 5, 5, 200 )
        sp_r                = isnumber( sp_r ) and sp_r or 2
        sp_a                = isnumber( sp_a ) and sp_a or 1

        /*
        *   assign varargs
        */

        local args          = { ... }
        local r             = isnumber( args[ 1 ] ) and args[ 1 ] or 100
        local bNoDraw       = ( args[ 2 ] and helper:val2bool( args[ 2 ] ) ) or ( args[ 1 ] and helper:val2bool( args[ 1 ] ) ) or false
                            if bNoDraw then return end

        /*
        *   defaults
        */

        pnl.radius          = 0
        pnl.a               = 0
        pnl.pos_x           = 0
        pnl.pos_y           = 0

        /*
        *   PaintOver
        */

        pnl:run( 'PaintOver', function( s, w, h )
            if s.a < 1 then return end

            design.circle_simple( s.pos_x, s.pos_y, s.radius, ColorAlpha( clr, s.a ) )

            s.radius    = Lerp( FrameTime( ) * sp_r, s.radius, r or w )
            s.a         = Lerp( FrameTime( ) * sp_a, s.a, 0 )
        end )

        /*
        *   DoClick
        */

        pnl:run( 'DoClick', function( cir )
            cir.pos_x, cir.pos_y    = cir:CursorPos( )
            cir.radius              = 0
            cir.a                   = clr.a
        end )
    end

    /*
    *   uclass > anim > onclick outline
    *
    *   creates a simple onclick animation with a poly expanding outward while becoming transparent
    *   based on mouse position
    *
    *   @param  : clr clr
    *   @param  : int sp_r
    *   @param  : int sp_a
    *   @param  : int, bool a1      ( switch )
    *   @param  : bool a2           ( switch )
    */

    function uclass.anim_click_ol( pnl, clr, sp_r, sp_a, ... )
        clr                 = IsColor( clr ) and clr or Color( 5, 5, 5, 200 )
        sp_r                = isnumber( sp_r ) and sp_r or 2
        sp_a                = isnumber( sp_a ) and sp_a or 2

        /*
        *   assign varargs
        */

        local args          = { ... }
        local r             = isnumber( args[ 1 ] ) and args[ 1 ] or 125
        local bNoDraw       = ( args[ 2 ] and helper:val2bool( args[ 2 ] ) ) or ( args[ 1 ] and helper:val2bool( args[ 1 ] ) ) or false
                            if bNoDraw then return end

        /*
        *   defaults
        */

        pnl.radius          = 0
        pnl.a               = 0
        pnl.pos_x           = 0
        pnl.pos_y           = 0

        /*
        *   PaintOver
        */

        pnl:run( 'PaintOver', function( s, w, h )
            if s.a < 1 then return end

            design.circle_ol( s.pos_x, s.pos_y, s.radius, ColorAlpha( clr, s.a ), ColorAlpha( clr, s.a ), ColorAlpha( clr, s.a ) )

            s.radius    = Lerp( FrameTime( ) * sp_r, s.radius, r or w )
            s.a         = Lerp( FrameTime( ) * sp_a, s.a, 0 )
        end )

        /*
        *   DoClick
        */

        pnl:run( 'DoClick', function( cir )
            cir.pos_x, cir.pos_y    = cir:CursorPos( )
            cir.radius              = 0
            cir.a                   = clr.a
        end )

    end

    /*
    *   uclass > anim > fade light
    *
    *   animates a pnl by setting pnl opacity to X with fade effect
    *
    *   @param  : int alpha
    *   @param  : int time
    *   @param  : func cb
    */

    function uclass.anim_light( pnl, alpha, time, cb )
        alpha   = isnumber( alpha ) and alpha or 255
        time    = isnumber( time ) and time or 0.5
        pnl:AlphaTo( alpha, time, 0, function( )
            cb( pnl )
        end )
    end
    uclass.anim_l = uclass.anim_light

    /*
    *   uclass > anim > dark
    *
    *   animates a pnl by setting pnl opacity to X with fade effect
    *
    *   @param  : int time
    *   @param  : func cb
    */

    function uclass.anim_dark( pnl, time, cb )
        time    = isnumber( time ) and time or 0.5
        pnl:AlphaTo( 0, time, 0, function( )
            cb( pnl )
        end )
    end
    uclass.anim_d = uclass.anim_dark

    /*
    *   uclass > anim > to color
    *
    *   changes pnl color using animated fade
    *
    *   @param  : clr clr
    *   @param  : int time
    *   @param  : func cb
    */

    function uclass.anim_color( pnl, clr, time, cb )
        clr     = IsColor( clr ) and clr or Color( 255, 255, 255, 255 )
        time    = isnumber( time ) and time or 0.5
        pnl:ColorTo( clr, time, 0, function( )
            cb( pnl )
        end )
    end
    uclass.anim_clr = uclass.anim_color

    /*
    *   uclass > anim > lerp
    *
    *   @note   : NewAnimation > OnEnd( )
    *             /lua/includes/extensions/client/panel/animation.lua
    *
    *   @param  : str id
    *   @param  : int to
    *   @param  : int dur
    *   @param  : func cb
    */

    function uclass.anim_lerp( pnl, id, to, dur, cb )
        dur = isnumber( dur ) and dur or 0.20

        local new       = pnl:NewAnimation( dur )
        new.lerp_to     = to
        new.Think       = function( anim, panel, frac )
            local frac_now = calc.ease.gen( frac, 0, 1, 1 )

            if not anim.lerp_from then
                anim.lerp_from = pnl[ id ]
            end

            pnl[ id ]   = Lerp( frac_now, anim.lerp_from, anim.lerp_to )
        end
        new.OnEnd = function( )
            if not cb then return end
            cb( pnl )
        end
    end

    /*
    *   uclass > Panel > lerp > color
    *
    *   @note   : NewAnimation > OnEnd( )
    *             /lua/includes/extensions/client/panel/animation.lua
    *
    *   @param  : str id
    *   @param  : int to
    *   @param  : int dur
    *   @param  : func cb
    */

    function uclass.anim_lerp_clr( pnl, id, to, dur, cb )
        dur    = isnumber( dur ) and dur or 0.20

        local color     = pnl[ id ]
        local new       = pnl:NewAnimation( dur )
        new.clr         = to
        new.Think       = function( anim, panel, frac )
            local frac_now = calc.ease.gen( frac, 0, 1, 1 )

            if not anim.StartColor then
                anim.StartColor = color
            end

            pnl[ id ]   = helper:clr_lerp( frac_now, anim.StartColor, anim.clr )
        end
        new.OnEnd = function( )
            if not cb then return end
            cb( pnl )
        end
    end

    /*
    *   uclass > anim > lerp x
    *
    *   @note   : NewAnimation > OnEnd( )
    *             /lua/includes/extensions/client/panel/animation.lua
    *
    *   @param  : int pos
    *   @param  : int dur
    *   @param  : func cb
    */

    function uclass.anim_lerp_x( pnl, pos, dur, cb )
        pos = isnumber( pos ) and pos or 0
        dur = isnumber( dur ) and dur or 0.20

        local new       = pnl:NewAnimation( dur )
        new.pos         = pos
        new.Think       = function( anim, panel, frac )
            local frac_now = calc.ease.gen( frac, 0, 1, 1 )

            if not anim.pos_start then
                anim.pos_start = panel.x
            end

            pnl:SetPos  ( Lerp( frac_now, anim.pos_start, anim.pos ), panel.y )
        end
        new.OnEnd = function( )
            if not cb then return end
            cb( pnl )
        end
    end

    /*
    *   uclass > anim > lerp y
    *
    *   @note   : NewAnimation > OnEnd( )
    *             /lua/includes/extensions/client/panel/animation.lua
    *
    *   @param  : int pos
    *   @param  : int dur
    *   @param  : func cb
    */

    function uclass.anim_lerp_y( pnl, pos, dur, cb )
        pos = isnumber( pos ) and pos or 0
        dur = isnumber( dur ) and dur or 0.20

        local new       = pnl:NewAnimation( dur )
        new.pos         = pos
        new.Think       = function( anim, panel, frac )
            local frac_now = calc.ease.gen( frac, 0, 1, 1 )

            if not anim.pos_start then
                anim.pos_start = panel.y
            end

            pnl:SetPos  ( panel.x, Lerp( frac_now, anim.pos_start, anim.pos ) )
        end
        new.OnEnd = function( )
            if not cb then return end
            cb( pnl )
        end
    end

    /*
    *   uclass > anim > to color
    *
    *   changes pnl color using animated fade
    *
    *   @note   : NewAnimation > OnEnd( )
    *             /lua/includes/extensions/client/panel/animation.lua
    *
    *   @param  : clr clr
    *   @param  : int dur
    *   @param  : func cb
    *   @param  : func fn
    */

    function uclass.anim_lerp_w( pnl, w, dur, cb, fn )
        if not dur then dur = 0.20 end
        if not fn then
            fn = function( a, b, c, d )
                return calc.ease.gen( a, b, c, d )
            end
        end

        local new       = pnl:NewAnimation( dur )
        new.w           = w
        new.Think       = function( anim, panel, frac )
            local frac_now = fn( frac, 0, 1, 1 )

            if not anim.w_start then
                anim.w_start = panel:GetWide( )
            end

            pnl:SetWide ( Lerp( frac_now, anim.w_start, anim.w ) )
        end
        new.OnEnd = function( )
            if not cb then return end
            cb( pnl )
        end
    end

    /*
    *   uclass > Panel > lerp > fade in
    *
    *   @ex     : anim_lerp_fi( 10 )
    *             uses clr 10, 10, 10 > time 0.20
    *
    *   @param  : clr clr
    *   @param  : int time
    */

    function uclass.anim_lerp_fi( pnl, clr, time )
        clr     = ( IsColor( clr ) and clr ) or isnumber( clr ) and Color( clr, clr, clr, 255 ) or Color( 10, 10, 10, 255 )
        time    = isnumber( time ) and time or 0.20

        pnl.ThinkAlpha = pnl.ThinkAlpha or 255

        pnl:anim_lerp( 'ThinkAlpha', 0, time, function( )
            pnl.PaintOver = nil
        end)

        pnl[ 'PaintOver' ] = function( s, w, h )
            design.box( 0, 0, w, h, ColorAlpha( clr, s.ThinkAlpha ) )
        end
    end

    /*
    *   uclass > Panel > lerp > fade out
    *
    *   @ex     : anim_lerp_fo( 10 )
    *             uses clr 10, 10, 10 > time 0.20
    *
    *   @param  : clr clr
    *   @param  : int time
    */

    function uclass.anim_lerp_fo( pnl, clr, time )
        clr     = ( IsColor( clr ) and clr ) or isnumber( clr ) and Color( clr, clr, clr, 255 ) or Color( 10, 10, 10, 255 )
        time    = isnumber( time ) and time or 0.20

        pnl.ThinkAlpha = pnl.ThinkAlpha or 0

        pnl:anim_lerp( 'ThinkAlpha', 255, time, function( )
            pnl.PaintOver   = nil
            pnl:hide        ( )
        end)

        pnl[ 'PaintOver' ] = function( s, w, h )
            design.box( 0, 0, w, h, ColorAlpha( clr, s.ThinkAlpha ) )
        end
    end

    /*
    *   uclass > avatar
    *
    *   @param  : ply pl
    *   @param  : int sz
    */

    function uclass.player( pnl, pl, sz )
        if not helper.ok.ply( pl ) then return end
        sz = isnumber( sz ) and sz or 32
        pnl:SetPlayer( pl, sz )
    end
    uclass.ply    = uclass.player

    /*
    *   uclass > DFrame > frame
    *
    *   sets up a frame using various classes
    *   should be the first thing executed when creating a new frm element
    */

    function uclass.frame( pnl, bPopup, bClose, title )
        if bPopup then
            pnl:popup   ( )
        end
        pnl:showclose   ( bClose )
        pnl:title       ( title )
    end

    /*
    *   uclass > DButton > setup
    *
    *   sets up a button using various classes
    *   should be the first thing executed when creating a new btn element
    */

    function uclass.bsetup( pnl )
        pnl:nodraw      ( )
        pnl:onhover     ( )
        pnl:ondisabled  ( )
        pnl:notext      ( )
    end

    /*
    *   uclass > SetupAnim
    *
    *   setup of animations
    *
    *   @ex     : :SetupAnim( 'OnHoverFill', 5, function( s ) return s:IsHovered( ) end )
    *
    *   @alias  : SetupAnim, setupanim, anim_setup
    *
    *   @param  : str name
    *   @param  : int sp
    *   @param  : func fn
    */

    function uclass.SetupAnim( pnl, name, sp, fn )
        fn = pnl.FnAnim or fn

        pnl[ name ] = 0
        pnl[ 'Think' ] = function( s )
            s[ name ] = Lerp( FrameTime( ) * sp, s[ name ], fn( s ) and 1 or 0 )
        end
    end
    uclass.setupanim    = uclass.SetupAnim
    uclass.anim_setup   = uclass.SetupAnim

    /*
    *   uclass > register
    *
    *   @alias  : register, reg
    *
    *   @param  : str id
    *   @param  : str, tbl mod
    *   @param  : str desc
    */

    function uclass.register( pnl, id, mod, desc )
        if not isstring( id ) then return end
        ui:register( id, mod, pnl, desc )
    end
    uclass.reg = uclass.register

    /*
    *   uclass > unregister
    *
    *   @alias  : unregister, unreg
    *
    *   @param  : str id
    *   @param  : str, tbl mod
    */

    function uclass.unregister( pnl, id, mod, desc )
        if not isstring( id ) then return end
        ui:unregister( id, mod )
    end
    uclass.unreg = uclass.unregister

/*
*   metatable > ui
*
*   mt registers new associated classes
*/

function dmeta:ui( )
    self.Class = function( pnl, name, ... )
        local fn = uclass[ name ]
        assert( fn, lang( 'logs_inf_pnl_assert', name ) )

        fn( pnl, ... )

        return pnl
    end

    for k, v in pairs( uclass ) do
        self[ k ] = function( pnl, ... )
            if not pnl then return end
            return pnl:Class( k, ... )
        end
    end

    return self
end

/*
*   ui > new
*
*   creates a new vgui element
*
*   @note   : alias deprecated in v3.1
*             will be migrated to ui.new only
*
*   @param  : str class
*   @param  : pnl panel
*   @param  : str, bool a1
*   @param  : str a2
*/

function ui.gmod( class, panel, a1, a2 )
    if not class then
        log( 2, lang( 'logs_inf_regclass_err' ) )
        return
    end

    class           = ui.element( class ) or class

    /*
    *   defaults
    */

    local bNoDraw   = false
    local name      = 'none'

    /*
    *   check if arg bool
    *   >   define name
    *   >   define bNoDraw
    */

    if helper:bIsBool( a1 ) then
        name        = isstring( a2 ) and a2 or name
        bNoDraw     = helper.util:toggle( a1 )
    end

    /*
    *   create new pnl
    */

    local pnl       = vgui.Create( class, panel, name )
                    if not ui:ok( pnl ) then return end

    if bNoDraw then
        pnl.Paint = function( s, w, h ) end
    end

    return pnl:ui( )
end
ui.new = ui.gmod

/*
*   ui > rlib
*
*   creates new pnl for rlib
*   pnl must be registered in the modules env / manifest file
*
*   @ex     : ui.rlib( mod, 'rlib_module_pnl' )
*           : ui.rlib( mod, 'rlib_module_pnl', parent )
*
*   @param  : tbl mod
*   @param  : str id
*   @param  : pnl panel
*   @param  : str, bool a1
*   @param  : str a2
*/

function ui.rlib( mod, id, panel, a1, a2 )
    if not id then
        log( 2, lang( 'logs_inf_regclass_err' ) )
        return
    end

    /*
    *   defaults
    */

    local bNoDraw   = false
    local name      = 'none'

    /*
    *   check if arg bool
    *       >   define name
    *       >   define bNoDraw
    */

    if helper:bIsBool( a1 ) then
        name        = isstring( a2 ) and a2 or name
        bNoDraw     = helper.util:toggle( a1 )
    end

    local call      = rlib:resource( mod, 'pnl', id )
    name            = isstring( name ) and name or 'none'

    local pnl       = vgui.Create( call, panel, name )
                    if not ui:ok( pnl ) then return end

    if bNoDraw then
        pnl.Paint = function( s, w, h ) end
    end

    return pnl:ui( )
end
ui.reg = ui.rlib

/*
*   ui > add
*
*   creates a new vgui element, adds the specified object to the panel.
*   similar to Panel:Add( )
*
*   @param  : str class
*   @param  : pnl parent
*/

function ui.add( class, parent )
    if not class then
        log( 2, lang( 'logs_inf_regclass_err' ) )
        return
    end

    class = ui.element( class ) or class

    local pnl = parent:Add( class )
    return pnl:ui( )
end

/*
*   ui > route // relink
*
*   routes one pnl to another while providing access to metatable classes
*
*   @ex     : mod.pnl.root = ui.route( mod.pnl.root, self )
*           : mod.pnl.root = ui.relink( mod.pnl.root, self )
*
*   @param  : pnl parent
*   @param  : pnl pnl
*/

function ui.route( parent, pnl )
    parent = pnl
    return pnl:ui( )
end
uclass.relink     = uclass.route
uclass.symlink    = uclass.route

/*
*   ui > get
*
*   returns the metatable for an existing pnl
*   useful for continuing where you left off when setting values for a pnl
*
*   @ex     :   local root_pnl  = ui.get( mod.pnl.root )
*               :wide           ( 100 )
*
*   @param  : pnl pnl
*           : target panel
*
*   @param  : bool b
*           : NoDraw
*/

function ui.get( pnl, b )
    if not ui:ok( pnl ) then return end

    local bNoDraw           = helper:bIsBool( b ) and helper.util:toggle( b ) or false

                            if bNoDraw then
                                pnl.Paint = function( s, w, h ) end
                            end

    return pnl:ui( )
end

/*
*   ui > edit
*
*   allows you to edit a pnl on the fly
*   validates the panel first prior and prevents random
*   nil pnl errors from occuring
*
*   @ex     : ui.edit( mod.pnl.root, 'wide', 500 )
*           : ui.edit( mod.pnl.root, 'zpos', 1 )
*
*   @param  : pnl pnl
*   @param  : str fn_name
*   @param  : vararg ...
*           : target panel
*/

function ui.edit( pnl, fn_name, ... )
    if not ui:ok( pnl ) then return end
    if not isstring( fn_name ) then return end

    uclass[ fn_name ]( pnl, ... )
end