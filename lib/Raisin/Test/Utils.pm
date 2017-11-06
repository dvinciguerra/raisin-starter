package Raisin::Test::Utils;
use utf8;

use JSON ();
use Exporter::Auto;

sub json_generate {
  JSON::to_json($_[0]);
}

sub json_parse {
  JSON::from_json($_[0]);
}


1;
