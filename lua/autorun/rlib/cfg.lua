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

rlib                    = rlib or { }
local base              = rlib
local cfg               = base.settings
local mf                = base.manifest
local prefix            = mf.prefix

/*
*   Localized rlib routes
*/

local helper            = base.h
local ui                = base.i

/*
*   Localized translation func
*/

local function lang( ... )
    return base:lang( ... )
end

/*
*	language
*
*	determines language to use when translating particular strings.
*	list of available languages can be found in the lang folder or by typing the console command:
*       > rlib.languages
*
*	@type       : str
*	@default    : 'en'
*/

    cfg.lang                = 'en'

/*
*   hooks
*/

    cfg.hooks =
    {
        timers =
        {
            [ '__lib_onready_delay' ] = 1,
        }
    }

/*
*   interfaces
*/

    /*
    *   interface > rlib
    *
    *   various setting related to main rlib interface
    *
    *   :   ui.width, ui.height
    *       determines the size of the interface
    *
    *   :   binds.key1, binds.key2
    *       keys to press in order to activate interface
    */

        cfg.rlib =
        {
            ui =
            {
                width       = 333,
                height      = 495,
            },
            binds =
            {
                enabled     = true,
                key1        = 79,   -- key: shift
                key2        = 58,   -- key: comma
                chat =
                {
                    [ '!rlib' ]     = true,
                },
            },
        }

    /*
    *   interface > model viewer
    *
    *   various setting related to mviewer (model viewer) interface
    *
    *   :   ui.width, ui.height
    *       determines the size of the interface
    */

        cfg.mdlv =
        {
            ui =
            {
                width       = 1000,
                height      = 900,
            },
            binds =
            {
                enabled     = true,
                chat =
                {
                    [ '!mdlv' ]     = true,
                    [ '!mview' ]    = true,
                },
            },
        }

    /*
    *   interface > language select
    *
    *   displays the language selection interface
    *
    *   :   ui.width, ui.height
    *       determines the size of the interface
    */

        cfg.languages =
        {
            ui =
            {
                width       = 450,
                height      = 250,
            },
            binds =
            {
                enabled     = true,
                chat =
                {
                    [ '!lang' ]     = true,
                },
            },
        }

    /*
    *   interface > diag
    *
    *   displays diag interface
    */

        cfg.diag =
        {
            ui =
            {
                width       = 550,
                height      = 400,
            },
            binds =
            {
                enabled     = true,
                key1        = 79,       -- key: shift
                key2        = 48,       -- key: keypad asterisk
                chat =
                {
                    [ '!diag' ] = true,
                },
            },
        }

/*
*   services > pco [ player client optimizations ]
*
*   only works if server-side cvar 'rlib_pco 1'
*/

    cfg.pco =
    {
        hooks           = true,
        broadcast =
        {
            onjoin      = false,
        },
        binds =
        {
            enabled     = true,
            chat        =
            {
                [ '!pco' ] = true,
            },
        }
    }

/*
*   services > rdo [ render distance optimizations ]
*/

    cfg.rdo =
    {
        enabled     = false,
        drawdist    =
        {
            enabled = true,
            limits  =
            {
                ply_min = 5000,     ply_max = 5000,
                ent_min = 3000,     ent_max = 3000,
                npc_min = 1500,     npc_max = 1750,
                oth_min = 3000,     oth_max = 3000,
                wls_min = 10000,    wls_max = 10000,
            },
        },
        ents =
        {
            [ 'prop_dynamic' ]                  = true,
            [ 'prop_dynamic_override' ]         = true,
            [ 'prop_physics' ]                  = true,
            [ 'prop_physics_multiplayer' ]      = true,
            [ 'prop_physics_override' ]         = true,
            [ 'prop_ragdoll' ]                  = true,
            [ 'info_overlay' ]                  = true,
            [ 'func_lod' ]                      = true,
            [ 'func_button' ]                   = true,
            [ 'func_door' ]                     = true,
            [ 'func_door_rotating' ]            = true,
        }
    }

/*
*   welcome interface
*/

    cfg.welcome =
    {
        ticker =
        {
            clr         = Color( 120, 120, 120, 255 ),
            speed       = 1.0,
            delay       = 3,
            msgs =
            {
                'THANKS FOR USING [LIB] [VERSION]',
                '[VERSION] -- be sure to check out our links for more information!',
                'Click the servers tab to visit our other garrys mod servers.',
            }
        }
    }

/*
*   services > precaching
*/

    cfg.cache =
    {
        darkrp_mdl          = true,
        debug_listall       = false,
    }

/*
*   dialogs
*
*   dialogs help deliver important information to users on-screen using draw hooks. the properties below
*   help customize these notices.
*/

    cfg.dialogs =
    {
        mat_gradient        = 'gui/center_gradient',
        audio               = 'ambient/levels/canals/drip3.wav',
        clrs =
        {
            primary         = Color( 25, 25, 25, 255 ),
            secondary       = Color( 217, 72, 72, 255 ),
            primary_text    = Color( 255, 255, 255, 255 ),
            progress        = Color( 217, 72, 72, 255 ),
            icons           = Color( 255, 255, 255, 255 ),
        }
    }

/*
*   tips
*
*   settings related to interface tips
*/

    cfg.tips =
    {
        clrs =
        {
            outline         = Color( 55, 55, 55, 255 ),
            inner           = Color( 35, 35, 35, 255 ),
            text            = Color( 255, 255, 255, 255 ),
            utf             = 10045,
        }
    }

/*
*   ui
*/

    cfg.ui = { }

/*
*   elements
*/

    cfg.elm =
    {
        clrs =
        {
            sbar_track_v2   = Color( 43, 43, 43, 255 ),
            sbar_grip_v2    = Color( 73, 73, 73, 255 ),
            sbar_track_v3   = Color( 10, 10, 10, 50 ),
            sbar_grip_v3    = Color( 218, 134, 0, 255 ),
        }
    }

/*
*   sendcmsg
*
*   @note   : will be deprecated in a future release
*           : review new smsg table
*
*   cmessages allow for user input when a player types something in chat.
*   they attempt to inform the player about an action based on the command they enter in chat, which color
*   variants to separate data so it is more easily readable to the player.
*
*   :   tag_private
*       tag lets the player know that the message they have received is a private message.
*
*       @ex         : < [PRIVATE] [subcategory]: message >
*                   : < [PRIVATE] [module name]: Feature has been disabled >
*
*   :   tag_server
*       tag lets the player know that the message they have received is a private message.
*
*       @ex         : < [SERVER] [subcategory]: message >
*                   : < [SERVER] [module name]: Feature has been disabled >
*
*   :   clrs
*       defines the colors to use for particular segments
*
*       cat         : Gamemode or Module name
*       subcat      : Feature name
*       msg         : Standard message
*       target      : First set of data
*       target_sec  : Second set of data
*       target_tri  : Third set of data
*/

    cfg.cmsg =
    {
        tag             = 'rlib',
        tag_private     = 'PRIVATE',
        tag_server      = 'SERVER',
        tag_console     = 'CONSOLE',
        clrs =
        {
            cat         = Color( 255, 89, 0 ),          -- red / orange
            subcat      = Color( 255, 255, 25 ),        -- yellow
            msg         = Color( 255, 255, 255 ),       -- white
            target      = Color( 25, 200, 25 ),         -- green
            target_sec  = Color( 180, 20, 20 ),         -- dark red
            target_tri  = Color( 13, 134, 255 ),        -- blue
            sec         = Color( 255, 255, 25 ),        -- yellow
            tri         = Color( 255, 107, 250 ),       -- pink
            quad        = Color( 25, 200, 25 ),         -- green
        }
    }

/*
*   sendmsg
*
*   similar to cmsg which will be deprecated in the future, so we're specifying the new tables
*   now so that they can be used for future projects.
*
*   @ref    : cmsg
*/

    cfg.smsg =
    {
        id              = 'rlib',
        to_private      = 'PRIVATE',
        to_server       = 'SERVER',
        to_staff        = 'STAFF',
        to_admins       = 'ADMINS',
        to_console      = 'CONSOLE',
        to_rsay         = 'RSAY',
        to_self         = 'YOU',
        binds =
        {
            rsay        = { trigger = '#', command = '/rsay' }
        },
        clrs =
        {
            msg         = Color( 255, 255, 255 ),       -- white
            sep         = Color( 50, 50, 50, 255 ),     -- grey
            c1          = Color( 255, 89, 0 ),          -- red / orange
            c2          = Color( 255, 255, 25 ),        -- yellow
            c3          = Color( 13, 134, 255 ),        -- blue
            t1          = Color( 25, 200, 25 ),         -- green
            t2          = Color( 180, 20, 20 ),         -- dark red
            t3          = Color( 13, 134, 255 ),        -- blue
            t4          = Color( 255, 255, 25 ),        -- yellow
            t5          = Color( 255, 107, 250 ),       -- pink
            t6          = Color( 25, 200, 25 ),         -- green
        }
    }

/*
*   debug > toggle
*
*   enabled [ true ] allows for special debug returns to print in console which helps with diagnosing
*   issues with the server
*
*   you may use the alternative method provided which utilizing a concommand to activate debug mode for
*   approx. 20 minutes. automatically turns itself off after the timer has expired.
*
*   if disabled [ false ], logging system will still print message types related to errors, warnings,
*   successes, and various others, however, anything labeled as a 'debug' message type will be silenced.
*
*   :   enabled
*       determines if debug mode enabled
*
*   :   stats
*       prints server and loadtime statistics when everything has finished loading.
*
*   :   clean_threshold
*       number of files that must reside in the debug folder before a message is displayed in console to
*       clean the folder.
*
*   @assoc      : libs/rlib_core_sh.lua
*               : base:log( )
*/

    cfg.debug =
    {
        enabled             = false,
        stats               = true,
        time_default        = 300,
        clean_threshold     = 2000,
        clean_delaytime     = 30,
    }