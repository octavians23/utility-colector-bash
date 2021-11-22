This is a utility that collects “well-known” files into convenient directory holders.

The utility should collect all executables, libraries, sources and includes from each directory given by the user into separate directories. By default, the allocation is as follows:

executables(*.exe) go to ~/bin

libraries(*.lib) go to ~/lib

sources(*.c, *.cc, *.cpp, *.cxx) go to ~/src

includes(*.h, *.hxx) go to ~/inc

The utility should ask whether another directory should be used in place of these default directories.

Each move is recorded in a log file having the date as name(located in the logs folder).

At the end,the utility should print statistics on file allocation: how many directories were processed, how many files in each category were moved and how long the reorganization was (the processing time in seconds).
