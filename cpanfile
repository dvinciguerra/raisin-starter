requires 'common::sense';

# web framework
requires 'Raisin';

requires 'Config::General';

# database perl orm
requires 'DBD::Pg';
requires 'App::Sqitch';
requires 'DateTime::Format::Pg';
requires 'DBIx::Class';
requires 'DBIx::Class::TimeStamp';
requires 'DBIx::Class::PassphraseColumn';

# logs and errors
requires 'Carp';
requires 'Try::Tiny';
requires 'Log::Log4perl';

# crypt and security
requires 'Crypt::PRNG';
requires 'Digest::SHA1';
requires 'Digest::HMAC_SHA1';


# oop featured
requires 'Object::Simple';

# json
requires 'JSON';
requires 'JSON::XS';

# psgi and server tools
requires 'Starman';
requires 'Server::Starter';
requires 'Net::Server::SS::PreFork';


on 'development' => sub {
  requires 'DDP';
  requires 'Perl::Tidy';
  requires 'App::Prove::Watch';
	requires 'DBIx::Class::Schema::Loader';
};


on 'test' => sub {
  requires 'Test::More';
  requires 'Test::Spec';
  requires 'Data::Fake';
  recommends 'App::Prove::Watch';
};

on 'production' => sub {
	requires 'Starman';
	requires 'Server::Starter';
	requires 'Net::Server::SS::PreFork';
};

