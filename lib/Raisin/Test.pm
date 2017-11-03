package Raisin::Test;

use utf8;
use strict;
use warnings;

# getting application home
use Cwd qw/realpath/;
use FindBin ();
BEGIN { $ENV{RAISIN_HOME} = realpath("$FindBin::Bin/../../") }

use DDP;
use JSON;
use Test::More;
use Plack::Util;
use Exporter::Auto;
use HTTP::Request::Common qw(GET POST PUT PATCH HEAD DELETE);


sub load_psgi {
  Plack::Util::load_psgi("$ENV{RAISIN_HOME}/app.psgi");
}


# VIM
# :r !perl -E 'say "sub rest_${_} {shift->(@{[uc($_)]} \@_)}" for qw/get post put patch delete/'
sub rest_get {shift->(GET @_)}
sub rest_post {shift->(POST @_)}
sub rest_put {shift->(PUT @_)}
sub rest_patch {shift->(PATCH @_)}
sub rest_delete {shift->(DELETE @_)}

sub json_generate {
  JSON::to_json($_[0])
}

sub json_parse {
  JSON::from_json($_[0])
}

sub inspect {
  p($_[0])
}

sub it($$) {
  subtest("\tit $_[0]", $_[1]);
}

sub describe($$) {
  subtest("$_[0]", $_[1]);
}

1;
