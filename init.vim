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

let mapleader = " "
" why could this disable auto-completion???
" set paste " no auto comment on pasting

" vim-plug
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug '907th/vim-auto-save'
Plug 'vim-airline/vim-airline'
" Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'tomasiser/vim-code-dark'
Plug 'junegunn/seoul256.vim'
Plug 'voldikss/vim-floaterm'
Plug 'ianding1/leetcode.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'zivyangll/git-blame.vim'
Plug 'thaerkh/vim-indentguides'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'dracula/vim', { 'as': 'dracula'  }
" Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension'  }
" Plug 'sainnhe/everforest'
Plug 'sonph/onehalf', { 'rtp': 'vim'  }
Plug 'bluz71/vim-moonfly-colors'
Plug 'liuchengxu/vista.vim'
Plug 'tpope/vim-commentary'
Plug 'github/copilot.vim'
" nerdtree
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

call plug#end()

" display and theme
set t_Co=256
set t_ut=


let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"

if has('termguicolors')
    set termguicolors
endif

" seoul256_background 233 (darkest) ~ 239 (lightest)
let g:seoul256_background = 233
set background=dark
" colorscheme everforest
colorscheme dracula
" colorscheme tokyonight

" let g:airline_theme = 'dracula'

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Insert <tab> when previous text is space, refresh completion if not.
inoremap <silent><expr> <TAB>
            \ coc#pum#visible() ? coc#pum#next(1):
            \ <SID>check_back_space() ? "\<Tab>" :
            \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" " Use tab for trigger completion with characters ahead and navigate.
" " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" " other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"            \ pumvisible() ? "\<C-n>" :
"            \ <SID>check_back_space() ? "\<TAB>" :
"            \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
if has('nvim')
    inoremap <silent><expr> <c-@> coc#refresh()
else
    inoremap <silent><expr> <c-space> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> g[ <Plug>(coc-diagnostic-prev)
nmap <silent> g] <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

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

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
inoremap <silent> <C-L> <Esc>:call CocAction('format')<CR>i
nnoremap <silent> <C-L> <Esc>:call CocAction('format')<CR>

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#buffer_nr_show = 1
" set statusline^=%{coc#status()} " %{get(b:,'coc_current_function','')}

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

" fzf short keys
nnoremap <silent><nowait> <leader>ff  :Files<CR>
nnoremap <silent><nowait> <leader>fb  :Buffers<CR>
nnoremap <silent><nowait> <leader>fw  :Rg<CR>

" set coc err msg color
" highlight CocFloating ctermbg=Gray
" highlight CocFloating ctermfg=White

" vim auto save
let g:auto_save = 1

" " config for netrw
" let g:netrw_hide = 1
" let g:netrw_liststyle = 3
" " let g:netrw_banner = 0
"
" let g:netrw_browse_split = 4
" let g:netrw_winsize = 15
" " show on right
" let g:netrw_altv = 1
" let g:netrw_chgwin = 2
" let g:netrw_list_hide = '.*\.swp$'
" " let g:netrw_localrmdir = 'rm -rf'
" let g:netrw_is_open = 0
" function! ToggleNetrwVexplore()
"     if g:netrw_is_open == 0
"         let g:netrw_is_open = 1
"         silent Vexplore
"     else
"         let i = bufnr("$")
"         while i > 0
"             if (getbufvar(i, "&filetype") == "netrw")
"                 silent exe "bwipeout " . i
"             endif
"             let i -= 1
"         endwhile
"         let g:netrw_is_open = 0
"     endif
" endfunction
" nnoremap <silent> <leader>e :call ToggleNetrwVexplore()<CR>
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l
" config for nerdtree
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeWinPos = "left"
let g:NERDTreeWinSize = 30
nnoremap <silent> <leader>e :NERDTreeToggle<CR>
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif



" rust settings
let g:rustfmt_autosave = 0

" set hotkeys for floaterm
let g:floaterm_keymap_new    = '<F7>'
let g:floaterm_keymap_prev   = '<F8>'
let g:floaterm_keymap_next   = '<F9>'
let g:floaterm_keymap_toggle = '<F12>'

" git-blame shorkeys
nnoremap <leader>gb :<C-u>call gitblame#echo()<CR>
" no map for cr
" let g:delimitMate_expand_cr = 0
let g:AutoPairsMapCR = 0

" gitgutter
set updatetime=500
" donot display eol
let g:indentguides_toggleListMode = 0

" tags
" nnoremap <silent><nowait> <space>t  :Tags<CR>
" nnoremap <silent><nowait> <space>g  :BTags<CR>
" noremap <F2> :LeaderfFunction!<cr>
" inoremap <F2> <Esc>:LeaderfFunction!<cr>

nnoremap <silent><nowait> <leader>so :so %<cr>
nnoremap <silent><nowait> <space>v :Vista<cr>

