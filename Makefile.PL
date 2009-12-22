use inc::Module::Install;

name       'Plack-App-Template-Declare';
all_from   'lib/Plack/App/Template/Declare.pm';
repository 'http://github.com/bestpractical/plack-app-template-declare';

requires 'Template::Declare';
requires 'Plack';

build_requires 'Test::Exception';

WriteAll;

