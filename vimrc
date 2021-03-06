""
"" Basic Setup
""

set nocompatible                  " use vim, no vi defaults
set history=50                    " keep 50 commands and 50 search patterns in the history
set ruler                         " show line and column number
syntax on                         " turn on syntax highlighting allowing local overrides
set encoding=utf-8                " set default encoding to UTF-8
set showcmd                       " display incomplete commands
map Q gq                          " defines the "Q" command to do formatting with the "gq" operator

set clipboard=unnamed

"some stuff to get the mouse going in term
set mouse=a
set ttymouse=xterm2

map <Leader>rt :!ctags -R *<CR><CR>


""
"" Whitespace
""

set nowrap                        " don't wrap lines
set softtabstop=2                 " use mix of spaces and tabs
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs
set backspace=indent,eol,start    " backspace through everything in insert mode


""
"" Searching
""

set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter
set incsearch   " incremental searching
set hlsearch    " highlight matches with the last used search pattern


""
"" File types
""

" Some file types should wrap their text
function! s:setupWrapping()
  set wrap
  set linebreak
  set textwidth=72
  set nolist
endfunction


set autoindent            " use the indent of the previous line for a newly created line

filetype plugin indent on " turn on filetype plugins (:help filetype-plugin)

" use real tabs ...
autocmd FileType make set noexpandtab
autocmd FileType python set noexpandtab
autocmd FileType c set noexpandtab
autocmd FileType cpp set noexpandtab

" Set the Ruby filetype for a number of common Ruby files without .rb
autocmd BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,config.ru,*.rake} set filetype=ruby

" Make sure all mardown files have the correct filetype set and setup wrapping
autocmd BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown | call s:setupWrapping()

" Treat JSON files like JavaScript
autocmd BufNewFile,BufRead *.json set filetype=javascript

" Remember last location in file, but not for commit messages.
" see :help last-position-jump
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif


""
"" Wild settings
""

set wildmode=list:longest           " list all matches and complete till longest common string

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
" Ignore bundler and sass cache
set wildignore+=*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
" Disable temp and backup files
set wildignore+=*.swp,*~,._*


""
"" Backup and swap files
""

set backupdir=~/.vim/tmp/backup/    " where to put backup files.
set directory=~/.vim/tmp/swap/      " where to put swap files.


""
"" Status line
""

set laststatus=2
"set statusline=%t%(\ [%n%M]%)%(\ %H%R%W%)\ %(%c-%v,\ %l\ of\ %L,\ (%o)\ %P\ 0x%B\ (%b)%)
"set statusline=%{fugitive#statusline()}

" Start the status line
set statusline=%f\ %m\ %r

" Add fugitive if enabled
set statusline+=%{fugitive#statusline()}

" Add syntastic if enabled
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

" Finish the statusline
set statusline+=Line:%l/%L[%p%%]
set statusline+=Col:%v
set statusline+=Buf:#%n
set statusline+=[%b][0x%B]


""
"" Layout
""

if !has("gui_running")
  set t_Co=256
endif
colorscheme railscasts


""
"" Pathogen & extentions
""

exe 'source ' . expand('~/.vim/') . 'core/pathogen/autoload/pathogen.vim'
call pathogen#infect('indent')
call pathogen#infect('plugins')
call pathogen#infect('langs')


""
"" Gist
""

let g:gist_clip_command = 'pbcopy'


" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
