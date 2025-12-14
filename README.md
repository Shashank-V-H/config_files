# Follow the Instructions to set things up in your respective OS 
# MacOS
- Generally zsh is used as a default shell are so the script is written according to the zsh.
## Vim config 
### Step 1: Install Vim
- Install vim with the whatever plugin manager you have.
> [!NOTE]
> make sure to choose plugin manager which downloads the latest version of whatever you download 
### Step 2: Install vim-plug (plugin manager to download vim packages)
- The below line will download the latest version of plug.vim file from vim-plug git-hub directory and places it in `~/.vim/autoload/` directory.
```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
### Step 3: Create (If not created before)/Update the ~/.vimrc to make use of the plug.vim to install packages and use them 

- If you want to just set up vim-plug and make configuration of your own below is the basic script for that, just Paste it in ~/.vimrc file. if you want to use my config you can find that in next point.
```bash
call plug#begin('~/.vim/plugged')
Plug 'aperezdc/vim-template'
call plug#end()
```
- My Config (latest can be found in MacOS/.vimrc under this repo)
```bash

" ====================================
" Plugins
" ====================================
call plug#begin('~/.vim/plugged')
Plug 'aperezdc/vim-template'               " Template support
Plug 'junegunn/fzf'                        " Fuzzy finder
Plug 'junegunn/fzf.vim'
Plug 'christoomey/vim-tmux-navigator'      " Seamless navigation between Vim and Tmux
call plug#end()

" ====================================
" General Settings
" ====================================
set relativenumber                        " Show relative line numbers
syntax on                                 " Enable syntax highlighting
set smartindent                          " Automatically indent new lines
colorscheme default                      " Set color scheme
set bg=dark                              " Use a dark background
set tabstop=4                            " Tab size is 4 spaces
set softtabstop=4
set shiftwidth=4
set cursorline                           " Highlight the current cursor line
hi CursorLine gui=underline cterm=underline
set laststatus=2                         " Enable status bar
set mouse=a                              " Enable mouse support
set undofile                             " Enable persistent undo
set undodir=~/.vim/undodir
set complete+=kspell                     " Enable spell checking
" let g:template_autocmd = 0            " Disable automatic template insertion if needed

" ====================================
" Leader Key
" ====================================
let mapleader = " "                      " Set leader key to ','

" ====================================
" Key Mappings
" ====================================
" Escape insert mode using 'kj'
inoremap kj <Esc>

" Smooth scrolling
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap <C-f> <C-f>zz
nnoremap <C-b> <C-b>zz

" Search navigation
nnoremap n nzzzv
nnoremap N Nzzzv

" Buffer and tab navigation
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>
nnoremap <S-h> :tabprevious<CR>
nnoremap <S-l> :tabnext<CR>
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>
nnoremap <leader>to :tabonly<CR>
" Open Lex and immediately resize the window
nnoremap <Leader>e :Lex<CR> : vertical resize 20<CR>

" Fuzzy search navigation
nnoremap <leader>f :Files<CR>
nnoremap <leader>g :GFiles<CR>
" Map <leader>sb to fuzzy search in the current buffer
nnoremap <leader>sb :BLines<CR>

" Tmux navigator mappings
let g:tmux_navigator_no_mappings = 1
nnoremap <C-h> :TmuxNavigateLeft<CR>
nnoremap <C-j> :TmuxNavigateDown<CR>
nnoremap <C-k> :TmuxNavigateUp<CR>
nnoremap <C-l> :TmuxNavigateRight<CR>
nnoremap <C-\> :TmuxNavigatePrevious<CR>

" ====================================
" Visual Feedback and Highlighting
" ====================================
" Enable system clipboard support
set clipboard=unnamedplus

" Yank to clipboard mappings for visual feedback
augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=200}
augroup END

" Optional: Add shortcuts for clipboard operations
" Yank to clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
" Paste from clipboard
nnoremap <leader>p "+p
vnoremap <leader>p "+p
" Cut (delete) to clipboard
nnoremap <leader>d "+d
vnoremap <leader>d "+d

" ====================================
" Template and Automation
" ====================================
" ====================================
" Template and Automation
" ====================================
" most efficient one last updated"
function! InsertTemplate()
  " Define the template directory.
  let template_dir = expand('~/.vim/plugged/vim-template/templates/my_templates/')

  " Use find and fzf to select a template.
  let file = system("find " . shellescape(template_dir) . " -type f | fzf")
  if empty(file)
    echo "No template selected."
    return
  endif

  " Trim any trailing whitespace/newline from the file path.
  let file = trim(file)

  " Insert the template at the current cursor position.
  execute "r " . fnameescape(file)

  " Force a redraw to update the screen.
  redraw!
endfunction

" Map <leader>t to call the InsertTemplate function.
nnoremap <leader>t :call InsertTemplate()<CR>


" function! LoadTemplate()
"     let template_dir = expand('~/.vim/plugged/vim-template/templates/')
"     let file = system("find " . template_dir . " -type f | fzf")
"     if !empty(file)
"         execute "0r " . file
"     endif
" endfunction

" nnoremap <leader>t :call LoadTemplate()<CR>


" failed function
" function! LoadTemplate()
"     let template_dir = expand('~/.vim/plugged/vim-template/templates/')
"     " Run fzf directly on the files in the template directory
"     let file = fzf#run({'source': glob(template_dir . '*', 0, 1), 'sink': 'e'})
"     " If a file was selected, insert it at the cursor position
"     if !empty(file)
"         " Open the file contents and insert at the cursor
"         call append(line('.'), readfile(file))
"     endif
" endfunction
"
" nnoremap <leader>t :call LoadTemplate()<CR>
"

" ====================================
" " calling saved Templates directly through call function
" " ====================================
"
" for loading main cpp with call function in vim command mode
function ForCppMain()
   :read ~/.vim/templates/main.cpp
endfunction

" ====================================
" End of all template function
" ====================================


" ====================================
" Custom Commands
" ====================================
command! InsertDate execute ":%s/%DATE%/" . strftime('%dth %B %Y') . "/g"

" ====================================
" C++ and python3 Compilation Shortcuts
" ====================================
" below uses the separate names binary file instead of a.out
" autocmd FileType cpp nnoremap <S-i> :w<CR>:!g++ -std=c++17 % -o %:r && ./%:r<CR>
"
" screen is not cleared appends the output instead of clearing
" autocmd FileType cpp nnoremap <S-i> :w<CR>:!g++ -std=c++17 % -o a.out && ./a.out<CR>
" autocmd FileType cpp nnoremap <S-u> :w<CR>:!g++ -std=c++17 % -o a.out && ./a.out < input.txt > output.txt<CR>
"
" below works properly but i introduced another method for Shit y command 
" autocmd FileType cpp nnoremap <S-y> :w<CR>:!clear; g++ -std=c++17 % -o a.out && ./a.out<CR>
autocmd FileType cpp nnoremap <S-u> :w<CR>:!clear; g++ -std=c++17 % -o a.out && ./a.out < input.txt > output.txt<CR>

autocmd FileType cpp nnoremap <S-y> :w<CR>:call RunInTmuxSidePane()<CR>

function! RunInTmuxSidePane()
  " Split the tmux window vertically (side pane)
  silent !tmux split-window -h


  " Compile, run, and then prompt to close with proper escaping for zsh
  silent !tmux send-keys "zsh -c 'echo \"\n\";g++ -std=c++17 % -o a.out && ./a.out; echo \"\n\";echo \"completed\"; read; tmux kill-pane'" C-m
endfunction

autocmd FileType cpp nnoremap <S-y> :w<CR>:call RunInTmuxSidePane()<CR>

autocmd FileType python nnoremap <S-y> :w<CR>:call RunPythonInTmuxSidePane()<CR>

function! RunPythonInTmuxSidePane()
  " Split the tmux window vertically (side pane)
  silent !tmux split-window -h

  " Run the Python script and prompt to close with proper escaping for zsh
  silent !tmux send-keys "zsh -c 'echo \"\n\"; python3 %; echo \"\n\"; echo \"completed\"; read; tmux kill-pane'" C-m
endfunction



autocmd FileType python nnoremap <S-u> :w<CR>:!clear; python3 % < input.txt > output.txt<CR>



" ====================================
" Task Macro
" ====================================
let @m = "0f[lrxddG$pgg10j"                 " Macro to mark task as complete and move it above the '---' line
nnoremap <leader>td @m
"
"
"
"
"
" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ OLD SETUP ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" " plug for templates
" call plug#begin('~/.vim/plugged')
" Plug 'aperezdc/vim-template'
" Plug 'junegunn/fzf'
" Plug 'junegunn/fzf.vim'
" Plug 'christoomey/vim-tmux-navigator'
" call plug#end()
"
" " Disable automatic template insertion
" " let g:template_autocmd = 0
"
" " Key mapping to escape insert mode using 'kj'
" inoremap kj <Esc>
"
" " General settings
" set relativenumber
" syntax on
" set smartindent
" " colorscheme default
" colorscheme blue
" set bg=dark
"
" " Set tab size to 4 spaces
" set tabstop=4
" set softtabstop=4
" set shiftwidth=4
"
" " Highlight the current cursor line
" set cursorline
" hi CursorLine gui=underline cterm=underline
"
" " Yanked contents will be accessed out of vim
" " set clipboard=unnamedplus   " causes clipboard issues in vim
"
"
" " Enable status bar
" set laststatus=2
"
" " Add spell checking dictionary support
" set complete+=kspell
"
" " ============================
" " Macro to mark task as complete and move it above the '---' line
" " let @m = "0f[lrxVddGkPggj"
" let @m="0f[lrxddG$pgg"
"
" " Map the macro to <leader>td for easy execution
" nnoremap <leader>td @m
"
"
" function! LoadTemplate()
"     let template_dir = expand('~/.vim/plugged/vim-template/templates/')
"     let file = system("find " . template_dir . " -type f | fzf")
"     if !empty(file)
"         execute "0r " . file
"     endif
" endfunction
"
"
" nnoremap <leader>t :call LoadTemplate()<CR>
"
"
" " augroup MarkdownTemplate
" "     autocmd!
" "     autocmd BufNewFile *.md execute "normal! gg/^%DATE%<CR>\"_diw" | execute "normal! i" . strftime("**%d %B %Y**") . "\<Esc>"
" " augroup END
" "
" command! InsertDate execute ":%s/%DATE%/" . strftime('%dth %B %Y') . "/g"
"
"
" " Map <F5> to compile and run C++ code in Vim, with file name
" " autocmd FileType cpp nnoremap <F5> :w<CR>:!g++ -std=c++17 % -o %:r && ./%:r<CR>
"
" " Map <F5> to compile to a.out and run C++ code in Vim
" autocmd FileType cpp nnoremap <F5> :w<CR>:!g++ -std=c++17 % -o a.out && ./a.out<CR>
"
" " Map <F9> to compile use input and output files
" autocmd FileType cpp nnoremap <F9> :w<CR>:!g++ -std=c++17 % -o a.out && ./a.out < input.txt > output.txt<CR>
"
"
" nnoremap <C-f> :Files<CR>
" nnoremap <C-g> :GFiles<CR>  " Git files
"
"
"





" ============================================= Iteration of code running in separate pane =============================================
" autocmd FileType cpp nnoremap <S-y> :w<CR>:call RunInTmuxSidePane()<CR>
"
" function! RunInTmuxSidePane()
"   " Split the tmux window vertically (side pane)
"   silent !tmux split-window -h
"
"   " Send the g++ compile and run command to the new tmux pane
"   silent !tmux send-keys 'clear; g++ -std=c++17 % -o a.out && ./a.out' C-m
"
"   " Optional: Automatically close the pane after execution
"   silent !tmux send-keys 'exit' C-m
" endfunction
"
"

" autocmd FileType cpp nnoremap <S-y> :w<CR>:call RunInTmuxSidePane()<CR>
"
" function! RunInTmuxSidePane()
"   " Split the tmux window vertically (side pane)
"   silent !tmux split-window -h
"
"   " Send the 'clear' command to the new tmux pane
"   " silent !tmux send-keys 'clear' C-m
"
"   " Send the 'g++' compile and run command to the tmux pane
"   " silent !tmux send-keys 'g++ -std=c++17 % -o a.out && ./a.out' C-m
"
"   " Send the 'g++' compile and run command to the tmux pane
"   silent !tmux send-keys 'g++ -std=c++17 % -o a.out && ./a.out' C-m
"   silent 'echo Press Enter to close; read' C-m
"
"   " Keep the pane open until user presses Enter, and then exit
"   silent !tmux send-keys 'exit' C-m
" endfunction
"
"

" autocmd FileType cpp nnoremap <S-y> :w<CR>:call RunInTmuxSidePane()<CR>
"
" function! RunInTmuxSidePane()
"   " Split the tmux window vertically (side pane)
"   silent !tmux split-window -h
"
"   " Clear the screen
"   silent !tmux send-keys 'clear' C-m
"
"   " Compile, run, and then prompt to close the pane
"   silent !tmux send-keys 'g++ -std=c++17 % -o a.out && ./a.out; echo Press Enter to close; read; tmux kill-pane' C-m
" endfunction



" autocmd FileType cpp nnoremap <S-y> :w<CR>:call RunInTmuxSidePane()<CR>
"
" function! RunInTmuxSidePane()
"   " Split the tmux window vertically (side pane)
"   silent !tmux split-window -h
"
"   " Clear the screen
"   silent !tmux send-keys 'clear' C-m
"
"   " Compile, run, and then prompt to close with a separator
"   silent !tmux send-keys 'g++ -std=c++17 % -o a.out && ./a.out; echo; echo "=========="; echo "Press Enter to close"; echo "=========="; read; tmux kill-pane' C-m
" endfunction




" autocmd FileType cpp nnoremap <S-y> :w<CR>:call RunInTmuxSidePane()<CR>
"
" function! RunInTmuxSidePane()
"   " Split the tmux window vertically (side pane)
"   silent !tmux split-window -h
"
"
"   " Compile, run, and then prompt to close with proper escaping for zsh
"   silent !tmux send-keys "zsh -c 'echo \"\n\";g++ -std=c++17 % -o a.out && ./a.out; echo \"\n\n\"; echo \"Press Enter to close\";  read; tmux kill-pane'" C-m
" endfunction
"
" autocmd FileType cpp nnoremap <S-y> :w<CR>:call RunInTmuxSidePane()<CR>

" ============================================= end Iteration of code running in separate pane =============================================
"
"
"
"

" ====================================
" Find and Replace Shortcuts
" ====================================

" Replace in the entire file (global)
nnoremap <leader>r :%s/<C-r><C-w>//g<Left><Left>

" Replace in the current line
nnoremap <leader>rl :s/<C-r><C-w>//g<Left><Left>

" Replace interactively in the file
nnoremap <leader>ri :%s/<C-r><C-w>//gc<Left><Left><Left>

" Replace interactively in the current line
nnoremap <leader>rli :s/<C-r><C-w>//gc<Left><Left><Left>


function! FlashSearch()
    let @/ = input("Flash Search: ")
    call search(@/)
endfunction

" Map 's' to Flash Search
nnoremap s :call FlashSearch()<CR>

" Define a mapping for auto-completing brackets with proper indentation
inoremap {<CR> {<CR>}<Esc>O

```
### Step 4: Install plugin
- Open vim and run the below command in vim command mode.
```vim
:PlugInstall
```
- If you used my script make sure to install the tmux with your package manager, cause some of the Commands in script should be used in tmux session to work.
<!-- TODO: Separate section will be added for tmux, which will be OS independent, the same config can be used for all the OS's when it comes to tmux (So don't worry it'll be here soon)-->
---
## Neovim Config
### Installation
- I use Lazyvim with some extra UI Themes, Templates and keybinding add-ons.
- If you want to install the plain version of Lazyvim and do the extra config by yourself, I suggest you to go through the [Lazyvim Installation guide](https://www.lazyvim.org/installation) for vanilla ("term to describe the original, unmodified, or plain version of a technology, language, application, or configuration." just for reference 😉) lazyvim installation and you can skip the remaining Nvim documentation here. You can always refer to my config if you stuck in modification.
- If you want to install my version of extra configured Lazyvim, you can do so by placing the `config_files/MacOS/nvim` directory of this repo under the `~/.config/` directory of your system.
- Hit `nvim` in terminal and you're good to go. everything is setup. In case if you want to know what extra changes i've made to the vanilla version you can refer the below.
### My changes to vanilla version of Lazyvim
- It mainly consist of these things:
  1. extra plugins i've added
  2. Creating new directory `~/.config/nvim/lua/user/` for adding custom code templates and keybindings.
- Before We move on to the plugins and templates. If you want to remap the Esc key with your custom key in nvim to toggle between command and insert mode update `~/.config/nvim/lua/config/keymaps.lua` file to do so.
  - I Personally use `kj` over `Esc`, you can use anything just replace the `kj` below with your preferred keybinding
    ```lua
    -- Here it remaps the <Esc> to kj
    vim.api.nvim_set_keymap("i", "kj", "<Esc>", { noremap = true, silent = true })
    ```
#### 1. Extra plugins I use 
- I use separate file each plugin i download under `~/.config/nvim/lua/plugins/` directory. Below are the list of files which contains the each pulgins
  1. colorscheme.lua
  2. fzf.lua
  3. tmux_navigation.lua 
  4. vim-dadbod-ui.lua 
  5. vim-run-code.lua
  6. some more are there but they are just to prettify the code, you can remove them if not needed
- you can find the contents of the above file under the `config_files/MacOS/nvim/`
#### 2. Creating new directory `~/.config/nvim/lua/user/` for adding custom code templates and keybindings.
- I created new directory `~/.config/nvim/lua/users/` for adding new key-maps to use the code templates.
- And one more directory `~/.config/nvim/lua/users/templates` for adding code templates
- Under the `templates` directory add whatever code file you want, this file contents can be inserted in some other file by using the key-binding we're about the create in next steps. 
- Next create a new file under `users` i.e., `~/.config/nvim/lua/user/init.lua` to write the logic and keybinding to use those templates.
- You can see my init.lua file containing a keymap <leader>ti which calls the function insert_template() which lists all the templates under templates/ directory using fzf.
