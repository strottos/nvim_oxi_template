local M = {
    done_setup = false,
}

local function trim_semicolon(s) return s:sub(-1) == ";" and s:sub(1, -2) or s end

-- Load the Rust library
function load_rust_lib()
    local lib_ext = (function()
        if vim.fn.has('mac') == 1 then
            return 'dylib'
        elseif vim.fn.has('win32') == 1 then
            return 'dll'
        else
            return 'so'
        end
    end)()

    local lib_name = (function()
        if vim.fn.has('win32') == 1 then
            return 'nvim_oxi_template_rs'
        else
            return 'libnvim_oxi_template_rs'
        end
    end)()

    local plugin_root = vim.fn.fnamemodify(vim.api.nvim_get_runtime_file('lua/nvim_oxi_template/init.lua', false)[1], ':h:h:h')
    local lib_path = plugin_root .. '/target/release/' .. lib_name .. '.' .. lib_ext

    -- Check if file exists first
    local f = io.open(lib_path, "r")
    if not f then
        lib_path = plugin_root .. '/target/debug/' .. lib_name .. '.' .. lib_ext
    end

    local f = io.open(lib_path, "r")
    if not f then
        error(string.format('Rust library not found at path: %s\nMake sure to run "cargo build --release" in the plugin directory', lib_path))
    end
    f:close()

    if not string.find(package.cpath, lib_path, 1, true) then
      package.cpath = trim_semicolon(package.cpath) .. ";" .. lib_path
    end

    local ok, result = pcall(require, 'nvim_oxi_template_rs')
    if not ok then
        error(string.format("Failed to initiate Nards Rust library: %s", result))
    end

    return result
end

-- Setup function
function M.setup(opts)
    if M.done_setup then
        return
    end

    -- Load the Rust library
    rustlib = load_rust_lib()
    rustlib.example(opts)

    M.done_setup = true
end

return M
