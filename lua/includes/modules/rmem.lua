/*
*   @package        : rlib
*   @module         : rmem
*   @author         : Richard [http://steamcommunity.com/profiles/76561198135875727]
*   @copyright      : (C) 2021 - 2021
*   @since          : 3.2.1
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
*   @package        : memoize
*   @author         : Enrique García Cota
*   @copyright      : (C) 2018
*   @website        : https://github.com/kikito/memoize.lua
*
*   MIT License
*
*   Copyright (c) 2018 Enrique García Cota
*
*   Permission is hereby granted, free of charge, to any person obtaining a copy
*   of this software and associated documentation files (the "Software"), to deal
*   in the Software without restriction, including without limitation the rights
*   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
*   copies of the Software, and to permit persons to whom the Software is
*   furnished to do so, subject to the following conditions:
*
*   The above copyright notice and this permission notice shall be included in all
*   copies or substantial portions of the Software.
*
*   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
*   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
*   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
*   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
*   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
*   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
*   SOFTWARE.
*/

/*
*   declarations
*/

rmem                        = { }
rmem.__index 			    = rmem

/*
*   standard tables and localization
*/

local unpack                = unpack or table.unpack

/*
*   is_callable
*
*	@param	: func, tbl f
*/

local function is_callable( f )
    local tf = type( f )
    if tf == 'function' then return true end
    if tf == 'table' then
        local mt = getmetatable( f )
        return type( mt ) == 'table' and is_callable( mt.__call )
    end

    return false
end

/*
*   cache_get
*/

local function cache_get( cache, params )
    local node = cache
    for i = 1, #params do
        node = node.child and node.child[ params[ i ] ]
        if not node then return nil end
    end
    return node.results
end

/*
*   cache_put
*/

local function cache_put( cache, params, results )
    local node = cache
    local param

    for i = 1, #params do
        param				= params[ i ]
        node.child      	= node.child or { }
        node.child[ param ]	= node.child[ param ] or { }
        node 				= node.child[ param ]
    end

    node.results = results
end

/*
*   memoize
*/

function rmem.memoize( f, cache )
    cache = cache or { }

    if not is_callable( f ) then
        error( string.format( 'memorize can be only func or callable table. Received %s (a %s)', tostring( f ), type( f ) ) )
    end

    return function( ... )
        local params = { ... }

        local results   = cache_get( cache, params )
                        if not results then
                            results = { f( ... ) }
                            cache_put( cache, params, results )
                        end

        return unpack( results )
    end
end

/*
*   smt
*/

setmetatable( rmem,
{
    __call = function( _, ... )
        return rmem.memoize(...)
    end
} )

/*
*   module
*/

return rmem