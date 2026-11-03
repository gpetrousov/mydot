-- This file configures global Neovim UI and diagnostic behavior

-- 1. Set the time delay for CursorHold
-- After the cursor stops moving for 500ms, the CursorHold event is triggered.
vim.opt.updatetime = 500

-- 2. Create the Autocommand to trigger the floating window
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        -- Only run this if the buffer has diagnostics
        if #vim.diagnostic.get(0) > 0 then
            -- Open a floating window with the diagnostic message under the cursor
            vim.diagnostic.open_float({
                scope = 'cursor', -- Show only diagnostics at the cursor position
                focusable = false,
                -- Define events that should immediately close the window
                close_events = { "CursorMoved", "BufHidden", "InsertCharPre" },
            })
        end
    end,
    -- Execute this only for files where an LSP is attached
    group = vim.api.nvim_create_augroup("LspFloatGroup", { clear = true }),
    pattern = { "*.rs", "*.lua", "*.py" },
})
