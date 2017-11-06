use common::sense;

use Raisin::API;

# setting app home dir
use Cwd qw/realpath/;
use FindBin ();
BEGIN { unshift @INC, "$FindBin::Bin/lib" }
BEGIN { $ENV{RAISIN_HOME} = realpath("$FindBin::Bin/../../") }

## logger plugin
plugin 'Logger', fallback => 1;
app->log(debug => 'Starting Raisin application...');

## cors plugin
middleware 'CrossOrigin',
  origins => '*',
  methods => [qw/DELETE GET HEAD OPTIONS PATCH POST PUT/],
  headers => [qw/accept authorization content-type api_key_token/];

## swagger plugin
plugin 'Swagger';
swagger_setup(
  # project title
  title       => 'Eokoe Raisin',
  description => 'Eokoe Raisin application example',

  # project contact
  contact => {
    name  => 'Daniel Vinciguerra',
    url   => 'http://github.com/eokoe',
    email => 'daniel@eokoe.com',
  },

  # project license
  license => {
    name => 'Perl license',
    url => 'http://dev.perl.org/licenses/'
  }
);


# set api format
api_format 'json';


# mount user endpoints
mount 'App::Controller::User';


run;
