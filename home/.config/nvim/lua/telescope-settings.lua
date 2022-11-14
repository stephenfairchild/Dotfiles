require('telescope').load_extension('gh')
require('telescope').load_extension('bookmarks')
require('telescope').setup {
  extensions = {
    bookmarks = {
      -- selected_browser = 'brave',
      -- url_open_command = "xdg-open",
      url_open_plugin = "vim_external",
      full_path = false,
      debug = true,
    },
  }
}
