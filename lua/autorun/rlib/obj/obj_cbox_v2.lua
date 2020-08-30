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
local helper                = base.h
local design                = base.d
local ui                    = base.i

/*
*   localization > misc
*/

local cfg                   = base.settings
local mf                    = base.manifest

/*
*   PANEL
*/

local PANEL = { }

/*
*   Init
*/

function PANEL:Init( )

    /*
    *   declarations
    */

    self:Declarations( )

    /*
    *   parent
    */

    self:SetSize                    ( 40, 15 )
    self:SetCursor                  ( 'hand' )
end

/*
*   FirstRun
*/

function PANEL:FirstRun( )
    if ui:ok( self ) then
        self:RequestFocus( )
    end

    self.bInitialized = true
end

/*
*   bEnabled
*
*   @return : bool
*/

function PANEL:bEnabled( )
    return self:GetCVar( ):GetBool( )
end

/*
*   OnMousePressed
*/

function PANEL:OnMousePressed( )
    surface.PlaySound( 'ui/buttonclick.wav' )

    self:onOptionChanged( )
end

/*
*   onOptionChanged
*/

function PANEL:onOptionChanged( )
    local cvar              = self:GetCVar( )
    self.val                = not cvar:GetBool( )

    cvar:SetBool            ( self.val )
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
*   Paint
*
*   @param  : int w
*   @param  : int h
*/

function PANEL:Paint( w, h )

    local clr_main      = self.hover and self.clr_main_h or self.clr_main_n
    local clr_togg_n    = ( self:bEnabled( ) and self.clr_togg_e ) or self.clr_togg_n
    local clr_togg_h    = self.clr_togg_h

    design.rbox( 8, 0, 0, w, h, clr_main )

    if self:bEnabled( ) then
        design.circle( w - 10, 10, 7, 25, clr_togg_n )
        if self.hover then
            design.circle( w - 10, 10, 7, 25, clr_togg_h )
        end
    else
        design.circle( 10, 10, 7, 25, clr_togg_n )
        if self.hover then
            design.circle( 10, 10, 7, 25, clr_togg_h )
        end
    end
end

/*
*   cvar > set
*
*   @param  : str cvar
*/

function PANEL:SetCVar( cvar )
    self.cvar = cvar
end

/*
*   cvar > get
*
*   @return : str
*/

function PANEL:GetCVar( )
    return self.cvar
end

/*
*   Declarations
*/

function PANEL:Declarations( )

    self.bInitialized               = false

    /*
    *   declare > colors
    */

    self.clr_main_n                 = Color( 255, 255, 255, 5 )
    self.clr_main_h                 = Color( 255, 255, 255, 9 )
    self.clr_togg_n                 = Color( 214, 103, 144 )
    self.clr_togg_e                 = Color( 103, 136, 214 )
    self.clr_togg_h                 = Color( 255, 255, 255, 30 )
end

/*
*   register
*/

vgui.Register( 'rlib.ui.cbox.v2', PANEL, 'EditablePanel' )