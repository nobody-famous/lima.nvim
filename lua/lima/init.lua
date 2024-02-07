local M = {}

M.delay = 500
M.timer = nil
M.enabled = true
M.do_leave_insert = function() return true end

function M.setup(opts)
    opts = opts or {}

    if type(opts.delay) == 'number' then
        M.delay = opts.delay
    end

    if type(opts.do_leave_insert) == 'function' then
        M.do_leave_insert = opts.do_leave_insert
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
        if type(M.do_leave_insert) ~= 'function' or M.do_leave_insert() then
            vim.cmd('stopinsert')
        else
            M._restart_timer()
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
