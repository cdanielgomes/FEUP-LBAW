-- Types

-- Tables

CREATE TABLE "user" (
  id SERIAL PRIMARY KEY,
  name text NOT NULL,
  username text NOT NULL,
  email text NOT NULL CONSTRAINT user_email_uk UNIQUE,
  password text NOT NULL,
  is_admin BOOLEAN NOT NULL
  is_manager BOOLEAN NOT NULL,

);


CREATE TABLE review (
  id_user INTEGER PRIMARY KEY REFERENCES "user" (id) ON UPDATE CASCADE,
  description text NOT NULL,
  "date" TIMESTAMP WITH TIME zone DEFAULT now() NOT NULL,
  score INTEGER NOT NULL CONSTRAINT score_check CHECK (((score > 0) OR (score <= 5)))
);

CREATE TABLE product (
  name text NOT NULL,
  description text NOT NULL,
  stock INTEGER NOT NULL,
  price INTEGER NOT NULL CONSTRAINT price_check CHECK (((price > 0),
  score INTEGER NOT NULL CONSTRAINT score_check CHECK (((score > 0) OR (score <= 5)))

);
