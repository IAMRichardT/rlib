/*
*   @package        : rlib
*   @author         : Richard [http://steamcommunity.com/profiles/76561198135875727]
*   @copyright      : (C) 2020 - 2020
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

/*
*   globals > Hex
*
*   hex to color
*
*   @ex     : Hex( '#FFF' )
*             return > Color( 255, 255, 255, 255 )
*
*   @param  : str hex
*   @param  : int a
*   @return : tbl
*/

function Hex( hex, a )
    local r, g, b = helper:clr_hex2rgb( hex, a )
    return Color( r, g, b, a )
end

/*
*   globals > table > getmax
*
*   gets the max value of a table
*
*   @ex     : tbl = { 1, 4, 5, 6 }
*             table.GetMax( tbl )
*
*   @ret    : 6 (val), 4 (pos)
*
*   @param  : tbl tbl
*   @return : int, int
*             val, pos
*/

function table.GetMax( tbl )
    local val, pos = 0
    for k, v in pairs( tbl ) do
        if val <= v then
            val, pos = v, k
        end
    end
    return val, pos
end

/*
*   globals > ents.Create ( alias )
*/

ents.new = ents.Create