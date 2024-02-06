local path = os.getenv('PLENARY_PATH')

vim.opt.runtimepath:append(path)

vim.cmd(
    [[runtime! plugin/plenary.vim]]
)
