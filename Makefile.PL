use inc::Module::Install;
name 'WWW-Google-Calc';
all_from 'lib/WWW/Google/Calc.pm';

requires 'URI';
requires 'WWW::Mechanize';
requires 'Web::Scraper';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
