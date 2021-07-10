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
        [ 'rlib_user_gag_timed' ] =
        {
            id              = 'rlib_user_gag_timed',
            category        = 'RLib » User',
            name            = 'User » Timed Gag',
            desc            = 'Gags a player for a certain duration and then auto un-gags them',
            ulx_id          = 'ulx rlib_user_gag_timed',
            sam_id          = 'rlib_user_gag_timed',
            xam_id          = 'rlib_user_gag_timed',
            access          = 'superadmin',
            pubcmds         = { '!timedgag', '!tgag' },
            bExt            = true,
        },
        [ 'rlib_user_mute_timed' ] =
        {
            id              = 'rlib_user_mute_timed',
            category        = 'RLib » User',
            name            = 'User » Timed Mute',
            desc            = 'Mutes a player for a certain duration and then auto un-mutes them',
            ulx_id          = 'ulx rlib_user_mute_timed',
            sam_id          = 'rlib_user_mute_timed',
            xam_id          = 'rlib_user_mute_timed',
            access          = 'superadmin',
            pubcmds         = { '!timedmute', '!tmute' },
            bExt            = true,
        },
        [ 'rlib_tools_mdlv' ] =
        {
            id              = 'rlib_tools_mdlv',
            category        = 'RLib » Tools',
            name            = 'Tools » MDLV',
            desc            = 'Model viewer',
            ulx_id          = 'ulx rlib_tools_mdlv',
            sam_id          = 'rlib_tools_mdlv',
            xam_id          = 'rlib_tools_mdlv',
            access          = 'superadmin',
            pubcmds         = { '!mdlview','!mdlv' },
            bExt            = true,
        },
        [ 'rlib_tools_pco' ] =
        {
            id              = 'rlib_tools_pco',
            category        = 'RLib » Tools',
            name            = 'Tools » PCO',
            desc            = 'Player-client-optimization service',
            ulx_id          = 'ulx rlib_tools_pco',
            sam_id          = 'rlib_tools_pco',
            xam_id          = 'rlib_tools_pco',
            access          = 'superadmin',
            pubcmds         = { '!setpco' },
            bExt            = true,
        },
        [ 'rlib_rp_setjob' ] =
        {
            id              = 'rlib_rp_setjob',
            category        = 'RLib » RP',
            name            = 'RP » Set Job',
            desc            = 'Set rp job from dropdown list',
            ulx_id          = 'ulx rlib_rp_setjob',
            sam_id          = 'rlib_rp_setjob',
            xam_id          = 'rlib_rp_setjob',
            access          = 'superadmin',
            pubcmds         = { '!setjob' },
            bExt            = true,
        },
        [ 'rlib_rp_setjob_cmd' ] =
        {
            id              = 'rlib_rp_setjob_cmd',
            category        = 'RLib » RP',
            name            = 'RP » Set Job',
            desc            = 'Set rp job based on command',
            ulx_id          = 'ulx rlib_rp_setjob_cmd',
            sam_id          = 'rlib_rp_setjob_cmd',
            xam_id          = 'rlib_rp_setjob_cmd',
            access          = 'superadmin',
            pubcmds         = { '!setjobcmd' },
            bExt            = true,
        },
        [ 'rlib_rp_getjob' ] =
        {
            id              = 'rlib_rp_getjob',
            category        = 'RLib » RP',
            name            = 'RP » Get Job',
            desc            = 'Get rp job id',
            ulx_id          = 'ulx rlib_rp_getjob',
            sam_id          = 'rlib_rp_getjob',
            xam_id          = 'rlib_rp_getjob',
            access          = 'superadmin',
            pubcmds         = { '!getjob' },
            bExt            = true,
        },
        [ 'rlib_ents_pos' ] =
        {
            id              = 'rlib_ents_pos',
            category        = 'RLib » Ents',
            name            = 'RP » Ent » Pos',
            desc            = 'Get ent position',
            ulx_id          = 'ulx rlib_ents_pos',
            sam_id          = 'rlib_ents_pos',
            xam_id          = 'rlib_ents_pos',
            access          = 'superadmin',
            pubcmds         = { '!entpos' },
            bExt            = true,
        },
        [ 'rlib_ents_goto' ] =
        {
            id              = 'rlib_ents_goto',
            category        = 'RLib » Ents',
            name            = 'RP » Ent » Goto',
            desc            = 'Goto specified ent',
            ulx_id          = 'ulx rlib_ents_goto',
            sam_id          = 'rlib_ents_goto',
            xam_id          = 'rlib_ents_goto',
            access          = 'superadmin',
            pubcmds         = { '!entgoto' },
            bExt            = true,
        },
        [ 'rlib_ents_id' ] =
        {
            id              = 'rlib_ents_id',
            category        = 'RLib » Ents',
            name            = 'RP » Ent » ID',
            desc            = 'Get ent id',
            ulx_id          = 'ulx rlib_ents_id',
            sam_id          = 'rlib_ents_id',
            xam_id          = 'rlib_ents_id',
            access          = 'superadmin',
            pubcmds         = { '!entid' },
            bExt            = true,
        },
        [ 'rlib_ents_class' ] =
        {
            id              = 'rlib_ents_class',
            category        = 'RLib » Ents',
            name            = 'RP » Ent » Class',
            desc            = 'returns ent class',
            ulx_id          = 'ulx rlib_ents_class',
            sam_id          = 'rlib_ents_class',
            xam_id          = 'rlib_ents_class',
            access          = 'superadmin',
            pubcmds         = { '!entclass' },
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