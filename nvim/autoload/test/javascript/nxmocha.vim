" vim-test runner for Nx monorepos whose test target wraps mocha via a
" custom executor accepting --path and --customFlags (e.g. glia-hub).
"
"   TestSuite    pnpm nx test <project>
"   TestFile     pnpm nx test <project> --path <file>
"   TestNearest  pnpm nx test <project> --path <file> --customFlags='--grep <name>'
"
" <project> is read from the nearest project.json above the test file.
" Requires cwd to be the repo root (vim-test assumes this anyway).

if !exists('g:test#javascript#patterns')
  runtime autoload/test/javascript.vim
endif

if !exists('g:test#javascript#nxmocha#file_pattern')
  let g:test#javascript#nxmocha#file_pattern = '\v(%(^|/)test/.*|\.test)\.(js|jsx|ts|tsx)$'
endif

function! test#javascript#nxmocha#test_file(file) abort
  return a:file =~# g:test#javascript#nxmocha#file_pattern
        \ && filereadable('nx.json')
        \ && !empty(s:project_file(a:file))
endfunction

function! test#javascript#nxmocha#build_position(type, position) abort
  let project = s:project_name(a:position['file'])
  if a:type ==# 'suite'
    return [project]
  endif

  let args = [project, '--path', a:position['file']]
  if a:type ==# 'nearest'
    let name = s:nearest_test(a:position)
    if !empty(name)
      let args += ['--customFlags=' . shellescape('--grep ' . shellescape(name))]
    endif
  endif
  return args
endfunction

function! test#javascript#nxmocha#build_args(args) abort
  return a:args
endfunction

function! test#javascript#nxmocha#executable() abort
  return 'pnpm nx test'
endfunction

function! s:project_file(file) abort
  return findfile('project.json', fnamemodify(a:file, ':p:h') . ';')
endfunction

function! s:project_name(file) abort
  let config = json_decode(join(readfile(s:project_file(a:file)), "\n"))
  return get(config, 'name', '')
endfunction

function! s:nearest_test(position) abort
  let name = test#base#nearest_test(a:position, g:test#javascript#patterns)
  return (len(name['namespace']) ? '^' : '') .
       \ test#base#escape_regex(join(name['namespace'] + name['test'])) .
       \ (len(name['test']) ? '$' : '')
endfunction
