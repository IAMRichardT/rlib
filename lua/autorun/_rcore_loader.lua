/*
*   @package        : rcore
*   @module         : base
*   @author         : Richard [http://steamcommunity.com/profiles/76561198135875727]
*   @copyright      : (C) 2018 - 2020
*   @since          : 1.0.0
*   @website        : https://rlib.io
*   @docs           : https://docs.rlib.io
*   @file           : _rcore_loader.lua
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
*   data tables
*/

rcore                       = rcore or { }
rcore.autoload              = rcore.autoload or { }
rcore.sys                   = rcore.sys or { }
rcore.manifest              = rcore.manifest or { }

/*
*   rcore :: autoload :: run
*
*   execute loader for rcore
*   initializing rcore starts the following process:
*       : setup standard tables
*       : check rlib status > run rlib loader > exec rlib.autoload:Run( base )
*       : inc rcore files
*       : load rcore materials
*       : run hook 'rcore.loader.post' > rcore sh_init.lua
*
*   after this process has finished, rcore will load all modules installed and begin to process them.
*
*   @assoc  : _rcore_loader.lua
*   @usage  : rcore.autoload:Run( )
*/

function rcore.autoload:Run( )

    /*
    *   core information
    */

    local base              = rcore
    local mf                = base.manifest
    mf.name                 = 'rcore'
    mf.prefix               = 'rcore.'
    mf.folder               = 'rlib'
    mf.modpath              = 'modules'

    /*
    *   workshops
    *
    *   a list of steam workshop collection ids that are associated to this script. On server boot, these
    *   workshops will be mounted to the server both server and client-side.
    *
    *   if you wish to disable steam workshop mounting, DO NOT DO IT FROM THIS TABLE.
    *   go to the provided config file in /sh/ and simply set the Workshop property to FALSE.
    *
    *   in most cases, this table will be empty unless content needs loaded here in special circumstances.
    *   check each modules' manifest file for any custom content being loaded.
    */

    mf.workshops =
    {
        '2280180827'
    }

    /*
    *   fastdl
    *
    *   list of folders which will include materials, resources, sounds that will be included using
    *   resource.AddFile
    */

    mf.fastdl =
    {
        'materials',
        'sound',
        'resource',
    }

    /*
    *    fonts
    *
    *    a list of the custom fonts used for this script. these will be used within the Resources section
    *    in order to ensure the proper fonts are added to the server.
    *
    *    in most cases, this table will be empty unless content needs loaded here in special circumstances.
    *    check each modules' manifest file for any custom content being loaded.
    *
    *    @ex    : font.ttf
    */

    mf.fonts =
    {
        'adventpro_light',
        'astra_bold',
        'astra_regular',
        'avatarock',
        'banks_miles',
        'barlow_black',
        'barlow_bold',
        'barlow_extra_bold',
        'barlow_extra_light',
        'barlow_light',
        'barlow_medium',
        'barlow_regular',
        'barlow_semi_bold',
        'barlow_thin',
        'bebasneue_regular',
        'centauri',
        'europa_bold',
        'europa_light',
        'europa_medium',
        'europa_regular',
        'excite',
        'excite_bold',
        'fudd',
        'gamma',
        'gsym_adv',
        'gsym_black',
        'gsym_light',
        'gsym_reg',
        'gsym_solid',
        'horizon',
        'hurufo',
        'hurufo_bold',
        'hurufo_thin',
        'jupiter_regular',
        'kaorigel',
        'kaorigel_bold',
        'kepler',
        'linguineve',
        'mclaren',
        'montserrat_black',
        'montserrat_bold',
        'montserrat_extrabold',
        'montserrat_extralight',
        'montserrat_light',
        'montserrat_medium',
        'montserrat_regular',
        'montserrat_thin',
        'odin_bold',
        'odin_light',
        'odin_regular',
        'oort_black',
        'oort_bold',
        'oort_light',
        'oort_medium',
        'oort_regular',
        'orion',
        'oswald_light',
        'pavanam',
        'pollux',
        'publicsans_black',
        'publicsans_bold',
        'publicsans_extra_bold',
        'publicsans_extra_light',
        'publicsans_light',
        'publicsans_medium',
        'publicsans_regular',
        'publicsans_semi_bold',
        'publicsans_thin',
        'raleway_black',
        'raleway_bold',
        'raleway_extra_bold',
        'raleway_extra_light',
        'raleway_light',
        'raleway_medium',
        'raleway_regular',
        'raleway_semibold',
        'raleway_thin',
        'requiem',
        'roboto_bk',
        'roboto_black',
        'roboto_bold',
        'roboto_light',
        'roboto_lt',
        'roboto_medium',
        'roboto_regular',
        'roboto_th',
        'roboto_thin',
        'robotocondensed_bold',
        'robotocondensed_light',
        'robotocondensed_regular',
        'ruler',
        'ruler_bold',
        'ruler_light',
        'saira',
        'saira_black',
        'saira_bold',
        'saira_extra_bold',
        'saira_extra_light',
        'saira_light',
        'saira_medium',
        'saira_semi_bold',
        'saira_thin',
        'skeirs',
        'tasmania_expandedlight',
        'tasmania_middle',
        'tasmania_regular',
        'teko_light',
        'titillium_web_light',
        'titillium_web_thin',
        'ubuntu_bold',
        'ubuntu_light',
        'ubuntu_medium',
        'ubuntu_regular',
        'vds',
        'vds_bold',
        'vds_light',
        'vds_thin',
        'vibra',
        'xo',
    }

    /*
    *   materials
    *
    *   this is a table of materials that are to be loaded with the script related to ui.
    *   anything that can be modified via a config file will not show up here and uses
    *   a different method. These are simply materials that have no reason to be changed.
    *
    *   in most cases, this table will be empty unless content needs loaded here in special circumstances.
    *   check each modules' manifest file for any custom content being loaded.
    *
    *   @ex     : { 'mat_name', 'path/to/material.png' }
    */

    mf.materials = { }

    /*
    *   checks for rlib and initialize if not. The script will fail if rlib is not available.
    */

    base.sys.loadtime   = 0
    base.sys.modules    = { total = 0, registered = 0, err = 0, disabled = 0 }

    MsgC( Color( 255, 255, 0 ),     '\n\n[' .. mf.name .. '] Initializing rlib.\n' )
    MsgC( Color( 255, 255, 255 ),   'rlib will now load all of the required library files.\n' )

    local autoload = 'autorun/rlib/_autoloader.lua'
    if file.Exists( autoload, 'LUA' ) then
        if SERVER then
            AddCSLuaFile( autoload )
        end
        include( autoload )
        rlib.autoload:Run( base )
    else
        MsgC( Color( 255, 0, 0 ), '\n\n-----------------------------------------------------------------------------\n' )
        MsgC( Color( 255, 0, 0 ), 'FATAL ERROR \n' )
        MsgC( Color( 255, 0, 0 ), '[' .. mf.name .. '] cannot run without rlib being installed. \n' )
        MsgC( Color( 255, 0, 0 ), '-----------------------------------------------------------------------------\n\n' )
        return
    end

    /*
    *   core tables
    */

    base.modules        = { }
    base.settings       = base.settings or { }
    base.language       = base.language or { }
    base.database       = base.database or { }

    /*
    *   localized paths
    */

    local dir_home      = mf.folder
    local sf            = string.format

    /*
    *   scope ref
    *       : 1        server :: sv
    *       : 2        shared :: sh
    *       : 3        client :: cl
    *
    *   values
    *       : file     file to inc
    *       : scope    scope to add file to
    *       : seg      dir of file [ excl filename ]  [ def dir_home ]
    */

    local prio_loader =
    {
        { file = 'sh_config',   scope = 2 },
        { file = 'sh_init',     scope = 2 },
        { file = 'sv_init',     scope = 1 },
        { file = 'cl_init',     scope = 3 },
    }

    for _, v in pairs( prio_loader ) do
        if not v.file then continue end
        if not v.seg then v.seg = dir_home end

        local path_prio = sf( '%s/%s.lua', v.seg, v.file )

        if not v.scope then
            MsgC( Color( 255, 0, 0 ), '[' .. rlib.manifest.name .. '] [L] ERR: ' .. path_prio .. ' :: [ missing scope ]\n' )
            continue
        end

        if v.scope == 1 then
            if not file.Exists( path_prio, 'LUA' ) then continue end
            if SERVER then include( path_prio ) end
            if rlib.settings.debug.enabled then
                MsgC( Color( 255, 255, 0 ), '[' .. rlib.manifest.name .. '] [L-SV] ' .. path_prio .. '\n' )
            end
        elseif v.scope == 2 then
            if not file.Exists( path_prio, 'LUA' ) then continue end
            include( path_prio )
            if SERVER then AddCSLuaFile( path_prio ) end
            if rlib.settings.debug.enabled then
                MsgC( Color( 255, 255, 0 ), '[' .. rlib.manifest.name .. '] [L-SH] ' .. path_prio .. '\n' )
            end
        elseif v.scope == 3 then
            if not file.Exists( path_prio, 'LUA' ) then continue end
            if SERVER then
                AddCSLuaFile( path_prio )
            else
                include( path_prio )
            end
            if rlib.settings.debug.enabled then
                MsgC( Color( 255, 255, 0), '[' .. rlib.manifest.name .. '] [L-CL] ' .. path_prio .. '\n' )
            end
        end
    end

    /*
    *   recursive autoloader
    *
    *   do not modify the following code. it will go through each folder recursively and add any
    *   files required for this system to function properly.
    *
    *   the scope of a file will be determined by the prefix that the file starts with.
    *
    *   scope prefixes
    *       : sv_ = server
    *       : sh_ = shared
    *       : cl_ = client
    *
    *   having a file named sv_helloworld.lua will set the scope to be accessible via server only.
    *
    *   ENSURE that you do NOT set sensitive data as shared. if your file includes passwords or
    *   anything that is sensitive in data (such as MySQL auth info); use sv_ (server) ONLY.
    */

    if SERVER then

        local dir_base      = mf.folder .. '/'
        local files, dirs   = file.Find( dir_base .. '*', 'LUA' )

        for k, v in pairs( files ) do
            include( dir_base .. v )
        end

        /*
        *   recursive autoloader :: serverside client
        */

        local function inc_sv( dir_recur, id, term )
            local scope_id =
            {
                [ 1 ] = 'SV',
                [ 2 ] = 'SH',
                [ 3 ] = 'CL',
            }

            for _, File in SortedPairs( file.Find( dir_recur .. '/' .. term .. '_*.lua', 'LUA' ), true ) do
                if id == 1 or id == 2 then include( dir_recur .. '/' .. File ) end
                if id == 2 or id == 3 then AddCSLuaFile( dir_recur .. '/' .. File ) end
                if rlib.settings.debug.enabled then
                    MsgC( Color( 255, 255, 0 ), '[' .. rlib.manifest.name .. '] [L-' .. scope_id[ id ] .. '] ' .. File .. '\n' )
                end
            end
            local file_sub, dir_sub = file.Find( dir_recur .. '/' .. '*', 'LUA' )
            for l, m in pairs( dir_sub ) do
                for _, FileSub in SortedPairs( file.Find( dir_recur .. '/' .. m .. '/' .. term .. '_*.lua', 'LUA' ), true ) do
                    if id == 1 or id == 2 then include( dir_recur .. '/' .. m .. '/' .. FileSub ) end
                    if id == 2 or id == 3 then AddCSLuaFile( dir_recur .. '/' .. m .. '/' .. FileSub ) end
                    if rlib.settings.debug.enabled then
                        MsgC( Color( 255, 255, 0), '[' .. rlib.manifest.name .. '] [L-' .. scope_id[ id ] .. '] ' .. FileSub .. '\n' )
                    end
                end
            end
        end

        for _, dir in SortedPairs( dirs, true ) do
            if dir == '.' or dir == '..' then continue end
            if dir == 'modules' then continue end

            local dir_recur = dir_base .. dir
            inc_sv( dir_recur, 1, 'sv'  )
            inc_sv( dir_recur, 2, 'sh'  )
            inc_sv( dir_recur, 3, 'cl'  )
            inc_sv( dir_recur, 3, 'i'   )
        end

    end

    if CLIENT then

        local dir_base      = mf.folder .. '/'
        local _, dirs       = file.Find( dir_base .. '*', 'LUA' )

        local function inc_cl( dir_recur, id, term )
            local scope_id =
            {
                [ 2 ] = 'SH',
                [ 3 ] = 'CL',
            }

            for _, File in SortedPairs( file.Find( dir_recur .. '/' .. term .. '_*.lua', 'LUA' ), true ) do
                include( dir_base .. '/' .. File )
                if rlib.settings.debug.enabled then
                    MsgC( Color( 255, 255, 0 ), '[' .. rlib.manifest.name .. '] [L-' .. scope_id[ id ] .. '] ' .. File .. '\n' )
                end
            end
            local file_sub, dir_sub = file.Find( dir_recur .. '/' .. '*', 'LUA' )
            for l, m in pairs( dir_sub ) do
                for _, FileSub in SortedPairs( file.Find( dir_recur .. '/' .. m .. '/' .. term .. '_*.lua', 'LUA' ), true ) do
                    include( dir_base  .. '/' .. m .. '/' .. FileSub )
                    if rlib.settings.debug.enabled then
                        MsgC( Color( 255, 255, 0 ), '[' .. rlib.manifest.name .. '] [L-' .. scope_id[ id ] .. '] ' .. FileSub .. '\n' )
                    end
                end
            end
        end

        for _, dir in SortedPairs( dirs, true ) do
            if dir == '.' or dir == '..' then continue end
            if dir == 'modules' then continue end

            local dir_recur = dir_base .. dir
            inc_cl( dir_recur, 2, 'sh'  )
            inc_cl( dir_recur, 3, 'cl'  )
            inc_cl( dir_recur, 3, 'i'   )
        end

    end

    if CLIENT then
        rlib.m:register_v1( mf.materials, mf.name )
    end

    /*
    *   hook :: rcore post loader
    */

    rhook.run.rlib( 'rcore_loader_post' )

end

/*
*   rcore :: autoload
*/

rcore.autoload:Run( )