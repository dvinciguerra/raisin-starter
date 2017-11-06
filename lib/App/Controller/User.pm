package App::Controller::User;

use Raisin::API;

use List::Util qw(max);
use HTTP::Status qw(:constants);
use Types::Standard qw(HashRef Any Int Str);


my %USERS = ();

plugin 'Logger', fallback => 1;

desc 'Users API';
resource users => sub {


  ## GET /users
  summary 'List users';
  params(
    optional('start_at', type => Int, default => 0,  desc => 'Pager (start)'),
    optional('size',     type => Int, default => 10, desc => 'Pager (count)'),
  );
  get sub {
    my $params = shift;
    my @users
      = map { {id => $_, %{$USERS{$_}}} } sort { $a <=> $b } keys %USERS;
    { data => \@users, total => int(keys %USERS)};
  };

  summary 'Create new user';
  params(
    requires('user', type => HashRef, desc => 'User object',
      group {
        requires('first_name',type => Str, desc => 'First name'),
        requires('last_name', type => Str, desc => 'Last name'),
        requires('password',  type => Str, desc => 'User password'),
        requires('email',     type => Str, default => undef, regex => qr/.+\@.+/, desc => 'User email'),
      }
    ),
  );


  ## POST /users
  post sub {
    my $params = shift;
    my $id = max(keys %USERS) + 1;

    $params->{user}->{id} = $id;
    $USERS{$id} = $params->{user};

    res->status(HTTP_CREATED);
    {id => $id};
  };



  desc 'Actions on the user';
  params requires('id', type => Int, desc => 'User ID');
  route_param 'id' => sub {

    ## GET /users/:id
    summary 'Show user';
    get sub {
      my $params = shift;
      $USERS{$params->{id}};
    };

    summary 'Update user';
    params(
      requires('user', type => HashRef, desc => 'User object',
        group {
          optional('first_name',type => Str, desc => 'First name'),
          optional('last_name', type => Str, desc => 'Last name'),
          optional('password',  type => Str, desc => 'User password'),
          optional('email',     type => Str, default => undef, regex => qr/.+\@.+/, desc => 'User email'),
        }
      )
    );


    ## PUT /users/:id
    put sub {
      my $params  = shift;
      my $id      = $params->{id};
      my $user    = $USERS{$params->{id}};

      # user not found
      unless ($user) {
        res->status(HTTP_NOT_FOUND);
        return {message => 'entity_not_found'};
      }

      # update hash data
      $USERS{$id} = {(%{$params->{user}}, %$user)};

      res->status(HTTP_OK);
      $USERS{$id};
    };

    ## DELETE /users/:id
    summary 'Delete user';
    del sub {
      my $params = shift;
      delete $USERS{$params->{id}};
      res->status(HTTP_NO_CONTENT);
      undef;
    };
  };
};

1;
