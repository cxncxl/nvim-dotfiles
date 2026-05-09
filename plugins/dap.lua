vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" });

local langs = {
    "typescript",
    "javascript",
};

for _, lang in ipairs(langs) do
    require("dap").configurations[lang] = {
        {
            type = "pwa-node",
            request = "attach",
            name = "Attach to a running process",
            processId = function() require("dap.utils").pick_process({ filter = "node" }) end,
            cwd = "${workspaceFolder}",
            sourceMaps = true,
        },
    }
end
