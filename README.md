# cppSetup

A plugin to easily setup cpp classes, Makefile and functions in vim

## Usage

`:Class <name>`

Creates a base class `<name>`

`:Hpp`

Creates a base .hpp file containing a include guard (ifndef) and class declaration with a default constructor, copy constructor, default destructor and assignment operator overload

`:Cpp`

Creates a base .cpp file containing a include with the filename.hpp and the class implementations of a default constructor, copy constructor, default destructor and assignment operator overload

`:Makefile <name>`

Creates a base Makefile with variables and rules, `<name>` as the executable name
