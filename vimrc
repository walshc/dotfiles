""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle packages:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" For the plugins, first run the command below:
" git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" Then open vim and type:
" :PluginInstall

set encoding=utf-8
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'chriskempson/base16-vim'
Plugin 'edkolev/promptline.vim'
Plugin 'ervandew/supertab'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'gerw/vim-latex-suite'
Plugin 'mhinz/vim-startify'
Plugin 'gmarik/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'xolox/vim-misc'
Plugin 'vim-syntastic/syntastic'
call vundle#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General options:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax enable
filetype plugin on
filetype indent on

" Colorscheme
set t_Co=256
let base16colorspace=256
source ~/.vimrc_background
hi Normal ctermbg=none
hi NonText ctermbg=none
hi normal ctermbg=none

set mouse=a  " enable clicking with the mouse
set cul  " highlight where the cursor is"
set smartcase
set wrapscan

" For wrapped lines:
set wrap linebreak nolist
noremap <buffer> <silent> k gk
noremap <buffer> <silent> j gj
noremap <buffer> <silent> 0 g0
noremap <buffer> <silent> $ g$

set wildmode=longest,list,full
set wildmenu

" Relative line numbering
set relativenumber
set numberwidth=3

" Prevent the tar plugin from loading:
let g:loaded_tarPlugin = 1
let g:leaded_tar       = 1

" No more reaching for Esc
inoremap jk <Esc>

" No more hitting F1 by mistake
:nmap <F1> :echo<CR>
:imap <F1> <C-o>:echo<CR>

" Backspace deletes without saving it in a register
map <BS> "_d

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Make vim more similar to a standard text editor
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Save with Ctrl+S
imap <c-s> <Esc>:w<CR>i
nmap <c-s> :w<CR>

" Copying and pasting with the system clipboard (from visual mode):
noremap <C-c> "+y
inoremap <C-v> <Esc>:set paste<CR>"+p<CR><Esc>i<Esc>:set nopaste<CR>i

noremap <expr> <Home> (col('.') == matchend(getline('.'), '^\s*')+1 ? '0' : '^')
noremap <expr> <End> (col('.') == match(getline('.'), '\s*$') ? '$' : 'g_')
vnoremap <expr> <End> (col('.') == match(getline('.'), '\s*$') ? '$h' : 'g_')
imap <Home> <C-o><Home>
imap <End> <C-o><End>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Make vim use some Emacs/terminal shortcuts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
imap <C-BS> <C-W>
imap <C-b> <Left>
imap <C-f> <Right>
imap <c-a> <Esc>^i
imap <c-e> <Esc>$i
imap <C-d> <Del>
imap <C-h> <BS>
imap <C-k> <Esc>ld$i

" Tabs and hidden characters
set expandtab
set list
set listchars=tab:▸-,trail:~

" Get rid of Ex mode, enter into it too often by accident.
nnoremap Q <Nop>
" Similarly, get rid of recording mode
nnoremap q <Nop>

" Toggle on and off spell check with :call SpellCheck()
function! SpellCheck()
  setlocal spell! spelllang=en_us
endfunction

set backspace=2  " enable backspace to delete text in insert mode

au BufEnter *.cpp,*.R,*.py,*.sh set colorcolumn=81
au BufEnter *html,*.R,*.cpp set shiftwidth=2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-airline
set laststatus=2
set ttimeoutlen=50
set noshowmode
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#hunks#enabled = 0
let g:airline_section_c = '%f'
let g:airline_section_y = ''
let g:airline_section_z = airline#section#create(['windowswap', 'linenr', 'maxlinenr', ':%3v'])
let g:airline_symbols.linenr=''
let g:airline_theme = "base16"

" vim-indent-guides
hi IndentGuidesOdd  ctermbg=blue
hi IndentGuidesEven ctermbg=green
let g:indent_guides_color_change_percent = 2

" vim-latex-suite
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_CompileRule_pdf = 'urxvt -e pdflatex %'
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
  au VimEnter * call IMAP('`1',"\\mathbbm{1}\\left\\{\\right\\}",'tex')
  au VimEnter * call IMAP('`i',"\\item ",'tex')
  au VimEnter * call IMAP('`B', '\boldsymbol{}<++>', 'tex')
  au VimEnter * call IMAP('`C', "\\mathcal{<++>}<++>",'tex')
  au VimEnter * call IMAP('`E', "\\[\n<++>\n\\]\n",'tex')
  au VimEnter * call IMAP('`P',"\\prime<++>",'tex')
  au VimEnter * call IMAP('`~',"\\widetilde{<++>}<++>",'tex')
  au VimEnter * call IMAP('DEI',"\\item[<++>]<++>",'tex')
  au VimEnter * call IMAP('EFE', "\\begin{frame}{<++>}\<CR>\<++>\<CR>\\end{frame}<++>",'tex')
  au VimEnter * call IMAP('||', '\left| <++> \right|<++>', "tex")
  au VimEnter * call IMAP('`|', '\multicolumn{<++>}{<++>}{<++>}<++>', "tex")
  au VimEnter * call IMAP('ICG', '\includegraphics[<++>]{<++>}<++>', "tex")
  au VimEnter * call IMAP('SSL', '\subsubsection*{<++>}<++>', "tex")
augroup END
" Need to add let g:Tex_SmartKeyQuote=0 to
" ~/.vim/bundle/vim-latex-suite/ftplugin/tex.vim

" promptline.vim
let g:promptline_preset = {
        \'a'    : [ promptline#slices#cwd() ]}

" vim-startify:
let g:startify_change_to_dir = 0

" vim-commentary
" Comment out/uncomment visual selections with 'gc'
map ,c Vgc
autocmd FileType r setlocal commentstring=#\ %s

" vim-syntastic
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "passive_filetypes": ["cpp"] }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python-specific settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufEnter *.py set shiftwidth=4
au BufEnter *.py map <F10> :w<cr>:let @+ = 'run ' . expand("%") . ''<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" R-specific settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indent only two spaces after braces
au BufEnter *.R set ft=r
" Comment out everything but the current visual selection:
au BufEnter *.R map  <F11> :<C-U>1,'<-1:s/^/# /<CR>:'>+1,$:s/^/# /<CR>
au BufEnter *.R imap <F11> <Esc>:<C-U>1,'<-1:s/^/# /<CR>:'>+1,$:s/^/# /<CR>
" " Copy the current filename (and relative path) to the clipboard and wrap it
" " with the source function:
au BufEnter *.R map  <F10> :w<cr>:let @+ = 'e("' . expand("%") . '")'<cr>
au BufEnter *.R imap <F10> <Esc>:w<cr>:let @+ = 'e("' . expand("%") . '")'<cr>i
au BufEnter *.R map  <F8> :w<cr>:let @+ = 'e("' . expand("%:p") . '")'<cr>
au BufEnter *.R imap <F8> <Esc>:w<cr>:let @+ = 'e("' . expand("%:p") . '")'<cr>i
" Copy the file path of the current directory and wrap it with setwd():
au BufEnter *.R map  ,p :let @+ = 'setwd("' . getcwd() . '")'<cr>
au BufEnter *.R imap ,p <Esc>:let @+ = 'setwd("' . getcwd() . '")'<cr>i
au BufEnter *.R set formatoptions+=r
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
" LaTeX-specific options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " Compile with F2 (works in both normal and insert mode)
au BufEnter *.tex set ft=tex
au BufEnter *.tex imap <F2> <Esc>:w<cr><leader>ll
au BufEnter *.tex  map <F2> <Esc>:w<cr><leader>ll
let g:Tex_CompileRule_pdf = 'urxvt -e latexmk --interaction=nonstopmode --synctex=1 -pdflatex="pdflatex % %S" -pdf $*; latexmk -c %'
au BufEnter *.tex  map <F2> <Esc>:w<cr>:! urxvt -e pdflatex %<cr>
au BufEnter *.tex imap <F2> <Esc>:w<cr>:! urxvt -e pdflatex %<cr>
au BufEnter *.tex imap <F3> <Esc>:!nohup evince %:r.pdf >/dev/null &<CR><CR>i
au BufEnter *.tex  map <F3> <Esc>:!nohup evince %:r.pdf >/dev/null &<CR><CR>
au BufEnter *.tex imap <F10> <Esc>:w<cr>:! xelatex % <cr>
au BufEnter *.tex  map <F10> :w<cr>:! xelatex % <cr>
au BufEnter *.tex nmap j gj
au BufEnter *.tex nmap k gk
au BufEnter *.tex set shiftwidth=2
au BufEnter *.tex set tw=100000
au BufEnter *.tex set formatoptions+=t
au BufEnter *.tex setlocal spell spelllang=en_us
au BufEnter *.tex vmap <F9> :s/\. /.\r/g<cr>

" For makefiles, make sure you use tabs:
au BufEnter Makefile set tabstop=8
au BufEnter Makefile set shiftwidth=8

if has("gui_running")
  if has("win32") || has("win16")
    set guifont=Consolas:h14
  else
    set guifont=Inconsolata\ for\ Powerline\ 14
  endif
  set guioptions-=m  "remove menu bar
  set guioptions-=T  "remove toolbar
  set guioptions-=r  "remove right-hand scroll bar
  set guioptions-=L  "remove left-hand scroll bar
endif
hi Normal ctermbg=none
hi NonText ctermbg=none
hi normal ctermbg=none
