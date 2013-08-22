" Open and close all the three plugins on the same time
nmap <F2> :TrinityToggleAll<CR>
" Open and close the srcexpl.vim separately
"nmap <F8> :TrinityToggleSourceExplorer<CR>
" Open and close the taglist.vim separately
nmap <F3> :TrinityToggleTagList<CR>
" Open and close the NERD_tree.vim separately
"nmap <F8> :TrinityToggleNERDTree<CR>

"set mouse=nv

"nmap <F2> <C-W>

set tabstop=8 "4
set nowrap
set hls

set viminfo='100,h

let search_max = 20
"let vimrc_debug = 1

if has("cscope")
	if exists("vimrc_debug") && vimrc_debug == 1
		echo "Searching cscope.out ..."
	endif

	let s:dir = fnamemodify(getcwd(), ":p:h")
	let i = 1
	while i <= search_max
		if exists("vimrc_debug") && vimrc_debug == 1
			echo s:dir
		endif

		if filereadable(s:dir . "/cscope.out")
			let $CSCOPE_DB = s:dir . "/cscope.out"
			break
		elseif s:dir == '/'
			break
		else
			let s:dir = fnamemodify(s:dir, ":h")
			let i += 1
		endif
	endwhile
endif

if &diff
	syntax off
endif

if exists("$GTAGSGLOBAL") || exists(":global")
	if exists("vimrc_debug") && vimrc_debug == 1
		echo "Searching GPATH, GTAGS, and GRTAGS ..."
	endif

	let s:dir = fnamemodify(getcwd(), ":p:h")
	let i = 1
	while i <= search_max
		if exists("vimrc_debug") && vimrc_debug == 1
			echo s:dir
		endif

		if filereadable(s:dir . "/GPATH") && filereadable(s:dir . "/GTAGS") && filereadable(s:dir . "/GRTAGS")
			let $GTAGSROOT = s:dir
			let GtagsCscope_Auto_Load = 1
			break
		elseif s:dir == '/'
			break
		else
			let s:dir = fnamemodify(s:dir, ":h")
			let i += 1
		endif
	endwhile
endif

