package Raisin::Test::Fixture;
use Object::Simple -base;

use Data::Faker;
use Raisin::Test::Utils;
use Raisin::Test::Fixture::Object;

# attributes
has 'faker'    => sub {Data::Faker->new};
has '_fixture' => sub { Raisin::Test::Fixture::Object->new };

sub alias {
  my ($self, $name) = @_;
  $self->_fixture->name($name);
  return $self->_fixture;
}


1;
