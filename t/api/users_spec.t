use Raisin::Test;

use Test::More;
use Plack::Test;
use HTTP::Request::Common;

# getting application
my $app = load_psgi();

test_psgi $app => sub {
  my $request = shift;

  describe 'POST /users' => sub {
    my $res = $request->(POST '/users',
      Content_Type => 'application/json',
      Content => user_fixture()
    );

    it 'returns 201 status code' => sub {
      diag($res->content) unless is($res->code, 201);
    };
  };

  describe 'GET /users' => sub {
    my $res = $request->(GET '/users');

    it 'returns 200 status code' => sub {
      diag($res->content) unless is($res->code, 200);
    };
  };

};

sub user_fixture {
  return json_generate({
    user => {
      first_name => 'Thiago',
      last_name  => 'Rondon',
      password   => 'test',
      email      => 'test@test.com'
    }
  });
}

done_testing;
