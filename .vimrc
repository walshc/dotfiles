"" For the plugins, first run the command below:
" git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" Then open vim and type:
" :PluginInstall

let hostname = substitute(system('hostname'), '\n', '', '')
set encoding=utf-8
set rtp+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'chriskempson/base16-vim'
Plugin 'itchyny/calendar.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'morhetz/gruvbox'
" Plugin 'Yggdroot/indentLine'
Plugin 'nanotech/jellybeans.vim'
Plugin 'vim-scripts/mayansmoke'
Plugin 'tomasr/molokai'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-scripts/R.vim'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'edkolev/promptline.vim'
Plugin 'ervandew/supertab'
Plugin 'godlygeek/tabular'
Bundle 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'bling/vim-bufferline'
Plugin 'tpope/vim-commentary'
Bundle 'croaky/vim-colors-github'
Plugin 'altercation/vim-colors-solarized'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'junegunn/vim-easy-align'
" Plugin 'easymotion/vim-easymotion'
Plugin 'tpope/vim-fugitive'
Plugin 'nathanaelkane/vim-indent-guides'
" Plugin 'airblade/vim-gitgutter'
Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'gerw/vim-latex-suite'
Plugin 'plasticboy/vim-markdown'
Plugin 'sickill/vim-monokai'
Plugin 'jpo/vim-railscasts-theme'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'tpope/vim-surround'
Plugin 'mhinz/vim-startify'
Plugin 'matthewtodd/vim-twilight'
Plugin 'gmarik/Vundle.vim'
Plugin 'jnurmine/Zenburn'
if hostname != "scc1"
  Plugin 'xolox/vim-colorscheme-switcher'
  Plugin 'xolox/vim-misc'
endif
call vundle#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General options:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax enable
filetype plugin on
filetype indent on
set expandtab
set shellslash
set grepprg=grep\ -nH\ $*
set smartcase
set wrapscan
set nohlsearch

set laststatus=2
set mouse=a

" For wrapped lines:
set wrap linebreak nolist
noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ g$

if !has('nvim')
  set t_Co=256
  set nocompatible
  set ttymouse=xterm2
endif
set wildmode=longest,list,full
set wildmenu

" Relative line numbering
if version >= 703
  set relativenumber
else
  set invnumber
endif
set numberwidth=3

" Prevent the tar plugin from loading:
let g:loaded_tarPlugin = 1
let g:leaded_tar       = 1

" No more reaching for Esc
inoremap jk <Esc>
inoremap <Home> <Esc>
inoremap <End> <Esc>

" Very often I miss Esc and hit F1 which opens help. Avoid this!
nmap <F1> <Esc>
imap <F1> <Esc>

" New line without entering insert mode
nmap <CR> o<Esc>

" Copying and pasting with the system clipboard (from visual mode):
noremap <C-c> "+y
set pastetoggle=<F4>
inoremap <C-v> <Esc>:set paste<CR>"+p :set nopaste<CR>i

" Delete previous word with Ctrl+Backspace
imap <C-BS> <C-W>

" Save with Ctrl+S
inoremap <c-s> <Esc>:Update<CR>

" Save in normal mode with \s:
noremap <Leader>s :update<CR>

" Backspace deletes without saving it in a register
map <BS> "_d

" Remove highlighting:
noh

" Switch tabs:
noremap <F7> :tabp<CR>
noremap <F8> :tabn<CR>
inoremap <F7> <Esc>:tabp<CR>i
inoremap <F8> <Esc>:tabn<CR>i
hi normal ctermbg=none

" Tabs and hidden characters
set expandtab
set list
set listchars=tab:▸-,trail:~

" Highlight characters exceeding 80 on one line:
highlight OverLength ctermbg=DarkMagenta ctermfg=white guibg=#592929
hi SpecialKey ctermfg=66 guifg=#649A9A

set cul  " highlight where the cursor is"

"" Get rid of Ex mode, enter into it too often by accident.
"nnoremap Q <Nop>
"" Similarly, get rid of recording mode
"nnoremap q <Nop>

" vim-airline shows the mode, no need to show it twice:
set noshowmode

" Some settings to make vim behave like a conventional text editor
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>i
noremap <expr> <Home> (col('.') == matchend(getline('.'), '^\s*')+1 ? '0' : '^')
noremap <expr> <End> (col('.') == match(getline('.'), '\s*$') ? '$' : 'g_')
vnoremap <expr> <End> (col('.') == match(getline('.'), '\s*$') ? '$h' : 'g_')
imap <Home> <C-o><Home>
imap <End> <C-o><End>


" Some emacs functionality in insert mode:
imap <C-b> <Left>
imap <C-f> <Right>
imap <c-a> <Esc>^i
imap <c-e> <Esc>$i
imap <C-d> <Del>
imap <C-h> <BS>
imap <C-k> <Esc>ld$i

" For some filetypes you want a warnign for when you go over 80 characters:
function! LongLineGuide()
  highlight OverLength ctermbg=DarkMagenta ctermfg=white guibg=#592929
  hi SpecialKey ctermfg=66 guifg=#649A9A
  match OverLength /\%81v./
endfunction

" Toggle on and off spell check with :call SpellCheck()
function! SpellCheck()
  setlocal spell! spelllang=en_us
endfunction

" Colorscheme
"colorscheme Tomorrow-Night-Eighties
" Get the same background as the terminal emulator (for transparency effects):
"hi normal ctermbg=none

" Make the comments italic except not on the BU cluster because it doesn't
" work there:
if hostname != "scc1"
  highlight Comment cterm=italic
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-airline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" badwolf, ubaryd, term, and wombat are also good themes:
let g:airline_theme                        = 'term'
let g:airline_powerline_fonts              = 1
let g:airline#extensions#whitespace#checks = []
let g:airline#extensions#hunks#enabled     = 0
let g:airline_section_c                    = '%f'
let g:airline_section_y                    = '%{bufnr("%")}'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-easy-align
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-easymotion
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
"nmap s <Plug>(easymotion-s)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
"nmap s <Plug>(easymotion-s2)

" Turn on case insensitive feature
"let g:EasyMotion_smartcase = 1

" JK motions: Line motions
"map <Leader>j <Plug>(easymotion-j)
"map <Leader>k <Plug>(easymotion-k)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-indent-guides
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

hi IndentGuidesOdd  ctermbg=blue
hi IndentGuidesEven ctermbg=green
let g:indent_guides_color_change_percent = 2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-latex-suite
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_CompileRule_pdf = 'latexmk -shell-escape --interaction=nonstopmode --synctex=1 -pdflatex="pdflatex % %S" -pdf $*; latexmk -c %'
let g:Tex_ViewRule_pdf = 'evince'
let g:tex_conceal = ""
let g:Tex_IgnoredWarnings ='
  \"Underfull\n".
  \"Overfull\n".
  \"specifier changed to\n".
  \"You have requested\n".
  \"Missing number, treated as zero.\n".
  \"There were undefined references\n".
  \"Citation %.%# undefined\n".
  \"\oval, \circle, or \line size unavailable\n"'
" Custom shortcuts
augroup MyIMAPs
  au!
  au VimEnter * call IMAP('`1',"\\mathbbm{1}\\left\\{\\right\\}<++>",'tex')
  au VimEnter * call IMAP('`i',"\\item <++>",'tex')
  au VimEnter * call IMAP('`B', '\boldsymbol{<++>}<++>', 'tex')
  au VimEnter * call IMAP('`C', "\\mathcal{<++>}<++>",'tex')
  au VimEnter * call IMAP('`E', "\\mathbb{<++>}<++>",'tex')
  au VimEnter * call IMAP('`P',"\\prime<++>",'tex')
  au VimEnter * call IMAP('`~',"\\widetilde{<++>}<++>",'tex')
  au VimEnter * call IMAP('DEI',"\\item[<++>]<++>",'tex')
  au VimEnter * call IMAP('EFE', "\\begin{frame}{<++>}\<CR>\<++>\<CR>\\end{frame}<++>",'tex')
  au VimEnter * call IMAP('||', '\left| <++> \right|<++>', "tex")
  au VimEnter * call IMAP('`|', '\multicolumn{<++>}{<++>}{<++>}<++>', "tex")
  au VimEnter * call IMAP('ICG', '\includegraphics[<++>]{<++>}<++>', "tex")
  au VimEnter * call IMAP('SSL', '\subsubsection*{<++>}<++>', "tex")
augroup END
" Note: Need to add let g:Tex_SmartKeyQuote=0 to
" ~/.vim/bundle/vim-latex-suite/ftplugin/tex.vim


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" calendar.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn this on with :Calendar
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" rainbow_parentheses:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

let g:rbpt_colorpairs = [
  \ ['brown',       'RoyalBlue3'],
  \ ['Darkblue',    'SeaGreen3'],
  \ ['darkgray',    'DarkOrchid3'],
  \ ['darkgreen',   'firebrick3'],
  \ ['darkcyan',    'RoyalBlue3'],
  \ ['darkred',     'SeaGreen3'],
  \ ['darkmagenta', 'DarkOrchid3'],
  \ ['brown',       'firebrick3'],
  \ ['gray',        'RoyalBlue3'],
  \ ['cyan',        'SeaGreen3'],
  \ ['darkmagenta', 'DarkOrchid3'],
  \ ['Darkblue',    'firebrick3'],
  \ ['darkgreen',   'RoyalBlue3'],
  \ ['darkcyan',    'SeaGreen3'],
  \ ['darkred',     'DarkOrchid3'],
  \ ['red',         'firebrick3'],
  \ ]

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-startify:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" If you want a custom message uncomment this (it looks stupid though):
"let g:startify_custom_header =
"  \ map(split(system('fortune | cowsay'), '\n'), '"   ". v:val') + ['','']
let g:startify_change_to_dir = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-markdown
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vim_markdown_folding_disabled=0
let g:vim_markdown_math=1
let g:vim_markdown_frontmatter=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nerdtree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Handy file browser (Ctrl+P is better though):
noremap <F5> :NERDTreeToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-colorscheme-switcher
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle between colorschemes with Ctrl+F8 and Shift+F8:
let g:colorscheme_switcher_define_mappings=0
map <S-F9> :NextColorScheme<CR>
map <S-F8> :PrevColorScheme<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-commentary
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Comment out/uncomment visual selections with 'gc'
map ,c Vgc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-latex-live-preview
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Compile LaTeX as you type for a live preview. Start with :LLPStartPreview
let g:livepreview_previewer = 'evince'









""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype-specific options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""








""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" C-specific settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufEnter *.c set shiftwidth=2
" Compile for use in R with F2:
au BufEnter *.c map <F2> :w<cr>:! R CMD SHLIB %<cr>
au BufEnter *.c imap <F2> <Esc>:w<cr>:! R CMD SHLIB %<cr>
au BufEnter *.c let g:airline#extensions#tabline#enabled = 1
au BufEnter *.c call LongLineGuide()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" C++-specific settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:cpp_class_scope_highlight = 1
au BufEnter *.cpp set shiftwidth=2
au BufEnter *.cpp let g:airline#extensions#tabline#enabled = 1
au BufEnter *.cpp call LongLineGuide()
au BufEnter *.h set shiftwidth=2
au BufEnter *.h let g:airline#extensions#tabline#enabled = 1
au BufEnter *.h call LongLineGuide()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Stata-specific settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indent only two spaces after braces
au BufEnter *.do set shiftwidth=2
au BufEnter *.do let g:airline#extensions#tabline#enabled = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" HTML-specific settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufEnter *.html set shiftwidth=2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Markdown-specific settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Convert to html with F2:
au BufEnter *.md set ft=markdown
au BufEnter *.md map  <F2> <Esc>:w<cr>:!  markdown % > %:r.html<cr><cr>
au BufEnter *.md imap <F2> <Esc>:w<cr>:!  markdown % > %:r.html<cr><cr>
au BufEnter *.md imap <F3> <Esc>:!nohup evince %:r.pdf &<CR><CR>
au BufEnter *.md  map <F3> <Esc>:!nohup evince %:r.pdf &<CR><CR>
au BufEnter *.md map  <F9> <Esc>:w<cr>:!  pandoc -S % -o  %:r.pdf<cr><cr>
au BufEnter *.md imap <F9> <Esc>:w<cr>:!  pandoc -S % -o  %:r.pdf<cr><cr>
au BufEnter *.md map  <F10> <Esc>:w<cr>:! markdown-pdf % -o  %:r.pdf<cr><cr>
au BufEnter *.md imap <F10> <Esc>:w<cr>:! markdown-pdf % -o  %:r.pdf<cr><cr>

au BufEnter *.md nmap j gj
au BufEnter *.md nmap k gk

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python-specific settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufEnter *.py set shiftwidth=4
au BufEnter *.py let g:airline#extensions#tabline#enabled = 1
au BufEnter *.py call LongLineGuide()
au BufEnter *.py map <F10> :w<cr>:let @+ = 'execfile("' . expand("%") . '")'<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" R-specific settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indent only two spaces after braces
au BufEnter *.R set shiftwidth=2
au BufEnter *.R set ft=r
autocmd FileType r setlocal commentstring=#\ %s
" Comment out everything but the current visual selection:
au BufEnter *.R map  <F11> :<C-U>1,'<-1:s/^/# /<CR>:'>+1,$:s/^/# /<CR>
au BufEnter *.R imap <F11> <Esc>:<C-U>1,'<-1:s/^/# /<CR>:'>+1,$:s/^/# /<CR>
" Copy the current filename (and relative path) to the clipboard and wrap it
" with the source function:
au BufEnter *.R map  <F10> :w<cr>:let @+ = 'e("' . expand("%") . '")'<cr>
au BufEnter *.R imap <F10> <Esc>:w<cr>:let @+ = 'e("' . expand("%") . '")'<cr>i
" Copy the file path of the current directory and wrap it with setwd():
au BufEnter *.R map  ,p :let @+ = 'setwd("' . getcwd() . '")'<cr>
au BufEnter *.R imap ,p <Esc>:let @+ = 'setwd("' . getcwd() . '")'<cr>i
au BufEnter *.R let g:airline#extensions#tabline#enabled = 1
au BufEnter *.R set formatoptions+=r
au BufEnter *.R call LongLineGuide()
au BufNewFile *.R 0r ~/Dropbox/dotfiles/R-template

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Rd-specific settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufEnter *.Rd map  <F10> <Esc>:w<cr>:! R CMD Rdconv % -t html > %:r.html<cr><cr>
au BufEnter *.Rd imap <F10> <Esc>:w<cr>:! R CMD Rdconv % -t html > %:r.html<cr><cr>
au BufEnter *.Rd map  <F11> <Esc>:w<cr>:! R CMD Rd2pdf % --force -i %:r.pdf<cr>
au BufEnter *.Rd imap <F11> <Esc>:w<cr>:! R CMD Rd2pdf % --force -i %:r.pdf<cr>
au BufEnter *.Rd call LongLineGuide()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Rnw-specific settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ToggleKnitrFiletype()
  let currentFT = &filetype
  if currentFT == "tex"
    set ft=r
    set syntax=rnoweb
  else
    set ft=tex
    set syntax=rnoweb
  endif
  echo "Setting filetype to" &filetype "and syntax to" &syntax
endfunction

function! KnitrComment()
  let currentFT = &filetype
  if currentFT == "tex"
    s/^/%/
  elseif currentFT == "r"
    s/^/#/
  endif
endfunction

function! KnitrUncomment()
  let currentFT = &filetype
  if currentFT == "tex"
    s/^%/
  elseif currentFT == "r"
    s/^#/
  endif
endfunction

" Start off in tex mode with rnoweb syntax:
au BufEnter *.Rnw set ft=tex
au BufEnter *.Rnw set syntax=rnoweb
" Toggle between R and LaTeX (for indentation and macros) with F11:
au BufEnter *.Rnw map  <F11> <Esc>:call ToggleKnitrFiletype()<CR>
au BufEnter *.Rnw imap <F11> <Esc>:call ToggleKnitrFiletype()<CR>i
" Knit and compile pdf with latexmk (see .Rprofile for klatex function)
au BufEnter *.Rnw map  <F10> <Esc>:w<cr>:!R -e 'klatex("%")'<cr>

au BufEnter *.Rnw imap <F10> <Esc>:w<cr>:!R -e 'klatex("%")'<cr><cr>i
" View pdf with F3:
au BufEnter *.Rnw map  <F3> <Esc>:!nohup evince %:r.pdf & <cr><cr>
au BufEnter *.Rnw imap <F3> <Esc>:!nohup evince %:r.pdf & <cr><cr>i
" Comment out and uncomment sections in visual mode:
au BufEnter *.Rnw map ,c :call KnitrComment()<cr>:noh<CR>
au BufEnter *.Rnw map ,u :call KnitrUncomment()<cr>:noh<CR>
au BufEnter *.Rnw call LongLineGuide()
au BufEnter *.Rnw set tw=79
au BufEnter *.Rnw set shiftwidth=2
au BufNewFile *.Rnw 0r ~/Dropbox/.dotties/Rnw-template

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASH-specific options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufEnter *.sh call LongLineGuide()
au BufEnter *.sh set tw=79

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TeX-specific options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Compile with F2 (works in both normal and insert mode)
au BufEnter *.tex set ft=tex
au BufEnter *.tex imap <F2> <Esc>:w<cr><leader>ll
au BufEnter *.tex  map <F2> <Esc>:w<cr><leader>ll
au BufEnter *.tex imap <F1> <Esc>
au BufEnter *.tex  map <F1> <Esc>
au BufEnter *.tex imap <F3> <Esc>:!nohup evince %:r.pdf >/dev/null &<CR><CR>i
au BufEnter *.tex  map <F3> <Esc>:!nohup evince %:r.pdf >/dev/null &<CR><CR>
au BufEnter *.tex imap <F10> <Esc>:w<cr>:! xelatex % <cr>
au BufEnter *.tex  map <F10> :w<cr>:! xelatex % <cr>
" Navigate up through wrapped lines
au BufEnter *.tex nmap j gj
au BufEnter *.tex nmap k gk
au BufEnter *.tex set shiftwidth=2
au BufEnter *.tex set tw=79
au BufEnter *.tex set formatoptions+=t
"au BufEnter *.tex setlocal spell spelllang=en_us


" For makefiles, make sure you use tabs:
au BufEnter Makefile set tabstop=8
au BufEnter Makefile set shiftwidth=8

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GUI settings:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("gui_running")
  if has("win32") || has("win16")
    set guifont=Consolas:h14
  else
    "set guifont=Liberation\ Mono\ 14
    set guifont=Inconsolata\ for\ Powerline\ 16
  endif
  "set bg=light
  colorscheme github
  let g:airline_theme = 'base16'
  set guioptions-=m  "remove menu bar
  set guioptions-=T  "remove toolbar
  set guioptions-=r  "remove right-hand scroll bar
  set guioptions-=L  "remove left-hand scroll bar
endif

let emulator=substitute(system('echo $EMULATOR'), '\n', '', '')
set bg=light
colorscheme solarized
" hi normal ctermbg=none
let g:airline_theme = 'solarized'
" if emulator == "gnome-terminal-server"
"   colorscheme Tomorrow
"   set bg=light
"   let g:airline_theme = 'tomorrow'
" endif
" if emulator == "urxvt"
"   colorscheme Tomorrow
"   set bg=light
"   let g:airline_theme = 'tomorrow'
" endif
" if emulator == "85x24"
"   colorscheme Tomorrow
"   set bg=light
"   let g:airline_theme = 'tomorrow'
" endif
" if emulator == "xfce4-terminal"
"   set bg=light
"   colorscheme Tomorrow
"   let g:airline_theme = 'tomorrow'
" endif
