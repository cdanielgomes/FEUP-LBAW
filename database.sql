-----------------------------------------
-- Drop old schmema
-----------------------------------------
DROP TABLE IF EXISTS productCategories CASCADE;
DROP TABLE IF EXISTS productBrand CASCADE;
DROP TABLE IF EXISTS productSize CASCADE;
DROP TABLE IF EXISTS productColor CASCADE;
DROP TABLE IF EXISTS administrator CASCADE;
DROP TABLE IF EXISTS storeManager CASCADE;
DROP TABLE IF EXISTS standard CASCADE;
DROP TABLE IF EXISTS deleted CASCADE;
DROP TABLE IF EXISTS premium CASCADE;
DROP TABLE IF EXISTS "analyze" CASCADE;
DROP TABLE IF EXISTS reportear CASCADE;
DROP TABLE IF EXISTS report CASCADE;
DROP TABLE IF EXISTS favorites CASCADE;
DROP TABLE IF EXISTS brand CASCADE;
DROP TABLE IF EXISTS size CASCADE;
DROP TABLE IF EXISTS color CASCADE;
DROP TABLE IF EXISTS address CASCADE;
DROP TABLE IF EXISTS city CASCADE;
DROP TABLE IF EXISTS country CASCADE;
DROP TABLE IF EXISTS line_item_cart CASCADE;
DROP TABLE IF EXISTS line_item_order CASCADE;
DROP TABLE IF EXISTS line_item CASCADE;
DROP TABLE IF EXISTS "order" CASCADE;
DROP TABLE IF EXISTS review CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS product CASCADE;
DROP TABLE IF EXISTS "user" CASCADE;
DROP TABLE IF EXISTS cart CASCADE;


-----------------------------------------
-- Tables
-----------------------------------------

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
 
-----------------------------------------
-- INDEXES
-----------------------------------------

CREATE INDEX username_user ON user USING hash (username);

CREATE INDEX address_id_user ON address USING hash (id_user);

CREATE INDEX favorites_id_user ON favorites USING hash (id_user);

CREATE INDEX order_id_user ON order USING hash (id_user);

CREATE INDEX review_id_product ON review USING hash (id_product);

CREATE INDEX product_price ON order USING btree (price);

CREATE INDEX product_category_id ON product_categories USING hash (id_product);

CREATE INDEX product_search ON product USING GIST (name);

-----------------------------------------
-- TRIGGERS and UDFs
----------------------------------------- 

CREATE FUNCTION update_product_score() RETURNS TRIGGER AS
$BODY$
BEGIN
	UPDATE product
	SET score = (AVG(score) FROM review WHERE id_product = New.product_id)
	WHERE "product_id" = New."product_id"
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER product_score AFTER INSERT OR UPDATE OR DELETE
ON review
EXECUTE PROCEDURE update_product_score();
