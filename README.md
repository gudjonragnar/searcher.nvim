# Searcher.nvim

This is a simple plugin for Neovim that allows the user to search for selected text on the internet (think Google/DuckDuckGo). I wrote it to familiarize myself with Neovim plugins so it is purely a hobby project.

## Install
To install, simply add it to the list of plugins using your plugin manager of choice. For `lazy.nvim` it would look something like this:

```lua
{
  'gudjonragnar/searcher.nvim',
  config = function() 
    require'searcher'.setup(opts | nil)
  end
}
```

### Configuration
The default search engine is Google but it also supports easy configuration for DuckDuckGo.
You can also choose some other search engine, by specifying `base_url`, as long as you they can be searched by appending the search string to the `base_url` e.g. for DuckDuckGo the `base_url` is `http://duckduckgo.com/?q=`.


| parameter  | values                   | default  |
|------------|--------------------------|----------|
| `se`       | `google` \| `duckduckgo` | `google` |
| `base_url` | nil \| string            | nil      |


## Functionality
The plugin offers two actions `Searcher` (`:lua require'searcher'.search()`) and `SearcherEdit` (`:lua require'searcher'.search_edit()`).
The former one just simply searches for what is selected by the cursor while the second allows you to edit the search before searching.

You can for example set keybindings:
```lua
vim.keymap.set('v', '<leader>ss', ':Searcher<cr>')
vim.keymap.set('v', '<leader>se', ':SearcherEdit<cr>')
```

## Caveats
The plugin makes use of the @z registry by copy-ing the last visual selection (`gv`) into the registry. In the case where you have nothing selected in visual mode it will simply search for the last visually selected text.
You can somewhat mitigate this by only setting keybinds for visual mode.
