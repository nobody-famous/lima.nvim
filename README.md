# lima.nvim
Leave Insert Mode Automatically

# Configuration

Using lazy.nvim,

```
return {
    'nobody-famous/lima.nvim',

    config = function()
        require('lima').setup({
            delay = 500,
            stay_in_insert = function()
                return require('cmp').core.view:visible() or vim.fn.pumvisible() ~= 0
            end
        })
    end
}
```

If you're using a different plugin manager, well, you're smart. You'll figure it out.

The setup options is a table with two fields,

- delay - The number of milliseconds to wait before stopping insert mode

- stay_in_insert - A function that returns a boolean value
    - true - Do not stop insert mode
    - false - Stop insert mode
