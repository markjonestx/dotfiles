local version = vim.version()

return {
    nvim_011 = vim.fn.has('nvim-0.11') == 1,
    nvim_012 = vim.fn.has('nvim-0.12') == 1,
    profile  = ("%d.%d"):format(version.major, version.minor)
}
