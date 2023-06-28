if exists("g:loaded_cppSetup")
	finish
endif

let g:loaded_cppSetup = 1

command! -nargs=1 Class		call cppSetup#Class(<f-args>)
command! -nargs=0 Hpp		call cppSetup#Hpp()
command! -nargs=0 Cpp		call cppSetup#Cpp()
command! -nargs=1 Makefile	call cppSetup#Makefile(<f-args>)
command! -nargs=0 Test		call cppSetup#Test()
