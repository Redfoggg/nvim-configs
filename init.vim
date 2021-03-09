syntax on
set background=dark
set relativenumber
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set termguicolors
"set listchars=eol:$,nbsp:_,tab:>-,trail:~,extends:>,precedes:<
"set nolist
set listchars=trail:·
set list

call plug#begin()

"Basic setup, fuzzy finding, tag create and CoC.nvim
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ludovicchabant/vim-gutentags'
Plug 'guns/vim-sexp'
Plug 'jiangmiao/auto-pairs', { 'tag': 'v2.0.0' }
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-sensible'
Plug 'dense-analysis/ale'
Plug 'puremourning/vimspector'

"remove trailing whitespace
Plug 'axelf4/vim-strip-trailing-whitespace'

"python
Plug 'numirias/semshi'

"js/ts/jsx/tsx
Plug 'maxmellon/vim-jsx-pretty'
Plug 'pangloss/vim-javascript'

"c#
Plug 'OmniSharp/omnisharp-vim'
Plug 'OrangeT/vim-csharp'

"clojure
Plug 'guns/vim-clojure-highlight'
Plug 'guns/vim-clojure-static'
Plug 'kien/rainbow_parentheses.vim'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'w0rp/ale'
Plug 'Olical/conjure', { 'tag': 'v4.3.1' }

"colorscheme plugins
Plug 'romainl/Apprentice'
Plug 'srcery-colors/srcery-vim'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'larsbs/vimterial_dark'
Plug 'tomasiser/vim-code-dark'
call plug#end()

colorscheme vimterial_dark
autocmd BufEnter *.cs colorscheme deep-space
"guttentags config
let g:gutentags_generate_on_write = 1

"nerdtree and fzf maps
nmap <C-P> :FZF<CR>
nmap <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

"end and begin of the line jump bash-alike mode
inoremap <C-e> <ESC>A
inoremap <C-a> <ESC>I

"coc maps
nmap <silent> gd <Plug>(coc-definition)

"Rainbow parentheses
autocmd VimEnter *       RainbowParenthesesToggle
autocmd Syntax   clojure RainbowParenthesesLoadRound
autocmd Syntax   clojure RainbowParenthesesLoadSquare
autocmd Syntax   clojure RainbowParenthesesLoadBraces

"Ale
let g:ale_linter = {
            \'clojure':['clj-kondo', 'joker']
            \}


" Tell ALE to use OmniSharp for linting C# files, and no other linters.
let g:ale_linters = { 'cs': ['OmniSharp'] }

augroup omnisharp_commands
  autocmd!

  " Show type information automatically when the cursor stops moving.
  " Note that the type is echoed to the Vim command line, and will overwrite
  " any other messages in this space including e.g. ALE linting messages.
  autocmd CursorHold *.cs OmniSharpTypeLookup

  " The following commands are contextual, based on the cursor position.
  autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfu <Plug>(omnisharp_find_usages)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfi <Plug>(omnisharp_find_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ospd <Plug>(omnisharp_preview_definition)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ospi <Plug>(omnisharp_preview_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ost <Plug>(omnisharp_type_lookup)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osd <Plug>(omnisharp_documentation)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfs <Plug>(omnisharp_find_symbol)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfx <Plug>(omnisharp_fix_usings)
  autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
  autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

  " Navigate up and down by method/property/field
  autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
  autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)
  " Find all code errors/warnings for the current solution and populate the quickfix window
  autocmd FileType cs nmap <silent> <buffer> <Leader>osgcc <Plug>(omnisharp_global_code_check)
  " Contextual code actions (uses fzf, vim-clap, CtrlP or unite.vim selector when available)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
  autocmd FileType cs xmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
  " Repeat the last code action performed (does not use a selector)
  autocmd FileType cs nmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)
  autocmd FileType cs xmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)

  autocmd FileType cs nmap <silent> <buffer> <Leader>os= <Plug>(omnisharp_code_format)

  autocmd FileType cs nmap <silent> <buffer> <Leader>osnm <Plug>(omnisharp_rename)

  autocmd FileType cs nmap <silent> <buffer> <Leader>osre <Plug>(omnisharp_restart_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osst <Plug>(omnisharp_start_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ossp <Plug>(omnisharp_stop_server)
augroup END


let g:OmniSharp_highlight_groups = {
\ 'ClassName': 'csClass'
\}

" vimspector configs
let g:vimspector_enable_mappings='HUMAN'
nmap <Leader>di <Plug>VimspectorBalloonEval
xmap <Leader>di <Plug>VimspectorBalloonEval
