" space-man.vim - Whitespace manager
" Author:       Rich Russon (flatcap) <rich@flatcap.org>
" Website:      https://flatcap.org
" Copyright:    2015 Richard Russon
" License:      GPLv3 <http://fsf.org/>
" Version:      1.0

if (exists ('g:loaded_space_man') || &cp || (v:version < 700))
	finish
endif
let g:loaded_space_man = 1

" wrap up all the space manipulating

" tidy whitespace
"	actions:
"		delete leading space
"		delete trailing space
"		delete space errors (space-tab)
"
"	work on:
"		line
"		visual
"		file
"		window
"		buffer
"		args

" delete empty lines
"	actions:
"		delete empty lines
"		delete empty lines at top of file (space-g)
"		delete empty lines at bottom of file (space-G)
"
"	work on:
"		file
"		window
"		buffer
"		args

" tabby
"	actions:
"		expand tab
"		unexpand tab
"
"	work on:
"		line
"		visual
"		file
"		window
"		buffer
"		args

" resize tabs
"	actions:
"
"	use coded count?
"	48<motion> => tabsize 4 -> tabsize 8
"	84<motion> => tabsize 8 -> tabsize 4

" vim:set noet ts=8 sw=8:
