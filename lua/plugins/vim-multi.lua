return {
    {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
        local mc = require("multicursor-nvim")
        local set = vim.keymap.set

        mc.setup()

        -- Add or skip cursor above/below the main cursor.
        set({"n", "v"}, "<C-S-up>", function() mc.lineAddCursor(-1) end)
        set({"n", "v"}, "<C-S-down>", function() mc.lineAddCursor(1) end)
        set({"n", "v"}, "m<up>", function() mc.lineSkipCursor(-1) end)
        set({"n", "v"}, "m<down>", function() mc.lineSkipCursor(1) end)

        -- Add or skip adding a new cursor by matching word/selection
        set({"n", "v"}, "<leader>m", function() mc.matchAddCursor(1) end)
        set({"n", "v"}, "<leader>n", function() mc.matchSkipCursor(1) end)

        -- Add all matches in the document
        set({"n", "v"}, "<leader>A", mc.matchAllAddCursors)

        -- Rotate the main cursor.
        set({"n", "v"}, "m,", mc.nextCursor)
        set({"n", "v"}, "m.", mc.prevCursor)

        -- Delete the main cursor.
        set({"n", "v"}, "mx", mc.deleteCursor)

        -- Add and remove cursors with control + left click.
        -- set("n", "<C-leftmouse>", mc.handleMouse)

        -- Easy way to add and remove cursors using the main cursor.
        set({"n", "v"}, "mm", mc.toggleCursor)

        -- Clone every cursor and disable the originals.
        set({"n", "v"}, "mi", mc.duplicateCursors)

        set("n", "<esc>", function()
            if not mc.cursorsEnabled() then
                mc.enableCursors()
            elseif mc.hasCursors() then
                mc.clearCursors()
            else
                -- Default <esc> handler.
            end
        end)

        -- bring back cursors if you accidentally clear them
        set("n", "mr", mc.restoreCursors)

        -- Align cursor columns.
        -- set("n", "ma", mc.alignCursors)

        -- Split visual selections by regex.
        -- set("v", "S", mc.splitCursors)

        -- Append/insert for each line of visual selections.
        set("v", "I", mc.insertVisual)
        set("v", "A", mc.appendVisual)

        -- match new cursors within visual selections by regex.
        set("v", "M", mc.matchCursors)

        -- Rotate visual selection contents.
        set("v", "<leader>t",
            function() mc.transposeCursors(1) end)
        set("v", "<leader>T",
            function() mc.transposeCursors(-1) end)

        -- Jumplist support
        -- set({"v", "n"}, "<c-i>", mc.jumpForward)
        -- set({"v", "n"}, "<c-o>", mc.jumpBackward)

        -- Customize how cursors look.
        local hl = vim.api.nvim_set_hl
        hl(0, "MultiCursorCursor", { link = "Cursor" })
        hl(0, "MultiCursorVisual", { link = "Visual" })
        hl(0, "MultiCursorSign", { link = "SignColumn"})
        hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
        hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
        hl(0, "MultiCursorDisabledSign", { link = "SignColumn"})
    end,
    event = "VeryLazy"
}
}
