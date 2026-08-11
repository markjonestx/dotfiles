local function collection_yaml(path)
    if not path or path == '' then
        return
    end

    local is_ansible_workspace = vim.fs.root(path, {
        'galaxy.yml',
        'ansible.cfg',
    })

    if is_ansible_workspace then
        return 'yaml.ansible'
    end
end

vim.filetype.add({
    pattern = {
        ['.*%.yml'] = {
            collection_yaml,
            { priority = 10 },
        },
        ['.*%.yaml'] = {
            collection_yaml,
            { priority = 10 },
        },
    },
})
