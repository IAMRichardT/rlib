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
local mf                    = base.manifest
local pf                    = mf.prefix

/*
*   localized rlib routes
*/

local helper                = base.h

/*
*   Localized translation func
*/

local function lang( ... )
    return base:lang( ... )
end

/*
*   simplifiy funcs
*/

local function log( ... ) base:log( ... ) end

/*
*   calls > catalog
*
*   loads library calls catalog
*
*   :   (bool) bPrefix
*       true adds lib prefix at front of all network entries
*       'rlib.network_string_id'
*
*   :   (str) affix
*       bPrefix must be true, determines what prefix to add to
*       the front of a netnw string. if none provided, lib prefix
*       will be used
*
*   @param  : bool bPrefix
*   @param  : str affix
*/

function base.calls:Catalog( bPrefix, affix )
    for v in helper.get.data( base._rcalls[ 'net' ] ) do
        local aff   = isstring( affix ) and affix or pf
        local id    = bPrefix and tostring( aff .. v[ 1 ] ) or tostring( v[ 1 ] )

        util.AddNetworkString( id )
        log( RLIB_LOG_RNET, lang( 'rnet_added', id ) )
    end
end