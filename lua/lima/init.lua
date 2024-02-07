local M = {}

M.delay = 500
M.timer = nil
M.enabled = true
M.stay_in_insert = function() return false end

function M.setup(opts)
    opts = opts or {}

    if type(opts.delay) == 'number' then
        M.delay = opts.delay
    end

    if type(opts.stay_in_insert) == 'function' then
        M.stay_in_insert = opts.stay_in_insert
    end
end

function M.enable()
    M.enabled = true
    M._restart_timer()
end

function M.disable()
    M.enabled = false
    M._stop_timer()
end

function M._restart_timer()
    if vim.fn.mode() == 'i' then
        M._stop_timer()
        M._start_timer()
    end
end

function M._start_timer()
    if not M.enabled then
        return
    end

    M.timer = vim.defer_fn(function()
        if type(M.stay_in_insert) == 'function' and M.stay_in_insert() then
            M._restart_timer()
        else
            vim.cmd('stopinsert')
        end
    end, M.delay)
end

function M._stop_timer()
    if M.timer ~= nil then
        M.timer:stop()
    end
end

vim.api.nvim_create_autocmd('ModeChanged', {
    pattern = 'n:i',
    callback = function()
        M._start_timer()
    end
})

vim.api.nvim_create_autocmd('ModeChanged', {
    pattern = 'i:*',
    callback = function()
        M._stop_timer()
    end
})

vim.on_key(function()
    M._restart_timer()
end)

return M
