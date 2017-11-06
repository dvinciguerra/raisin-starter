-- Revert raisin:20171027163707-add_user from pg

BEGIN;

DROP TABLE "user";

COMMIT;
