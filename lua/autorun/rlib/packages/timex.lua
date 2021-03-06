/*
*   @package        : rlib
*   @module         : timex
*   @author         : Richard [http://steamcommunity.com/profiles/76561198135875727]
*   @copyright      : (C) 2018 - 2020
*   @since          : 1.1.0
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

local base              = rlib
local mf                = base.manifest
local pf                = mf.prefix
local script            = mf.name

/*
*   lib includes
*/

local access            = base.a
local helper            = base.h

/*
*   module declarations
*/

local dcat              = 9

/*
*   localizations
*/

local timer             = timer
local math              = math
local debug             = debug
local module            = module
local sf                = string.format
local floor             = math.floor

/*
*   simplifiy funcs
*/

local function con( ... ) base:console( ... ) end
local function log( ... ) base:log( ... ) end

/*
*   call id
*
*   @source : lua\autorun\libs\_calls
*   @param  : str id
*/

local function call_id( id )
    return base:call( 'timers', id )
end

/*
*   Localized translation func
*/

local function lang( ... )
    return base:lang( ... )
end

/*
*	pf > create id
*/

local function pref( id, suffix )
    local affix     = istable( suffix ) and suffix.id or isstring( suffix ) and suffix or pf
    affix           = affix:sub( -1 ) ~= '.' and sf( '%s.', affix ) or affix

    id              = isstring( id ) and id or 'noname'
    id              = id:gsub( '[%c%s]', '.' )

    return sf( '%s%s', affix, id )
end

/*
*	prefix > handle
*/

local function pid( str, suffix )
    local state = ( isstring( suffix ) and suffix ) or ( base and mf.prefix ) or false
    return pref( str, state )
end

/*
*   define module
*/

module( 'timex', package.seeall )

/*
*   local declarations
*/

local pkg                   = timex
local pkg_name              = _NAME or 'timex'

/*
*   pkg declarations
*/

local manifest =
{
    author                  = 'richard',
    desc                    = 'timer registration and management tool',
    build                   = 042120,
    version                 = { 2, 3, 0 },
}

/*
*   required tables
*/

settings                    = settings  or { }
sys                         = sys       or { }
secs                        = secs      or { }
bw                          = bw        or { }

/*
*	pf > getid
*/

local function gid( id )
    id = isstring( id ) and id or tostring( id )
    if not isstring( id ) then
        local trcback = debug.traceback( )
        log( dcat, '[ %s ] :: invalid id\n%s', pkg_name, tostring( trcback ) )
        return
    end

    id = call_id( id )

    return id
end

/*
*   timex > exists
*
*   checks to see if a timer exists
*
*   @param  : str id
*   @return : bool
*/

function exists( id )
    id = gid( id )
    return isstring( id ) and timer.Exists( id ) and true or false
end
valid = exists

/*
*   timex > expire
*
*   destroys a timer if it exists
*
*   @param  : str id
*/

function expire( id )
    local bExists   = exists( id )
    id              = gid( id )

    if isstring( id ) and bExists then
        timer.Remove( id )
    end
end
kill = expire

/*
*   timex > pause
*
*   pauses a timer if it exists
*
*   @param  : str id
*/

function pause( id )
    local bExists   = exists( id )
    id              = gid( id )

    if isstring( id ) and bExists then
        timer.Pause( id )
    end
end
stop = pause

/*
*   timex > adjust
*
*   modifies a timer
*
*   @param  : str id
*   @param  : int delay
*   @param  : int reps
*   @param  : func fn
*/

function adjust( id, delay, reps, fn )
    local bExists   = exists( id )
    id              = gid( id )

    if not bExists then return end
    if not isnumber( delay ) then return end
    timer.Adjust( id, delay, reps, fn )
end

/*
*   timex > resume
*
*   continues a timer where it left off
*
*   @param  : str id
*/

function resume( id )
    local bExists   = exists( id )
    id              = gid( id )

    if not isstring( id ) or not bExists then return end
    timer.UnPause( id )
end
start = resume

/*
*   timex > remains
*
*   returns the time in seconds remaining on an existing timer
*
*   @param  : str id
*   @param  : bool b
*   @return : int
*/

function remains( id, b )
    local bExists   = exists( id )
    id              = gid( id )

    return bExists and math.Round( timer.TimeLeft( id ) ) or ( b and 0 ) or false
end
left = remains

/*
*   timex > reps
*
*   returns the number of reps left on a timer
*
*   @param  : str id
*   @return : int
*/

function reps( id )
    local bExists   = exists( id )
    id              = gid( id )

    return bExists and math.Round( timer.RepsLeft( id ) ) or 0
end
life = reps

/*
*   timex > create
*
*   create a detailed timer
*
*   @todo   : add timer logging
*
*   @param  : str id
*   @param  : int delay
*   @param  : int repscnt
*   @param  : func fn
*/

function create( id, delay, repscnt, fn )
    id          = gid( id )
    delay       = delay or 0.1
    repscnt     = repscnt or 1

    if not fn or not base:isfunc( fn ) then
        log( 1, '[ %s ] :: timer created with no func', pkg_name )
        fn = function( ) end
    end

    timer.Create( id, delay, repscnt, fn )
end
new = create

/*
*   timex > unique
*
*   create a detailed timer only if it currently doesnt exist
*
*   @param  : str id
*   @param  : int delay
*   @param  : int repscnt
*   @param  : func fn
*/

function unique( id, delay, repscnt, fn )
    local bExists   = exists( id )
    id              = gid( id )
    delay           = delay or 0.1
    repscnt         = repscnt or 1

    if bExists then return end

    if not fn or not base:isfunc( fn ) then
        log( 1, '[ %s ] :: unique timer created with no func', pkg_name )
        fn = function( ) end
    end

    timer.Create( id, delay, repscnt, fn )
end
uni = unique

/*
*   timex > simple
*
*   create a simple timer.
*   args a, b can be mixed to include or exclude a string id ( used for the lib calls function )
*
*   @usage  : timex.simple( pf .. 'action_name', 5, function( ) end )
*   @usage  : timex.simple( 5, function( ) end )
*
*   @todo   : add timer logging for c_id
*   @param  : str, int a
*   @param  : int b
*   @param  : func fn
*/

function simple( a, b, fn )
    local id        = isstring( a ) and a or nil
    local delay     = isnumber( b ) and b or isnumber( a ) and a or 0.1
    local func      = base:isfunc( fn ) and fn or base:isfunc( b ) and b or nil

    if not func or not base:isfunc( func ) then
        log( 6, '[%s] :: simple timer created with no func', pkg_name )
        func = function( ) end
    end

    timer.Simple( delay, func )
end

/*
*   rnet > source
*
*   returns source tbl for timers
*
*   @return : tbl
*/

function source( )
    return base.calls:get( 'timers' ) or { }
end

/*
*   timex > list
*
*   returns a list of registered timers that are active for a complete list of both active and non, use
*   the concommand rlib.calls
*
*   @param  : bool bActiveOnly
*   @return : tbl, int
*/

function list( bActiveOnly )
    local t         = source( )
    local item      = { }
    local cnt       = 0
    for k, v in pairs( t ) do
        local id    = ( isstring( v[ 1 ] ) and v[ 1 ] ) or ( isstring( v.id ) and v.id )
        local desc  = ( isstring( v[ 2 ] ) and v[ 2 ] ) or ( isstring( v.desc ) and v.desc )

        if bActiveOnly and not exists( id ) then continue end

        item[ k ]               = { }
        item[ k ].id            = id
        item[ k ].desc          = desc
        item[ k ].remains       = remains( id )
        item[ k ].reps          = reps( id )
        item[ k ].bActive       = exists( id ) and 'yes' or 'no'

        cnt = cnt + 1
    end

    return item, cnt
end

/*
*   timex > count
*
*   returns total number of timers
*
*   @param  : bool bActiveOnly
*   @return : int
*/

function count( bActiveOnly )
    local t         = source( )
    local cnt       = 0
    for k, v in pairs( t ) do
        local id    = ( isstring( v[ 1 ] ) and v[ 1 ] ) or ( isstring( v.id ) and v.id )
        if bActiveOnly and not exists( id ) then continue end

        cnt = cnt + 1
    end

    return cnt
end

/*
*   timex funcs
*/

/*
*   clean time
*
*   strips zeros out of the front of times displayed
*
*   @ex     : timex.cleantime( os.date( '%I:%M %p' ) )
*           :   06:50 am changes to 6:50 am
*
*   @param  : str str
*   @return : str
*/

function cleantime( str )
    while true do
        if str:sub( 1, 1 ) == '0' then
            str = str:sub( 2 )
        else
            break
        end
    end
    return str
end

/*
*   seconds > duration
*
*   converts seconds to a human readable format with various different parameters so you can decide
*   on what you want to see.
*
*   @ex     :   timex.secs.duration( 30 )
*   @out    :   20 seconds
*
*   @param  : int i
*   @param  : bool bSLabel
*   @return : str
*/

function secs.duration( i, bSLabel )
    local str = ''

    i = tonumber( i ) or 0
    if i < 0 then i = 0 end
    i = math.Round( i )

    local days      = floor( ( i - i % 86400 ) / 86400 )
    local hours     = floor( ( i - i % 3600 ) / 3600 )
    local minutes   = floor( ( i - i % 60 ) / 60 )
    local seconds   = i

    if hours >= 24 then
        local affix = ( not bSLabel and ( days == 1 and 'day' or 'days' ) or 'd' ) or ''
        return days .. ' ' .. affix
    end

    if minutes >= 60 then
        local affix = ( not bSLabel and ( hours == 1 and 'hour' or 'hours' ) or 'h' ) or ''
        return hours .. ' ' .. affix
    end

    if seconds >= 60 then
        local affix = ( not bSLabel and ( minutes == 1 and 'minute' or 'minutes' ) or 'm' ) or ''
        return minutes .. ' ' .. affix
    end

    if seconds < 60 then
        local affix = ( not bSLabel and ( seconds == 1 and 'second' or 'seconds' ) or 's' ) or ''
        return seconds .. ' ' .. affix
    end

    return str
end

/*
*   seconds > merged
*
*   displays a human readable format from seconds which simply displays HH:MM:SS
*   does not support days
*
*   @ex     :   timex.secs.merged( 90 )
*   @out    :   1:30
*               m : s
*
*   @param  : int i
*   @return : str
*/

function secs.merged( i )
    local str = ''

    i = i and tonumber( i ) or 0

    local hours     = ( i - i % 3600 ) / 3600
    i               = i - hours * 3600

    local mins      = ( i - i % 60 ) / 60
    i               = i - mins * 60

    local sec       = sf( '%02d', i )

    if sec ~= 0 then
        str = sec
    end

    if mins ~= 0 then
        if sec == 0 then
            str = mins .. '' .. str
        else
            str = mins .. ':' .. str
        end
    end

    if hours ~= 0 then
        str = hours .. ':' .. str
    end

    return str
end

/*
*   seconds > shorthand > simple
*
*   calculates how many seconds are within the current timeframe.
*   with how the time is formatted, it the time exceeds a type, it will progress to the next one up
*
*   does not support hours or days, so only use it for clocks that need 60 minutes and less.
*
*   @ex     :   60      01:00
*                       displays as 1 min : 00 sec
*
*   @ex     :   3500    58:20
*                       displays as 58 min : 20 sec
*
*   @param  : int i
*   @return : str
*/

function secs.sh_simple( i )
    i = i and tonumber( i ) or 0
    i = math.Round( i )

    local min, sec = 0

    if i <= 0 then
        return '00:00'
    else
        min     = sf( '%02.f', floor( i / 60 ) )
        sec     = sf( '%02.f', floor( i - min * 60 ) )

        return min .. ':' .. sec
    end
end

/*
*   seconds > shorthand > seconds only
*
*   @ex     :   timex.secs.sh_secsonly( 300 )
*   @out    :   300
*               s
*
*   @param  : int i
*   @return : str
*/

function secs.sh_secsonly( i )
    i = i and tonumber( i ) or 0

    if i <= 0 then
        return 0
    else
        return i
    end
end

/*
*   seconds > shorthand > under hour
*
*   does not support hours or days, so only use it for clocks that need 60 minutes and less.
*
*   @ex     :   timex.secs.sh_uhour( 120, true )
*   @out    :   00:02:00
*               h : m : s
*
*   @ex     :   timex.secs.sh_uhour( 120 )
*   @out    :   00:02
*               h : m
*
*   @param  : int i
*   @param  : bool bSecs
*   @return : str
*/

function secs.sh_uhour( i, bSecs )
    i = i and tonumber( i ) or 0

    local min, sec, hour = 0

    if i <= 0 then
        return '00:00'
    else
        hour	= sf( '%02.f', floor( i / 3600 ) )
        min	    = sf( '%02.f', floor( i / 60 - ( hour * 60 ) ) )
        sec	    = sf( '%02.f', floor( i - hour * 3600 - min * 60 ) )

        if bSecs then
            return hour .. ':' .. min .. ':' .. sec
        else
            return hour .. ':' .. min
        end
    end
end

/*
*   seconds > shorthand > columnized
*
*   format seconds to short-hand readable format
*
*   @ex     :   timex.secs.sh_uhour( 175 )
*   @out    :   00w 00d 00h 02m 55s
*               w : d : h : m : s
*
*   @param  : int i
*   @param  : bool bSecs
*   @return : str
*/

function secs.sh_cols( i, bSecs )
    i = i and tonumber( i )

    local tmp   = i
    local s     = tmp % 60
    tmp         = floor( tmp / 60 )
    local m     = tmp % 60
    tmp         = floor( tmp / 60 )
    local h     = tmp % 24
    tmp         = floor( tmp / 24 )
    local d     = tmp % 7
    local w     = floor( tmp / 7 )

    return bSecs and sf( '%02iw %02id %02ih %02im %02is', w, d, h, m, s ) or sf( '%02iw %02id %02ih %02im', w, d, h, m )
end

/*
*   seconds > shorthand > columnized > steps
*
*   converts seconds to a human readable format with various different parameters so you can decide
*   on what you want to see.
*
*   time displays in steps based on the higher type
*   does not display seconds until the final 60 seconds
*
*   @ex     :   timex.secs.sh_cols_steps( 175 )
*   @out    :   02m
*               m
*
*   @ex     :   timex.secs.sh_cols_steps( 32 )
*   @out    :   32s
*               s
*
*   :   ( bool ) bShowEmpty
*       will show all segments even if they are at 00.
*
*   :   ( bool ) bSeconds
*       displays the seconds value on the end
*
*   @param  : int i
*   @param  : bool bShowEmpty
*   @param  : bool bSeconds
*   @return : str
*/

function secs.sh_cols_steps( i, bShowEmpty, bSeconds )
    local str = ''
    local set_format = '%02.f'

    i = tonumber( i ) or 0
    if i < 0 then i = 0 end
    i = math.Round( i )

    local bBelowMin = i < 60 and true or false

    local days      = sf( set_format, floor( ( i - i % 86400 ) / 86400 ) )
    i               = i - days * 86400

    local hours     = sf( set_format, floor( ( i - i % 3600 ) / 3600 ) )
    i               = i - hours * 3600

    local minutes   = sf( set_format, floor( ( i - i % 60 ) / 60 ) )
    i               = i - minutes * 60

    local seconds   = sf( '%02d', i )

    if ( bBelowMin and ( ( not bShowEmpty and seconds ~= 0 ) or bShowEmpty ) ) or bSeconds then
        seconds = sf( '%02d', math.abs( seconds ) )
        str         = seconds .. 's'
    end

    if ( not bBelowMin and ( ( not bShowEmpty and tonumber( minutes ) ~= 0 ) or bShowEmpty ) ) then
        str         = minutes .. 'm ' .. str
    end

    if ( not bBelowMin and ( ( not bShowEmpty and tonumber( hours ) ~= 0 ) or bShowEmpty ) ) then
        str         = hours .. 'h ' .. str
    end

    if ( not bBelowMin and ( ( not bShowEmpty and tonumber( days ) ~= 0 ) or bShowEmpty ) ) then
        str         = days .. 'd ' .. str
    end

    return str
end

/*
*   seconds > milliseconds
*
*   uses os.clock( ) with a specified starting point to determine the ms that have passed.
*
*   @ex     : 0.5 =>  0.5ms
*   @ex     : 60  =>  60 s
*   @ex     : 130 =>  130 s
*
*   @param  : int began
*   @return : str
*/

function secs.ms( began )
    began           = isnumber( began ) and began or os.clock( )
    local elapsed   = os.clock( ) - began
    local ms        = 1000 * elapsed

    return sf( '%dms', ms )
end

/*
*   seconds > benchmark
*
*   returns only in seconds
*
*   @ex     : 0.5 =>  0.5ms
*   @ex     : 60  =>  60 s
*   @ex     : 130 =>  130 s
*
*   @param  : int i
*   @param  : int offset [ optional ]
*   @return : str
*/

function secs.benchmark( i, offset )
    i       = i and tonumber( i ) or 0
    offset  = offset and tonumber( offset ) or 0

    if i < 1 then
        return math.Truncate( i, 3 ) .. 'ms'
    else
        local sec = math.Truncate( i, 2 )
        if offset and offset > 0 then
            sec = sec - offset
        end
        return math.Round( sec ) .. 's'
    end
end

/*
*   seconds > curtime
*
*   compares stored curtime to current and returns time remaining
*
*   @param  : str str
*   @return : str
*/

function secs.curtime( num )
    return ( num and calc.min( 0, num - CurTime( ) ) ) or CurTime( )
end

/*
*   seconds > ctime
*
*   similar to timex.curtime but returns a string with the seconds appended
*
*   @ex     : timex.secs.ctime( pl.NextSpawn, false )
*             '5 seconds'
*
*   @ex     : timex.secs.ctime( pl.NextSpawn, true )
*             '5s'
*
*   @param  : str str
*   @param  : bool bShort
*   @return : str
*/

function secs.ctime( num, bShort )
    local time  = ( num and calc.min( 0, num - CurTime( ) ) ) or CurTime( )
    if bShort then
        return string.format( '%is', time )
    else
        return string.format( '%i seconds', time )
    end
end

/*
*   basewars > structure time
*
*   gamemode specific func that displays basewars playtime
*   for player.
*
*   formats table for playtime into human readable format
*
*   @ex     : timex.bw.structtime( { h = 0, m = 0, s = 52 } )
*   @out    : 52s
*
*   @param  : tbl tbl
*   @param  : bool bLong
*   @return : str
*/

function bw.structtime( tbl, bLong )
    local dat       = tbl
    local resp      = ''

    if dat.h > 0 then
        resp        = resp .. dat.h .. ( not bLong and BaseWars.LANG.HoursShort or lang( 'time_hour_sh' ) ) .. ' '
    end
    if dat.m > 0 then
        resp        = resp .. dat.m ..  ( not bLong and BaseWars.LANG.MinutesShort or lang( 'time_min_sh' ) ) .. ' '
    end
    if dat.s > 0 then
        resp        = resp .. dat.s  ..  ( not bLong and BaseWars.LANG.SecondsShort or lang( 'time_sec_sh' ) ) .. ' '
    end

    return #resp > 0 and resp or sf( '0%s', ( not bLong and BaseWars.LANG.SecondsShort or lang( 'time_sec_ti' ) ) )
end

/*
*   basewars > playtime
*
*   gamemode specific func that displays basewars playtime
*   for player.
*
*   gets player current playtime as int
*
*   @assoc  : bw.structtime( tbl )
*
*   @ex     : timex.bw.playtime( pl )
*   @out    : 4m 39s
*
*   @param  : ply pl
*   @param  : bool bLong
*   @return : str
*/

function bw.playtime( pl, bLong )
    local def = { h = 0, m = 0, s = 0 }
    if not helper.ok.ply( pl ) then return def end
    local playtime = pl.GetPlayTimeTable and pl:GetPlayTimeTable( ) or def
    return bw.structtime( playtime, bLong )
end

/*
*   rcc > base
*
*   base package command
*/

local function rcc_timex_base( pl, cmd, args )

    /*
    *   permissions
    */

    local ccmd = base.calls:get( 'commands', 'timex' )

    if ( ccmd.scope == 1 and not base.con:Is( pl ) ) then
        access:deny_consoleonly( pl, script, ccmd.id )
        return
    end

    if not access:bIsRoot( pl ) then
        access:deny_permission( pl, script, ccmd.id )
        return
    end

    /*
    *   output
    */

    con( pl, 1 )
    con( pl, 0 )
    con( pl, Color( 255, 255, 0 ), sf( 'Manifest » %s', pkg_name ) )
    con( pl, 0 )
    con( pl, manifest.desc )
    con( pl, 1 )

    local a1_l              = sf( '%-20s',  'Version'   )
    local a2_l              = sf( '%-5s',  '»'   )
    local a3_l              = sf( '%-35s',  sf( 'v%s build-%s', rlib.get:ver2str( manifest.version ), manifest.build )   )

    con( pl, Color( 255, 255, 0 ), a1_l, Color( 255, 255, 255 ), a2_l, a3_l )

    local b1_l              = sf( '%-20s',  'Author'    )
    local b2_l              = sf( '%-5s',  '»'          )
    local b3_l              = sf( '%-35s',  sf( '%s', manifest.author ) )

    con( pl, Color( 255, 255, 0 ), b1_l, Color( 255, 255, 255 ), b2_l, b3_l )

    con( pl, 2 )
end

/*
*   rcc > list registered timers
*
*   returns a list of registered timers within package
*/

local function rcc_timex_list( pl, cmd, args )

    /*
    *   permissions
    */

    local ccmd = base.calls:get( 'commands', 'timex_list' )

    if ( ccmd.scope == 1 and not base.con:Is( pl ) ) then
        access:deny_consoleonly( pl, script, ccmd.id )
        return
    end

    if not access:bIsRoot( pl ) then
        access:deny_permission( pl, script, ccmd.id )
        return
    end

    /*
    *   functionality
    */

    local arg_param     = args and args[ 1 ] or false
    local gcf_active    = base.calls:gcflag( 'timex_list', 'active' )

    /*
    *   bActiveOnly
    *       >  true returns only a list of active timers running
    *       >  false returns all timers registered
    */

    local bActiveOnly = false
    if ( arg_param == gcf_active ) then
        bActiveOnly = true
    end

    local res, cnt = list( bActiveOnly )

    base:console( pl, '\n' )

    local id_cat        = pkg_name or 'Unspecified'
    local id_subcat     = ccmd.title or ccmd.name or 'Unspecified'

    local i1_lbl        = sf( ' %s » %s', id_cat, id_subcat )
    local i2_lbl        = sf( '%-15s', '' )
    local i0_lbl        = sf( '%s %s', i1_lbl, i2_lbl )

    base:console( pl, Color( 255, 0, 0 ), i0_lbl )
    base:console( pl, ' -------------------------------------------------------------------------------------------' )

    helper.p_table( res )

    base:console( pl, ' -------------------------------------------------------------------------------------------' )
    base:console( pl, Color( 255, 0, 255 ), '\n Results: ' .. cnt )
    base:console( pl, '\n' )

end

/*
*   rcc > register
*/

local function rcc_register( )
    local pkg_commands =
    {
        [ pkg_name ] =
        {
            enabled     = true,
            warn        = true,
            id          = pkg_name,
            name        = pkg_name,
            desc        = 'returns package information',
            scope       = 2,
            clr         = Color( 255, 255, 0 ),
            assoc = function( ... )
                rcc_timex_base( ... )
            end,
        },
        [ pkg_name .. '_list' ] =
        {
            enabled     = true,
            warn        = true,
            id          = pkg_name .. '.list',
            name        = 'List',
            desc        = 'returns a list of registered timers',
            clr         = Color( 255, 255, 0 ),
            scope       = 2,
            flags =
            {
                [ 'active' ]    = { flag = '-a', desc = 'returns active only' },
            },
            assoc = function( ... )
                rcc_timex_list( ... )
            end,
        },
    }

    base.calls.commands:Register( pkg_commands )
end
hook.Add( pid( 'cmd.register' ), pid( '__timex.cmd.register' ), rcc_register )

/*
*   register package
*/

local function register_pkg( )
    if not istable( _M ) then return end
    base.package:Register( _M )
end
hook.Add( pid( 'pkg.register' ), pid( '__timex.pkg.register' ), register_pkg )

/*
*   module info > manifest
*/

function pkg:manifest( )
    return self.__manifest
end

/*
*   __tostring
*/

function pkg:__tostring( )
    return self:_NAME( )
end

/*
*   create new class
*/

function pkg:loader( class )
    class = class or { }
    self.__index = self
    return setmetatable( class, self )
end

/*
*   __index / manifest declarations
*/

pkg.__manifest =
{
    __index     = _M,
    name        = _NAME,
    build       = manifest.build,
    version     = manifest.version,
    author      = manifest.author,
    desc        = manifest.desc
}

pkg.__index     = pkg