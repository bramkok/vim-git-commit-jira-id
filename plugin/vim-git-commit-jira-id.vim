" Filename: vim-git-commit-jira-id.vim
" Author: Bram Kok <http://bramkok.com>
" Version: 1.0

" Don't load in compatible mode, vim versions > 7.0 or twice
if exists('g:loaded_vim_git_commit_jira_id') || &cp || v:version < 700
  finish
endif
let g:loaded_vim_git_commit_jira_id = 1

function! s:InsertJiraId()
  if getline(1) == ''
    let l:branch = system("git symbolic-ref --short HEAD")
    let l:branch = substitute(branch, '^\([^-]\+-\d\+\)*-*.*', '\1', '')
    let l:jira_id = substitute(branch, 'feature/\|hotfix/\|release', '', '')
    if !empty(l:jira_id)
      call setline(1, l:jira_id . ' ')
      call feedkeys("\<End>")
    endif
  endif
endfunction

function! s:CreateGitCommitMessage()
  if exists('l:jira_id') && getline(1) == l:jira_id . ' '
    cquit
  endif
endfunction

call s:InsertJiraId()

augroup vim_git_commit_jira_id
  autocmd BufUnload <buffer> call s:CreateGitCommitMessage()
augroup END
