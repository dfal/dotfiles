" Disalbe bell
set noerrorbells visualbell t_vb=

" Set language
set langmenu=en_US.UTF-8
"set encoding=utf-8
"set fileencoding=utf-8
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif
let $LANG = 'en_US.UTF-8'

" Backup
set backupdir=~/vimfiles/tmp,. " Backup files folder.
set directory=~/vimfiles/tmp,. " Swap files folder.

" Store session
"map <F2> :mksession! ~/vimfiles/tmp/vim_session <CR>	" Save session with F2
"map <F3> :source ~/vimfiles/tmp/vim_session <CR>	" Load session with F3

" Editor 
set shiftwidth=4	" Shift width.
set tabstop=4		" Set tabsize.  
set autoindent		" Copy indent from current line when starting a new line.  
set smartindent		" Automatically inserts one extra level of indentation.
set number		" Set line numbers.
set relativenumber
set ruler		" Show the cursor position all the time.
set laststatus=2	" Always display the status line

" Search
set incsearch
"# make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase

set history=1000
set noswapfile

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Switch between Vim window splits
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" Always use vertical diffs
set diffopt+=vertical

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
	syntax on
endif

autocmd BufEnter *.*proj :setfiletype xml

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" If a file is changed outside of vim, automatically reload it without asking
set autoread

" Prettify xml
nmap ,f :%s/>\s*</>\r</g<CR>gg=G

" Insert new line before(Shift-Enter) or after(Enter) cursor
nmap <S-Enter> O<Esc>j
nmap <CR> o<Esc>k

" -----------------------------------------------------------------------------
" Scripts section
" -----------------------------------------------------------------------------

"====[ Show when lines extend past column 80 "]================================>-<=====================

highlight ColorColumn ctermbg=magenta

function! MarkMargin (on)
    if exists('b:MarkMargin')
        try 
            call matchdelete(b:MarkMargin)
        catch /./
        endtry
        unlet b:MarkMargin
    endif
    if a:on
        let b:MarkMargin = matchadd('ColorColumn', '\%81v', 100)
    endif
endfunction

augroup MarkMargin
    autocmd!
    autocmd  BufEnter  *       :call MarkMargin(1)
    autocmd  BufEnter  *.cs*   :call MarkMargin(0)
augroup END


" -----------------------------------------------------------------------------
" Plug-in section
" -----------------------------------------------------------------------------
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" Set colorscheme for GUI
if has("gui_running")
	set background=dark
	colorscheme solarized
endif

" Toggle nerdtree with F10
map <F10> :NERDTreeToggle<CR>
" Current file in nerdtree
map <F9> :NERDTreeFind<CR>

let g:neocomplete#enable_at_startup = 1

" rust autocomplete
set hidden
let g:racer_cmd = "C:/RustWork/@racer/target/release/racer"
let $RUST_SRC_PATH="C:/RustWork/@rust/src"
