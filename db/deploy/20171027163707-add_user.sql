-- Deploy raisin:20171027163707-add_user to pg

BEGIN;

CREATE TABLE "user"
(
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  first_name text NOT NULL,
  last_name text,
  email text NOT NULL,
  password text NOT NULL,
  created_at timestamp without time zone NOT NULL DEFAULT now(),
  updated_at timestamp without time zone,
  CONSTRAINT user_pk PRIMARY KEY (id),
  CONSTRAINT user_email_unq UNIQUE (email)
);

COMMIT;
