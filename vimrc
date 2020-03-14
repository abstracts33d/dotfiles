" Vimrc
" STOP WRITING STUFF HERE MORON
" You took the time to create a directory structure to keep
" things cleaner : USE IT.

" Also you stole this from christoomey/dotfiles

set nocompatible
filetype off

let mapleader = "\<Space>"
let maplocalleader = "\<Space>"

function! s:SourceConfigFilesIn(directory)
  let directory_splat = '~/.vim/' . a:directory . '/*'
  for config_file in split(glob(directory_splat), '\n')
    if filereadable(config_file)
      execute 'source' config_file
    endif
  endfor
endfunction

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin('~/.vim/bundle')
call s:SourceConfigFilesIn('rcplugins')
call vundle#end()

call s:SourceConfigFilesIn('rcfiles')
