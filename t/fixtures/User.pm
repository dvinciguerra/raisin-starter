package Raisin::Fixture::User;
use Raisin::Test::Fixture;

my $fixture = Raisin::Test::Fixture->new;
my $faker   = $fixture->faker;

sub user_fixture {
  return $fixture->alias('User')
    ->params(
      first_name => $faker->first_name,
      last_name  => $faker->last_name,
      password   => 'test',
      email      => $faker->email
    );
}

1;
