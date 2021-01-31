/*
*   @package        : rcore
*   @module         : base
*	@extends		: sam
*   @author         : Richard [http://steamcommunity.com/profiles/76561198135875727]
*   @copyright      : (c) 2018 - 2021
*   @since          : 3.2.0
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
local access                = base.a

/*
*   req
*/

if SAM_LOADED then return end

local sam, command 			= sam, sam.command

/*
*   new field > dropdown
*/

command.new_argument( 'dropdown' )

	/*
	*   OnExecute
	*/

	:OnExecute( function( arg, input, ply, _, result )
		if not arg.options or table.Empty( arg.options ) then
			ply:sam_send_message( 'no data',
			{
				S = 'dropdown', S_2 = input
			} )
			return
		end

		table.insert( result, input )
	end )

	/*
	*   Menu
	*/

	:Menu( function( set_result, body, buttons, args )
		local default 		= args.hint or 'select'
		local cbo 			= buttons:Add( 'SAM.ComboBox' )
		cbo:SetValue		( default )

		function cbo:OnSelect( _, value )
			set_result		( value )
			default 		= value
		end

		function cbo:DoClick( )
			if self:IsMenuOpen( ) then
				return self:CloseMenu( )
			end

			self:Clear( )
			self:SetValue( default )

			if not args or not args.options then
				LocalPlayer( ):sam_send_message( 'dropdown has no options data' )
				return
			end

			for k, v in pairs( args.options ) do
				self:AddChoice( v )
			end

			self:OpenMenu( )
		end
	end )
:End( )