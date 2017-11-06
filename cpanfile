requires 'parent';
requires 'common::sense';


# rest api framework
requires 'Raisin';


# orm & database
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


requires 'URI';
requires 'DateTime';
requires 'Data::UUID';
requires 'URI::Escape';
requires 'Exporter::Auto';
requires 'ExtUtils::MakeMaker';
requires 'App::ForkProve';
requires 'Data::Printer';
requires 'MIME::Base64';


on 'development' => sub {
  requires 'DDP';

  requires 'Perl::Tidy';
  requires 'App::Prove::Watch';
	requires 'DBIx::Class::Schema::Loader';
};


on 'test' => sub {
  requires 'Test::More';
  requires 'Test::Spec';
  requires 'Catalyst::Test';
  requires 'Data::Fake';
  recommends 'App::Prove::Watch';
};

on 'production' => sub {
	requires 'Starman';
	requires 'Server::Starter';
	requires 'Net::Server::SS::PreFork';
};

