" mainly inspired from http://sontek.net/blog/detail/turning-vim-into-a-modern-python-ide

filetype off
execute pathogen#infect()
call pathogen#helptags()

syntax on
filetype on
filetype plugin indent on
set hlsearch

set list
set number

" remap <leader>
let mapleader = ","

set foldmethod=indent
set foldlevel=99
colorscheme torte

"pyflakes (code checking)
let g:pyflakes_use_quickfix = 0

"supertab
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

" pydoc : <leader>pw (changeit!)

" NERDTree
map <leader>n :NERDTreeToggle<CR>

" Python-mode 
let g:pymode_folding = 0

" Ropevim
" https://github.com/peplin/ropevim !! imported from python-mode github-repo
map <leader>d :RopeGotoDefinition<CR>
map <leader>r :RopeRename<CR>
let g:ropevim_autoimport_modules = ["os", "shutil", "libvirt"]

" git fugitive
" Gblame / Gwrite / Gcommit
"XXX %{fugitive#statusline()}

" Ack (searching in project) https://github.com/mileszs/ack.vim
" need to install paclage : apt-get install ack-grep
nmap <leader>a <Esc>:Ack!

" Add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

" colorize
" https://raw.github.com/michalbachowski/vim-wombat256mod/master/colors/wombat256mod.vim
"colorscheme wombat256mod

"ctags & taglist
let Tlist_WinWidth = 50
map <F4> :TlistToggle<cr>
map <F5> :TagbarToggle<cr>
" ctags keys
" get definition under function/method  : ctrl-]
" go back to origin again to function/method call : ctrl-t
" ta / ts / tn tp / tf tl

" TOTO
" * backup history files

hi Search guibg=LightBlue

" Yaml
au BufNewFile,BufRead *.yaml,*.yml so ~/.vim/yaml.vim


" tab navigation like irssi
map <M-Left> :tabprevious<CR>
map <M-Right>   :tabnext<CR>
map <C-t>     :tabnew<CR>
imap <M-Left> <Esc>:tabprevious<CR>i
imap <M-Right>   <Esc>:tabnext<CR>i
imap <C-t>     <Esc>:tabnew<CR>i
