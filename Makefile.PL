use inc::Module::Install;
name 'DBI-Executed';
all_from 'lib/DBI/Executed.pm';

requires 'DBI';
build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
