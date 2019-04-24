-----------------------------------------
-- Drop old schmema
-----------------------------------------
DROP TABLE IF EXISTS product_categories CASCADE;
DROP TABLE IF EXISTS product_brand CASCADE;
DROP TABLE IF EXISTS product_size CASCADE;
DROP TABLE IF EXISTS product_color CASCADE;
DROP TABLE IF EXISTS administrator CASCADE;
DROP TABLE IF EXISTS store_manager CASCADE;
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
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS "user" CASCADE;
DROP TABLE IF EXISTS cart CASCADE;
DROP TRIGGER IF EXISTS product_score ON review;
DROP TRIGGER IF EXISTS set_users ON users;
DROP TRIGGER IF EXISTS update_total_line ON line_item;
DROP TRIGGER IF EXISTS update_stock ON line_item_order;
DROP TRIGGER IF EXISTS deleteProd ON product;




-----------------------------------------
-- Tables
-----------------------------------------

CREATE TABLE cart
(
  id SERIAL PRIMARY KEY,
  date DATE DEFAULT current_date

);

CREATE TABLE users
(
  id SERIAL PRIMARY KEY,
  name text NOT NULL,
  username text NOT NULL CONSTRAINT username_uk UNIQUE,
  email text NOT NULL CONSTRAINT email_user_uk UNIQUE,
  password text NOT NULL,
  id_cart INTEGER REFERENCES "cart" (id) ON UPDATE CASCADE,
  is_admin BOOLEAN NOT NULL,
  is_manager BOOLEAN NOT NULL,
  is_premium BOOLEAN NOT NULL,
  deleted BOOLEAN NOT NULL,
  remember_token TEXT

);

CREATE TABLE product
(
  id SERIAL PRIMARY KEY,
  name text NOT NULL CONSTRAINT name_uk UNIQUE,
  price FLOAT NOT NULL CONSTRAINT price_ck CHECK (price > 0),
  description text,
  deleted BOOLEAN DEFAULT TRUE,
  stock INTEGER NOT NULL CONSTRAINT stock_ck CHECK (stock >= 0),
  score INTEGER NOT NULL CONSTRAINT score_ck DEFAULT 0 CHECK ((score >= 0) OR (score <=5))

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
  id_user INTEGER NOT NULL REFERENCES users (id) ON UPDATE CASCADE,
  id_product INTEGER NOT NULL REFERENCES "product" (id) ON UPDATE CASCADE,
  title text NOT NULL,
  description text,
  score INTEGER NOT NULL CONSTRAINT score_ck CHECK ((score >= 0) OR (score <=5))

);

CREATE TABLE "order"
(
  id SERIAL PRIMARY KEY,
  id_user INTEGER NOT NULL REFERENCES users (id) ON UPDATE CASCADE,
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
  id_user INTEGER NOT NULL REFERENCES users (id) ON UPDATE CASCADE,
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
  id_user INTEGER NOT NULL REFERENCES users (id) ON UPDATE CASCADE,
  id_product INTEGER NOT NULL REFERENCES "product" (id) ON UPDATE CASCADE,
  PRIMARY KEY (id_user, id_product)
);

CREATE TABLE report
(
  id_review INTEGER NOT NULL REFERENCES "review" (id) ON UPDATE CASCADE,
  id_user_reportee INTEGER NOT NULL REFERENCES users (id) ON UPDATE CASCADE,
  PRIMARY KEY (id_review, id_user_reportee)
);

CREATE TABLE reportear
(
  id_review INTEGER NOT NULL REFERENCES "review" (id) ON UPDATE CASCADE,
  id_user_reportear INTEGER NOT NULL REFERENCES users (id) ON UPDATE CASCADE,
  PRIMARY KEY (id_review, id_user_reportear)
);

CREATE TABLE "analyze"
(
  id_review INTEGER NOT NULL REFERENCES "review" (id) ON UPDATE CASCADE,
  id_user_analyze INTEGER NOT NULL REFERENCES users (id) ON UPDATE CASCADE,
  PRIMARY KEY (id_review, id_user_analyze)
);

CREATE TABLE premium
(
  id_user INTEGER NOT NULL REFERENCES users (id) ON UPDATE CASCADE,
  discounts FLOAT NOT NULL CONSTRAINT discounts_ck CHECK (discounts > 0),
  PRIMARY KEY (id_user)
);

CREATE TABLE deleted
(
  id_user INTEGER NOT NULL REFERENCES users (id) ON UPDATE CASCADE,
  date DATE DEFAULT current_date,
  PRIMARY KEY (id_user)
);

CREATE TABLE standard
(
  id_user INTEGER NOT NULL REFERENCES users (id) ON UPDATE CASCADE,
  PRIMARY KEY (id_user)
);

CREATE TABLE store_manager
(
  id_user INTEGER NOT NULL REFERENCES users (id) ON UPDATE CASCADE,
  PRIMARY KEY (id_user)
);

CREATE TABLE administrator
(
  id_user INTEGER NOT NULL REFERENCES users (id) ON UPDATE CASCADE,
  PRIMARY KEY (id_user)
);

CREATE TABLE product_color
(
  id_product INTEGER NOT NULL REFERENCES "product" (id) ON UPDATE CASCADE,
  id_color INTEGER NOT NULL REFERENCES "color" (id) ON UPDATE CASCADE,
  PRIMARY KEY (id_product, id_color)
);

CREATE TABLE product_size
(
  id_product INTEGER NOT NULL REFERENCES "product" (id) ON UPDATE CASCADE,
  id_size INTEGER NOT NULL REFERENCES "size" (id) ON UPDATE CASCADE,
  PRIMARY KEY (id_product, id_size)
);

CREATE TABLE product_brand
(
  id_product INTEGER NOT NULL REFERENCES "product" (id) ON UPDATE CASCADE,
  id_brand INTEGER NOT NULL REFERENCES "brand" (id) ON UPDATE CASCADE,
  PRIMARY KEY (id_product, id_brand)
);

CREATE TABLE product_categories
(
  id_product INTEGER NOT NULL REFERENCES "product" (id) ON UPDATE CASCADE,
  id_categories INTEGER NOT NULL REFERENCES "categories" (id) ON UPDATE CASCADE,
  PRIMARY KEY (id_product, id_categories)
);
 
-----------------------------------------
-- INDEXES
-----------------------------------------

CREATE INDEX username_user ON users USING hash (username);

CREATE INDEX address_id_user ON address USING hash (id_user);

CREATE INDEX favorites_id_user ON favorites USING hash (id_user);

CREATE INDEX order_id_user ON "order" USING hash (id_user);

CREATE INDEX review_id_product ON review USING hash (id_product);

CREATE INDEX product_price ON "order" USING btree (total);

CREATE INDEX product_category_id ON product_categories USING hash (id_product);

CREATE INDEX product_search ON product USING GIST (to_tsvector('english', name));

-----------------------------------------
-- TRIGGERS and UDFs
-----------------------------------------

CREATE OR REPLACE FUNCTION update_product_score() RETURNS TRIGGER AS
$BODY$
BEGIN
	UPDATE product
	SET score = (SELECT avg(review.score) FROM review WHERE id_product = New.id_product)
	WHERE id = New.id_product;

  RETURN NULL;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER product_score AFTER INSERT OR UPDATE
ON review
FOR EACH ROW  
EXECUTE PROCEDURE update_product_score();

-- insert users

CREATE OR REPLACE FUNCTION insert_standard_users() RETURNS TRIGGER AS 
$BODY$
BEGIN 
    CASE
    WHEN NEW.is_admin THEN
     INSERT INTO administrator(id_user) VALUES(NEW.id);
    WHEN NEW.is_premium THEN 
     INSERT INTO premium(id_user, discounts) VALUES(NEW.id, 20);
    WHEN NEW.is_manager THEN
     INSERT INTO store_manager(id_user) VALUES(NEW.id);
    ELSE INSERT INTO standard(id_user) VALUES(NEW.id);
    END CASE;

RETURN NULL;

END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER set_users AFTER INSERT ON users 
FOR EACH ROW  
EXECUTE PROCEDURE insert_standard_users();



-- update de price in a line 
CREATE OR REPLACE  FUNCTION update_total() RETURNS TRIGGER AS
$BODY$
BEGIN
    UPDATE line_item
    SET price  = (SELECT price FROM product WHERE id = id_product) * quantity
    where id = new.id;

RETURN NULL;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER update_total_line AFTER INSERT ON line_item 
FOR EACH ROW
EXECUTE PROCEDURE update_total();


-- update quantity of stock

CREATE OR REPLACE FUNCTION setStock() RETURNS TRIGGER AS
$BODY$
BEGIN 
IF NOT EXISTS (SELECT * FROM product, line_item WHERE product.id = line_item.id_product AND new.id_line_item = line_item.id AND stock >= line_item.quantity) THEN 
    RAISE EXCEPTION 'YOU CAN NOT BUY That number of ITEMS';
ELSE
    UPDATE product SET stock = stock - line_item.quantity FROM line_item WHERE product.id = line_item.id_product and  new.id_line_item = line_item.id;
END IF;

RETURN NULL;
END
$BODY$
LANGUAGE plpgsql;



CREATE TRIGGER update_stock BEFORE INSERT ON line_item_order 
FOR EACH ROW 
EXECUTE PROCEDURE setStock();

-- delete all products

CREATE OR REPLACE FUNCTION removeProducts() RETURNS TRIGGER AS
$BODY$
BEGIN
IF new.deleted = TRUE THEN 
    DELETE FROM favorites WHERE favorites.id_product = NEW.id;
    DELETE FROM product_categories where product_categories.id_product = NEW.id;

    IF EXISTS (SELECT id_line_item, id, id_product from line_item_cart, line_item where id = id_line_item and id_product = new.id) THEN 
        DELETE FROM line_item_cart USING line_item where line_item.id = line_item_cart.id_line_item and new.id = line_item.id_product; 
        DELETE from line_item where new.id = line_item.id_product;
    END IF;

END IF;

RETURN NULL;
END

$BODY$
LANGUAGE plpgsql;


CREATE TRIGGER deleteProd AFTER UPDATE ON product 
FOR EACH ROW
EXECUTE PROCEDURE removeProducts();

-----------------------------------------
-- cart
-----------------------------------------

INSERT INTO cart (id, date) VALUES (1, '2019/12/02');
INSERT INTO cart (id, date) VALUES (2, '2022/01/18');
INSERT INTO cart (id, date) VALUES (3, '2023/02/19');
INSERT INTO cart (id, date) VALUES (4, '2021/08/10');
INSERT INTO cart (id, date) VALUES (5, '2020/12/01');
INSERT INTO cart (id, date) VALUES (6, '2018/05/22');
INSERT INTO cart (id, date) VALUES (7, '2022/04/19');
INSERT INTO cart (id, date) VALUES (8, '2021/08/05');
INSERT INTO cart (id, date) VALUES (9, '2018/11/06');
INSERT INTO cart (id, date) VALUES (10, '2018/12/30');
INSERT INTO cart (id, date) VALUES (11, '2023/01/02');
INSERT INTO cart (id, date) VALUES (12, '2022/09/29');
INSERT INTO cart (id, date) VALUES (13, '2021/06/15');
INSERT INTO cart (id, date) VALUES (14, '2021/03/31');
INSERT INTO cart (id, date) VALUES (15, '2019/07/08');
INSERT INTO cart (id, date) VALUES (16, '2023/04/29');
INSERT INTO cart (id, date) VALUES (17, '2021/05/13');
INSERT INTO cart (id, date) VALUES (18, '2018/10/28');
INSERT INTO cart (id, date) VALUES (19, '2019/07/26');
INSERT INTO cart (id, date) VALUES (20, '2019/12/22');
INSERT INTO cart (id, date) VALUES (21, '2018/08/17');
INSERT INTO cart (id, date) VALUES (22, '2021/11/12');
INSERT INTO cart (id, date) VALUES (23, '2021/04/16');
INSERT INTO cart (id, date) VALUES (24, '2019/01/23');
INSERT INTO cart (id, date) VALUES (25, '2022/11/25');
INSERT INTO cart (id, date) VALUES (26, '2019/04/07');
INSERT INTO cart (id, date) VALUES (27, '2022/12/01');
INSERT INTO cart (id, date) VALUES (28, '2023/07/26');
INSERT INTO cart (id, date) VALUES (29, '2020/07/11');
INSERT INTO cart (id, date) VALUES (30, '2018/08/24');
INSERT INTO cart (id, date) VALUES (31, '2020/04/21');
INSERT INTO cart (id, date) VALUES (32, '2021/03/31');
INSERT INTO cart (id, date) VALUES (33, '2021/03/12');
INSERT INTO cart (id, date) VALUES (34, '2020/09/14');
INSERT INTO cart (id, date) VALUES (35, '2022/08/25');
INSERT INTO cart (id, date) VALUES (36, '2020/06/13');
INSERT INTO cart (id, date) VALUES (37, '2021/06/30');
INSERT INTO cart (id, date) VALUES (38, '2020/09/24');
INSERT INTO cart (id, date) VALUES (39, '2019/12/19');
INSERT INTO cart (id, date) VALUES (40, '2018/05/04');
INSERT INTO cart (id, date) VALUES (41, '2019/04/22');
INSERT INTO cart (id, date) VALUES (42, '2021/10/01');
INSERT INTO cart (id, date) VALUES (43, '2019/07/27');
INSERT INTO cart (id, date) VALUES (44, '2019/08/09');
INSERT INTO cart (id, date) VALUES (45, '2019/05/09');
INSERT INTO cart (id, date) VALUES (46, '2019/10/27');
INSERT INTO cart (id, date) VALUES (47, '2023/05/28');
INSERT INTO cart (id, date) VALUES (48, '2021/02/07');
INSERT INTO cart (id, date) VALUES (49, '2023/08/17');
INSERT INTO cart (id, date) VALUES (50, '2021/06/08');

-----------------------------------------
-- users 
-----------------------------------------

INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (1, 'user', 'user', 'ghalhead0@mlb.com', '$2y$12$xqJe1BDygV3tiCKv3kCTyO92Oyd3jnL8RGcmze0xb2XnRL13KmEpu', 1, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (2, 'Lacey Jorn', 'ljorn1', 'ljorn1@microsoft.com', 'kUpzFTe', 2, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (3, 'Hank Matthaus', 'hmatthaus2', 'hmatthaus2@g.co', 'wGZDjBvHBv', 3, false, false, false, true);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (4, 'Tessa Bromet', 'tbromet3', 'tbromet3@twitter.com', 'kjFjyEk', 4, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (5, 'Sacha Syred', 'ssyred4', 'ssyred4@wp.com', 'dBkmxIoPC', 5, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (6, 'Bert Volke', 'bvolke5', 'bvolke5@posterous.com', 'Nd7cJoQ1ROZ0', 6, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (7, 'Teodora Collens', 'tcollens6', 'tcollens6@google.com', 'tC7fxIcXpxu', 7, false, false, true, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (8, 'Clarine Roswarn', 'croswarn7', 'croswarn7@economist.com', 'Hu5cSRclBAou', 8, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (9, 'Judy Stote', 'jstote8', 'jstote8@telegraph.co.uk', 'wAFyiO', 9, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (10, 'Melanie Fillon', 'mfillon9', 'mfillon9@simplemachines.org', 'djYN63s', 10, false, false, true, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (11, 'Darrel Louder', 'dloudera', 'dloudera@paginegialle.it', 'a3nBuNl', 11, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (12, 'Layla Ewell', 'lewellb', 'lewellb@etsy.com', 'Wb2vMbvdy', 12, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (13, 'Ross Grigorescu', 'rgrigorescuc', 'rgrigorescuc@nasa.gov', 'XvkMLLj', 13, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (14, 'Beaufort Canter', 'bcanterd', 'bcanterd@dot.gov', 'Hq5uGz', 14, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (15, 'Sonnie Lemasney', 'slemasneye', 'slemasneye@patch.com', '6fUffqV3', 15, false, false, true, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (16, 'Ewell Irwin', 'eirwinf', 'eirwinf@hexun.com', '8ILlOJb1t', 16, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (17, 'Poul Lansberry', 'plansberryg', 'plansberryg@patch.com', 'QMPyvW', 17, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (18, 'Marylinda Licari', 'mlicarih', 'mlicarih@google.ca', 'TQJ2GGpc2ME', 18, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (19, 'Benita Alwell', 'balwelli', 'balwelli@wix.com', 'BPhAojIt', 19, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (20, 'Tammy Zaczek', 'tzaczekj', 'tzaczekj@amazonaws.com', '1IuFt4', 20, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (21, 'Valeria Auton', 'vautonk', 'vautonk@ft.com', 'yEPcN15E', 21, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (22, 'Hildagarde Hargate', 'hhargatel', 'hhargatel@pagesperso-orange.fr', '5kQdqsTY63eB', 22, false, false, true, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (23, 'Brit Polson', 'bpolsonm', 'bpolsonm@shareasale.com', '9MDCv0Wx', 23, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (24, 'Maurise Czaja', 'mczajan', 'mczajan@java.com', 'hTJylxOpnbJx', 24, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (25, 'Daphne Emanuel', 'demanuelo', 'demanuelo@spiegel.de', '3gN5w8rrWs', 25, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (26, 'Bill McGeagh', 'bmcgeaghp', 'bmcgeaghp@lulu.com', 'SpBr9VnP3', 26, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (27, 'Cookie Creigan', 'ccreiganq', 'ccreiganq@webnode.com', 'lWU1MPLtCUv', 27, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (28, 'Damian Dukelow', 'ddukelowr', 'ddukelowr@altervista.org', 'tnONDendzNr', 28, false, false, false, true);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (29, 'Gavan Kinker', 'gkinkers', 'gkinkers@cloudflare.com', 'RneFUOyLA', 29, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (30, 'Elset Rudall', 'erudallt', 'erudallt@hc360.com', 'PP3zDuT9', 30, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (31, 'Lynnette Hearnes', 'lhearnesu', 'lhearnesu@angelfire.com', 'kMoRnrKd2PD', 31, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (32, 'Den Elsegood', 'delsegoodv', 'delsegoodv@state.gov', 'kUf4RA84GVyi', 32, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (33, 'Annabelle Bentke', 'abentkew', 'abentkew@msu.edu', '5mPbbeZW', 33, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (34, 'Corabelle Ascraft', 'cascraftx', 'cascraftx@delicious.com', '0RacTW85mG', 34, false, true, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (35, 'Garrik Spirritt', 'gspirritty', 'gspirritty@icio.us', 'p4mSWnS', 35, true, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (36, 'Osbourne Fylan', 'ofylanz', 'ofylanz@dedecms.com', 'ujVIpac', 36, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (37, 'Claretta Blacklawe', 'cblacklawe10', 'cblacklawe10@youtu.be', 'gWjBWO9ecxtN', 37, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (38, 'Tommi Fallon', 'tfallon11', 'tfallon11@mysql.com', 'O7uVgk', 38, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (39, 'Melantha Teague', 'mteague12', 'mteague12@intel.com', 'WCEdNA7s', 39, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (40, 'Lizabeth Isacke', 'lisacke13', 'lisacke13@tripod.com', 'WZiPSD90HQI1', 40, false, false, false, true);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (41, 'Sigrid Borthwick', 'sborthwick14', 'sborthwick14@cbc.ca', 'RFQYCGjT', 41, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (42, 'Ulberto Scholard', 'uscholard15', 'uscholard15@dagondesign.com', 'pYyvkE', 42, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (43, 'Colene Fennelow', 'cfennelow16', 'cfennelow16@dailymail.co.uk', 'QxQJwJew7', 43, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (44, 'Revkah Zapatero', 'rzapatero17', 'rzapatero17@bbc.co.uk', 'xRogmOsuAj', 44, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (45, 'Editha Mableson', 'emableson18', 'emableson18@fema.gov', 'QJoAnqXhRU', 45, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (46, 'Gabriel Ashwin', 'gashwin19', 'gashwin19@flickr.com', 'uyItdeNbcg', 46, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (47, 'Joyann Villa', 'jvilla1a', 'jvilla1a@hp.com', 'mbZHXXTy', 47, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (48, 'Colleen Greenmon', 'cgreenmon1b', 'cgreenmon1b@barnesandnoble.com', 'zovT3VWH', 48, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (49, 'Aldric Knell', 'aknell1c', 'aknell1c@newyorker.com', 'zJQF8EWQZ00D', 49, false, false, false, false);
INSERT INTO users (id, name, username, email, password, id_cart, is_admin, is_manager, is_premium, deleted) VALUES (50, 'Fernande Cornilleau', 'fcornilleau1d', 'fcornilleau1d@xrea.com', 'jOWX2YyMgEeM', 50, false, false, false, true);

-----------------------------------------
-- product
-----------------------------------------

INSERT INTO product (id, name, price, description, stock, score) VALUES (1, 'Bog Beggarticks', 24.0, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.', 82, 4.0);
INSERT INTO product (id, name, price, description, stock, score) VALUES (2, 'Pale Indian Paintbrush', 94.04, 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', 27, 3.6);
INSERT INTO product (id, name, price, description, stock, score) VALUES (3, 'Laurel Espada', 24.24, 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', 61, 1.7);
INSERT INTO product (id, name, price, description, stock, score) VALUES (4, 'Shining Blazingstar', 51.27, 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.', 85, 4.0);
INSERT INTO product (id, name, price, description, stock, score) VALUES (5, 'Sheep Milkvetch', 78.15, 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', 10, 3.2);
INSERT INTO product (id, name, price, description, stock, score) VALUES (6, 'Wachendorfia', 67.72, 'Fusce consequat. Nulla nisl. Nunc nisl.', 87, 0.5);
INSERT INTO product (id, name, price, description, stock, score) VALUES (7, 'Humboldt''s Lily', 60.09, 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', 97, 4.7);
INSERT INTO product (id, name, price, description, stock, score) VALUES (8, 'Canadian Rim Lichen', 63.85, 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.', 17, 4.9);
INSERT INTO product (id, name, price, description, stock, score) VALUES (9, 'Soft Brome', 74.54, 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', 15, 0.6);
INSERT INTO product (id, name, price, description, stock, score) VALUES (10, 'Wheelscale Saltbush', 81.05, 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.', 22, 0.7);
INSERT INTO product (id, name, price, description, stock, score) VALUES (11, 'Orange Lichen', 75.48, 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', 60, 3.6);
INSERT INTO product (id, name, price, description, stock, score) VALUES (12, 'Slenderleaf False Foxglove', 41.66, 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', 53, 1.4);
INSERT INTO product (id, name, price, description, stock, score) VALUES (13, 'Beet', 66.53, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.', 73, 3.7);
INSERT INTO product (id, name, price, description, stock, score) VALUES (14, 'Largeleaf Phlox', 85.69, 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.', 14, 3.4);
INSERT INTO product (id, name, price, description, stock, score) VALUES (15, 'Fuchsia Begonia', 56.08, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.', 22, 3.2);
INSERT INTO product (id, name, price, description, stock, score) VALUES (16, 'Mexican Avocado', 71.59, 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', 16, 1.5);
INSERT INTO product (id, name, price, description, stock, score) VALUES (17, 'Spanish Arborvine', 43.39, 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.', 45, 2.0);
INSERT INTO product (id, name, price, description, stock, score) VALUES (18, 'California Laurel', 89.31, 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.', 51, 0.7);
INSERT INTO product (id, name, price, description, stock, score) VALUES (19, 'Short''s Spreading Chervil', 52.33, 'Fusce consequat. Nulla nisl. Nunc nisl.', 89, 2.6);
INSERT INTO product (id, name, price, description, stock, score) VALUES (20, 'Douglas'' Buckwheat', 62.34, 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.', 3, 1.2);
INSERT INTO product (id, name, price, description, stock, score) VALUES (21, 'Cola', 85.06, 'In congue. Etiam justo. Etiam pretium iaculis justo.', 1, 2.6);
INSERT INTO product (id, name, price, description, stock, score) VALUES (22, 'Hawkweed Oxtongue', 28.13, 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.', 38, 4.8);
INSERT INTO product (id, name, price, description, stock, score) VALUES (23, 'Kamchatka Globeflower', 21.42, 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', 88, 2.8);
INSERT INTO product (id, name, price, description, stock, score) VALUES (24, 'Mulberry', 84.96, 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.', 74, 1.1);
INSERT INTO product (id, name, price, description, stock, score) VALUES (25, 'Fiveleaf Cinquefoil', 97.95, 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.', 7, 1.5);
INSERT INTO product (id, name, price, description, stock, score) VALUES (26, 'Whorl-leaf Watermilfoil', 78.13, 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', 98, 1.9);
INSERT INTO product (id, name, price, description, stock, score) VALUES (27, 'Cup Lichen', 86.15, 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.', 38, 4.3);
INSERT INTO product (id, name, price, description, stock, score) VALUES (28, 'Texas Ringstem', 54.97, 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.', 24, 1.4);
INSERT INTO product (id, name, price, description, stock, score) VALUES (29, 'Smooth Northern-rockcress', 70.79, 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.', 58, 1.2);
INSERT INTO product (id, name, price, description, stock, score) VALUES (30, 'Catalina Nightshade', 67.13, 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.', 76, 1.2);
INSERT INTO product (id, name, price, description, stock, score) VALUES (31, 'Philonotis Moss', 90.96, 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.', 78, 4.7);
INSERT INTO product (id, name, price, description, stock, score) VALUES (32, 'Tomentose Gopherweed', 96.66, 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', 62, 3.2);
INSERT INTO product (id, name, price, description, stock, score) VALUES (33, 'Standley''s Bloodleaf', 81.12, 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', 22, 2.7);
INSERT INTO product (id, name, price, description, stock, score) VALUES (34, 'Dunn''s Lobelia', 63.45, 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.', 77, 3.1);
INSERT INTO product (id, name, price, description, stock, score) VALUES (35, 'Wildrye', 82.25, 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.', 59, 1.0);
INSERT INTO product (id, name, price, description, stock, score) VALUES (36, 'Coral Phyllopsora Lichen', 94.21, 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.', 9, 4.4);
INSERT INTO product (id, name, price, description, stock, score) VALUES (37, 'South African Oatgrass', 89.95, 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', 87, 3.5);
INSERT INTO product (id, name, price, description, stock, score) VALUES (38, 'Barneby''s Phacelia', 47.58, 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 21, 3.9);
INSERT INTO product (id, name, price, description, stock, score) VALUES (39, 'Paulownia', 45.83, 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.', 84, 1.1);
INSERT INTO product (id, name, price, description, stock, score) VALUES (40, 'Los Alamos Beardtongue', 36.59, 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.', 72, 2.1);
INSERT INTO product (id, name, price, description, stock, score) VALUES (41, 'Lecidea Lichen', 33.51, 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 6, 1.5);
INSERT INTO product (id, name, price, description, stock, score) VALUES (42, 'Dwarf Chamaesaracha', 89.19, 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.', 16, 0.5);
INSERT INTO product (id, name, price, description, stock, score) VALUES (43, 'Hoover''s Deserttrumpet', 50.62, 'Phasellus in felis. Donec semper sapien a libero. Nam dui.', 5, 1.6);
INSERT INTO product (id, name, price, description, stock, score) VALUES (44, 'Elaeagnus Willow', 56.41, 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.', 88, 1.9);
INSERT INTO product (id, name, price, description, stock, score) VALUES (45, 'Beaked Spikerush', 74.39, 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.', 83, 3.2);
INSERT INTO product (id, name, price, description, stock, score) VALUES (46, 'Pohlia Moss', 99.18, 'Phasellus in felis. Donec semper sapien a libero. Nam dui.', 81, 0.5);
INSERT INTO product (id, name, price, description, stock, score) VALUES (47, 'Duncan''s Foxtail Cactus', 70.6, 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.', 46, 0.1);
INSERT INTO product (id, name, price, description, stock, score) VALUES (48, 'Winter Vetch', 93.94, 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 92, 2.2);
INSERT INTO product (id, name, price, description, stock, score) VALUES (49, 'Neofuscelia Lichen', 38.79, 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.', 78, 2.7);
INSERT INTO product (id, name, price, description, stock, score) VALUES (50, 'Field Eryngo', 76.45, 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', 70, 1.8);
INSERT INTO product (id, name, price, description, stock, score) VALUES (51, 'Flowering Ash', 61.15, 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.', 0, 3.6);
INSERT INTO product (id, name, price, description, stock, score) VALUES (52, 'Coville''s Rush', 20.04, 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.', 57, 2.0);
INSERT INTO product (id, name, price, description, stock, score) VALUES (53, 'Mammoth Wildrye', 46.39, 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', 63, 1.6);
INSERT INTO product (id, name, price, description, stock, score) VALUES (54, 'Bracted Passionflower', 79.32, 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.', 48, 2.4);
INSERT INTO product (id, name, price, description, stock, score) VALUES (55, 'Oval-leaf Clustervine', 66.21, 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', 65, 1.9);
INSERT INTO product (id, name, price, description, stock, score) VALUES (56, 'False Brome', 87.35, 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', 94, 4.4);
INSERT INTO product (id, name, price, description, stock, score) VALUES (57, 'Walpole''s Small Camas', 81.31, 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.', 32, 2.5);
INSERT INTO product (id, name, price, description, stock, score) VALUES (58, 'Guilarte', 98.25, 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', 11, 0.3);
INSERT INTO product (id, name, price, description, stock, score) VALUES (59, 'Sarea Lichen', 32.47, 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', 25, 3.5);
INSERT INTO product (id, name, price, description, stock, score) VALUES (60, 'Douglas'' Silver Lupine', 33.11, 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', 57, 4.4);
INSERT INTO product (id, name, price, description, stock, score) VALUES (61, 'Magalospora Lichen', 32.03, 'Sed ante. Vivamus tortor. Duis mattis egestas metus.', 49, 0.8);
INSERT INTO product (id, name, price, description, stock, score) VALUES (62, 'Clokey''s Cryptantha', 78.19, 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', 83, 3.7);
INSERT INTO product (id, name, price, description, stock, score) VALUES (63, 'Cultivated Raspberry', 46.15, 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.', 65, 3.2);
INSERT INTO product (id, name, price, description, stock, score) VALUES (64, 'Pale Serviceberry', 27.27, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.', 6, 3.1);
INSERT INTO product (id, name, price, description, stock, score) VALUES (65, 'Chamomile', 92.73, 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 52, 2.3);
INSERT INTO product (id, name, price, description, stock, score) VALUES (66, 'Drymary Dwarf-flax', 62.54, 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.', 25, 3.6);
INSERT INTO product (id, name, price, description, stock, score) VALUES (67, 'Bugloss', 70.17, 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.', 82, 3.8);
INSERT INTO product (id, name, price, description, stock, score) VALUES (68, 'Globe Sedge', 82.45, 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 54, 3.1);
INSERT INTO product (id, name, price, description, stock, score) VALUES (69, 'Whiskerbush', 98.29, 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.', 67, 2.1);
INSERT INTO product (id, name, price, description, stock, score) VALUES (70, 'Buckthorn Bully', 73.99, 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.', 66, 4.2);
INSERT INTO product (id, name, price, description, stock, score) VALUES (71, 'Polished Maidenhair', 90.94, 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', 100, 3.7);
INSERT INTO product (id, name, price, description, stock, score) VALUES (72, 'Rough Coneflower', 95.82, 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.', 40, 5.0);
INSERT INTO product (id, name, price, description, stock, score) VALUES (73, 'Smooth Arizona Cypress', 43.22, 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.', 49, 4.1);
INSERT INTO product (id, name, price, description, stock, score) VALUES (74, 'River Redgum', 29.16, 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 98, 1.2);
INSERT INTO product (id, name, price, description, stock, score) VALUES (75, 'Yellow Spikerush', 40.47, 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', 28, 4.2);
INSERT INTO product (id, name, price, description, stock, score) VALUES (76, 'Netted Anoda', 62.76, 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.', 9, 1.4);
INSERT INTO product (id, name, price, description, stock, score) VALUES (77, 'Charleston Mountain Violet', 96.35, 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.', 19, 5.0);
INSERT INTO product (id, name, price, description, stock, score) VALUES (78, 'Creeping Silverback', 73.44, 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 67, 2.1);
INSERT INTO product (id, name, price, description, stock, score) VALUES (79, 'Giant Ricegrass', 87.16, 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', 66, 3.9);
INSERT INTO product (id, name, price, description, stock, score) VALUES (80, 'Pterygiopsis Lichen', 21.45, 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 95, 1.6);
INSERT INTO product (id, name, price, description, stock, score) VALUES (81, 'Marsh Hedgenettle', 54.32, 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.', 14, 3.3);
INSERT INTO product (id, name, price, description, stock, score) VALUES (82, 'Spiderling', 94.09, 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.', 22, 3.8);
INSERT INTO product (id, name, price, description, stock, score) VALUES (83, 'Physcomitrium Moss', 46.27, 'Sed ante. Vivamus tortor. Duis mattis egestas metus.', 19, 3.0);
INSERT INTO product (id, name, price, description, stock, score) VALUES (84, 'Bayrumtree', 56.09, 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.', 30, 0.7);
INSERT INTO product (id, name, price, description, stock, score) VALUES (85, 'Yellow Pincushion', 56.45, 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.', 49, 2.9);
INSERT INTO product (id, name, price, description, stock, score) VALUES (86, 'White-flowered Black Mangrove', 61.1, 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.', 74, 1.6);
INSERT INTO product (id, name, price, description, stock, score) VALUES (87, 'African Tamarisk', 81.89, 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 63, 3.5);
INSERT INTO product (id, name, price, description, stock, score) VALUES (88, 'Coral Ipomopsis', 84.85, 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', 9, 2.9);
INSERT INTO product (id, name, price, description, stock, score) VALUES (89, '''ohe Makai', 79.46, 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.', 100, 5.0);
INSERT INTO product (id, name, price, description, stock, score) VALUES (90, 'Rosy Sandcrocus', 72.08, 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.', 66, 0.4);
INSERT INTO product (id, name, price, description, stock, score) VALUES (91, 'Mock Dandelion', 60.09, 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', 14, 2.1);
INSERT INTO product (id, name, price, description, stock, score) VALUES (92, 'Maid Marian', 21.75, 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.', 67, 0.0);
INSERT INTO product (id, name, price, description, stock, score) VALUES (93, 'Alaska Alkaligrass', 40.24, 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.', 24, 2.7);
INSERT INTO product (id, name, price, description, stock, score) VALUES (94, 'Gooseberryleaf Globemallow', 86.33, 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', 51, 3.6);
INSERT INTO product (id, name, price, description, stock, score) VALUES (95, 'Duck River Bladderpod', 75.98, 'In congue. Etiam justo. Etiam pretium iaculis justo.', 19, 2.8);
INSERT INTO product (id, name, price, description, stock, score) VALUES (96, 'Sierra Baby Blue Eyes', 63.75, 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.', 56, 4.3);
INSERT INTO product (id, name, price, description, stock, score) VALUES (97, 'Field Pussytoes', 34.85, 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', 17, 0.6);
INSERT INTO product (id, name, price, description, stock, score) VALUES (98, 'Whiteplume Wirelettuce', 84.21, 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.', 84, 2.1);
INSERT INTO product (id, name, price, description, stock, score) VALUES (99, 'Russian Milkvetch', 91.59, 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.', 93, 1.3);
INSERT INTO product (id, name, price, description, stock, score) VALUES (100, 'American Plum', 71.73, 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.', 62, 4.9);

-----------------------------------------
-- categories
-----------------------------------------

INSERT INTO categories (id, name, season) VALUES (1, 'consequat', 'lacinia');
INSERT INTO categories (id, name, season) VALUES (2, 'lacus', 'semper');
INSERT INTO categories (id, name, season) VALUES (3, 'ipsum', 'lobortis');
INSERT INTO categories (id, name, season) VALUES (4, 'est', 'vestibulum');
INSERT INTO categories (id, name, season) VALUES (5, 'massa', 'justo');
INSERT INTO categories (id, name, season) VALUES (6, 'cras', 'nulla');
INSERT INTO categories (id, name, season) VALUES (7, 'faucibus', 'volutpat');
INSERT INTO categories (id, name, season) VALUES (8, 'penatibus', 'sed');
INSERT INTO categories (id, name, season) VALUES (9, 'accumsan', 'ligula');
INSERT INTO categories (id, name, season) VALUES (10, 'adipiscing', 'justo');
INSERT INTO categories (id, name, season) VALUES (11, 'panths', 'quis');
INSERT INTO categories (id, name, season) VALUES (12, 'interdum', 'et');
INSERT INTO categories (id, name, season) VALUES (13, 'tristique', 'cubilia');
INSERT INTO categories (id, name, season) VALUES (14, 'kinus', 'volutpat');
INSERT INTO categories (id, name, season) VALUES (15, 'nisi', 'commodo');
INSERT INTO categories (id, name, season) VALUES (16, 'elementum', 'facilisi');
INSERT INTO categories (id, name, season) VALUES (17, 'praesent', 'in');
INSERT INTO categories (id, name, season) VALUES (18, 'barberum', 'nulla');
INSERT INTO categories (id, name, season) VALUES (19, 'aliquet', 'eget');
INSERT INTO categories (id, name, season) VALUES (20, 'ultrices', 'ut');
INSERT INTO categories (id, name, season) VALUES (21, 'bibendum', 'sapien');
INSERT INTO categories (id, name, season) VALUES (22, 'adipiscin', 'duis');
INSERT INTO categories (id, name, season) VALUES (23, 'et', 'duis');
INSERT INTO categories (id, name, season) VALUES (24, 'in', 'amet');
INSERT INTO categories (id, name, season) VALUES (25, 'magna', 'nulla');
INSERT INTO categories (id, name, season) VALUES (26, 'tu', 'platea');
INSERT INTO categories (id, name, season) VALUES (27, 'augue', 'ultrices');
INSERT INTO categories (id, name, season) VALUES (28, 'eu', 'elit');
INSERT INTO categories (id, name, season) VALUES (29, 'congue', 'pede');
INSERT INTO categories (id, name, season) VALUES (30, 'viverra', 'ipsum');
INSERT INTO categories (id, name, season) VALUES (31, 'ola', 'lacinia');
INSERT INTO categories (id, name, season) VALUES (32, 'orci', 'non');
INSERT INTO categories (id, name, season) VALUES (33, 'nulla', 'convallis');
INSERT INTO categories (id, name, season) VALUES (34, 'sopa', 'leo');
INSERT INTO categories (id, name, season) VALUES (35, 'eget', 'sapien');
INSERT INTO categories (id, name, season) VALUES (36, 'consectetuer', 'sapien');
INSERT INTO categories (id, name, season) VALUES (37, 'donec', 'leo');
INSERT INTO categories (id, name, season) VALUES (38, 'vestibulum', 'interdum');
INSERT INTO categories (id, name, season) VALUES (39, 'imperdiet', 'nunc');
INSERT INTO categories (id, name, season) VALUES (40, 'duis', 'nec');

-----------------------------------------
-- review
-----------------------------------------

INSERT INTO review (id, id_user, id_product, title, description, score) VALUES (1, 1, 51, 'Duis mattis egestas metus.', 'In congue. Etiam justo. Etiam pretium iaculis justo.', 0);
INSERT INTO review (id, id_user, id_product, title, description, score) VALUES (2, 2, 49, 'Proin interdum mauris non ligula pellentesque ultrices.', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', 3);
INSERT INTO review (id, id_user, id_product, title, description, score) VALUES (3, 3, 55, 'Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl.', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', 1);
INSERT INTO review (id, id_user, id_product, title, description, score) VALUES (4, 4, 77, 'Etiam faucibus cursus urna.', 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', 5);
INSERT INTO review (id, id_user, id_product, title, description, score) VALUES (5, 5, 23, 'Phasellus in felis.', 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.', 0);
INSERT INTO review (id, id_user, id_product, title, description, score) VALUES (6, 6, 21, 'Ut at dolor quis odio consequat varius.', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.', 0);
INSERT INTO review (id, id_user, id_product, title, description, score) VALUES (7, 7, 69, 'Pellentesque ultrices mattis odio.', 'Fusce consequat. Nulla nisl. Nunc nisl.', 3);
INSERT INTO review (id, id_user, id_product, title, description, score) VALUES (8, 8, 67, 'Aliquam quis turpis eget elit sodales scelerisque.', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.', 4);
INSERT INTO review (id, id_user, id_product, title, description, score) VALUES (9, 9, 34, 'Nulla mollis molestie lorem.', 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.', 1);
INSERT INTO review (id, id_user, id_product, title, description, score) VALUES (10, 10, 57, 'Duis bibendum.', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.', 4);
INSERT INTO review (id, id_user, id_product, title, description, score) VALUES (11, 11, 57, 'In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.', 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.', 3);
INSERT INTO review (id, id_user, id_product, title, description, score) VALUES (12, 12, 48, 'Morbi a ipsum.', 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', 1);
INSERT INTO review (id, id_user, id_product, title, description, score) VALUES (13, 13, 91, 'Curabitur in libero ut massa volutpat convallis.', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', 0);
INSERT INTO review (id, id_user, id_product, title, description, score) VALUES (14, 14, 88, 'Morbi vel lectus in quam fringilla rhoncus.', 'Phasellus in felis. Donec semper sapien a libero. Nam dui.', 0);
INSERT INTO review (id, id_user, id_product, title, description, score) VALUES (15, 15, 55, 'Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', 2);
INSERT INTO review (id, id_user, id_product, title, description, score) VALUES (16, 16, 94, 'Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', 'Sed ante. Vivamus tortor. Duis mattis egestas metus.', 0);
INSERT INTO review (id, id_user, id_product, title, description, score) VALUES (17, 17, 91, 'Morbi non lectus.', 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.', 4);
INSERT INTO review (id, id_user, id_product, title, description, score) VALUES (18, 18, 84, 'Quisque ut erat.', 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.', 5);
INSERT INTO review (id, id_user, id_product, title, description, score) VALUES (19, 19, 80, 'Nulla justo.', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 2);
INSERT INTO review (id, id_user, id_product, title, description, score) VALUES (20, 20, 42, 'Donec vitae nisi.', 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.', 1);

-----------------------------------------
-- "order"
-----------------------------------------

INSERT INTO "order" (id, id_user, date, total, state) VALUES (1, 46, '2019/01/20', 68.3, 'Processing');
INSERT INTO "order" (id, id_user, date, total, state) VALUES (2, 31, '2019/10/25', 22.23, 'Shipped');
INSERT INTO "order" (id, id_user, date, total, state) VALUES (3, 30, '2019/07/25', 41.55, 'Delivered');
INSERT INTO "order" (id, id_user, date, total, state) VALUES (4, 28, '2018/06/27', 7.97, 'Processing');
INSERT INTO "order" (id, id_user, date, total, state) VALUES (5, 3, '2019/12/08', 73.53, 'Delivered');
INSERT INTO "order" (id, id_user, date, total, state) VALUES (6, 50, '2018/05/19', 28.41, 'Delivered');
INSERT INTO "order" (id, id_user, date, total, state) VALUES (7, 19, '2018/07/28', 45.25, 'Delivered');
INSERT INTO "order" (id, id_user, date, total, state) VALUES (8, 29, '2019/07/07', 7.33, 'Processing');
INSERT INTO "order" (id, id_user, date, total, state) VALUES (9, 6, '2019/10/10', 55.04, 'Processing');
INSERT INTO "order" (id, id_user, date, total, state) VALUES (10, 17, '2018/06/19', 59.49, 'Processing');
INSERT INTO "order" (id, id_user, date, total, state) VALUES (11, 18, '2020/03/22', 11.59, 'Processing');
INSERT INTO "order" (id, id_user, date, total, state) VALUES (12, 14, '2019/03/21', 66.9, 'Delivered');
INSERT INTO "order" (id, id_user, date, total, state) VALUES (13, 6, '2018/04/19', 82.14, 'Processing');
INSERT INTO "order" (id, id_user, date, total, state) VALUES (14, 29, '2020/02/08', 50.15, 'Shipped');
INSERT INTO "order" (id, id_user, date, total, state) VALUES (15, 13, '2018/04/27', 98.98, 'Processing');
INSERT INTO "order" (id, id_user, date, total, state) VALUES (16, 32, '2018/11/07', 93.45, 'Shipped');
INSERT INTO "order" (id, id_user, date, total, state) VALUES (17, 33, '2019/06/09', 84.31, 'Shipped');
INSERT INTO "order" (id, id_user, date, total, state) VALUES (18, 18, '2018/09/04', 61.27, 'Shipped');
INSERT INTO "order" (id, id_user, date, total, state) VALUES (19, 35, '2018/07/20', 21.0, 'Delivered');
INSERT INTO "order" (id, id_user, date, total, state) VALUES (20, 8, '2018/12/09', 60.87, 'Processing');
INSERT INTO "order" (id, id_user, date, total, state) VALUES (21, 28, '2019/11/30', 18.26, 'Processing');
INSERT INTO "order" (id, id_user, date, total, state) VALUES (22, 37, '2018/10/19', 33.4, 'Processing');
INSERT INTO "order" (id, id_user, date, total, state) VALUES (23, 19, '2018/04/21', 17.19, 'Delivered');
INSERT INTO "order" (id, id_user, date, total, state) VALUES (24, 42, '2019/06/16', 94.93, 'Processing');
INSERT INTO "order" (id, id_user, date, total, state) VALUES (25, 46, '2018/06/12', 72.55, 'Shipped');
INSERT INTO "order" (id, id_user, date, total, state) VALUES (26, 50, '2019/04/14', 43.76, 'Shipped');
INSERT INTO "order" (id, id_user, date, total, state) VALUES (27, 41, '2018/05/26', 26.48, 'Shipped');
INSERT INTO "order" (id, id_user, date, total, state) VALUES (28, 14, '2019/11/22', 51.41, 'Shipped');
INSERT INTO "order" (id, id_user, date, total, state) VALUES (29, 26, '2019/09/02', 68.96, 'Delivered');
INSERT INTO "order" (id, id_user, date, total, state) VALUES (30, 24, '2018/10/06', 11.94, 'Shipped');

-----------------------------------------
-- line item 
-----------------------------------------

INSERT INTO line_item (id, id_product, quantity, price) VALUES (1, 73, 2, 74.78);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (2, 51, 3, 14.73);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (3, 7, 5, 80.09);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (4, 38, 8, 74.23);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (5, 85, 9, 69.11);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (6, 83, 3, 27.11);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (7, 41, 1, 42.09);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (8, 17, 5, 32.4);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (9, 27, 10, 17.29);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (10, 78, 9, 93.64);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (11, 31, 10, 42.98);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (12, 90, 10, 46.9);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (13, 17, 5, 8.69);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (14, 42, 2, 68.8);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (15, 57, 5, 22.32);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (16, 42, 7, 76.8);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (17, 42, 6, 89.61);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (18, 73, 6, 89.3);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (19, 96, 8, 46.94);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (20, 8, 8, 48.84);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (21, 23, 7, 5.85);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (22, 47, 9, 42.89);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (23, 70, 7, 88.93);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (24, 44, 4, 90.9);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (25, 92, 4, 78.82);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (26, 66, 3, 69.26);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (27, 77, 8, 5.56);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (28, 19, 2, 69.06);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (29, 53, 2, 67.51);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (30, 66, 5, 98.81);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (31, 31, 10, 83.65);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (32, 27, 10, 29.65);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (33, 62, 5, 14.67);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (34, 31, 10, 58.67);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (35, 83, 3, 66.29);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (36, 3, 3, 72.91);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (37, 80, 10, 81.77);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (38, 23, 1, 35.64);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (39, 16, 6, 94.46);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (40, 43, 10, 81.41);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (41, 32, 3, 42.77);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (42, 52, 2, 4.96);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (43, 23, 4, 18.43);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (44, 18, 2, 35.43);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (45, 91, 1, 85.04);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (46, 3, 4, 58.04);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (47, 98, 9, 36.79);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (48, 6, 4, 35.05);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (49, 37, 10, 46.84);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (50, 84, 2, 80.97);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (51, 78, 6, 31.46);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (52, 12, 10, 34.82);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (53, 10, 9, 2.87);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (54, 91, 9, 49.24);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (55, 72, 2, 4.51);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (56, 59, 4, 67.63);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (57, 32, 5, 10.58);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (58, 72, 5, 66.69);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (59, 57, 9, 11.14);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (60, 73, 7, 48.97);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (61, 20, 8, 79.04);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (62, 38, 8, 37.05);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (63, 61, 9, 85.25);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (64, 42, 1, 34.83);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (65, 61, 10, 82.29);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (66, 29, 7, 15.97);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (67, 90, 1, 14.29);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (68, 1, 2, 40.92);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (69, 12, 10, 82.77);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (70, 19, 3, 91.54);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (71, 45, 5, 18.45);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (72, 83, 3, 37.93);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (73, 29, 10, 87.47);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (74, 12, 9, 11.96);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (75, 32, 8, 78.79);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (76, 11, 5, 53.2);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (77, 51, 1, 78.2);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (78, 37, 8, 33.23);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (79, 33, 3, 40.09);
INSERT INTO line_item (id, id_product, quantity, price) VALUES (80, 38, 9, 64.4);

-----------------------------------------
-- line_item cart
-----------------------------------------

INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (1, 27);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (2, 34);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (3, 34);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (4, 2);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (5, 42);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (6, 24);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (7, 9);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (8, 12);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (9, 38);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (10, 21);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (11, 32);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (12, 29);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (13, 20);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (14, 3);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (15, 45);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (16, 35);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (17, 30);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (18, 7);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (19, 25);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (20, 8);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (21, 33);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (22, 4);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (23, 9);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (24, 45);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (25, 27);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (26, 45);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (27, 42);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (28, 20);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (29, 41);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (30, 32);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (31, 5);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (32, 24);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (33, 35);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (34, 30);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (35, 27);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (36, 43);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (37, 27);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (38, 20);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (39, 16);
INSERT INTO line_item_cart (id_line_item, id_cart) VALUES (40, 48);

-----------------------------------------
-- line item order
-----------------------------------------

INSERT INTO line_item_order (id_line_item, id_order) VALUES (41, 14);
INSERT INTO line_item_order (id_line_item, id_order) VALUES (42, 14);
INSERT INTO line_item_order (id_line_item, id_order) VALUES (43, 3);
INSERT INTO line_item_order (id_line_item, id_order) VALUES (44, 13);
INSERT INTO line_item_order (id_line_item, id_order) VALUES (45, 22);
INSERT INTO line_item_order (id_line_item, id_order) VALUES (46, 7);
INSERT INTO line_item_order (id_line_item, id_order) VALUES (47, 18);
INSERT INTO line_item_order (id_line_item, id_order) VALUES (48, 27);
INSERT INTO line_item_order (id_line_item, id_order) VALUES (49, 30);
INSERT INTO line_item_order (id_line_item, id_order) VALUES (50, 14);
INSERT INTO line_item_order (id_line_item, id_order) VALUES (51, 21);
INSERT INTO line_item_order (id_line_item, id_order) VALUES (52, 14);
INSERT INTO line_item_order (id_line_item, id_order) VALUES (53, 22);
INSERT INTO line_item_order (id_line_item, id_order) VALUES (54, 24);
INSERT INTO line_item_order (id_line_item, id_order) VALUES (55, 16);
INSERT INTO line_item_order (id_line_item, id_order) VALUES (56, 18);
INSERT INTO line_item_order (id_line_item, id_order) VALUES (57, 15);
INSERT INTO line_item_order (id_line_item, id_order) VALUES (58, 6);
INSERT INTO line_item_order (id_line_item, id_order) VALUES (59, 16);
INSERT INTO line_item_order (id_line_item, id_order) VALUES (60, 15);
INSERT INTO line_item_order (id_line_item, id_order) VALUES (62, 28);
INSERT INTO line_item_order (id_line_item, id_order) VALUES (63, 4);
INSERT INTO line_item_order (id_line_item, id_order) VALUES (64, 11);
INSERT INTO line_item_order (id_line_item, id_order) VALUES (65, 18);
INSERT INTO line_item_order (id_line_item, id_order) VALUES (66, 22);
INSERT INTO line_item_order (id_line_item, id_order) VALUES (67, 6);
INSERT INTO line_item_order (id_line_item, id_order) VALUES (68, 7);
INSERT INTO line_item_order (id_line_item, id_order) VALUES (69, 14);
INSERT INTO line_item_order (id_line_item, id_order) VALUES (70, 12);
INSERT INTO line_item_order (id_line_item, id_order) VALUES (71, 25);
INSERT INTO line_item_order (id_line_item, id_order) VALUES (72, 26);
INSERT INTO line_item_order (id_line_item, id_order) VALUES (73, 11);
INSERT INTO line_item_order (id_line_item, id_order) VALUES (74, 25);
INSERT INTO line_item_order (id_line_item, id_order) VALUES (75, 7);
INSERT INTO line_item_order (id_line_item, id_order) VALUES (76, 5);
INSERT INTO line_item_order (id_line_item, id_order) VALUES (78, 26);
INSERT INTO line_item_order (id_line_item, id_order) VALUES (79, 5);

-----------------------------------------
-- country 
-----------------------------------------

INSERT INTO country (id, name) VALUES (1, 'Vietnam');
INSERT INTO country (id, name) VALUES (2, 'Philippines');
INSERT INTO country (id, name) VALUES (3, 'England');
INSERT INTO country (id, name) VALUES (4, 'Central African Republic');
INSERT INTO country (id, name) VALUES (5, 'China');
INSERT INTO country (id, name) VALUES (6, 'Portugal');
INSERT INTO country (id, name) VALUES (7, 'Norway');
INSERT INTO country (id, name) VALUES (8, 'Mexico');
INSERT INTO country (id, name) VALUES (9, 'Croatia');
INSERT INTO country (id, name) VALUES (10, 'Colombia');
INSERT INTO country (id, name) VALUES (11, 'China');
INSERT INTO country (id, name) VALUES (12, 'Bangladesh');
INSERT INTO country (id, name) VALUES (13, 'Luxembourg');
INSERT INTO country (id, name) VALUES (14, 'Peru');
INSERT INTO country (id, name) VALUES (15, 'China');
INSERT INTO country (id, name) VALUES (16, 'Spain');
INSERT INTO country (id, name) VALUES (17, 'Guatemala');
INSERT INTO country (id, name) VALUES (18, 'Thailand');
INSERT INTO country (id, name) VALUES (19, 'Russia');
INSERT INTO country (id, name) VALUES (20, 'United States');

-----------------------------------------
-- city
-----------------------------------------

INSERT INTO city (id, id_country, name) VALUES (1, 4, 'Taquara');
INSERT INTO city (id, id_country, name) VALUES (2, 13, 'Velká Bystřice');
INSERT INTO city (id, id_country, name) VALUES (3, 18, 'Zhufo');
INSERT INTO city (id, id_country, name) VALUES (4, 1, 'Mananum');
INSERT INTO city (id, id_country, name) VALUES (5, 9, 'Salcedo');
INSERT INTO city (id, id_country, name) VALUES (6, 20, 'Lishu');
INSERT INTO city (id, id_country, name) VALUES (7, 12, 'Sexmoan');
INSERT INTO city (id, id_country, name) VALUES (8, 4, 'Benzilan');
INSERT INTO city (id, id_country, name) VALUES (9, 13, 'Alindao');
INSERT INTO city (id, id_country, name) VALUES (10, 13, 'Arroyo Naranjo');
INSERT INTO city (id, id_country, name) VALUES (11, 12, 'Kuala Lumpur');
INSERT INTO city (id, id_country, name) VALUES (12, 7, 'Warlubie');
INSERT INTO city (id, id_country, name) VALUES (13, 20, 'Amiens');
INSERT INTO city (id, id_country, name) VALUES (14, 7, 'Villach');
INSERT INTO city (id, id_country, name) VALUES (15, 16, 'Sandakan');
INSERT INTO city (id, id_country, name) VALUES (16, 9, 'Nova Kakhovka');
INSERT INTO city (id, id_country, name) VALUES (17, 1, 'Rathnew');
INSERT INTO city (id, id_country, name) VALUES (18, 13, 'Nova Odesa');
INSERT INTO city (id, id_country, name) VALUES (19, 15, 'Maple Plain');
INSERT INTO city (id, id_country, name) VALUES (20, 3, 'Malitubog');

-----------------------------------------
-- address 
-----------------------------------------

INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (1, 1, 12, 'Grim', '446600');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (2, 2, 4, 'Michigan', '06-121');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (3, 3, 19, 'Pepper Wood', '70061');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (4, 4, 19, 'Lighthouse Bay', '431-10');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (5, 5, 20, 'Arrowood', '7104');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (6, 6, 3, 'Anzinger', '662133');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (7, 7, 12, 'American Ash', '744 88');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (8, 8, 9, 'Nobel', '301649');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (9, 9, 2, 'Artisan', '2350-259');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (10, 10, 5, 'Nancy', 'L1X');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (11, 11, 7, 'Melvin', '675 31');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (12, 12, 2, 'Northview', '4890-223');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (13, 13, 20, 'Westport', '8301');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (14, 14, 15, 'Fordem', '22111');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (15, 15, 4, 'Karstens', '58500-000');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (16, 16, 9, 'Lien', '249070');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (17, 17, 1, 'Commercial', '60078');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (18, 18, 2, 'Anhalt', '7104');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (19, 19, 8, 'Corben', '30902');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (20, 20, 17, 'Nova', '399-8205');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (21, 21, 4, 'Northridge', '82001');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (22, 22, 17, 'Jenna', '28210');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (23, 23, 11, 'Lunder', '21006');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (24, 24, 18, 'Prairieview', '64800-000');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (25, 25, 11, 'Evergreen', '2327');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (26, 26, 6, 'Mayer', '28210');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (27, 27, 2, 'Kings', '999-3503');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (28, 28, 19, 'Oxford', '21006');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (29, 29, 4, 'Golf Course', '142143');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (30, 30, 15, 'Russell', '83404 CEDEX');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (31, 31, 10, '1st', '1695');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (32, 32, 7, 'Fieldstone', '733517');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (33, 33, 8, 'Reinke', '6406');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (34, 34, 16, 'Center', '10040');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (35, 35, 19, 'Memorial', '19130');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (36, 36, 3, 'Carpenter', '624857');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (37, 37, 15, 'Memorial', '3255');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (38, 38, 11, 'International', '47405');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (39, 39, 17, 'Lindbergh', '419-0125');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (40, 40, 11, 'Ridge Oak', '05-804');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (41, 41, 1, 'Carey', '9630-311');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (42, 42, 8, 'Sachtjen', '242467');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (43, 43, 5, 'Killdeer', '374 53');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (44, 44, 6, 'Manitowish', '30010');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (45, 45, 9, 'Pleasure', '912 24');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (46, 46, 4, 'Sycamore', '4750-521');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (47, 47, 7, 'Eggendart', '141986');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (48, 48, 3, 'Clemons', '7803');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (49, 49, 8, 'Jenna', '10040');
INSERT INTO address (id, id_user, id_city, street, zipCode) VALUES (50, 50, 13, 'Donald', '11403');

-----------------------------------------
-- brand 
-----------------------------------------

INSERT INTO brand (id, name) VALUES (1, 'Cummings, Bosco and Botsford');
INSERT INTO brand (id, name) VALUES (2, 'Bergstrom Group');
INSERT INTO brand (id, name) VALUES (3, 'Pouros, Fritsch and Grimes');
INSERT INTO brand (id, name) VALUES (4, 'Ratke-Lesch');
INSERT INTO brand (id, name) VALUES (5, 'Brown-Batz');
INSERT INTO brand (id, name) VALUES (6, 'MacGyver, Breitenberg and Schaden');
INSERT INTO brand (id, name) VALUES (7, 'Shanahan-Prosacco');
INSERT INTO brand (id, name) VALUES (8, 'Cole LLC');
INSERT INTO brand (id, name) VALUES (9, 'McDermott Inc');
INSERT INTO brand (id, name) VALUES (10, 'Bahringer Group');
INSERT INTO brand (id, name) VALUES (11, 'Hodkiewicz-Terry');
INSERT INTO brand (id, name) VALUES (12, 'Stracke, Corwin and Herzog');
INSERT INTO brand (id, name) VALUES (13, 'Kuhn-Muller');
INSERT INTO brand (id, name) VALUES (14, 'Nolan Inc');
INSERT INTO brand (id, name) VALUES (15, 'Kessler, Hoeger and Kertzmann');
INSERT INTO brand (id, name) VALUES (16, 'Heidenreich Group');
INSERT INTO brand (id, name) VALUES (17, 'Rau, Medhurst and Douglas');
INSERT INTO brand (id, name) VALUES (18, 'Goldner, Torphy and Hilpert');
INSERT INTO brand (id, name) VALUES (19, 'Bartell-Upton');
INSERT INTO brand (id, name) VALUES (20, 'Stoltenberg Inc');

-----------------------------------------
-- color 
-----------------------------------------

INSERT INTO color (id, name) VALUES (1, 'Mauv');
INSERT INTO color (id, name) VALUES (2, 'Teal');
INSERT INTO color (id, name) VALUES (3, 'Turquoise');
INSERT INTO color (id, name) VALUES (4, 'Indigo');
INSERT INTO color (id, name) VALUES (5, 'Purple');
INSERT INTO color (id, name) VALUES (6, 'Goldenrod');
INSERT INTO color (id, name) VALUES (7, 'Yellow');
INSERT INTO color (id, name) VALUES (8, 'Purple');
INSERT INTO color (id, name) VALUES (9, 'Goldenrod');
INSERT INTO color (id, name) VALUES (10, 'Mauv');

-----------------------------------------
-- size
-----------------------------------------

INSERT INTO size (id, name) VALUES (1, 'XXS');
INSERT INTO size (id, name) VALUES (2, 'XS');
INSERT INTO size (id, name) VALUES (3, 'S');
INSERT INTO size (id, name) VALUES (4, 'M');
INSERT INTO size (id, name) VALUES (5, 'L');
INSERT INTO size (id, name) VALUES (6, 'XL');
INSERT INTO size (id, name) VALUES (7, 'XXL');

-----------------------------------------
-- favorites
-----------------------------------------

INSERT INTO favorites (id_user, id_product) VALUES (49, 40);
INSERT INTO favorites (id_user, id_product) VALUES (12, 44);
INSERT INTO favorites (id_user, id_product) VALUES (1, 90);
INSERT INTO favorites (id_user, id_product) VALUES (21, 96);
INSERT INTO favorites (id_user, id_product) VALUES (25, 8);
INSERT INTO favorites (id_user, id_product) VALUES (23, 60);
INSERT INTO favorites (id_user, id_product) VALUES (38, 28);
INSERT INTO favorites (id_user, id_product) VALUES (26, 66);
INSERT INTO favorites (id_user, id_product) VALUES (1, 57);
INSERT INTO favorites (id_user, id_product) VALUES (41, 96);
INSERT INTO favorites (id_user, id_product) VALUES (15, 76);
INSERT INTO favorites (id_user, id_product) VALUES (24, 21);
INSERT INTO favorites (id_user, id_product) VALUES (7, 60);
INSERT INTO favorites (id_user, id_product) VALUES (27, 25);
INSERT INTO favorites (id_user, id_product) VALUES (14, 64);
INSERT INTO favorites (id_user, id_product) VALUES (7, 1);
INSERT INTO favorites (id_user, id_product) VALUES (19, 98);
INSERT INTO favorites (id_user, id_product) VALUES (27, 59);
INSERT INTO favorites (id_user, id_product) VALUES (49, 6);
INSERT INTO favorites (id_user, id_product) VALUES (48, 81);
INSERT INTO favorites (id_user, id_product) VALUES (50, 85);
INSERT INTO favorites (id_user, id_product) VALUES (19, 2);
INSERT INTO favorites (id_user, id_product) VALUES (15, 27);
INSERT INTO favorites (id_user, id_product) VALUES (19, 22);
INSERT INTO favorites (id_user, id_product) VALUES (48, 23);
INSERT INTO favorites (id_user, id_product) VALUES (16, 14);
INSERT INTO favorites (id_user, id_product) VALUES (41, 12);
INSERT INTO favorites (id_user, id_product) VALUES (13, 75);
INSERT INTO favorites (id_user, id_product) VALUES (24, 96);
INSERT INTO favorites (id_user, id_product) VALUES (39, 67);
INSERT INTO favorites (id_user, id_product) VALUES (34, 40);
INSERT INTO favorites (id_user, id_product) VALUES (2, 5);
INSERT INTO favorites (id_user, id_product) VALUES (12, 72);
INSERT INTO favorites (id_user, id_product) VALUES (44, 85);
INSERT INTO favorites (id_user, id_product) VALUES (24, 24);
INSERT INTO favorites (id_user, id_product) VALUES (2, 42);
INSERT INTO favorites (id_user, id_product) VALUES (36, 41);
INSERT INTO favorites (id_user, id_product) VALUES (45, 95);
INSERT INTO favorites (id_user, id_product) VALUES (4, 47);
INSERT INTO favorites (id_user, id_product) VALUES (36, 62);
INSERT INTO favorites (id_user, id_product) VALUES (14, 59);
INSERT INTO favorites (id_user, id_product) VALUES (38, 82);
INSERT INTO favorites (id_user, id_product) VALUES (44, 8);
INSERT INTO favorites (id_user, id_product) VALUES (29, 30);
INSERT INTO favorites (id_user, id_product) VALUES (7, 24);
INSERT INTO favorites (id_user, id_product) VALUES (21, 5);
INSERT INTO favorites (id_user, id_product) VALUES (4, 24);
INSERT INTO favorites (id_user, id_product) VALUES (26, 36);
INSERT INTO favorites (id_user, id_product) VALUES (45, 30);
INSERT INTO favorites (id_user, id_product) VALUES (46, 64);
INSERT INTO favorites (id_user, id_product) VALUES (44, 82);
INSERT INTO favorites (id_user, id_product) VALUES (46, 45);
INSERT INTO favorites (id_user, id_product) VALUES (27, 15);
INSERT INTO favorites (id_user, id_product) VALUES (44, 5);
INSERT INTO favorites (id_user, id_product) VALUES (47, 99);
INSERT INTO favorites (id_user, id_product) VALUES (32, 73);
INSERT INTO favorites (id_user, id_product) VALUES (48, 34);
INSERT INTO favorites (id_user, id_product) VALUES (6, 44);
INSERT INTO favorites (id_user, id_product) VALUES (44, 68);
INSERT INTO favorites (id_user, id_product) VALUES (2, 49);

-----------------------------------------
-- report 
-----------------------------------------

INSERT INTO report (id_review, id_user_reportee) VALUES (8, 18);
INSERT INTO report (id_review, id_user_reportee) VALUES (16, 19);
INSERT INTO report (id_review, id_user_reportee) VALUES (16, 1);
INSERT INTO report (id_review, id_user_reportee) VALUES (13, 46);
INSERT INTO report (id_review, id_user_reportee) VALUES (16, 11);
INSERT INTO report (id_review, id_user_reportee) VALUES (6, 30);
INSERT INTO report (id_review, id_user_reportee) VALUES (3, 3);
INSERT INTO report (id_review, id_user_reportee) VALUES (4, 49);
INSERT INTO report (id_review, id_user_reportee) VALUES (12, 36);
INSERT INTO report (id_review, id_user_reportee) VALUES (2, 20);
INSERT INTO report (id_review, id_user_reportee) VALUES (6, 41);
INSERT INTO report (id_review, id_user_reportee) VALUES (18, 12);
INSERT INTO report (id_review, id_user_reportee) VALUES (16, 28);
INSERT INTO report (id_review, id_user_reportee) VALUES (2, 43);
INSERT INTO report (id_review, id_user_reportee) VALUES (5, 9);
INSERT INTO report (id_review, id_user_reportee) VALUES (19, 42);
INSERT INTO report (id_review, id_user_reportee) VALUES (14, 11);
INSERT INTO report (id_review, id_user_reportee) VALUES (14, 37);
INSERT INTO report (id_review, id_user_reportee) VALUES (1, 7);
INSERT INTO report (id_review, id_user_reportee) VALUES (16, 6);

-----------------------------------------
-- reportear
-----------------------------------------

INSERT INTO reportear (id_review , id_user_reportear) VALUES (8, 12);
INSERT INTO reportear (id_review , id_user_reportear) VALUES (16, 10);
INSERT INTO reportear (id_review , id_user_reportear) VALUES (16, 15);
INSERT INTO reportear (id_review , id_user_reportear) VALUES (13, 41);
INSERT INTO reportear (id_review , id_user_reportear) VALUES (16, 34);
INSERT INTO reportear (id_review , id_user_reportear) VALUES (6, 12);
INSERT INTO reportear (id_review , id_user_reportear) VALUES (3, 9);
INSERT INTO reportear (id_review , id_user_reportear) VALUES (4, 4);
INSERT INTO reportear (id_review , id_user_reportear) VALUES (12, 26);
INSERT INTO reportear (id_review , id_user_reportear) VALUES (2, 19);
INSERT INTO reportear (id_review , id_user_reportear) VALUES (6, 1);
INSERT INTO reportear (id_review , id_user_reportear) VALUES (18, 42);
INSERT INTO reportear (id_review , id_user_reportear) VALUES (16, 48);
INSERT INTO reportear (id_review , id_user_reportear) VALUES (2, 45);
INSERT INTO reportear (id_review , id_user_reportear) VALUES (5, 37);
INSERT INTO reportear (id_review , id_user_reportear) VALUES (19, 12);
INSERT INTO reportear (id_review , id_user_reportear) VALUES (14, 14);
INSERT INTO reportear (id_review , id_user_reportear) VALUES (14, 48);
INSERT INTO reportear (id_review , id_user_reportear) VALUES (1, 9);
INSERT INTO reportear (id_review , id_user_reportear) VALUES (16, 2);

-----------------------------------------
-- analyze
-----------------------------------------

INSERT INTO "analyze" (id_review , id_user_analyze) VALUES (8, 35);
INSERT INTO "analyze" (id_review , id_user_analyze) VALUES (13, 35);
INSERT INTO "analyze" (id_review , id_user_analyze) VALUES (16, 35);
INSERT INTO "analyze" (id_review , id_user_analyze) VALUES (3, 35);
INSERT INTO "analyze" (id_review , id_user_analyze) VALUES (4, 35);
INSERT INTO "analyze" (id_review , id_user_analyze) VALUES (12, 35);
INSERT INTO "analyze" (id_review , id_user_analyze) VALUES (6, 35);
INSERT INTO "analyze" (id_review , id_user_analyze) VALUES (18, 35);
INSERT INTO "analyze" (id_review , id_user_analyze) VALUES (2, 35);
INSERT INTO "analyze" (id_review , id_user_analyze) VALUES (5, 35);
INSERT INTO "analyze" (id_review , id_user_analyze) VALUES (19, 35);
INSERT INTO "analyze" (id_review , id_user_analyze) VALUES (14, 35);
INSERT INTO "analyze" (id_review , id_user_analyze) VALUES (1, 35);

-----------------------------------------
-- product Category  
-----------------------------------------

INSERT INTO product_categories (id_product, id_categories) VALUES (1, 18);
INSERT INTO product_categories (id_product, id_categories) VALUES (2, 14);
INSERT INTO product_categories (id_product, id_categories) VALUES (3, 11);
INSERT INTO product_categories (id_product, id_categories) VALUES (4, 12);
INSERT INTO product_categories (id_product, id_categories) VALUES (5, 14);
INSERT INTO product_categories (id_product, id_categories) VALUES (6, 10);
INSERT INTO product_categories (id_product, id_categories) VALUES (7, 15);
INSERT INTO product_categories (id_product, id_categories) VALUES (8, 15);
INSERT INTO product_categories (id_product, id_categories) VALUES (9, 8);
INSERT INTO product_categories (id_product, id_categories) VALUES (10, 1);
INSERT INTO product_categories (id_product, id_categories) VALUES (11, 16);
INSERT INTO product_categories (id_product, id_categories) VALUES (12, 7);
INSERT INTO product_categories (id_product, id_categories) VALUES (13, 2);
INSERT INTO product_categories (id_product, id_categories) VALUES (14, 15);
INSERT INTO product_categories (id_product, id_categories) VALUES (15, 1);
INSERT INTO product_categories (id_product, id_categories) VALUES (16, 2);
INSERT INTO product_categories (id_product, id_categories) VALUES (17, 2);
INSERT INTO product_categories (id_product, id_categories) VALUES (18, 19);
INSERT INTO product_categories (id_product, id_categories) VALUES (19, 1);
INSERT INTO product_categories (id_product, id_categories) VALUES (20, 19);
INSERT INTO product_categories (id_product, id_categories) VALUES (21, 3);
INSERT INTO product_categories (id_product, id_categories) VALUES (22, 9);
INSERT INTO product_categories (id_product, id_categories) VALUES (23, 17);
INSERT INTO product_categories (id_product, id_categories) VALUES (24, 2);
INSERT INTO product_categories (id_product, id_categories) VALUES (25, 12);
INSERT INTO product_categories (id_product, id_categories) VALUES (26, 10);
INSERT INTO product_categories (id_product, id_categories) VALUES (27, 20);
INSERT INTO product_categories (id_product, id_categories) VALUES (28, 7);
INSERT INTO product_categories (id_product, id_categories) VALUES (29, 14);
INSERT INTO product_categories (id_product, id_categories) VALUES (30, 13);
INSERT INTO product_categories (id_product, id_categories) VALUES (31, 16);
INSERT INTO product_categories (id_product, id_categories) VALUES (32, 8);
INSERT INTO product_categories (id_product, id_categories) VALUES (33, 3);
INSERT INTO product_categories (id_product, id_categories) VALUES (34, 9);
INSERT INTO product_categories (id_product, id_categories) VALUES (35, 10);
INSERT INTO product_categories (id_product, id_categories) VALUES (36, 17);
INSERT INTO product_categories (id_product, id_categories) VALUES (37, 10);
INSERT INTO product_categories (id_product, id_categories) VALUES (38, 8);
INSERT INTO product_categories (id_product, id_categories) VALUES (39, 6);
INSERT INTO product_categories (id_product, id_categories) VALUES (40, 11);
INSERT INTO product_categories (id_product, id_categories) VALUES (41, 16);
INSERT INTO product_categories (id_product, id_categories) VALUES (42, 2);
INSERT INTO product_categories (id_product, id_categories) VALUES (43, 20);
INSERT INTO product_categories (id_product, id_categories) VALUES (44, 13);
INSERT INTO product_categories (id_product, id_categories) VALUES (45, 20);
INSERT INTO product_categories (id_product, id_categories) VALUES (46, 13);
INSERT INTO product_categories (id_product, id_categories) VALUES (47, 9);
INSERT INTO product_categories (id_product, id_categories) VALUES (48, 2);
INSERT INTO product_categories (id_product, id_categories) VALUES (49, 3);
INSERT INTO product_categories (id_product, id_categories) VALUES (50, 17);
INSERT INTO product_categories (id_product, id_categories) VALUES (51, 10);
INSERT INTO product_categories (id_product, id_categories) VALUES (52, 1);
INSERT INTO product_categories (id_product, id_categories) VALUES (53, 17);
INSERT INTO product_categories (id_product, id_categories) VALUES (54, 20);
INSERT INTO product_categories (id_product, id_categories) VALUES (55, 15);
INSERT INTO product_categories (id_product, id_categories) VALUES (56, 16);
INSERT INTO product_categories (id_product, id_categories) VALUES (57, 2);
INSERT INTO product_categories (id_product, id_categories) VALUES (58, 6);
INSERT INTO product_categories (id_product, id_categories) VALUES (59, 15);
INSERT INTO product_categories (id_product, id_categories) VALUES (60, 17);
INSERT INTO product_categories (id_product, id_categories) VALUES (61, 2);
INSERT INTO product_categories (id_product, id_categories) VALUES (62, 20);
INSERT INTO product_categories (id_product, id_categories) VALUES (63, 16);
INSERT INTO product_categories (id_product, id_categories) VALUES (64, 12);
INSERT INTO product_categories (id_product, id_categories) VALUES (65, 17);
INSERT INTO product_categories (id_product, id_categories) VALUES (66, 8);
INSERT INTO product_categories (id_product, id_categories) VALUES (67, 3);
INSERT INTO product_categories (id_product, id_categories) VALUES (68, 4);
INSERT INTO product_categories (id_product, id_categories) VALUES (69, 9);
INSERT INTO product_categories (id_product, id_categories) VALUES (70, 13);
INSERT INTO product_categories (id_product, id_categories) VALUES (71, 9);
INSERT INTO product_categories (id_product, id_categories) VALUES (72, 17);
INSERT INTO product_categories (id_product, id_categories) VALUES (73, 20);
INSERT INTO product_categories (id_product, id_categories) VALUES (74, 20);
INSERT INTO product_categories (id_product, id_categories) VALUES (75, 19);
INSERT INTO product_categories (id_product, id_categories) VALUES (76, 16);
INSERT INTO product_categories (id_product, id_categories) VALUES (77, 4);
INSERT INTO product_categories (id_product, id_categories) VALUES (78, 13);
INSERT INTO product_categories (id_product, id_categories) VALUES (79, 5);
INSERT INTO product_categories (id_product, id_categories) VALUES (80, 4);
INSERT INTO product_categories (id_product, id_categories) VALUES (81, 7);
INSERT INTO product_categories (id_product, id_categories) VALUES (82, 2);
INSERT INTO product_categories (id_product, id_categories) VALUES (83, 20);
INSERT INTO product_categories (id_product, id_categories) VALUES (84, 8);
INSERT INTO product_categories (id_product, id_categories) VALUES (85, 20);
INSERT INTO product_categories (id_product, id_categories) VALUES (86, 6);
INSERT INTO product_categories (id_product, id_categories) VALUES (87, 8);
INSERT INTO product_categories (id_product, id_categories) VALUES (88, 8);
INSERT INTO product_categories (id_product, id_categories) VALUES (89, 14);
INSERT INTO product_categories (id_product, id_categories) VALUES (90, 2);
INSERT INTO product_categories (id_product, id_categories) VALUES (91, 10);
INSERT INTO product_categories (id_product, id_categories) VALUES (92, 6);
INSERT INTO product_categories (id_product, id_categories) VALUES (93, 9);
INSERT INTO product_categories (id_product, id_categories) VALUES (94, 18);
INSERT INTO product_categories (id_product, id_categories) VALUES (95, 13);
INSERT INTO product_categories (id_product, id_categories) VALUES (96, 2);
INSERT INTO product_categories (id_product, id_categories) VALUES (97, 3);
INSERT INTO product_categories (id_product, id_categories) VALUES (98, 16);
INSERT INTO product_categories (id_product, id_categories) VALUES (99, 6);
INSERT INTO product_categories (id_product, id_categories) VALUES (100, 7);

-----------------------------------------
-- product color
-----------------------------------------

INSERT INTO product_color (id_product, id_color) VALUES (1, 5);
INSERT INTO product_color (id_product, id_color) VALUES (2, 3);
INSERT INTO product_color (id_product, id_color) VALUES (3, 7);
INSERT INTO product_color (id_product, id_color) VALUES (4, 4);
INSERT INTO product_color (id_product, id_color) VALUES (5, 4);
INSERT INTO product_color (id_product, id_color) VALUES (6, 5);
INSERT INTO product_color (id_product, id_color) VALUES (7, 3);
INSERT INTO product_color (id_product, id_color) VALUES (8, 6);
INSERT INTO product_color (id_product, id_color) VALUES (9, 5);
INSERT INTO product_color (id_product, id_color) VALUES (10, 2);
INSERT INTO product_color (id_product, id_color) VALUES (11, 1);
INSERT INTO product_color (id_product, id_color) VALUES (12, 9);
INSERT INTO product_color (id_product, id_color) VALUES (13, 1);
INSERT INTO product_color (id_product, id_color) VALUES (14, 7);
INSERT INTO product_color (id_product, id_color) VALUES (15, 10);
INSERT INTO product_color (id_product, id_color) VALUES (16, 3);
INSERT INTO product_color (id_product, id_color) VALUES (17, 2);
INSERT INTO product_color (id_product, id_color) VALUES (18, 6);
INSERT INTO product_color (id_product, id_color) VALUES (19, 4);
INSERT INTO product_color (id_product, id_color) VALUES (20, 8);
INSERT INTO product_color (id_product, id_color) VALUES (21, 3);
INSERT INTO product_color (id_product, id_color) VALUES (22, 7);
INSERT INTO product_color (id_product, id_color) VALUES (23, 5);
INSERT INTO product_color (id_product, id_color) VALUES (24, 3);
INSERT INTO product_color (id_product, id_color) VALUES (25, 4);
INSERT INTO product_color (id_product, id_color) VALUES (26, 2);
INSERT INTO product_color (id_product, id_color) VALUES (27, 1);
INSERT INTO product_color (id_product, id_color) VALUES (28, 3);
INSERT INTO product_color (id_product, id_color) VALUES (29, 6);
INSERT INTO product_color (id_product, id_color) VALUES (30, 2);
INSERT INTO product_color (id_product, id_color) VALUES (31, 3);
INSERT INTO product_color (id_product, id_color) VALUES (32, 9);
INSERT INTO product_color (id_product, id_color) VALUES (33, 2);
INSERT INTO product_color (id_product, id_color) VALUES (34, 6);
INSERT INTO product_color (id_product, id_color) VALUES (35, 5);
INSERT INTO product_color (id_product, id_color) VALUES (36, 10);
INSERT INTO product_color (id_product, id_color) VALUES (37, 10);
INSERT INTO product_color (id_product, id_color) VALUES (38, 8);
INSERT INTO product_color (id_product, id_color) VALUES (39, 8);
INSERT INTO product_color (id_product, id_color) VALUES (40, 3);
INSERT INTO product_color (id_product, id_color) VALUES (41, 5);
INSERT INTO product_color (id_product, id_color) VALUES (42, 6);
INSERT INTO product_color (id_product, id_color) VALUES (43, 4);
INSERT INTO product_color (id_product, id_color) VALUES (44, 3);
INSERT INTO product_color (id_product, id_color) VALUES (45, 1);
INSERT INTO product_color (id_product, id_color) VALUES (46, 2);
INSERT INTO product_color (id_product, id_color) VALUES (47, 10);
INSERT INTO product_color (id_product, id_color) VALUES (48, 1);
INSERT INTO product_color (id_product, id_color) VALUES (49, 5);
INSERT INTO product_color (id_product, id_color) VALUES (50, 4);
INSERT INTO product_color (id_product, id_color) VALUES (51, 7);
INSERT INTO product_color (id_product, id_color) VALUES (52, 7);
INSERT INTO product_color (id_product, id_color) VALUES (53, 7);
INSERT INTO product_color (id_product, id_color) VALUES (54, 4);
INSERT INTO product_color (id_product, id_color) VALUES (55, 4);
INSERT INTO product_color (id_product, id_color) VALUES (56, 1);
INSERT INTO product_color (id_product, id_color) VALUES (57, 9);
INSERT INTO product_color (id_product, id_color) VALUES (58, 7);
INSERT INTO product_color (id_product, id_color) VALUES (59, 10);
INSERT INTO product_color (id_product, id_color) VALUES (60, 10);
INSERT INTO product_color (id_product, id_color) VALUES (61, 6);
INSERT INTO product_color (id_product, id_color) VALUES (62, 8);
INSERT INTO product_color (id_product, id_color) VALUES (63, 1);
INSERT INTO product_color (id_product, id_color) VALUES (64, 4);
INSERT INTO product_color (id_product, id_color) VALUES (65, 4);
INSERT INTO product_color (id_product, id_color) VALUES (66, 10);
INSERT INTO product_color (id_product, id_color) VALUES (67, 6);
INSERT INTO product_color (id_product, id_color) VALUES (68, 4);
INSERT INTO product_color (id_product, id_color) VALUES (69, 8);
INSERT INTO product_color (id_product, id_color) VALUES (70, 4);
INSERT INTO product_color (id_product, id_color) VALUES (71, 5);
INSERT INTO product_color (id_product, id_color) VALUES (72, 2);
INSERT INTO product_color (id_product, id_color) VALUES (73, 7);
INSERT INTO product_color (id_product, id_color) VALUES (74, 7);
INSERT INTO product_color (id_product, id_color) VALUES (75, 3);
INSERT INTO product_color (id_product, id_color) VALUES (76, 2);
INSERT INTO product_color (id_product, id_color) VALUES (77, 5);
INSERT INTO product_color (id_product, id_color) VALUES (78, 9);
INSERT INTO product_color (id_product, id_color) VALUES (79, 5);
INSERT INTO product_color (id_product, id_color) VALUES (80, 6);
INSERT INTO product_color (id_product, id_color) VALUES (81, 10);
INSERT INTO product_color (id_product, id_color) VALUES (82, 10);
INSERT INTO product_color (id_product, id_color) VALUES (83, 8);
INSERT INTO product_color (id_product, id_color) VALUES (84, 9);
INSERT INTO product_color (id_product, id_color) VALUES (85, 9);
INSERT INTO product_color (id_product, id_color) VALUES (86, 7);
INSERT INTO product_color (id_product, id_color) VALUES (87, 10);
INSERT INTO product_color (id_product, id_color) VALUES (88, 6);
INSERT INTO product_color (id_product, id_color) VALUES (89, 2);
INSERT INTO product_color (id_product, id_color) VALUES (90, 3);
INSERT INTO product_color (id_product, id_color) VALUES (91, 6);
INSERT INTO product_color (id_product, id_color) VALUES (92, 6);
INSERT INTO product_color (id_product, id_color) VALUES (93, 8);
INSERT INTO product_color (id_product, id_color) VALUES (94, 7);
INSERT INTO product_color (id_product, id_color) VALUES (95, 10);
INSERT INTO product_color (id_product, id_color) VALUES (96, 1);
INSERT INTO product_color (id_product, id_color) VALUES (97, 2);
INSERT INTO product_color (id_product, id_color) VALUES (98, 9);
INSERT INTO product_color (id_product, id_color) VALUES (99, 10);
INSERT INTO product_color (id_product, id_color) VALUES (100, 9);

-----------------------------------------
-- product size
-----------------------------------------

INSERT INTO product_size (id_product, id_size) VALUES (1, 4);
INSERT INTO product_size (id_product, id_size) VALUES (2, 3);
INSERT INTO product_size (id_product, id_size) VALUES (3, 7);
INSERT INTO product_size (id_product, id_size) VALUES (4, 6);
INSERT INTO product_size (id_product, id_size) VALUES (5, 6);
INSERT INTO product_size (id_product, id_size) VALUES (6, 3);
INSERT INTO product_size (id_product, id_size) VALUES (7, 4);
INSERT INTO product_size (id_product, id_size) VALUES (8, 7);
INSERT INTO product_size (id_product, id_size) VALUES (9, 5);
INSERT INTO product_size (id_product, id_size) VALUES (10, 2);
INSERT INTO product_size (id_product, id_size) VALUES (11, 7);
INSERT INTO product_size (id_product, id_size) VALUES (12, 3);
INSERT INTO product_size (id_product, id_size) VALUES (13, 6);
INSERT INTO product_size (id_product, id_size) VALUES (14, 6);
INSERT INTO product_size (id_product, id_size) VALUES (15, 7);
INSERT INTO product_size (id_product, id_size) VALUES (16, 6);
INSERT INTO product_size (id_product, id_size) VALUES (17, 5);
INSERT INTO product_size (id_product, id_size) VALUES (18, 6);
INSERT INTO product_size (id_product, id_size) VALUES (19, 1);
INSERT INTO product_size (id_product, id_size) VALUES (20, 7);
INSERT INTO product_size (id_product, id_size) VALUES (21, 5);
INSERT INTO product_size (id_product, id_size) VALUES (22, 2);
INSERT INTO product_size (id_product, id_size) VALUES (23, 2);
INSERT INTO product_size (id_product, id_size) VALUES (24, 1);
INSERT INTO product_size (id_product, id_size) VALUES (25, 2);
INSERT INTO product_size (id_product, id_size) VALUES (26, 5);
INSERT INTO product_size (id_product, id_size) VALUES (27, 6);
INSERT INTO product_size (id_product, id_size) VALUES (28, 2);
INSERT INTO product_size (id_product, id_size) VALUES (29, 3);
INSERT INTO product_size (id_product, id_size) VALUES (30, 7);
INSERT INTO product_size (id_product, id_size) VALUES (31, 3);
INSERT INTO product_size (id_product, id_size) VALUES (32, 7);
INSERT INTO product_size (id_product, id_size) VALUES (33, 3);
INSERT INTO product_size (id_product, id_size) VALUES (34, 4);
INSERT INTO product_size (id_product, id_size) VALUES (35, 7);
INSERT INTO product_size (id_product, id_size) VALUES (36, 5);
INSERT INTO product_size (id_product, id_size) VALUES (37, 7);
INSERT INTO product_size (id_product, id_size) VALUES (38, 4);
INSERT INTO product_size (id_product, id_size) VALUES (39, 4);
INSERT INTO product_size (id_product, id_size) VALUES (40, 1);
INSERT INTO product_size (id_product, id_size) VALUES (41, 1);
INSERT INTO product_size (id_product, id_size) VALUES (42, 4);
INSERT INTO product_size (id_product, id_size) VALUES (43, 7);
INSERT INTO product_size (id_product, id_size) VALUES (44, 5);
INSERT INTO product_size (id_product, id_size) VALUES (45, 3);
INSERT INTO product_size (id_product, id_size) VALUES (46, 4);
INSERT INTO product_size (id_product, id_size) VALUES (47, 2);
INSERT INTO product_size (id_product, id_size) VALUES (48, 6);
INSERT INTO product_size (id_product, id_size) VALUES (49, 1);
INSERT INTO product_size (id_product, id_size) VALUES (50, 4);
INSERT INTO product_size (id_product, id_size) VALUES (51, 5);
INSERT INTO product_size (id_product, id_size) VALUES (52, 6);
INSERT INTO product_size (id_product, id_size) VALUES (53, 4);
INSERT INTO product_size (id_product, id_size) VALUES (54, 5);
INSERT INTO product_size (id_product, id_size) VALUES (55, 5);
INSERT INTO product_size (id_product, id_size) VALUES (56, 5);
INSERT INTO product_size (id_product, id_size) VALUES (57, 2);
INSERT INTO product_size (id_product, id_size) VALUES (58, 2);
INSERT INTO product_size (id_product, id_size) VALUES (59, 4);
INSERT INTO product_size (id_product, id_size) VALUES (60, 1);
INSERT INTO product_size (id_product, id_size) VALUES (61, 2);
INSERT INTO product_size (id_product, id_size) VALUES (62, 7);
INSERT INTO product_size (id_product, id_size) VALUES (63, 6);
INSERT INTO product_size (id_product, id_size) VALUES (64, 3);
INSERT INTO product_size (id_product, id_size) VALUES (65, 1);
INSERT INTO product_size (id_product, id_size) VALUES (66, 6);
INSERT INTO product_size (id_product, id_size) VALUES (67, 6);
INSERT INTO product_size (id_product, id_size) VALUES (68, 3);
INSERT INTO product_size (id_product, id_size) VALUES (69, 1);
INSERT INTO product_size (id_product, id_size) VALUES (70, 3);
INSERT INTO product_size (id_product, id_size) VALUES (71, 5);
INSERT INTO product_size (id_product, id_size) VALUES (72, 2);
INSERT INTO product_size (id_product, id_size) VALUES (73, 3);
INSERT INTO product_size (id_product, id_size) VALUES (74, 2);
INSERT INTO product_size (id_product, id_size) VALUES (75, 5);
INSERT INTO product_size (id_product, id_size) VALUES (76, 4);
INSERT INTO product_size (id_product, id_size) VALUES (77, 5);
INSERT INTO product_size (id_product, id_size) VALUES (78, 6);
INSERT INTO product_size (id_product, id_size) VALUES (79, 6);
INSERT INTO product_size (id_product, id_size) VALUES (80, 1);
INSERT INTO product_size (id_product, id_size) VALUES (81, 7);
INSERT INTO product_size (id_product, id_size) VALUES (82, 6);
INSERT INTO product_size (id_product, id_size) VALUES (83, 7);
INSERT INTO product_size (id_product, id_size) VALUES (84, 7);
INSERT INTO product_size (id_product, id_size) VALUES (85, 3);
INSERT INTO product_size (id_product, id_size) VALUES (86, 7);
INSERT INTO product_size (id_product, id_size) VALUES (87, 6);
INSERT INTO product_size (id_product, id_size) VALUES (88, 2);
INSERT INTO product_size (id_product, id_size) VALUES (89, 1);
INSERT INTO product_size (id_product, id_size) VALUES (90, 1);
INSERT INTO product_size (id_product, id_size) VALUES (91, 5);
INSERT INTO product_size (id_product, id_size) VALUES (92, 6);
INSERT INTO product_size (id_product, id_size) VALUES (93, 4);
INSERT INTO product_size (id_product, id_size) VALUES (94, 1);
INSERT INTO product_size (id_product, id_size) VALUES (95, 4);
INSERT INTO product_size (id_product, id_size) VALUES (96, 7);
INSERT INTO product_size (id_product, id_size) VALUES (97, 3);
INSERT INTO product_size (id_product, id_size) VALUES (98, 1);
INSERT INTO product_size (id_product, id_size) VALUES (99, 3);
INSERT INTO product_size (id_product, id_size) VALUES (100, 1);

-----------------------------------------
-- product brand
-----------------------------------------

INSERT INTO product_brand (id_product, id_brand) VALUES (1, 3);
INSERT INTO product_brand (id_product, id_brand) VALUES (2, 9);
INSERT INTO product_brand (id_product, id_brand) VALUES (3, 7);
INSERT INTO product_brand (id_product, id_brand) VALUES (4, 7);
INSERT INTO product_brand (id_product, id_brand) VALUES (5, 9);
INSERT INTO product_brand (id_product, id_brand) VALUES (6, 17);
INSERT INTO product_brand (id_product, id_brand) VALUES (7, 4);
INSERT INTO product_brand (id_product, id_brand) VALUES (8, 4);
INSERT INTO product_brand (id_product, id_brand) VALUES (9, 8);
INSERT INTO product_brand (id_product, id_brand) VALUES (10, 12);
INSERT INTO product_brand (id_product, id_brand) VALUES (11, 18);
INSERT INTO product_brand (id_product, id_brand) VALUES (12, 1);
INSERT INTO product_brand (id_product, id_brand) VALUES (13, 8);
INSERT INTO product_brand (id_product, id_brand) VALUES (14, 2);
INSERT INTO product_brand (id_product, id_brand) VALUES (15, 1);
INSERT INTO product_brand (id_product, id_brand) VALUES (16, 15);
INSERT INTO product_brand (id_product, id_brand) VALUES (17, 9);
INSERT INTO product_brand (id_product, id_brand) VALUES (18, 19);
INSERT INTO product_brand (id_product, id_brand) VALUES (19, 16);
INSERT INTO product_brand (id_product, id_brand) VALUES (20, 17);
INSERT INTO product_brand (id_product, id_brand) VALUES (21, 14);
INSERT INTO product_brand (id_product, id_brand) VALUES (22, 16);
INSERT INTO product_brand (id_product, id_brand) VALUES (23, 19);
INSERT INTO product_brand (id_product, id_brand) VALUES (24, 18);
INSERT INTO product_brand (id_product, id_brand) VALUES (25, 10);
INSERT INTO product_brand (id_product, id_brand) VALUES (26, 9);
INSERT INTO product_brand (id_product, id_brand) VALUES (27, 2);
INSERT INTO product_brand (id_product, id_brand) VALUES (28, 17);
INSERT INTO product_brand (id_product, id_brand) VALUES (29, 9);
INSERT INTO product_brand (id_product, id_brand) VALUES (30, 20);
INSERT INTO product_brand (id_product, id_brand) VALUES (31, 19);
INSERT INTO product_brand (id_product, id_brand) VALUES (32, 13);
INSERT INTO product_brand (id_product, id_brand) VALUES (33, 14);
INSERT INTO product_brand (id_product, id_brand) VALUES (34, 18);
INSERT INTO product_brand (id_product, id_brand) VALUES (35, 3);
INSERT INTO product_brand (id_product, id_brand) VALUES (36, 15);
INSERT INTO product_brand (id_product, id_brand) VALUES (37, 20);
INSERT INTO product_brand (id_product, id_brand) VALUES (38, 2);
INSERT INTO product_brand (id_product, id_brand) VALUES (39, 5);
INSERT INTO product_brand (id_product, id_brand) VALUES (40, 7);
INSERT INTO product_brand (id_product, id_brand) VALUES (41, 16);
INSERT INTO product_brand (id_product, id_brand) VALUES (42, 20);
INSERT INTO product_brand (id_product, id_brand) VALUES (43, 17);
INSERT INTO product_brand (id_product, id_brand) VALUES (44, 11);
INSERT INTO product_brand (id_product, id_brand) VALUES (45, 1);
INSERT INTO product_brand (id_product, id_brand) VALUES (46, 6);
INSERT INTO product_brand (id_product, id_brand) VALUES (47, 14);
INSERT INTO product_brand (id_product, id_brand) VALUES (48, 3);
INSERT INTO product_brand (id_product, id_brand) VALUES (49, 18);
INSERT INTO product_brand (id_product, id_brand) VALUES (50, 8);
INSERT INTO product_brand (id_product, id_brand) VALUES (51, 6);
INSERT INTO product_brand (id_product, id_brand) VALUES (52, 1);
INSERT INTO product_brand (id_product, id_brand) VALUES (53, 5);
INSERT INTO product_brand (id_product, id_brand) VALUES (54, 9);
INSERT INTO product_brand (id_product, id_brand) VALUES (55, 15);
INSERT INTO product_brand (id_product, id_brand) VALUES (56, 14);
INSERT INTO product_brand (id_product, id_brand) VALUES (57, 6);
INSERT INTO product_brand (id_product, id_brand) VALUES (58, 8);
INSERT INTO product_brand (id_product, id_brand) VALUES (59, 15);
INSERT INTO product_brand (id_product, id_brand) VALUES (60, 12);
INSERT INTO product_brand (id_product, id_brand) VALUES (61, 11);
INSERT INTO product_brand (id_product, id_brand) VALUES (62, 13);
INSERT INTO product_brand (id_product, id_brand) VALUES (63, 14);
INSERT INTO product_brand (id_product, id_brand) VALUES (64, 16);
INSERT INTO product_brand (id_product, id_brand) VALUES (65, 8);
INSERT INTO product_brand (id_product, id_brand) VALUES (66, 9);
INSERT INTO product_brand (id_product, id_brand) VALUES (67, 6);
INSERT INTO product_brand (id_product, id_brand) VALUES (68, 2);
INSERT INTO product_brand (id_product, id_brand) VALUES (69, 10);
INSERT INTO product_brand (id_product, id_brand) VALUES (70, 15);
INSERT INTO product_brand (id_product, id_brand) VALUES (71, 7);
INSERT INTO product_brand (id_product, id_brand) VALUES (72, 9);
INSERT INTO product_brand (id_product, id_brand) VALUES (73, 3);
INSERT INTO product_brand (id_product, id_brand) VALUES (74, 7);
INSERT INTO product_brand (id_product, id_brand) VALUES (75, 13);
INSERT INTO product_brand (id_product, id_brand) VALUES (76, 18);
INSERT INTO product_brand (id_product, id_brand) VALUES (77, 5);
INSERT INTO product_brand (id_product, id_brand) VALUES (78, 10);
INSERT INTO product_brand (id_product, id_brand) VALUES (79, 20);
INSERT INTO product_brand (id_product, id_brand) VALUES (80, 1);
INSERT INTO product_brand (id_product, id_brand) VALUES (81, 1);
INSERT INTO product_brand (id_product, id_brand) VALUES (82, 6);
INSERT INTO product_brand (id_product, id_brand) VALUES (83, 4);
INSERT INTO product_brand (id_product, id_brand) VALUES (84, 6);
INSERT INTO product_brand (id_product, id_brand) VALUES (85, 13);
INSERT INTO product_brand (id_product, id_brand) VALUES (86, 19);
INSERT INTO product_brand (id_product, id_brand) VALUES (87, 11);
INSERT INTO product_brand (id_product, id_brand) VALUES (88, 14);
INSERT INTO product_brand (id_product, id_brand) VALUES (89, 3);
INSERT INTO product_brand (id_product, id_brand) VALUES (90, 6);
INSERT INTO product_brand (id_product, id_brand) VALUES (91, 1);
INSERT INTO product_brand (id_product, id_brand) VALUES (92, 12);
INSERT INTO product_brand (id_product, id_brand) VALUES (93, 6);
INSERT INTO product_brand (id_product, id_brand) VALUES (94, 15);
INSERT INTO product_brand (id_product, id_brand) VALUES (95, 18);
INSERT INTO product_brand (id_product, id_brand) VALUES (96, 5);
INSERT INTO product_brand (id_product, id_brand) VALUES (97, 8);
INSERT INTO product_brand (id_product, id_brand) VALUES (98, 1);
INSERT INTO product_brand (id_product, id_brand) VALUES (99, 16);
INSERT INTO product_brand (id_product, id_brand) VALUES (100, 11);
