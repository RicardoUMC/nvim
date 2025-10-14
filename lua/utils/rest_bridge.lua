local M = {}

local function readfile(p)
    local f = io.open(p, "rb"); if not f then return nil end
    local s = f:read("*a"); f:close(); return s
end

local function decode_jsonc(s)
    -- remove BOM
    s = s:gsub("^\239\187\191", "")
    -- /* ... */ multiline comments
    s = s:gsub("/%*[%z\1-\255]-%*/", "")
    -- trailing commas
    s = s:gsub(",%s*([}%]])", "%1")
    return vim.json.decode(s)
end

local function exists(p)
    local uv = vim.uv or vim.loop
    return p ~= "" and uv and uv.fs_stat(p) or false
end

local function find_settings()
    local cwd = vim.fn.getcwd()
    local home = os.getenv("HOME") or ""
    local appdata = os.getenv("APPDATA") or ""
    local cands = {
        cwd .. "/.vscode/settings.json",

        -- VS Code (user)
        appdata ~= "" and (appdata .. "/Code/User/settings.json") or "",
        home ~= "" and (home .. "/.config/Code/User/settings.json") or "",
        home ~= "" and (home .. "/Library/Application Support/Code/User/settings.json") or "",

        -- Insiders / VSCodium (just in case)
        appdata ~= "" and (appdata .. "/Code - Insiders/User/settings.json") or "",
        home ~= "" and (home .. "/.config/Code - Insiders/User/settings.json") or "",
        home ~= "" and (home .. "/.config/VSCodium/User/settings.json") or "",
    }
    for _, p in ipairs(cands) do
        if exists(p) then return p end
    end
end

local function vars_to_dynamic_fns(vars)
    local fns = {}
    for k, v in pairs(vars) do
        fns[k] = function() return tostring(v) end
    end
    return fns
end

local function write_env_file(vars)
    local path = "./.env.rest_bridge"
    local f = io.open(path, "wb")
    if not f then
        vim.notify("rest.nvim bridge: could not create " .. path, vim.log.levels.ERROR)
        return nil
    end
    for k, v in pairs(vars) do
        -- only valid keys for dotenv: Uppercase/lowercase and _
        if k:match("^[A-Za-z_][A-Za-z0-9_]*$") then
            f:write(("%s=%s\n"):format(k, tostring(v)))
        end
    end
    f:close()
    return path
end

function M.use_vscode_rest_env(profile)
    profile = profile ~= "" and profile or "multipagos"
    local path = find_settings()
    if not path then
        vim.notify("rest.nvim bridge: VS Code settings.json not found", vim.log.levels.WARN)
        return
    end
    local content = readfile(path); if not content then return end

    local ok, cfg = pcall(decode_jsonc, content)
    if not ok or type(cfg) ~= "table" then
        vim.notify("rest.nvim bridge: error parsing settings.json", vim.log.levels.ERROR)
        return
    end

    local envs = cfg["rest-client.environmentVariables"]
    if type(envs) ~= "table" then
        vim.notify("rest.nvim bridge: 'rest-client.environmentVariables' not found in settings.json", vim.log.levels.WARN)
        return
    end

    local vars = vim.deepcopy(envs[profile] or {})
    for k, v in pairs(envs["$shared"] or {}) do
        if vars[k] == nil then vars[k] = v end
    end

    local normalized = {}
    for k, v in pairs(vars) do
        normalized[k] = v
        local unders = k:gsub("-", "_")
        if unders ~= k and normalized[unders] == nil then
            normalized[unders] = v
        end
    end
    vars = normalized

    local ok_setup, rest = pcall(require, "rest-nvim")
    if not ok_setup then
        vim.notify("rest.nvim bridge: could not load 'rest-nvim'", vim.log.levels.ERROR)
        return
    end

    rest.setup({
        custom_dynamic_variables = vars_to_dynamic_fns(vars),
    })

    -- Display the adapted variables on screen
    -- local variable_names = vim.tbl_keys(vars)
    -- vim.notify("Adpated variables: " .. table.concat(variable_names, ", "), vim.log.levels.INFO)

    local env_path = write_env_file(vars)
    if env_path then
        vim.cmd("Rest env set " .. vim.fn.fnameescape(env_path))
    else
        vim.notify("rest.nvim: could not create the environment file", vim.log.levels.ERROR)
    end
end

vim.api.nvim_create_user_command("RestUseVSCodeEnv", function(opts)
    M.use_vscode_rest_env(opts.args)
end, { nargs = "?" })

return M
