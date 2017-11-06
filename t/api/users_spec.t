use Raisin::Test;

use Test::More;
use Plack::Test;
use HTTP::Request::Common;

# getting application
my $app = load_psgi();

# load fixtures
#load_fixture('user');

test_psgi $app => sub {
  my $request = shift;
  my $user;

  describe 'POST /users' => sub {
    my $res = $request->(
      POST '/users',
      Content_Type => 'application/json',
      Content      => user_fixture()
    );

    it 'returns 201 status code' => sub {
      diag($res->content) unless is($res->code, 201);
    };
  };

  describe 'GET /users' => sub {
    my $res = $request->(GET '/users');
    $user = eval { json_parse($res->content)->{data}->[0] || {} };

    it 'returns 200 status code' => sub {
      diag($res->content) unless is($res->code, 200);
    };
  };

  describe 'PUT /users/:id' => sub {
    my $res = $request->(
      PUT "/users/@{[$user->{id}]}",
      Content_Type => 'application/json',
      Content      => json_generate({user => {first_name => 'User'}})
    );

    it 'returns 200 status code' => sub {
      diag($res->content) unless is($res->code, 200);
    };
    it 'returns success message' => sub {
      my $entity = json_parse($res->content);
      diag($res->content) unless is($entity->{first_name}, 'User');
    };
  };

  describe 'GET /users/:id' => sub {
    my $res = $request->(
      GET "/users/@{[$user->{id}]}",
      Content_Type => 'application/json',
    );

    it 'returns 200 status code' => sub {
      diag($res->content) unless is($res->code, 200);
    };
    it 'returns user data' => sub {
      my $entity = json_parse($res->content);
      diag($res->content) unless is($entity->{first_name}, 'User')
    };
  };



};

sub user_fixture {
  return json_generate(
    {
      user => {
        first_name => 'Thiago',
        last_name  => 'Rondon',
        password   => 'test',
        email      => 'test@test.com'
      }
    }
  );
}

done_testing;
