" Plugins -------------------------------------------------------------------{{{
  " Setup dein {{{
    if (!isdirectory(expand("$HOME/.vim/nvim/repos/github.com/Shougo/dein.vim")))
      call system(expand("mkdir -p $HOME/.vim/nvim/repos/github.com"))
      call system(expand("git clone https://github.com/Shougo/dein.vim $HOME/.vim/nvim/repos/github.com/Shougo/dein.vim"))
    endif

    set runtimepath+=~/.vim/nvim/repos/github.com/Shougo/dein.vim/
    call dein#begin(expand('~/.vim/nvim'))

    call dein#add('Shougo/dein.vim')
    call dein#add('haya14busa/dein-command.vim')
    call dein#add('wsdjeg/dein-ui.vim')
  " }}}
  " System {{{
    if !has('nvim')
      call dein#add('rhysd/vim-healthcheck')                  " healthcheck polyfill for vim
    endif
    " call dein#add('itmammoth/doorboy.vim')                    " auto closing
    " call dein#add('MartinLafreniere/vim-PairTools')           " paring tools
    call dein#add('eugen0329/vim-esearch')                    " project-wide async search and replace
    call dein#add('tpope/vim-endwise')                        " automagically add end tags
    call dein#add('tpope/vim-surround')                       " suroundings
    call dein#add('tpope/vim-unimpaired')
    call dein#add('tpope/vim-repeat')
    call dein#add('AndrewRadev/switch.vim')                   " switch segments of text with predefined replacements
    call dein#add('christoomey/vim-tmux-navigator')           " vim-tmux navigation
    call dein#add('tomtom/tcomment_vim')                      " comments handling
    call dein#add('junegunn/vim-easy-align')                  " alignment handling
    call dein#add('easymotion/vim-easymotion')                " easy motion
    call dein#add('tmux-plugins/vim-tmux')                    " syntax highlighting for tmux.conf
    call dein#add('Shougo/context_filetype.vim')              " find code blocks and their filetype
    call dein#add('mhinz/vim-sayonara')                       " sane buffer/window deletion.
    call dein#add('mattn/webapi-vim')                         " interface to WEB APIs
    call dein#add('mattn/gist-vim')                           " automatic gist publication
    call dein#add('mg979/vim-visual-multi')                   " multiples cursors
    call dein#add('simnalamburt/vim-mundo')                   " vim undo tree visualizer
    if has('nvim')
      call dein#add('neovim/nvim-lsp')
      call dein#add('haorenW1025/diagnostic-nvim')
    endif
  " }}}
  " UI {{{
    call dein#add('justinmk/vim-dirvish')                     " path navigator
    call dein#add('kristijanhusak/vim-dirvish-git')           " dirvish git plugin
    call dein#add('Shougo/defx.nvim')
    call dein#add('kristijanhusak/defx-git')                  " defx git plugin
    call dein#add('kristijanhusak/defx-icons')                " defx icons
    if !has('nvim')                                           " defx vim dependendencies
      call dein#add('roxma/nvim-yarp')
      call dein#add('roxma/vim-hug-neovim-rpc')
    endif
    call dein#add('vim-airline/vim-airline')                  " airline status bar
    " call dein#add('vim-airline/vim-airline-themes')           " airline themes
    call dein#add('arcticicestudio/nord-vim')                 " nord theme
    " call dein#add('chriskempson/base16-vim')                  " base16 theme
    " call dein#add('morhetz/gruvbox')                          " gruvbox theme
    " call dein#add('rainglow/vim')                             " rainglow themes
    " call dein#add('mhartington/oceanic-next')                 " oceanic-next theme
    " call dein#add('rafi/awesome-vim-colorschemes')            " theme collection
  " }}}
  " Code Style {{{
    " call dein#add('neomake/neomake')
    call dein#add('sbdchd/neoformat')                         " code formatter
    call dein#add('editorconfig/editorconfig-vim')            " editorconfig plugin
  " }}}
  " Completion {{{
    call dein#add('Shougo/deoplete.nvim')                     " asynchronous completion framework
    call dein#add('fszymanski/deoplete-emoji')                " deoplete emoji
    call dein#add('Shougo/deoplete-lsp')                      " lsp completion source for deoplete
    if !has('nvim')                                           " deople reqiured if not nvim
      call dein#add('roxma/nvim-yarp')
      call dein#add('roxma/vim-hug-neovim-rpc')
    endif
    call dein#add('Shougo/neco-vim')                          " the vim source for deoplete
    call dein#add('Shougo/neoinclude.vim')                    " include completion framework for deoplete
    call dein#add('Shougo/echodoc.vim')                       " Print documents in echo area.
    call dein#add('deoplete-plugins/deoplete-jedi')           " jedi autocomplete plugin for deoplete
  " }}}
  " Denite {{{
    if has('nvim')
      call dein#add('romgrk/searchReplace.vim')               " search & replace, simply & efficiently
    endif

    call dein#add('ctrlpvim/ctrlp.vim')                       " fuzzy file, buffer, mru, tag, etc finder
    call dein#add('hara/ctrlp-colorscheme')                   " ctrlp colorscheme
    call dein#add('zeero/vim-ctrlp-help')                     " ctrlp help
    call dein#add('fisadev/vim-ctrlp-cmdpalette')             " ctrlp command palette

    call dein#add('Shougo/denite.nvim')                       " async unite all interfaces
    call dein#add('neoclide/denite-git')                      " git for denite
    call dein#add('chemzqm/denite-extra')                     " extra useful sources for denite
    call dein#add('pocari/vim-denite-gists')                  " denite plugin for show and browse Gist

    call dein#add('liuchengxu/vim-clap',
      \ {'build': './install.sh'})                            " modern performant generic finder and dispatcher
    call dein#add('raghur/fruzzy',
      \ {'build': 'python3 ./python3/fruzzy_installer.py'})   " fast fuzzy finder for (denite.nvim/CtrlP matcher)
    call dein#add('nixprime/cpsm',
      \ {'build': 'PY3=ON ./install.sh'})
    call dein#add('Shougo/neomru.vim')                        " MRU plugin includes denite.nvim MRU sources
  " }}}
  " Git {{{{
    call dein#add('tpope/vim-fugitive')                       " git wrapper
    call dein#add('tpope/vim-rhubarb')                        " hub extention for vim fugitive
    call dein#add('sgeb/vim-diff-fold')                       " folding support for diff/patch
    call dein#add('mhinz/vim-signify')                        " async git diff in the sign column
    call dein#add('junegunn/gv.vim')                          " git commit browser
    call dein#add('AGhost-7/critiq.vim')                      " code review
    call dein#add('lambdalisue/gina.vim')                     " async control git repositories
    call dein#add('rhysd/git-messenger.vim', {
      \   'lazy' : 1,
      \   'on_cmd' : 'GitMessenger',
      \   'on_map' : '<Plug>(git-messenger-',
      \ })                                                    " commit messages under the cursor
  " }}}}
  " Snippets {{{
    call dein#add('Shougo/neosnippet.vim')                    " snipet manager
    call dein#add('Shougo/neosnippet-snippets')               " snipet collection
    call dein#add('Shougo/neoinclude.vim')                    " include completion framework for deoplete
    call dein#add('honza/vim-snippets')                       " common snippets
  " }}}
  " Markdown {{{
    call dein#add('tpope/vim-markdown',
      \ {'on_ft': 'markdown'})                                " syntax highlighting for MD
    call dein#add('dhruvasagar/vim-table-mode')               " automatic table creator & formatter
    call dein#add('nelstrom/vim-markdown-folding',
      \ {'on_ft': 'markdown'})                                " MD folding
    call dein#add('rhysd/vim-grammarous')                     " grammar checker
    call dein#add('junegunn/goyo.vim')                        " distraction-free writing
    call dein#add('iamcco/markdown-preview.nvim',
      \ {'on_ft': ['markdown', 'pandoc.markdown',
      \ 'rmd'],'build': 'cd app & npm install' })             " MD preview
  " }}}
  " Javascript {{{
    call dein#add('othree/yajs.vim')                          " JavaScript syntax highlighting
    call dein#add('othree/javascript-libraries-syntax.vim')   " Syntax for JavaScript libraries
    call dein#add('HerringtonDarkholme/yats.vim')             " TypeScript syntax highlighting
    " call dein#add('mhartington/nvim-typescript',
    "   \ {'build': './install.sh'})                            " typescript tooling
    " call dein#add('mxw/vim-jsx')                              " React syntax highlighting
    " call dein#add('chemzqm/vim-jsx-improve')                  " React syntax highlighting
    call dein#add('maxmellon/vim-jsx-pretty')                 " React syntax highlighting and indenting
    call dein#add('heavenshell/vim-jsdoc')                    " generate JSDoc
    call dein#add('elzr/vim-json')                            " better JSON (!= highlighting of keywords/values)
    call dein#add('Quramy/vison')                             " JSON with JSON Schema
    call dein#add('jxnblk/vim-mdx-js')                        " syntax for mdx
  " }}}
  " Python{{{
    " call dein#add('lambdalisue/vim-pyenv')                    " activates the pyenv Python NEEDED for many plugins
    call dein#add('PieterjanMontens/vim-pipenv')              " interactions with pipenv
    call dein#add('jmcantrell/vim-virtualenv')                " interaction with virtualenv
    if has('nvim')
      call dein#add('numirias/semshi')                        " improved python syntax
    endif
    call dein#add('tmhedberg/SimpylFold',
          \ {'on_ft': 'python'})                              " python code folding
    call dein#add('deoplete-plugins/deoplete-jedi')           " python autocompletion, static analysis and refactoring
    call dein#add('nvie/vim-flake8')                          " PyFlakes and pep8
  " }}}
  " Ruby {{{
    call dein#add('vim-ruby/vim-ruby')                        " ruby tooling
    call dein#add('tpope/vim-rails')                          " rails tooling
    call dein#add('tpope/vim-rake')                           " rake tooling
  " }}}
  " Html {{{
    call dein#add('othree/html5.vim')                         " HTML5 omnicomplete and syntax
    call dein#add('mattn/emmet-vim')                          " emmet expansion
    call dein#add('posva/vim-vue')                            " syntax highlighting for vue
    call dein#add('skwp/vim-html-escape')                     " pluginization of html entities
    call dein#add('kana/vim-textobj-user')                    " create your own text objects
    call dein#add('whatyouhide/vim-textobj-xmlattr')          " A vim text object for XML/HTML attributes
    call dein#add('pedrohdz/vim-yaml-folds')                  " simple folding configuration for YAML
    call dein#add('Valloric/MatchTagAlways')                  " match html tags
  " }}}
  " Css {{{
    call dein#add('hail2u/vim-css3-syntax')                   " CSS3 syntax
    if has('nvim')
      call dein#add('norcalli/nvim-colorizer.lua')            " neovim colorizer
    endif
    call dein#add('ncm2/ncm2-cssomni')                        " ncm2 CSS omnicomplete
    call dein#add('cakebaker/scss-syntax.vim')                " scss syntax
  " }}}
  " Has to be last according to docs
  call dein#add('ryanoasis/vim-devicons')                     " dev icons

  if dein#check_install()
    call dein#install()
    let pluginsExist=1
  endif

  call dein#end()

  " clean removed plugin (keep this uncommented when fiddling with config)
  call map(dein#check_clean(), "delete(v:val, 'rf')")
  call dein#recache_runtimepath()

  filetype plugin indent on
" }}}
" System Settings -----------------------------------------------------------{{{
  if (has("termguicolors"))
    set termguicolors
  endif
  " if (has('python3'))                                         " dynamically load python3 first for vim
  " endif
  " set pyxversion=3                                            " set python3 as default pyx version
  let mapleader = ','                                         " map leader to ,
  set mouse=a                                                 " copy outside of vim
  set clipboard+=unnamedplus                                  " set + registery as default
  filetype on                                                 " enable file type detection
  set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20     " set cursor preferences
  set nopaste                                                 " for paste from other windows
  set noshowmode                                              " do not show mode in msg
  set hidden                                                  " hide instead of close buffers
  set noswapfile                                              " no swap file
  set number                                                  " display numberlines
  set numberwidth=1                                           " numberwidth
  set tabstop=2 shiftwidth=2 expandtab                        " soft tabs identation
  set nospell                                                 " no spell checker
  set conceallevel=1                                          " text concealed to one char
  set virtualedit=                                            " defailt virtual edit
  set laststatus=2                                            " always display status line
  set wrap linebreak nolist                                   " wrap & line breaks options
  set textwidth=120                                           " set wrap width
  set formatoptions+=t                                        " wrap text using textwidth
  set wildmenu                                                " vimcommand completion
  set wildmode=full                                           " vim command completion
  set autoread                                                " sync file change from outside of vim
  set updatetime=100                                          " update time
  set redrawtime=100                                          " redraw time
  set fillchars+=vert:│                                       " set vertical separrator char
  set undofile                                                " save undo hist to file
  set undodir="$HOME/.VIM_UNDO_FILES"                         " set undo files
  set complete=.,w,b,u,t,k                                    " set complete options
  if has('nvim')
    set inccommand=nosplit                                    " live preview of substiutions
  endif
  set shortmess=atIc                                          " abbreviation tirm noIntro noCompletion
  set isfname-==                                              " remove = from filenames

  set list
  set listchars=tab:‣\ ,trail:·                               " set list chars
  " set listchars=tab:\ \ ,trail:·,eol:¬,nbsp:_

  colorscheme nord                                            " set theme
  set background=dark                                         " set background

  augroup prewrites
    autocmd!
    " trim whitespaces and ensure file's line endings are UNIX
    autocmd BufWritePre,FileWritePre * :%s/\s\+$//e | %s/\r$//e
  augroup END

  augroup postread
    autocmd!
    " Remember cursor position between vim sessions
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line ("'\"") <= line("$") |
      \   exe "normal! g'\"" |
      \ endif
    " center buffer around cursor when opening files
    autocmd BufReadPost * normal zz
  augroup END

  augroup aroundinsert
    autocmd!
    autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
    autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)
  augroup END

  augroup filetypes
    autocmd!
    autocmd BufNewFile,BufRead .babelrc set filetype=json
    autocmd BufNewFile,BufRead .eslintrc set filetype=json
    autocmd BufNewFile,BufRead .prettierrc set filetype=json
    autocmd BufNewFile,BufRead tsconfig.json set filetype=jsonc
    autocmd BufNewFile,BufRead .gitignore set filetype=config
    autocmd BufNewFile,BufRead *zlogin set filetype=zsh
    autocmd BufNewFile,BufRead *zprofile set filetype=zsh
    autocmd BufNewFile,BufRead *zserver set filetype=zsh
    autocmd BufNewFile,BufRead *zshenv set filetype=zsh
    autocmd BufNewFile,BufRead *zbindings set filetype=zsh
  augroup END
" }}}
" System Mappings -----------------------------------------------------------{{{
  " No need for ex mode
  nnoremap Q <nop>
  " exit insert, dd line, enter insert
  inoremap <c-d> <esc>ddi
  " join
  vnoremap <silent> gJ :join<cr>
  " yank
  noremap Y y$
  vnoremap y myy`y
  vnoremap Y myY`y

  " Quickly edit/reload the vimrc file
  nmap <silent> <leader>ev :e ~/.vimrc<CR>
  nmap <silent> <leader>sv :so ~/.vimrc<CR>

  " Quickly edit/reload the init.vim file
  nmap <silent> <leader>en :e ~/.config/nvim/init.vim<CR>
  nmap <silent> <leader>sn :so ~/.config/nvim/init.vim<CR>

  " Quickly edit the tmux.conf file
  nmap <silent> <leader>et :e ~/.tmux.conf<CR>

  " Quickly edit the zshrc file
  nmap <silent> <leader>ez :e ~/$ZDOTDIR/.zshrc<CR>

  " Disable arrows
  nnoremap <Up> <nop>
  inoremap <Up> <nop>
  vnoremap <Up> <nop>
  nnoremap <Down> <nop>
  inoremap <Down> <nop>
  vnoremap <Down> <nop>
  nnoremap <Left> <nop>
  inoremap <Left> <nop>
  vnoremap <Left> <nop>
  nnoremap <Right> <nop>
  inoremap <Right> <nop>
  vnoremap <Right> <nop>

  " Navigate between display lines
  nnoremap <silent><expr> k v:count == 0 ? 'gk' : 'k'
  vnoremap <silent><expr> k v:count == 0 ? 'gk' : 'k'
  nnoremap <silent><expr> j v:count == 0 ? 'gj' : 'j'
  vnoremap <silent><expr> j v:count == 0 ? 'gj' : 'j'

  " Navigation shortcuts
  noremap H ^
  noremap L g_
  noremap J 5j
  noremap K 5k
  noremap  <silent> <Home> g<Home>
  noremap  <silent> <End>  g<End>
  inoremap <silent> <Home> <C-o>g<Home>
  inoremap <silent> <End>  <C-o>g<End>

  "So I can move around in insert
  inoremap <C-k> <C-o>gk
  inoremap <C-j> <C-o>gj

  " Move lines
  nnoremap <A-j> :m .+1<CR>==
  inoremap <A-j> <Esc>:m .+1<CR>==gi
  vnoremap <A-j> :m '>+1<CR>gv=gv
  nnoremap <A-k> :m .-2<CR>==
  inoremap <A-k> <Esc>:m .-2<CR>==gi
  vnoremap <A-k> :m '<-2<CR>gv=gv

  " Neovim terminal mapping
  tmap <esc> <c-\><c-n><esc><cr>

  " Align blocks of text and keep them selected
  vmap < <gv
  vmap > >gv

  " clear last search highlighting
  nnoremap <silent> <esc> :noh<cr>

  " EasyAlign
  " Start interactive EasyAlign in visual mode (e.g. vipga)
  xmap ga <Plug>(EasyAlign)
  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap ga <Plug>(EasyAlign)

  " SynStack
  nnoremap <leader>e :call <SID>SynStack()<CR>

  function! <SID>SynStack()
    if !exists("*synstack")
      return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
  endfunction

  function! s:PlaceholderImgTag(size)
    let url = 'http://dummyimage.com/' . a:size . '/000000/555555'
    let [width,height] = split(a:size, 'x')
    execute "normal a<img src=\"".url."\" width=\"".width."\" height=\"".height."\" />"
  endfunction

  command! -nargs=1 PlaceholderImgTag call s:PlaceholderImgTag(<f-args>)
" }}}"
" Fold ----------------------------------------------------------------------{{{
  function! MyFoldText() " {{{
      let line = getline(v:foldstart)
      let nucolwidth = &fdc + &number * &numberwidth
      let windowwidth = winwidth(0) - nucolwidth - 3
      let foldedlinecount = v:foldend - v:foldstart

      " expand tabs into spaces
      let onetab = strpart('          ', 0, &tabstop)
      let line = substitute(line, '\t', onetab, 'g')

      let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
      let fillcharcount = windowwidth - len(line)
      return line . ''. repeat(" ",fillcharcount)
  endfunction
  " }}}

  set foldtext=MyFoldText()

  set foldlevel=99

  " Space to toggle folds.
  nnoremap <Space> za
  vnoremap <Space> za

  let g:xml_syntax_folding = 1

  augroup fold
    autocmd!
    autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
    autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

    autocmd FileType xml setlocal foldmethod=syntax

    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim setlocal foldlevel=0

    autocmd FileType javascript,html,css,scss setlocal foldlevel=99

    autocmd FileType css,scss,json setlocal foldmethod=marker
    autocmd FileType css,scss,json setlocal foldmarker={,}

    autocmd FileType html setlocal foldmethod=expr
    autocmd FileType html setlocal foldexpr=HTMLFolds()

    autocmd FileType javascript,javascriptreact,json setlocal foldmethod=syntax

    autocmd FileType zsh let g:zsh_fold_enable=1

    autocmd FileType sh let g:sh_fold_enabled=5
    autocmd FileType sh let g:is_bash=1
    autocmd FileType sh set foldmethod=syntax

  augroup END
" }}}
" Git Settings --------------------------------------------------------------{{{
  set signcolumn=yes
  set diffopt+=internal,algorithm:patience,iwhiteall

  let g:conflict_marker_enable_mappings = 0
  let g:EditorConfig_exclude_patterns = ['fugitive://.*']

  " Signify settings
  let g:signify_sign_show_count = 0
  let g:signify_sign_add               = ''
  let g:signify_sign_delete            = ''
  let g:signify_sign_delete_first_line = ''
  let g:signify_sign_change            = ''

  nnoremap <leader><leader>gd :SignifyDiff<cr>
  nnoremap <leader><leader>gp :SignifyHunkDiff<cr>
  nnoremap <leader><leader>gu :SignifyHunkUndo<cr>
  nmap <leader><leader>gj <plug>(signify-next-hunk)
  nmap <leader><leader>gk <plug>(signify-prev-hunk)

  let g:gina#command#blame#formatter#format="%in (%au) %ti"

  function! s:fugitive_settings() abort
    setlocal nonumber
  endfunction

  augroup git_settings
    autocmd!
    autocmd FileType fugitive call s:fugitive_settings()
  augroup END
" }}}
" UI Plugins Settings -------------------------------------------------------{{{
  " Defx {{{
    set conceallevel=2
    set concealcursor=nc
    map <silent> - :Defx<cr>

    call defx#custom#column('icon', {
      \ 'directory_icon': '',
      \ 'opened_icon':  '',
      \ 'root_icon': '',
      \ 'root_marker_highlight': 'Ignore',
      \ })

    call defx#custom#column('filename', {
      \ 'root_marker_highlight': 'Ignore',
      \ })

    call defx#custom#column('mark', {
      \ 'readonly_icon': '✗',
      \ 'selected_icon': '',
      \ })

    call defx#custom#option('_', {
      \ 'winwidth': 45,
      \ 'columns': 'mark:indent:icon:icons:filename:git',
      \ 'split': 'vertical',
      \ 'direction': 'topleft',
      \ 'show_ignored_files': 1,
      \ 'buffer_name': '',
      \ 'toggle': 1,
      \ 'resume': 1,
      \ 'root_marker': ':',
      \ })

    function! Open_close_tree_or_drop() abort
      return defx#is_directory() ? defx#do_action('open_or_close_tree') : defx#do_action('multi', ['drop', 'quit'])
    endfunction

    function! s:defx_my_settings() abort " {{{
      setl nospell
      setl signcolumn=no
      setl nonumber
      nnoremap <silent><buffer><expr> <CR>    Open_close_tree_or_drop()
      nnoremap <silent><buffer><expr> f       Open_close_tree_or_drop()
      nnoremap <silent><buffer><expr> h       defx#do_action('close_tree')
      nnoremap <silent><buffer><expr> C       defx#do_action('copy')
      nnoremap <silent><buffer><expr> P       defx#do_action('paste')
      nnoremap <silent><buffer><expr> M       defx#do_action('rename')
      nnoremap <silent><buffer><expr> D       defx#do_action('remove_trash')
      nnoremap <silent><buffer><expr> A       defx#do_action('new_multiple_files')
      nnoremap <silent><buffer><expr> U       defx#do_action('cd', ['..'])
      nnoremap <silent><buffer><expr> .       defx#do_action('toggle_ignored_files')
      nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select')
      nnoremap <silent><buffer><expr> R       defx#do_action('redraw')
      nnoremap <silent><buffer><expr> <Tab>   <SID>defx_toggle_zoom()
    endfunction
    " }}}

    function s:defx_toggle_zoom() abort " {{{
      let b:DefxOldWindowSize = get(b:, 'DefxOldWindowSize', winwidth('%'))
      let size = b:DefxOldWindowSize
      if exists("b:DefxZoomed") && b:DefxZoomed
          exec "silent vertical resize ". size
          let b:DefxZoomed = 0
      else
          exec "vertical resize ". get(g:, 'DefxWinSizeMax', '')
          let b:DefxZoomed = 1
      endif
    endfunction
    " }}}

    let g:defx_git#show_ignored = 0
    let g:defx_git#column_length = 1

    hi def link Defx_filename_directory Keyword
    hi def link Defx_git_Modified Special
    hi def link Defx_git_Staged Function
    hi def link Defx_git_Renamed Title
    hi def link Defx_git_Unmerged Label
    hi def link Defx_git_Untracked Tag
    hi def link Defx_git_Ignored Comment

    let g:defx_icons_parent_icon = ""
    let g:defx_icons_mark_icon = ''
    let g:defx_icons_enable_syntax_highlight = 1
    let g:defx_icons_column_length = 1
    let g:defx_icons_mark_icon = '*'
    let g:defx_icons_default_icon = ''
    let g:defx_icons_directory_symlink_icon = ''
    " Options below are applicable only when using "tree" feature
    let g:defx_icons_directory_icon = ''
    let g:defx_icons_root_opened_tree_icon = ''
    let g:defx_icons_nested_opened_tree_icon = ''
    let g:defx_icons_nested_closed_tree_icon = ''

    augroup defx_settings
      autocmd!
      autocmd FileType defx call s:defx_my_settings()
    augroup END
  " }}}
  " Denite {{{
    let s:menus = {}
    call denite#custom#option('_', {
      \ 'prompt': 'ϟ',
      \ 'winheight': 10,
      \ 'filter_updatetime': 1,
      \ 'auto_resize': v:true,
      \ 'highlight_matched_char': 'Underlined',
      \ 'highlight_mode_normal': 'CursorLine',
      \ 'reversed': v:true,
      \ 'start_filter': v:true,
      \})

    call denite#custom#option('TSDocumentSymbol', {
      \ 'prompt': '@ ' ,
      \ 'reversed': v:false,
      \})

    call denite#custom#option('TSWorkspaceSymbol', {
      \ 'prompt': '# ' ,
      \ 'reversed': v:false,
      \})

    call denite#custom#source('file/rec', 'vars', {
      \'command': ['rg', '--files', '--glob', '!.git'],
      \'sorters':['sorter_sublime'],
      \'matchers': ['matcher/fruzzy'],
      \})

    call denite#custom#source('grep', 'vars', {
      \'command': ['rg'],
      \'default_opts': ['-i', '--vimgrep'],
      \'recursive_opts': [],
      \'pattern_opt': [],
      \'separator': ['--'],
      \'final_opts': [],
      \'matchers': ['matcher/ignore_globs', 'matcher/regexp', 'matcher/pyfuzzy']
      \})

    let g:ctrlp_user_command="rg --files --glob !.git"
    let g:ctrlp_grep_command_definition="rg -i --vimgrep"
    let g:ctrlp_use_caching = 0
    let g:ctrlp_match_func = {'match': 'fruzzy#ctrlp#matcher'}
    let g:ctrlp_map = ''
    let fruzzy#usenative = 1

    let g:clap_insert_mode_only = v:true
    let g:clap_layout = { 'relative': 'editor' }
    let g:clap_enable_icon = 1
    let g:clap_theme = 'nord'

    nnoremap <silent> <c-p>      :Clap files<CR>
    nnoremap <silent> <leader>a  :Clap grep<CR>
    nnoremap <silent> <leader>h  :Clap help_tags<CR>
    nnoremap <silent> <leader>u  :DeinUpdate<CR>

    function! s:denite_my_settings() abort
      nnoremap <silent><buffer><expr> <CR>    denite#do_map('do_action')

      nnoremap <silent><buffer><expr> <Tab>    denite#do_map('choose_action')
      nnoremap <silent><buffer><expr> <ESC>   denite#do_map('quit')
      nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select')
      nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
    endfunction

    function s:denite_filter_settings() abort
      setl nonumber
      call deoplete#custom#buffer_option('auto_complete', v:false)

      inoremap <silent><buffer><expr> <ESC> denite#do_map('quit')
      inoremap <silent><buffer> <CR>  <ESC><C-w>p:call denite#call_map('do_action')<CR>

      inoremap <silent><buffer> <Tab>   <Esc><C-w>p:call denite#call_map('choose_action')<CR>
      inoremap <silent><buffer> <Space> <Esc><C-w>p:call denite#call_map('toggle_select')<CR><C-w>pA
      inoremap <silent><buffer> <C-j>   <Esc><C-w>p:call cursor(line('.')+1,0)<CR><C-w>pA
      inoremap <silent><buffer> <C-k>   <Esc><C-w>p:call cursor(line('.')-1,0)<CR><C-w>pA
    endfunction

    call denite#custom#map('insert','<C-n>','<denite:move_to_next_line>','noremap')
    call denite#custom#map('insert','<C-p>','<denite:move_to_previous_line>','noremap')

    call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
      \ [ '.git/', '__pycache__/',
      \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])
    call denite#custom#var('menu', 'menus', s:menus)

    augroup denite_settings
      autocmd!
      autocmd FileType denite call s:denite_my_settings()
      autocmd FileType denite-filter call s:denite_filter_settings()
    augroup END
  " }}}
  " Airline {{{
    let g:webdevicons_enable_airline_statusline = 1

    if !exists('g:airline_symbols')
      let g:airline_symbols = {
        \ 'branch': '',
        \ 'modified': ' ●'
        \}
    endif

    let g:airline_powerline_fonts = 1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#fnamemod = ':t'
    let g:airline#extensions#tabline#buffer_idx_mode = 1
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline#extensions#nvim_typescript#enabled=1
    let w:airline_skip_empty_sections = 0

    cnoreabbrev x Sayonara

    nmap <silent><leader>, :bnext<CR>
    tmap <leader>, <C-\><C-n>:bnext<cr>
    nmap <silent><leader>. :bprevious<CR>
    tmap <leader>. <C-\><C-n>:bprevious<CR>

    tmap <leader>1  <C-\><C-n><Plug>AirlineSelectTab1
    tmap <leader>2  <C-\><C-n><Plug>AirlineSelectTab2
    tmap <leader>3  <C-\><C-n><Plug>AirlineSelectTab3
    tmap <leader>4  <C-\><C-n><Plug>AirlineSelectTab4
    tmap <leader>5  <C-\><C-n><Plug>AirlineSelectTab5
    tmap <leader>6  <C-\><C-n><Plug>AirlineSelectTab6
    tmap <leader>7  <C-\><C-n><Plug>AirlineSelectTab7
    tmap <leader>8  <C-\><C-n><Plug>AirlineSelectTab8
    tmap <leader>9  <C-\><C-n><Plug>AirlineSelectTab9
    nmap <leader>1 <Plug>AirlineSelectTab1
    nmap <leader>2 <Plug>AirlineSelectTab2
    nmap <leader>3 <Plug>AirlineSelectTab3
    nmap <leader>4 <Plug>AirlineSelectTab4
    nmap <leader>5 <Plug>AirlineSelectTab5
    nmap <leader>6 <Plug>AirlineSelectTab6
    nmap <leader>7 <Plug>AirlineSelectTab7
    nmap <leader>8 <Plug>AirlineSelectTab8
    nmap <leader>9 <Plug>AirlineSelectTab9

    let g:airline#extensions#branch#format = 0
    let g:airline_detect_spelllang=0
    let g:airline_detect_spell=0
    let g:airline#extensions#hunks#enabled = 0
    let g:airline#extensions#wordcount#enabled = 0
    let g:airline#extensions#whitespace#enabled = 0
    let g:airline_section_c = '%f%m'
    let g:airline_section_x = ''
    let g:airline_section_y = ''
    let g:airline_section_z = '%l:%c'
    let g:airline#parts#ffenc#skip_expected_string=''
  " }}}
  " Devicons {{{
    let g:NERDTreeGitStatusNodeColorization = 1
    let g:webdevicons_enable_denite = 0
    let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ''
    let g:DevIconsEnableFoldersOpenClose = 1
    let g:WebDevIconsUnicodeDecorateFolderNodes = 1
    let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = ''
    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = { } " needed
    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['js'] = ''
    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['jsx'] = ''
    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['vim'] = ''
    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['css'] = ''
    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['html'] = ''
    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['json'] = ''
    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['md'] = ''
    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['sql'] = ''
  " }}}
" }}}
" MultiCursor ---------------------------------------------------------------{{{
  let g:multi_cursor_exit_from_visual_mode=0
  let g:multi_cursor_exit_from_insert_mode=0
" }}}
" Nvim Terminal -------------------------------------------------------------{{{
  if has('nvim')
    au BufEnter * if &buftype == 'terminal' | :startinsert | endif
    augroup nvim_terminal
      autocmd!
      autocmd BufEnter term://* startinsert
      autocmd TermOpen * set bufhidden=hide
    augroup END
  endif
" }}}
" Formatting / Completion / Snipppets ---------------------------------------{{{
  " Syntax {{{
    augroup theming
      autocmd!
      autocmd ColorScheme * call highlight#CustomHighlight()
      autocmd FileType python :Semshi enable
    augroup END
  " }}}
  " LSP {{{
    if has('nvim')
      " When nvim's LSP is ready...
      " lua require
      lua require("lsp_config")
      set omnifunc=v:lua.vim.lsp.omnifunc
      nnoremap <silent> <leader>gdc <cmd>lua vim.lsp.buf.declaration()<CR>
      nnoremap <silent> <leader>gd <cmd>lua vim.lsp.buf.definition()<CR>
      nnoremap <silent> <leader>gt <cmd>lua vim.lsp.buf.hover()<CR>
      nnoremap <silent> <leader>gi <cmd>lua vim.lsp.buf.implementation()<CR>
      nnoremap <silent> <leader>gtd <cmd>lua vim.lsp.buf.type_definition()<CR>
      nnoremap <m-Enter> <cmd>lua vim.lsp.buf.code_action()<CR>
      let g:diagnostic_auto_popup_while_jump = 1
      let g:LspDiagnosticsErrorSign='•'
      let g:LspDiagnosticsWarningSign='•'
      let g:LspDiagnosticsInformationSign='•'
      let g:LspDiagnosticsHintSign='•'
      let g:diagnostic_show_sign = 1
      augroup lsp_settings
        autocmd!
        autocmd CursorHold * silent! :lua require'util'.show_line_diagnostics()
      augroup END
    endif
  " }}}
  " Code Formatting (Neoformat) {{{
    " ,f to format code
    noremap <silent> <leader>f :Neoformat<CR>

    let g:standard_prettier_settings = {
      \ 'exe': 'prettier',
      \ 'args': ['--stdin', '--stdin-filepath', '%:p', '--single-quote'],
      \ 'stdin': 1,
      \ }

    let g:neoformat_zsh_shfmt = {
      \ 'exe': 'shfmt',
      \ 'args': ['-i ' . shiftwidth()],
      \ 'stdin': 1,
      \ }

    let g:neoformat_enabled_zsh = ['shfmt']
    let g:neoformat_enabled_sh = ['shfmt']

    let g:neoformat_vue_eslint_d = {
      \ 'exe': 'eslint_d',
      \ 'args': ['--stdin', '--stdin-filename', '"%:p"', '--fix-to-stdout'],
      \ 'stdin': 1,
      \ }
  " }}}
  " Code Completion (Deoplete) {{{
    let g:deoplete#enable_at_startup = 1

    call deoplete#custom#option({
      \ 'auto_complete_delay': 100,
      \ 'smart_case': v:true,
      \})

    call deoplete#custom#option('ignore_sources', {'_': ['buffer', 'around', 'member', 'omni']})
    let g:echodoc_enable_at_startup=1
    let g:echodoc#type="virtual"
    set splitbelow
    set completeopt+=menuone,noinsert,noselect
    set completeopt-=preview

    function g:Multiple_cursors_before()
      call deoplete#custom#buffer_option('auto_complete', v:false)
    endfunction
    function g:Multiple_cursors_after()
      call deoplete#custom#buffer_option('auto_complete', v:true)
    endfunction

    let g:deoplete#file#enable_buffer_path=1
    function! Preview_func()
      if &pvw
        setlocal nonumber norelativenumber
      endif
    endfunction
    augroup deoplete_settings
      autocmd!
      autocmd CompleteDone * pclose
      autocmd WinEnter * call Preview_func()
    augroup END
  " }}}
  " Snippets {{{
    " Enable snipMate compatibility feature.
    let g:neosnippet#enable_snipmate_compatibility=1
    let g:neosnippet#snippets_directory=[
      \ '~/.vim/nvim/repos/github.com/honza/vim-snippets/snippets',
      \ '~/.vim/snippets']

    imap <C-x>     <Plug>(neosnippet_expand_or_jump)
    smap <C-x>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-x>     <Plug>(neosnippet_expand_target)

    smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
  " }}}
  " Emmet {{{
    " Remapping <C-y>, just doesn't cut it.
    function! s:expand_html_tab()
      " try to determine if we're within quotes or tags.
      " if so, assume we're in an emmet fill area.
      let line = getline('.')
      if col('.') < len(line)
        let line = matchstr(line, '[">][^<"]*\%'.col('.').'c[^>"]*[<"]')
        if len(line) >= 2
          return "\<C-n>"
        endif
      endif
      " expand anything emmet thinks is expandable.
      if emmet#isExpandable()
        return emmet#expandAbbrIntelligent("\<tab>")
      endif
      " return a regular tab character
      return "\<tab>"
    endfunction

    let g:user_emmet_mode='a'
    let g:user_emmet_complete_tag = 0
    let g:user_emmet_install_global = 0

    augroup emmet_settings
      autocmd!
      autocmd FileType html,css,scss,vue,javascript,javascriptreact,markdown.mdx
        \ imap <silent><buffer><expr><tab>
          \ neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" :
          \ <sid>expand_html_tab()

      autocmd FileType html,css,scss,vue,javascript,javascriptreact,markdown.mdx EmmetInstall
    augroup END
  " }}}
" }}}
" Languages Specific Settings -----------------------------------------------{{{
  " Javascript {{{
    let g:neoformat_enabled_javascript = ['eslint_d']
    let g:neoformat_enabled_vue = ['eslint_d']

    let g:neoformat_json_prettier = g:standard_prettier_settings
    let g:neoformat_enabled_json = ['prettier']

    let g:used_javascript_libs = 'underscore,vue,react'         " set enabled highlighted libraries

    let g:jsx_ext_required = 0                                  " do not force .jsx etension

    " jsdoc
    let g:jsdoc_allow_input_prompt = 1                          " allow prompt for interactive input
    let g:jsdoc_input_description = 1                           " prompt for a function description
    let g:jsdoc_return=0                                        " no the @return tag
    let g:jsdoc_return_type=0                                   " do not prompt for and add a type for @return

    let g:vim_json_syntax_conceal = 0

    function! ToggleConcealLevel()
      if &conceallevel == 0
          setlocal conceallevel=2
      else
          setlocal conceallevel=0
      endif
    endfunction

    nnoremap <silent> <C-c><C-y> :call ToggleConcealLevel()<CR>

    augroup javascript_settings
      autocmd!
      autocmd FileType vue syntax sync fromstart
    augroup END

    " typescript stuff {{{
      let g:nvim_typescript#max_completion_detail=50
      let g:nvim_typescript#completion_mark=''
      let g:nvim_typescript#javascript_support=1
      let g:nvim_typescript#expand_snippet=0
      let g:nvim_typescript#vue_support=0
      if has('nvim')
        let g:nvim_typescript#diagnostics_enable=1
      endif
      let g:nvim_typescript#type_info_on_hold=0
      let g:nvim_typescript#suggestions_enabled=1

      let g:neoformat_typescript_prettier = g:standard_prettier_settings
      let g:neoformat_enabled_typescript = ['prettier']
      let g:neoformat_typescriptreact_prettier = g:standard_prettier_settings
      let g:neoformat_enabled_typescriptreact = ['prettier']
      let g:nvim_typescript#kind_symbols = {
        \ 'keyword': 'keyword',
        \ 'class': '',
        \ 'interface': '',
        \ 'script': 'script',
        \ 'module': '',
        \ 'local class': 'local class',
        \ 'type': '',
        \ 'enum': '',
        \ 'enum member': '',
        \ 'alias': '',
        \ 'type parameter': 'type param',
        \ 'primitive type': 'primitive type',
        \ 'var': '',
        \ 'local var': '',
        \ 'property': '',
        \ 'let': '',
        \ 'const': '',
        \ 'label': 'label',
        \ 'parameter': 'param',
        \ 'index': 'index',
        \ 'function': '',
        \ 'local function': 'local function',
        \ 'method': '',
        \ 'getter': '',
        \ 'setter': '',
        \ 'call': 'call',
        \ 'constructor': '',
        \}

      if has('nvim')
        let s:menus.typescript = {
          \ 'description' : 'typescript commands',
          \}
        let s:menus.typescript.command_candidates = [
          \['Get Type', 'TSType' ],
          \['Get Doc', 'TSDoc'],
          \['Edit Project Config', 'TSEditConfig'],
          \['Restart Server', 'TSRestart'],
          \['Start Server', 'TSStart'],
          \['Stop Server', 'TSStop'],
          \]
      endif

      hi TSErrorTexthl gui=underline
      hi TSWarningTexthl gui=underline
      hi TSSuggestionTexthl gui=underline
      hi TSErrorSignhl ctermfg=203 ctermbg=235 guifg=#ec5f67 guibg=#1b2b34
      hi TSWarningSignhl ctermfg=221 ctermbg=235 guifg=#fac863 guibg=#1b2b34
      hi TSInfoSignhl ctermfg=15 ctermbg=235 guifg=#ffffff guibg=#1b2b34

      let g:nvim_typescript#default_signs = [
        \{ 'TSerror':      { 'texthl': 'TSErrorTexthl', 'signText':      '•', 'signTexthl': 'TSErrorSignhl' } },
        \{ 'TSwarning':    { 'texthl': 'TSWarningTexthl', 'signText':    '•', 'signTexthl': 'TSWarningSignhl' } },
        \{ 'TSsuggestion': { 'texthl': 'TSSuggestionTexthl', 'signText': '･', 'signTexthl': 'TSInfoSignhl' } },
        \{ 'TShint':       { 'texthl': 'SpellBad', 'signText':           '?', 'signTexthl': 'TSInfoSignhl' } }
        \]

      augroup typescript_settings
        autocmd!
        autocmd FileType typescript,typescriptreact setl omnifunc=TSOmniFunc
        autocmd FileType typescript,typescriptreact map <silent> <leader>gd :TSDoc <cr>
        autocmd FileType typescript,typescriptreact map <silent> <leader>gt :TSType <cr>
        autocmd FileType typescript,typescriptreact map <silent> <leader>gtd :TSTypeDef <cr>
        autocmd FileType typescript,typescriptreact map <silent> <leader>gtD :TSDef <cr>
        if has('nvim')
          autocmd FileType typescript,typescriptreact map <silent> <leader>@ :Denite -buffer-name=TSDocumentSymbol TSDocumentSymbol <cr>
          autocmd FileType typescript,typescriptreact map <silent> <leader># :Denite -buffer-name=TSWorkspaceSymbol TSWorkspaceSymbol <cr>
        endif
        autocmd FileType typescript,typescriptreact nnoremap <m-Enter> :TSGetCodeFix<CR>
      augroup END
    " }}}
  " }}}
  " Python {{{
    let g:pipenv_auto_activate=1
    let g:pipenv_auto_switch=1
  " }}}
  " Ruby {{{
    let g:neoformat_enabled_ruby = ['rubocop']
  " }}}
  " HTML {{{
    let g:neoformat_html_prettier = g:standard_prettier_settings
    let g:neoformat_enabled_html = ['prettier']
    " let g:neoformat_enabled_html = ['htmlbeautify']
    let g:mta_filetypes = {
      \ 'html' : 1,
      \ 'xhtml' : 1,
      \ 'xml' : 1,
      \ 'jinja' : 1,
      \ 'javascript.jsx' : 1,
      \}
  " }}}
  " CSS {{{
    let g:neoformat_scss_prettier = g:standard_prettier_settings
    let g:neoformat_enabled_scss = ['prettier']
    if has('nvim')
      lua require 'colorizer'.setup()
    endif
  " }}}
  " MarkDown {{{
    let g:neoformat_markdown_prettier = g:standard_prettier_settings
    let g:neoformat_enabled_markdown = ['prettier']

    noremap <leader>TM :TableModeToggle<CR>

    let g:table_mode_corner="|"

    let g:markdown_fold_override_foldtext = 0
    let g:markdown_syntax_conceal = 0

    let g:mkdp_auto_start = 0
  " }}}
" }}}
