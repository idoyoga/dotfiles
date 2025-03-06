require("copilot").setup {
    filetypes = { "c", "cpp", "lua", "python", "javascript", "typescript" },
}

local M = {}

function M.ToggleCopilot()
    if vim.g.copilot_enabled == nil then
        vim.g.copilot_enabled = true
    end

    if vim.g.copilot_enabled then
        vim.cmd("Copilot disable")
        print("Copilot Disabled")
    else
        vim.cmd("Copilot enable")
        print("Copilot Enabled")
    end

    vim.g.copilot_enabled = not vim.g.copilot_enabled
end

return M
