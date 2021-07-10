/*
*   @package        : rcore
*   @module         : base
*	@extends		: ulx
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
local cvar                  = base.v

/*
*   module calls
*/

local mod, pf       	    = base.modules:req( 'base' )
local cfg               	= base.modules:cfg( mod )
local smsg                  = base.settings.smsg
local sf                    = sf

/*
*   Localized translation func
*/

local function ln( ... )
    return base:translate( mod, ... )
end

/*
*	prefix ids
*/

local function pref( str, suffix )
    local state = not suffix and mod or isstring( suffix ) and suffix or false
    return base.get:pref( str, state )
end

/*
*   console
*/

local function con( ... )
    base:console( ... )
end

/*
*   get access perm
*/

local function perm( id )
    return access:getperm( id, mod )
end

/*
*   declare perm ids
*/

local id_pos                = perm( 'rlib_ents_pos' )
local id_goto               = perm( 'rlib_ents_goto' )
local id_entid              = perm( 'rlib_ents_id' )
local id_class              = perm( 'rlib_ents_class' )

/*
*   check dependency
*
*   @param  : ply pl
*   @param  : str p
*/

local function checkDependency( pl, p )
    if not base or not base.modules:bInstalled( mod ) then
        p                   = isstring( p ) and helper.ok.str( p ) or istable( p ) and ( p.ulx or p.id ) or 'unknown command'
        local msg           = { smsg.clrs.t2, p, smsg.clrs.msg, '\nAn error has occured with the library. Contact the developer or sys admin.' }
        pl:push             ( '', 'Critical Error', 7, msg )
        return false
    end
    return true
end

/*
*   ulx > ents > get pos
*
*	force closes and locks all doors immediately after being triggered
*
*   @param	: ply call_pl
*   @param  : str ent_id
*/

function ulx.rlib_ents_pos( call_pl, ent_id )
    if not checkDependency( call_pl, id_pos ) then return end

    local tr                = call_pl:GetEyeTrace( )

    if not IsValid( tr.Entity ) then
        base.msg:target( call_pl, id_pos.id, 'No', smsg.clrs.t3, ent_id, smsg.clrs.msg, 'found within eyesight. Look at ent before running command' )
        return
    end

    local pos               = tr.Entity:GetPos( )
    local ang               = tr.Entity:GetAngles( )
    local class             = tr.Entity:GetClass( )

    local pos_x             = math.floor( pos[ 1 ] )
    local pos_y             = math.floor( pos[ 2 ] )
    local pos_z             = math.floor( pos[ 3 ] )

    local ang_x             = math.floor( ang[ 1 ] )
    local ang_y             = math.floor( ang[ 2 ] )
    local ang_z             = math.floor( ang[ 3 ] )

    local pos_str           = sf( '%i, %i, %i', pos_x, pos_y, pos_z )
    local ang_str           = sf( '%i, %i, %i', ang_x, ang_y, ang_z )

    con( 'c', 3 )
    con( 'c', 0 )
    con( 'c',               sf( 'ENT » %s', class  ) )
    con( 'c', 0 )

    local a1_l              = sf( '%-15s',  'Type' )
    local a2_l              = sf( '%-5s',  '»'   )
    local a3_l              = sf( '%-35s',  'Vector' )

    con( 'c',               Color( 0, 255, 0 ), a1_l, Color( 0, 255, 0 ), a2_l, a3_l )

    local r1_l              = sf( '%-15s',  'Position' )
    local r2_l              = sf( '%-5s',  '»'   )
    local r3_l              = sf( '%-35s',  tostring( pos_str ) )

    con( 'c',               Color( 255, 255, 0 ), r1_l, Color( 255, 255, 255 ), r2_l, r3_l )

    local r1_2              = sf( '%-15s',  'Angle' )
    local r2_2              = sf( '%-5s',  '»'   )
    local r3_2              = sf( '%-35s',  tostring( ang_str ) )

    con( 'c',               Color( 255, 255, 0 ), r1_2, Color( 255, 255, 255 ), r2_2, r3_2 )
    con( 'c', 0 )

    con( 'c', 2 )

    print( ' Pos: ' .. tostring( pos_str ) )
    print( ' Ang ' .. tostring( ang_str ) )

    con( 'c', 2 )

    base.msg:target( call_pl, id_goto.id, 'Ent:', smsg.clrs.t3, class, smsg.clrs.msg, '\n[Position] :', smsg.clrs.t4, tostring( pos_str ), smsg.clrs.msg, '\n[Angle] :', smsg.clrs.t4, tostring( ang_str ) )
end
local rlib_ents_pos                             = ulx.command( id_pos.category, id_pos.ulx_id, ulx.rlib_ents_pos, id_pos.pubcmds )
rlib_ents_pos:addParam                          { type = ULib.cmds.StringArg, hint = 'ent_id' }
rlib_ents_pos:defaultAccess                     ( access:ulx( id_pos, mod ) )
rlib_ents_pos:help                              ( id_pos.desc )

/*
*   ulx > ents > goto
*
*	force closes and locks all doors immediately after being triggered
*
*   @param	: ply call_pl
*   @param  : str ent_id
*   @param  : int id
*/

function ulx.rlib_ents_goto( call_pl, ent_id, id )
    if not checkDependency( call_pl, id_goto ) then return end

    id                      = isnumber( id ) and id or tonumber( id ) or 1
    local en                = ent_id
    local c                 = helper.ent.count( en )( ) or 0
    local ent_pos           = { }
    local ent_ang           = { }

    if c == 0 or c == nil then
        base.msg:target( call_pl, id_goto.id, 'Ent', smsg.clrs.t3, en, smsg.clrs.msg, 'not spawned on map' )
        return
    end

    if c > 1 then
        if not id or id == 0 then
            base.msg:target( call_pl, id_goto.id, 'More than 1 found for', smsg.clrs.t3, en, smsg.clrs.msg, 'Specify a number between', smsg.clrs.t4, '1', smsg.clrs.msg, '-', smsg.clrs.t4, tostring( c ) )
            return
        end

        if not calc.bIsNum( id ) then
            base.msg:target( call_pl, id_goto.id, 'Specified parameter is not a real number:', smsg.clrs.t3, tostring( id ) )
            return
        end

        id = tonumber( id )
    end

    if c > 1 and id > c then
        base.msg:target( call_pl, id_goto.id, 'id number specified is too high or low:', smsg.clrs.t3, tostring( id ) )
        return
    end

    for i, v in pairs( ents.FindByClass( en ) ) do
        if c > 1 and id and calc.bIsNum( id ) then
            if i == id then
                ent_pos     = v:GetPos( )
                ent_ang     = v:GetAngles( )
            end
        else
            ent_pos         = v:GetPos( )
            ent_ang         = v:GetAngles( )
            id              = tonumber( 1 )
        end
    end

    call_pl:SetPos( ent_pos + call_pl:GetForward( ) * -80 )

    base.msg:target( call_pl, id_goto.id, 'Teleported to', smsg.clrs.t3, en, smsg.clrs.msg, '[ID] :', smsg.clrs.t4, tostring( id ) )

end
local rlib_ents_goto                            = ulx.command( id_goto.category, id_goto.ulx_id, ulx.rlib_ents_goto, id_goto.pubcmds )
rlib_ents_goto:addParam                         { type = ULib.cmds.StringArg, hint = 'ent_id' }
rlib_ents_goto:addParam                         { type = ULib.cmds.StringArg, hint = '0' }
rlib_ents_goto:defaultAccess                    ( access:ulx( id_goto, mod ) )
rlib_ents_goto:help                             ( id_goto.desc )

/*
*   ulx > ents > door id
*
*	returns door id
*
*   @param	: ply call_pl
*/

local lst_doors =
{
    [ 'func_door' ]                 = true,
    [ 'func_door_rotating' ]        = true,
    [ 'prop_door_rotating' ]        = true,
}

function ulx.rlib_ents_id( call_pl )
    if not checkDependency( call_pl, id_entid ) then return end

    local tr = call_pl:GetEyeTrace( )
    if not IsValid( tr.Entity ) then
        base.msg:target( call_pl, id_entid.id, 'No items found within eyesight. Look at door before running command' )
        return
    end

    if lst_doors[ tr.Entity:GetClass( ) ] then
        if not IsValid( tr.Entity ) then return end
        local en        = tr.Entity
        local en_id     = en:MapCreationID( )

        base.msg:target( call_pl, id_entid.id, 'Door', smsg.clrs.t3, en, smsg.clrs.msg, '[ID] :', smsg.clrs.t4, tostring( en_id ) )
    end

end
local rlib_ents_id                              = ulx.command( id_entid.category, id_entid.ulx_id, ulx.rlib_ents_id, id_entid.pubcmds )
rlib_ents_id:defaultAccess                      ( access:ulx( id_entid ) )
rlib_ents_id:help                               ( id_entid.desc )

/*
*   ulx > ents > class
*
*	returns ent class
*
*   @param	: ply call_pl
*/

function ulx.rlib_ents_class( call_pl )
    if not checkDependency( call_pl, id_class ) then return end

    local tr = call_pl:GetEyeTrace( )
    if not IsValid( tr.Entity ) then
        base.msg:target( call_pl, id_class.id, 'No items found within eyesight. Look at door before running command' )
        return
    end

    if lst_doors[ tr.Entity:GetClass( ) ] then
        if not IsValid( tr.Entity ) then return end
        local en        = tr.Entity
        local en_id     = en:MapCreationID( )

        base.msg:target( call_pl, id_class.id, 'Door', smsg.clrs.t3, en, smsg.clrs.msg, '[ID] :', smsg.clrs.t4, tostring( en_id ) )
    end

end
local rlib_ents_class                           = ulx.command( id_class.category, id_class.ulx_id, ulx.rlib_ents_class, id_class.pubcmds )
rlib_ents_class:defaultAccess                   ( access:ulx( id_class ) )
rlib_ents_class:help                            ( id_class.desc )