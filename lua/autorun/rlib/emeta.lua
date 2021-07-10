/*
*   @package        : rlib
*   @author         : Richard [http://steamcommunity.com/profiles/76561198135875727]
*   @copyright      : (C) 2019 - 2020
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
local mf                    = base.manifest

/*
*   localized rlib routes
*/

local helper                = base.h

/*
*   Localized lua funcs
*
*   i absolutely hate having to do this, but for squeezing out every
*   bit of performance, we need to.
*/

local istable               = istable
local isfunction            = isfunction
local isnumber              = isnumber
local isstring              = isstring
local debug                 = debug
local util                  = util
local table                 = table
local math                  = math
local string                = string
local sf                    = string.format

/*
*   Localized cmd func
*
*   @source : lua\autorun\libs\calls
*   @param  : str t
*   @param  : varg { ... }
*/

local function call( t, ... )
    return base:call( t, ... )
end

/*
*   Localized translation func
*/

local function ln( ... )
    return base:lang( ... )
end

/*
*	prefix ids
*/

local function pid( str, suffix )
    local state = ( isstring( suffix ) and suffix ) or ( base and mf.prefix ) or false
    return base.get:pref( str, state )
end

/*
*   emeta
*/

local emeta                 = FindMetaTable( 'Entity' )

/*
*	emeta > what > get
*
*   returns ent id or class name
*
*	@param	: bool bEID
*	@return	: str
*/

function emeta:what( bEID )
    if not self:IsValid( ) then return end
    return ( bEID and self:EntIndex( ) or self:GetClass( ) ) or 0
end

/*
*	emeta > generate id
*
*   returns an id based on the ent
*   useful for ent specific timer ids, etc.
*
*   @ex     : timer_id = ent:gid( 'val', false || true )
*   @res    : val.rlib_ent_class
*           : val.1678
*
*	@param	: str suffix
*   @param  : bool bUseSteam
*	@return	: str
*/

function emeta:gid( suffix, bUseEntID )
    if not self:IsValid( ) then return end
    local id = ( bUseEntID and self:EntIndex( ) ) or self:GetClass( )
    return sf( '%s.%s', suffix, tostring( id ) )
end

/*
*   emeta > association id
*
*   makes an id based on the specified ent class
*       : special chars     => [ . ]
*       : spaces            => [ _ ]
*
*   @ex     : timer_id = ent:aid( 'timer', 'frostshell'  )
*   @res    : timer.frostshell.ent_class_name
*
*   @param  : varg { ... }
*   @return : str
*/

function emeta:aid( ... )
    if not helper.ok.ent( self ) then return end

    local cl            = self:what( true )
    local args          = { ... }

    table.insert        ( args, cl )

    local resp          = table.concat( args, '_' )
    resp                = resp:lower( )
    resp                = resp:gsub( '[%p%c]', '.' )
    resp                = resp:gsub( '[%s]', '_' )

    return resp
end