set nu
filetype plugin on
filetype indent on

set autoread " set to auto read when a file is changed from the outside
set ruler    " always show current position
set hlsearch
set showmatch
syntax enable
set encoding=utf8
set nobackup
set nowb
set noswapfile
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set autoindent
set smartindent
set wrap
set backspace=indent,eol,start
set cursorline
set colorcolumn=120
set complete+=k
set spell
set spelloptions=camel
set dictionary+=~/.dict/aspell-en.dict

let mapleader = " "

" vim-plug
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
Plug '907th/vim-auto-save'
Plug 'vim-airline/vim-airline'
Plug 'itchyny/vim-gitbranch'
Plug 'cespare/vim-toml'
Plug 'tomasiser/vim-code-dark'
Plug 'junegunn/seoul256.vim'
Plug 'voldikss/vim-floaterm'
Plug 'ianding1/leetcode.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/rpc'  }
Plug 'zivyangll/git-blame.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'dracula/vim', { 'as': 'dracula'  }
Plug 'sonph/onehalf', { 'rtp': 'vim'  }
Plug 'bluz71/vim-moonfly-colors'
Plug 'liuchengxu/vista.vim'
Plug 'tpope/vim-commentary'
" Plug 'github/copilot.vim'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'wfxr/minimap.vim', {'do': ':!cargo install --locked code-minimap'}
call plug#end()

" display and theme
set t_Co=256
set t_ut=


let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"

if has('termguicolors') && (has('win32') || (system('uname -a | grep WSL ') == ''))
    set termguicolors
endif

let g:dracula_colorterm = 0
colorscheme dracula

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Insert <tab> when previous text is space, refresh completion if not.
inoremap <silent><expr> <TAB>
            \ coc#pum#visible() ? coc#pum#next(1):
            \ CheckBackspace() ? "\<Tab>" :
            \ coc#refresh()

inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr :<C-u>CocCommand fzf-preview.CocReferences<CR>

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

nnoremap <silent> <leader>lf :call CocAction('format')<CR>
" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <leader>la  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <leader>le  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <leader>lc  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <leader>lo  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <leader>ls  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <leader>lj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <leader>lk  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <leader>lp  :<C-u>CocListResume<CR>

" fzf configs
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'border': 'sharp'  }  }
let g:fzf_preview_use_dev_icons = 1
let g:fzf_preview_dev_icons_limit = 2000
let g:fzf_preview_history_dir = '~/.local/share/fzf-history'

" fzf short keys
nnoremap <silent><nowait> <leader>ff  :Files<CR>
nnoremap <silent><nowait> <leader>fb  :Buffers<CR>
nnoremap <silent><nowait> <leader>fw  :Rg<CR>
nnoremap <silent><nowait> <leader>gg  :FloatermNew --height=0.8 --width=0.8 lazygit<CR>

" nnoremap <silent><nowait> <leader>fr :<C-u>FzfPreviewProjectGrepRpc .<CR>

" vim auto save
let g:auto_save = 1

nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l
" config for nerdtree
let g:NERDTreeMinimalUI = 1
let g:NERDTreeWinPos = "left"
let g:NERDTreeWinSize = 30
let g:NERDTreeAutoRefresh = 0
function IsNerdtreeOpen() abort
    return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction
function! ToggleNerdtree() abort
    if IsNerdtreeOpen()
        NERDTreeToggle
    else
        NERDTreeFind
    endif
endfunction
nnoremap <silent> <leader>e :call ToggleNerdtree()<CR>
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" rust settings
let g:rustfmt_autosave = 0

" set hotkeys for floaterm
let g:floaterm_keymap_new    = '<F7>'
let g:floaterm_keymap_prev   = '<F8>'
let g:floaterm_keymap_next   = '<F9>'
let g:floaterm_keymap_toggle = '<F12>'
let g:floaterm_width         = 0.8
let g:floaterm_height        = 0.8

nnoremap <silent><nowait> <leader>tv :FloatermNew --wintype=vsplit --width=0.5<CR>

" git-blame shorkeys
nnoremap <leader>gb :<C-u>call gitblame#echo()<CR>

" no map for cr
" let g:delimitMate_expand_cr = 0
let g:AutoPairsMapCR = 0

" gitgutter
set updatetime=500

nnoremap <silent><nowait> <leader>so :so %<cr>
nnoremap <silent><nowait> <space>v :Vista<cr>

" airline configuration
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#custom_head = 'gitbranch#name'
let g:airline#extensions#ale#enabled = 1

let airline#extensions#vim9lsp#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>0 <Plug>AirlineSelectTab0
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab

set list
set listchars=trail:·,nbsp:◇,tab:│\ ,leadmultispace:\┆\ \ \ ,extends:▸,precedes:◂
" change color of SpecialKey from dracula
hi SpecialKey guifg=#959595 guibg=NONE gui=NONE cterm=NONE

" minimap
let g:minimap_width = 12
let g:minimap_auto_start = 1
let g:minimap_auto_start_win_enter = 1

" set powershell as shell
if (has('win32') || has('gui_win32')) && executable('pwsh')
    set shell=pwsh
    set shellcmdflag=-NoProfile\ -Command
    set shellquote=\"
endif

" ale config
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
