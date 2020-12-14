/*
*   @package        : rlib
*   @module         : rcir
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
*   @author         : SneakySquid [hhttps://github.com/SneakySquid/Circles]
*   @copyright      : (C) 2020
*
*   MIT License
*
*   Copyright (c) 2019 Sneaky-Squid
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
*	check > client only
*/

if not CLIENT then return end

/*
*	declarations
*/

rcir                        = { }
rcir.__index 				= rcir

/*
*	assign enums
*/

do
    CIRCLE_FILL 			= 0
    CIRCLE_LINE 		    = 1
    CIRCLE_BLUR 			= 2
end

local mat_blur 				= Material( 'pp/blurscreen' )

local err = 'bad argument #%i to %s (%s expected, got %s)'
local function TypeCheck( cond, arg, name, expected, got )
    if not cond then
        error( string.format( err, arg, name, expected, type( got ) ), 3 )
    end
end

/*
*	New
*
*   @param  : enum enum
*   @param  : int r
*   @param  : int x
*   @param  : int y
*/

local function New( enum, r, x, y, ... )
    TypeCheck( isnumber( enum ),    1, 'New', 'number', enum )
    TypeCheck( isnumber( r ),       2, 'New', 'number', r )
    TypeCheck( isnumber( x ),       3, 'New', 'number', x )
    TypeCheck( isnumber( y ),       4, 'New', 'number', y )

    local cir        = setmetatable( { }, rcir )

    cir:SetType      ( tonumber( enum ) )
    cir:SetRadius    ( tonumber( r ) )
    cir:SetPos       ( tonumber( x ), tonumber( y ) )

    if enum == CIRCLE_LINE then
        local outline_width     = ( {...} )[ 1 ]
        cir:SetOutlineWidth  ( tonumber( outline_width ) )
    elseif enum == CIRCLE_BLUR then
        local blur_layers, blur_density = unpack( {...} )
        cir:SetBlurLayers    ( tonumber( blur_layers ) )
        cir:SetBlurDensity   ( tonumber( blur_density ) )
    end

    return cir
end

/*
*	RotateVertices
*/

local function RotateVertices( vert, ox, oy, rotation, rotate_uv )
    TypeCheck( istable( vert ),         1, 'RotateVertices', 'table', vert )
    TypeCheck( isnumber( ox ),          2, 'RotateVertices', 'number', ox )
    TypeCheck( isnumber( oy ),          3, 'RotateVertices', 'number', oy )
    TypeCheck( isnumber( rotation ),    4, 'RotateVertices', 'number', rotation )

    rotation    = math.rad( rotation )
    local c     = math.cos( rotation )
    local s     = math.sin( rotation )

    for i = 1, #vert do
        local vertex    = vert[ i ]
        local vx, vy    = vertex.x, vertex.y
        vx              = vx - ox
        vy              = vy - oy

        vertex.x        = ox + ( vx * c - vy * s )
        vertex.y        = oy + ( vx * s + vy * c )

        if not rotate_uv then
            local u, v  = vertex.u, vertex.v
            u, v        = u - 0.5, v - 0.5

            vertex.u    = 0.5 + ( u * c - v * s )
            vertex.v    = 0.5 + ( u * s + v * c )
        end
    end
end

/*
*	CalculateVertices
*/

local function CalculateVertices(x, y, radius, rotation, start_angle, end_angle, dist, rotate_uv )
    TypeCheck( isnumber( x ), 1, 'CalculateVertices', 'number', x )
    TypeCheck( isnumber( y ), 2, 'CalculateVertices', 'number', y )
    TypeCheck( isnumber( radius ), 3, 'CalculateVertices', 'number', radius )
    TypeCheck( isnumber( rotation ), 4, 'CalculateVertices', 'number', rotation )
    TypeCheck( isnumber( start_angle ), 5, 'CalculateVertices', 'number', start_angle )
    TypeCheck( isnumber( end_angle ), 6, 'CalculateVertices', 'number', end_angle )
    TypeCheck( isnumber( dist ), 7, 'CalculateVertices', 'number', dist )

    local vert = { }
    local step = ( dist * 360 ) / ( 2 * math.pi * radius )

    for a = start_angle, end_angle + step, step do
        a = math.min( end_angle, a )
        a = math.rad( a )

        local c = math.cos( a )
        local s = math.sin( a )

        local vertex =
        {
            x = x + c * radius,
            y = y + s * radius,

            u = 0.5 + c / 2,
            v = 0.5 + s / 2,
        }

        table.insert(vert, vertex)
    end

    if (end_angle - start_angle ~= 360) then
        table.insert( vert, 1,
        {
            x = x, y = y,
            u = 0.5, v = 0.5,
        })
    else
        table.remove(vert)
    end

    if rotation ~= 0 then
        RotateVertices( vert, x, y, rotation, rotate_uv )
    end

    return vert
end

/*
*	stencil > mask
*/

local function stencil_mask( a, b, c )
    render.SetStencilTestMask           ( a )
    render.SetStencilWriteMask          ( b )
    render.SetStencilReferenceValue     ( c )
end

/*
*	stencil > open
*/

local function stencil_open( )
    render.SetStencilCompareFunction    ( STENCIL_NEVER )
    render.SetStencilFailOperation      ( STENCIL_REPLACE )
    render.SetStencilZFailOperation     ( STENCIL_REPLACE )
end

/*
*	stencil > close
*/

local function stencil_close( bLesser )
    local compare = bLesser and STENCIL_LESSEQUAL or STENCIL_GREATER

    render.SetStencilCompareFunction    ( compare )
    render.SetStencilFailOperation      ( STENCIL_KEEP )
    render.SetStencilZFailOperation     ( STENCIL_KEEP )
end

/*
*	circle > __tostring
*/

function rcir:__tostring( )
    return string.format('Circle: %p', self)
end

/*
*	circle > Copy
*/

function rcir:Copy( )
    return table.Copy(self)
end

/*
*	circle > Calculate
*/

function rcir:Calculate( )
    local rotate_uv     = self:GetRotateMaterial( )
    local x, y          = self:GetPos( )
    local radius        = self:GetRadius( )
    local rotation      = self:GetRotation( )
    local start_angle   = self:GetStartAngle( )
    local end_angle     = self:GetEndAngle( )
    local dist          = self:GetDistance( )

    assert( radius > 0, string.format( "Circle radius should be higher than 0. (%.2f)", radius ) )
    assert( dist > 0, string.format( "Circle vertice distance should be higher than 0. (%.2f)", dist ) )

    self:SetVertices( CalculateVertices( x, y, radius, rotation, start_angle, end_angle, dist, rotate_uv ) )

    if self:GetType( ) == CIRCLE_LINE then
        local inner                 = self:GetChildCircle( ) or self:Copy( )

        inner:SetType               ( CIRCLE_FILL )
        inner:SetRadius             ( self:GetRadius( ) - self:GetOutlineWidth( ) )
        inner:SetAcceptRadians      ( false     )
        inner:SetAngles             ( 0, 360    )
        inner:SetColor              ( false     )
        inner:SetMaterial           ( false     )
        inner:SetDisableClipping    ( false     )
        self:SetChildCircle         ( inner     )
    end

    self:SetDirty(false)
end

/*
*	circle > __call
*/

function rcir:__call( )
    if self:GetDirty( ) then
        self:Calculate( )
    end

    if #self:GetVertices( ) < 3 then return end

    if IsColor( self:GetColor( ) ) then
        local col = self:GetColor( )
        surface.SetDrawColor( col.r, col.g, col.b, col.a )
    end

    if TypeID( self:GetMaterial( ) ) == TYPE_MATERIAL then
        surface.SetMaterial( self:GetMaterial( ) )
    elseif self:GetMaterial( ) == true then
        draw.NoTexture( )
    end

    local clip      = self:GetDisableClipping( )
                    if clip then surface.DisableClipping( true ) end

    /*
    *	circle > outline
    */

    if self:GetType( ) == CIRCLE_LINE then
        render.ClearStencil( )

        render.SetStencilEnable( true )
            stencil_mask( 0xFF, 0xFF, 0x01 )
            stencil_open( )
                self:GetChildCircle( )( )
            stencil_close( false )

            surface.DrawPoly( self:GetVertices( ) )
        render.SetStencilEnable( false )

    /*
    *	circle > blurred
    */

    elseif self:GetType( ) == CIRCLE_BLUR then
        render.ClearStencil( )

        render.SetStencilEnable( true )
            stencil_mask( 0xFF, 0xFF, 0x01 )
            stencil_open( )
                surface.DrawPoly( self:GetVertices( ) )
            stencil_close( true )

            surface.SetMaterial( mat_blur )

            local w, h = ScrW( ), ScrH( )

            for i = 1, self:GetBlurLayers( ) do
                mat_blur:SetFloat   ( '$blur', ( i / self:GetBlurLayers( ) ) * self:GetBlurDensity( ) )
                mat_blur:Recompute  ( )

                render.UpdateScreenEffectTexture( )
                surface.DrawTexturedRect( 0, 0, w, h )
            end
        render.SetStencilEnable( false )

    /*
    *	circle > filled
    */

    else
        surface.DrawPoly( self:GetVertices( ) )
    end

    if clip then surface.DisableClipping( false ) end
end

/*
*	circle > Translate
*
*   @param  : int x
*   @param  : int y
*/

function rcir:Translate( x, y )
    x           = tonumber( x )
    y           = tonumber( y )
                if not x and not y then return end
                if x == 0 and y == 0 then return end

    self.m_X    = self:GetX( ) + x
    self.m_Y    = self:GetY( ) + y

    if self:GetDirty( ) then return end

    x = tonumber( x ) or 0
    y = tonumber( y ) or 0

    for i, v in ipairs( self:GetVertices( ) ) do
        v.x = v.x + x
        v.y = v.y + y
    end

    if self:GetType( ) == CIRCLE_LINE then
        self:GetChildCircle( ):Translate( x, y )
    end
end

/*
*	circle > Scale
*
*   @param  : int amt
*/

function rcir:Scale( amt )
    amt             = tonumber( amt )
                    if not amt or amt == 1 then return end

    self.m_Radius   = self:GetRadius( ) * amt

    if self:GetDirty( ) then return end

    local x, y = self:GetPos( )

    for i, vertex in ipairs( self:GetVertices( ) ) do
        vertex.x = x + ( ( vertex.x - x ) * amt )
        vertex.y = y + ( ( vertex.y - y ) * amt )
    end

    if self:GetType( ) == CIRCLE_LINE then
        self:GetChildCircle( ):Scale( amt )
    end
end

/*
*	circle > Rotate
*
*   @param  : int amt
*/

function rcir:Rotate( amt )
    amt             = tonumber( amt )
                    if not amt or amt == 0 then return end

    if self:GetAcceptRadians( ) then
        amt = math.deg( amt )
    end

    self.m_Rotation = self:GetRotation( ) + amt

    if self:GetDirty( ) then return end

    local x, y          = self:GetPos( )
    local vert          = self:GetVertices( )
    local rotate_uv     = self:GetRotateMaterial( )

    RotateVertices( vert, x, y, amt, rotate_uv )

    if self:GetType( ) == CIRCLE_LINE then
        self:GetChildCircle( ):Rotate( amt )
    end
end

do

    /*
    *	AccessorFunc
    */

    local function AccessorFunc( name, def, dirty, cb )
        local id = 'm_' .. name

        rcir[ 'Get' .. name ] = function( self )
            return self[ id ]
        end

        rcir[ 'Set' .. name ] = function( self, val )
            if def ~= nil and val == nil then
                val = def
            end

            if self[ id ] ~= val then
                if dirty then
                    self[ dirty ] = true
                end

                if isfunction( cb ) then
                    val = cb( self, self[ id ], val ) or val
                end

                self[ id ] = val
            end
        end

        rcir[ id ] = def
    end

    /*
    *	OffsetVerticesX
    */

    local function OffsetVerticesX( cir, old, new )
        if ( cir:GetDirty( ) or not cir:GetVertices( ) ) then return end

        for i, vertex in ipairs( cir:GetVertices( ) ) do
            vertex.x = vertex.x + ( new - old )
        end

        if cir:GetType( ) == CIRCLE_LINE then
            OffsetVerticesX( cir:GetChildCircle( ), old, new )
        end
    end

    /*
    *	OffsetVerticesY
    */

    local function OffsetVerticesY( cir, old, new )
        if cir:GetDirty( ) or not cir:GetVertices( ) then return end

        for i, vertex in ipairs( cir:GetVertices( ) ) do
            vertex.y = vertex.y + ( new - old )
        end

        if cir:GetType( ) == CIRCLE_LINE then
            OffsetVerticesY( cir:GetChildCircle( ), old, new )
        end
    end

    /*
    *	UpdateRotation
    */

    local function UpdateRotation( cir, old, new )
        if cir:GetDirty( ) or not cir:GetVertices( ) then return end

        if cir:GetAcceptRadians( ) then
            new = math.deg( new )
        end

        local vert          = cir:GetVertices( )
        local x, y          = cir:GetPos( )
        local rotation      = new - old
        local rotate_uv     = cir:GetRotateMaterial( )

        RotateVertices( vert, x, y, rotation, rotate_uv )

        if cir:GetType( ) == CIRCLE_LINE then
            UpdateRotation( cir:GetChildCircle( ), old, new )
        end
    end

    /*
    *	UpdateStartAngle
    */

    local function UpdateStartAngle( cir, old, new )
        if cir:GetAcceptRadians( ) then
            return math.deg( new )
        end
    end

    /*
    *	UpdateEndAngle
    */

    local function UpdateEndAngle( cir, old, new )
        if cir:GetAcceptRadians( ) then
            return math.deg( new )
        end
    end

    /*
    *	AccessorFunc
    *
    *   set internally.
    *   only use them if you know what you're doing.
    */

    AccessorFunc( 'Dirty',              true    )
    AccessorFunc( 'Vertices',           false   )
    AccessorFunc( 'ChildCircle',        false   )

    AccessorFunc( 'Color',              false   )					            -- The colour you want the circle to be. If set to false then surface.SetDrawColor's can be used.
    AccessorFunc( 'Material',           false   )							    -- The material you want the circle to render. If set to false then surface.SetMaterial can be used.
    AccessorFunc( 'AcceptRadians',      false   )						        -- Use radians instead of degrees for the method arguments.
    AccessorFunc( 'RotateMaterial',     true    )						        -- Sets whether or not the circle's UV points should be rotated with the vertices.
    AccessorFunc( 'DisableClipping',    false   )						        -- Sets whether or not to disable clipping when the circle is rendered. Useful for circles that go out of the render bounds.

    AccessorFunc( 'Type',               CIRCLE_FILL, 'm_Dirty' )				-- The circle's type.
    AccessorFunc( 'X',                  0, false, OffsetVerticesX )				-- The circle's X position relative to the top left of the screen.
    AccessorFunc( 'Y',                  0, false, OffsetVerticesY )				-- The circle's Y position relative to the top left of the screen.
    AccessorFunc( 'Radius',             8, 'm_Dirty' )						    -- The circle's radius.
    AccessorFunc( 'Rotation',           0, false, UpdateRotation )			    -- The circle's rotation, measured in degrees.
    AccessorFunc( 'StartAngle',         0, 'm_Dirty', UpdateStartAngle )	    -- The circle's start angle, measured in degrees.
    AccessorFunc( 'EndAngle',           360, 'm_Dirty', UpdateEndAngle )	    -- The circle's end angle, measured in degrees.
    AccessorFunc( 'Distance',           10, 'm_Dirty' )						    -- The maximum distance between each of the circle's vertices. Set to false to use segments instead. This should typically be used for large circles in 3D2D.

    AccessorFunc( 'BlurLayers',         3       )								-- The circle's blur layers if Type is set to CIRCLE_BLUR.
    AccessorFunc( 'BlurDensity',        2       )								-- The circle's blur density if Type is set to CIRCLE_BLUR.
    AccessorFunc( 'OutlineWidth',       10, 'm_Dirty' )					        -- The circle's outline width if Type is set to CIRCLE_LINE.

    /*
    *	circle > SetPos
    */

    function rcir:SetPos( x, y )
        self:SetX   ( x )
        self:SetY   ( y )
    end

    /*
    *	circle > SetAngles
    */

    function rcir:SetAngles( s, e )
        self:SetStartAngle      ( s )
        self:SetEndAngle        ( e )
    end

    /*
    *	circle > GetPos
    */

    function rcir:GetPos( )
        return self:GetX( ), self:GetY( )
    end

    /*
    *	circle > GetAngles
    */

    function rcir:GetAngles( )
        return self:GetStartAngle( ), self:GetEndAngle( )
    end
end

rcir.new        = New
rcir.rotate     = RotateVertices
rcir.calc       = CalculateVertices

return rcir