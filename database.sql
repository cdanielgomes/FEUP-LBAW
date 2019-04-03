-- Tables

CREATE TABLE cart
(
  id SERIAL PRIMARY KEY,
  date DATE DEFAULT current_date

);

CREATE TABLE "user"
(
  id SERIAL PRIMARY KEY,
  name text NOT NULL,
  username text NOT NULL CONSTRAINT username_uk UNIQUE,
  email text NOT NULL CONSTRAINT email_user_uk UNIQUE,
  password text NOT NULL,
  id_cart INTEGER NOT NULL REFERENCES "cart" (id) ON UPDATE CASCADE,
  is_admin BOOLEAN NOT NULL,
  is_manager BOOLEAN NOT NULL,
  is_premium BOOLEAN NOT NULL,
  deleted BOOLEAN NOT NULL

);

CREATE TABLE product
(
  id SERIAL PRIMARY KEY,
  name text NOT NULL CONSTRAINT name_uk UNIQUE,
  price FLOAT NOT NULL CONSTRAINT price_ck CHECK (price > 0),
  description text,
  stock INTEGER NOT NULL CONSTRAINT stock_ck CHECK (stock >= 0),
  score INTEGER NOT NULL CONSTRAINT score_ck CHECK ((score >= 0) OR (score <=5))

);

CREATE TABLE categories
(
  id SERIAL PRIMARY KEY,
  name text NOT NULL CONSTRAINT categories_name_uk UNIQUE,
  season text NOT NULL

);

CREATE TABLE review
(
  id SERIAL PRIMARY KEY,
  id_user INTEGER NOT NULL REFERENCES "user" (id) ON UPDATE CASCADE,
  id_product INTEGER NOT NULL REFERENCES "product" (id) ON UPDATE CASCADE,
  title text NOT NULL,
  description text,
  score INTEGER NOT NULL CONSTRAINT score_ck CHECK ((score >= 0) OR (score <=5))

);

CREATE TABLE "order"
(
  id SERIAL PRIMARY KEY,
  id_user INTEGER NOT NULL REFERENCES "user" (id) ON UPDATE CASCADE,
  date DATE DEFAULT current_date,
  total FLOAT NOT NULL CONSTRAINT total_ck CHECK (total >= 0),
  state text NOT NULL CONSTRAINT state_ck CHECK (state IN ('Processing', 'Delivered', 'Shipped'))
);

CREATE TABLE line_item
(
  id SERIAL PRIMARY KEY,
  id_product INTEGER NOT NULL REFERENCES "product" (id) ON UPDATE CASCADE,
  quantity INTEGER NOT NULL CONSTRAINT quantity_ck CHECK (quantity > 0),
  price FLOAT NOT NULL CONSTRAINT price_ck CHECK (price > 0)
);

CREATE TABLE line_item_order
(
  id_line_item INTEGER NOT NULL REFERENCES "line_item" (id) ON UPDATE CASCADE,
  id_order INTEGER NOT NULL REFERENCES "order" (id) ON UPDATE CASCADE,
  PRIMARY KEY (id_line_item)

);

CREATE TABLE line_item_cart
(
  id_line_item INTEGER NOT NULL REFERENCES "line_item" (id) ON UPDATE CASCADE,
  id_cart INTEGER NOT NULL REFERENCES "cart" (id) ON UPDATE CASCADE,
  PRIMARY KEY (id_line_item)

);

CREATE TABLE country
(
  id SERIAL PRIMARY KEY,
  name text NOT NULL
);

CREATE TABLE city
(
  id SERIAL PRIMARY KEY,
  id_country INTEGER NOT NULL REFERENCES "country" (id) ON UPDATE CASCADE,
  name text NOT NULL
);

CREATE TABLE address
(
  id SERIAL PRIMARY KEY,
  id_user INTEGER NOT NULL REFERENCES "user" (id) ON UPDATE CASCADE,
  id_city INTEGER NOT NULL REFERENCES "city" (id) ON UPDATE CASCADE,
  street text NOT NULL,
  zipCode text NOT NULL
);

CREATE TABLE color
(
  id SERIAL PRIMARY KEY,
  name text NOT NULL
);

CREATE TABLE size
(
  id SERIAL PRIMARY KEY,
  name text NOT NULL
);

CREATE TABLE brand
(
  id SERIAL PRIMARY KEY,
  name text NOT NULL
);

CREATE TABLE favorites
(
  id_user INTEGER NOT NULL REFERENCES "user" (id) ON UPDATE CASCADE,
  id_product INTEGER NOT NULL REFERENCES "product" (id) ON UPDATE CASCADE,
  PRIMARY KEY (id_user, id_product)
);

CREATE TABLE report
(
  id_review INTEGER NOT NULL REFERENCES "review" (id) ON UPDATE CASCADE,
  id_user_reportee INTEGER NOT NULL REFERENCES "user" (id) ON UPDATE CASCADE,
  PRIMARY KEY (id_review, id_user_reportee)
);

CREATE TABLE reportear
(
  id_review INTEGER NOT NULL REFERENCES "review" (id) ON UPDATE CASCADE,
  id_user_reportear INTEGER NOT NULL REFERENCES "user" (id) ON UPDATE CASCADE,
  PRIMARY KEY (id_review, id_user_reportear)
);

CREATE TABLE "analyze"
(
  id_review INTEGER NOT NULL REFERENCES "review" (id) ON UPDATE CASCADE,
  id_user_analyze INTEGER NOT NULL REFERENCES "user" (id) ON UPDATE CASCADE,
  PRIMARY KEY (id_review, id_user_analyze)
);

CREATE TABLE premium
(
  id_user INTEGER NOT NULL REFERENCES "user" (id) ON UPDATE CASCADE,
  discounts FLOAT NOT NULL CONSTRAINT discounts_ck CHECK (discounts > 0),
  PRIMARY KEY (id_user)
);

CREATE TABLE deleted
(
  id_user INTEGER NOT NULL REFERENCES "user" (id) ON UPDATE CASCADE,
  date DATE DEFAULT current_date,
  PRIMARY KEY (id_user)
);

CREATE TABLE standard
(
  id_user INTEGER NOT NULL REFERENCES "user" (id) ON UPDATE CASCADE,
  PRIMARY KEY (id_user)
);

CREATE TABLE storeManager
(
  id_user INTEGER NOT NULL REFERENCES "user" (id) ON UPDATE CASCADE,
  PRIMARY KEY (id_user)
);

CREATE TABLE administrator
(
  id_user INTEGER NOT NULL REFERENCES "user" (id) ON UPDATE CASCADE,
  PRIMARY KEY (id_user)
);

CREATE TABLE productColor
(
  id_product INTEGER NOT NULL REFERENCES "product" (id) ON UPDATE CASCADE,
  id_color INTEGER NOT NULL REFERENCES "color" (id) ON UPDATE CASCADE,
  PRIMARY KEY (id_product, id_color)
);

CREATE TABLE productSize
(
  id_product INTEGER NOT NULL REFERENCES "product" (id) ON UPDATE CASCADE,
  id_size INTEGER NOT NULL REFERENCES "size" (id) ON UPDATE CASCADE,
  PRIMARY KEY (id_product, id_size)
);

CREATE TABLE productBrand
(
  id_product INTEGER NOT NULL REFERENCES "product" (id) ON UPDATE CASCADE,
  id_brand INTEGER NOT NULL REFERENCES "brand" (id) ON UPDATE CASCADE,
  PRIMARY KEY (id_product, id_brand)
);

CREATE TABLE productCategories
(
  id_product INTEGER NOT NULL REFERENCES "product" (id) ON UPDATE CASCADE,
  id_categories INTEGER NOT NULL REFERENCES "categories" (id) ON UPDATE CASCADE,
  PRIMARY KEY (id_product, id_categories)
);