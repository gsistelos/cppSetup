func! cppSetup#Test()

	call append("$", className)
	call append("$", hppDefine)
endf

func! s:DeclareClass(pos, className)
	let content = [ 'class ' . a:className, '{' ]
	call add(content, 'private:')
	call add(content, 'public:')
	call add(content, '	' . a:className . '(void);')
	call add(content, '	' . a:className . '(const ' . a:className . ' &other);')
	call add(content, '	~' . a:className . '();')
	call add(content, '')
	call add(content, '	' . a:className . ' &operator=(const ' . a:className . ' &other);')
	call add(content, '};')

	call append(a:pos, content)
endf

func! cppSetup#Class(className)
	call s:DeclareClass(".", a:className)
endf

func! cppSetup#Hpp()
	let className = substitute(expand('%:r'), '\.', '_', 'g')
	let hppDefine = toupper(className) . '_HPP'

	call setline("$", [ '#ifndef ' . hppDefine, '#define ' . hppDefine, '' ])
	call s:DeclareClass("$", className)
	call append("$", [ '', '#endif /* ' . hppDefine . ' */' ])
endf

func! s:NewMethod(pos, return, className, name, params)
	let content = [ a:return . a:className . '::' . a:name . '(' . a:params . ')' ]
	call add(content, '{')
	call add(content, '}')

	call append(a:pos, content)
endf

func! cppSetup#Cpp()
	let className = substitute(expand('%:r'), '\.', '_', 'g')

	call setline("$", '#include "' . className . '.hpp"')
	call append("$", '')
	call s:NewMethod("$", '', className, className, 'void')
	call append("$", '')
	call s:NewMethod("$", '', className, className, 'const ' . className . ' &other')
	call append("$", '')
	call s:NewMethod("$", '', className, '~' . className, '')
	call append("$", '')
	call s:NewMethod("$", className . ' &', className, 'operator=', 'const ' . className . ' &other')
endf

func! cppSetup#Makefile(name)
	let content = [ 'NAME		=	' . a:name ]
	call add(content, '')
	call add(content, 'SRCS		=	main.cpp')
	call add(content, '')
	call add(content, 'OBJS		=	$(SRCS:.cpp=.o)')
	call add(content, '')
	call add(content, 'CXX			=	c++')
	call add(content, '')
	call add(content, 'CXXFLAGS	=	-Wall -Werror -Wextra -std=c++98')
	call add(content, '')
	call add(content, 'INCLUDE		=	-I.')
	call add(content, '')
	call add(content, 'FLAGS		=	')
	call add(content, '')
	call add(content, 'RM			=	rm -f')
	call add(content, '')
	call add(content, 'all: $(NAME)')
	call add(content, '')
	call add(content, '$(NAME): $(OBJS)')
	call add(content, '	$(CXX) $(INCLUDE) $(OBJS) $(FLAGS) -o $(NAME)')
	call add(content, '')
	call add(content, '.cpp.o:')
	call add(content, '	$(CXX) $(CXXFLAGS) -c $< -o $@')
	call add(content, '')
	call add(content, 'clean:')
	call add(content, '	$(RM) $(OBJS)')
	call add(content, '')
	call add(content, 'fclean:')
	call add(content, '	$(RM) $(OBJS) $(NAME)')
	call add(content, '')
	call add(content, 're: fclean all')
	call add(content, '')
	call add(content, '.PHONY: all clean fclean re')

	call setline("$", content)
endf
