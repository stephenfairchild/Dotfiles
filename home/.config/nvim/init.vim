fun! LoadFiles(files)
    for file in a:files
        if filereadable(expand(file))
            execute "source " . file
        endif
    endfor
endfun

" Bootstrap dotfiles {{{
    " Setup vim-plugin manager {{{
    fun! SetupVimPlug()
        " Define our install dir and add it to our runtime path
        let plugin_root_dir = expand('$HOME', 1) . '/.config/nvim/plugins'
        let &rtp .= (empty(&rtp) ? '' : ',') . plugin_root_dir.'/vim-plug'

        " Clone vim-plug if we don't have it yet
        if !isdirectory(plugin_root_dir . '/vim-plug')
            echo "***********************************"
            echo "*   First time using this init.vim   *"
            echo "* Installing vim-plug and plugins *"
            echo "***********************************"
            silent execute '!git clone --depth=1 https://github.com/junegunn/vim-plug ' shellescape(plugin_root_dir . '/vim-plug', 1)
            let g:first_run = 1
        endif

        call LoadFiles([plugin_root_dir . '/vim-plug/plug.vim'])

        call plug#begin(plugin_root_dir)
        call LoadFiles(["~/.config/nvim/bundles"])
        call plug#end()
    endfun

    call SetupVimPlug()
    " }}}

    " Install plugins on first run {{{
    if exists('g:first_run')
        PlugInstall
    endif
    " }}}

let config_files= [
    \"~/.config/nvim/config/functions",
    \"~/.config/nvim/config/environment",
    \"~/.config/nvim/config/commands",
    \"~/.config/nvim/config/mappings",
    \"~/.config/nvim/.vim.local",
\]

call LoadFiles(config_files)
