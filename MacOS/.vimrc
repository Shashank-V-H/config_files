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




