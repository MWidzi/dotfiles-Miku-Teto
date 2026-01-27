-- resize all sidebar plugins
function AutoLayout()
    local api = require 'nvim-tree.api'
    local normal_buffers = {}
    local terminal_buffers = {}
    local width = vim.o.columns
    local height = vim.o.lines

    if api.tree.is_visible() then
        local windows = vim.api.nvim_list_wins()

        for _, win in ipairs(windows) do
            local buf = vim.api.nvim_win_get_buf(win)
            local buf_name = vim.api.nvim_buf_get_name(buf)
            local buf_type = vim.api.nvim_buf_get_option(buf, 'buftype')

            vim.api.nvim_set_current_win(win)

            if buf_type == 'terminal' then
                table.insert(terminal_buffers, win)
            elseif buf_name ~= '' and (buf_type == 'nofile' or buf_type == 'nowrite') then
                vim.print(buf_name)
                vim.cmd 'wincmd K'
                if string.find(buf_name, 'diffpanel') then
                    vim.cmd 'resize 10'
                elseif string.find(buf_name, 'undotree') then
                    vim.cmd 'resize 5'
                elseif string.find(buf_name, 'NvimTree') then
                    vim.cmd 'wincmd J'
                    vim.cmd 'resize 20'
                end
            elseif buf_name ~= '' and (buf_type == '' or buf_type == 'normal') then
                vim.cmd 'wincmd L'
                normal_buffers[#normal_buffers + 1] = win
            end
        end
        vim.cmd 'wincmd 10h'
        vim.cmd 'vertical resize 30'

        if #normal_buffers > 1 then
            vim.api.nvim_set_current_win(normal_buffers[#normal_buffers])
            vim.cmd 'vertical resize 50'
        end

        if #terminal_buffers > 0 then
            vim.api.nvim_set_current_win(terminal_buffers[1])
            vim.cmd 'wincmd L'

            if #terminal_buffers > 1 then
                for i = 2, #terminal_buffers do
                    local term_buf_to_move = vim.api.nvim_win_get_buf(terminal_buffers[i])
                    vim.api.nvim_set_current_win(terminal_buffers[1])
                    vim.cmd 'split'
                    vim.api.nvim_win_set_buf(0, term_buf_to_move)
                end

                for i = 2, #terminal_buffers do
                    vim.api.nvim_win_close(terminal_buffers[i], false)
                end
            end

            vim.cmd 'wincmd 10l'
            vim.cmd 'vertical resize 35'
        end
    end
end
