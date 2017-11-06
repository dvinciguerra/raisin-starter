package Raisin::Test::Fixture::Object;
use Object::Simple -base;

use Raisin::Test::Utils;

# attributes
has '_name' => '';
has '_params' => sub{ {} };

sub name {
  my ($self, $name) = @_;
  $self->_name($name);
  $self
}

sub params {
  my ($self, %args) = @_;
  $self->{_params} = $self->_hash_merge($self->_params, \%args);
  return $self
}


sub get_name {
  return $_[0]->_name
}

sub get_params {
  return $_[0]->_params
}

# helper to merge hashes
sub _hash_merge {
  my ($self, $old, $new) = @_;
  return {(%$old, %$new)}
}

# return as hash
sub to_hash {
  return shift->_params;
}

# return as json
sub to_json {
  return json_generate(shift->params);
}

1;
