
local M = {}

-- M.on_file_open = function(name)
--     return 'require"nvchad-core.lazy_load".on_file_open("'..name..'")';
-- end
-- M.on_file_open = require"nvchad-core.lazy_load".on_file_open;

M.create_config = function(name)
    local n = "plugins.configs."..name.."";
    local r =  require(n)
    return r
    -- return function()
        -- print('asdasd', name)
        -- return require(name);
    -- end
end

M.fzf_cmds = {
    'Files',
    'GFiles',
    'Buffers',
    'Colors',
    "Ag",
    "Rg", 'Lines',
    'RLines',
}

M.eunuch_cmds = {
    'Remove',
    'Rename',
    'Delete',
    'Move',
    'Chmod',
    'Mkdir',
    'Cfind',
    'Locate',
    'Lfind',
    'Wall',
    'SudoWrite',
    'SudoEdit',
}

M.treesitter_cmds = {
  "TSInstall",
  "TSBufEnable",
  "TSBufDisable",
  "TSEnable",
  "TSDisable",
  "TSModuleInfo",
}


-- M.treesitter_cmds = require"nvchad-core.lazy_load".treesitter_cmds;
--
-- M.packer_cmds = require"nvchad-core.lazy_load".packer_cmds;

return M;
