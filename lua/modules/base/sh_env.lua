/*
*   @package        : rcore
*   @module         : base
*   @author         : Richard [http://steamcommunity.com/profiles/76561198135875727]
*   @copyright      : (c) 2018 - 2020
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
*   module data
*/

    MODULE                  = { }
    MODULE.calls            = { }
    MODULE.resources        = { }

    MODULE.enabled          = true
    MODULE.name             = 'Base'
    MODULE.id               = 'base'
    MODULE.desc             = 'base module'
    MODULE.author           = 'Richard'
    MODULE.icon             = ''
    MODULE.version          = { 2, 0, 0, 0 }
    MODULE.libreq           = { 3, 2, 0, 0 }
    MODULE.released		    = 1607993054

/*
*   content distribution
*/

    MODULE.fastdl 	        = false
    MODULE.precache         = false
    MODULE.ws_enabled 	    = false
    MODULE.ws_lst           = { }

/*
*   storage :: sh
*/

    MODULE.storage =
    {
        settings = { },
    }

/*
*   storage :: sv
*/

    MODULE.storage_sv = { }

/*
*   storage :: cl
*/

    MODULE.storage_cl = { }

/*
*   calls :: commands
*/

    MODULE.calls.commands = { }

/*
*   calls :: hooks
*/

    MODULE.calls.hooks = { }

/*
*   calls :: net
*/

    MODULE.calls.net = { }

/*
*   calls :: timers
*/

    MODULE.calls.timers = { }

/*
*   resources :: particles
*/

    MODULE.resources.ptc = { }

/*
*   resources :: sounds
*/

    MODULE.resources.snd = { }

/*
*   resources :: models
*/

    MODULE.resources.mdl = { }

/*
*   resources :: panels
*/

    MODULE.resources.pnl = { }

/*
*   permissions
*/

    MODULE.permissions =
    {
        [ 'rcore_user_gag_timed' ] =
        {
            id              = 'rcore_user_gag_timed',
            name            = 'User » Timed Gag',
            ulx_id          = 'ulx rcore_user_gag_timed',
            sam_id          = 'rcore_user_gag_timed',
            xam_id          = 'rcore_user_gag_timed',
            category        = 'RLib » User',
            desc            = 'Gags a player for a certain duration and then auto un-gags them',
            access          = 'superadmin',
            pubcmds         = { '!timedgag', '!tgag' },
            bExt            = true,
        },
        [ 'rcore_user_mute_timed' ] =
        {
            id              = 'rcore_user_mute_timed',
            name            = 'User » Timed Mute',
            ulx_id          = 'ulx rcore_user_mute_timed',
            sam_id          = 'rcore_user_mute_timed',
            xam_id          = 'rcore_user_mute_timed',
            category        = 'RLib » User',
            desc            = 'Mutes a player for a certain duration and then auto un-mutes them',
            access          = 'superadmin',
            pubcmds         = { '!timedmute', '!tmute' },
            bExt            = true,
        },
        [ 'rcore_tools_mdlv' ] =
        {
            id              = 'rcore_tools_mdlv',
            name            = 'Tools » MDLV',
            ulx_id          = 'ulx rcore_tools_mdlv',
            sam_id          = 'rcore_tools_mdlv',
            xam_id          = 'rcore_tools_mdlv',
            category        = 'RLib » Tools',
            desc            = 'Model viewer',
            access          = 'superadmin',
            pubcmds         = { '!mdlview', '!mdlviewer', '!mdlv' },
            bExt            = true,
        },
        [ 'rcore_tools_pco' ] =
        {
            id              = 'rcore_tools_pco',
            name            = 'Tools » PCO',
            ulx_id          = 'ulx rcore_tools_pco',
            sam_id          = 'rcore_tools_pco',
            xam_id          = 'rcore_tools_pco',
            category        = 'RLib » Tools',
            desc            = 'Player-client-optimization service',
            access          = 'superadmin',
            pubcmds         = { '!pcotool' },
            bExt            = true,
        },
        [ 'rcore_rp_setjob' ] =
        {
            id              = 'rcore_rp_setjob',
            name            = 'RP » Set Job',
            ulx_id          = 'ulx rcore_rp_setjob',
            sam_id          = 'rcore_rp_setjob',
            xam_id          = 'rcore_rp_setjob',
            category        = 'RLib » RP',
            desc            = 'Set rp job based on command',
            access          = 'superadmin',
            pubcmds         = { '!setjob' },
            bExt            = true,
        },
        [ 'rcore_rp_getjob' ] =
        {
            id              = 'rcore_rp_getjob',
            name            = 'RP » Get Job',
            ulx_id          = 'ulx rcore_rp_getjob',
            sam_id          = 'rcore_rp_getjob',
            xam_id          = 'rcore_rp_getjob',
            category        = 'RLib » RP',
            desc            = 'Get rp job id',
            access          = 'superadmin',
            pubcmds         = { '!getjob' },
            bExt            = true,
        },
    }

/*
*   doclick
*/

    MODULE.doclick = function( ) end

/*
*   dependencies
*/

    MODULE.dependencies =
    {

    }