-- GNU Style indentation
function SetGnuIndent()
    vim.bo.cindent = true
    vim.bo.cinoptions = "j1,f0,^-2,{2,>4,:4,n-2,(0,t0"
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 8
    vim.bo.expandtab = false -- Use tabs instead of spaces
    print("Switched to GNU indentation style")
end

-- Redis Style indentation
function SetRedisIndent()
    vim.bo.cindent = true
    vim.bo.cinoptions = "l1,g0"
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
    vim.bo.expandtab = true  -- Use spaces instead of tabs
    print("Switched to Redis indentation style")
end

-- Default Style indentation
function SetDefaultIndent()
    vim.bo.cindent = true
    vim.bo.cinoptions = ""
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
    vim.bo.expandtab = true
    print("Switched to default indentation style")
end

-- Create user commands
vim.api.nvim_create_user_command('IndentGNU', function()
    SetGnuIndent()
end, {})

vim.api.nvim_create_user_command('IndentRedis', function()
    SetRedisIndent()
end, {})

vim.api.nvim_create_user_command('IndentDefault', function()
    SetDefaultIndent()
end, {})
