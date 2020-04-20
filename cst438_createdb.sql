-- *************************************************************
-- This script creates the Food Flight Schema
-- for CST 438 Final Project
-- *************************************************************

-- ********************************************
-- CREATE THE FOODFLIGHT DATABASE
-- *******************************************

-- create the database
DROP DATABASE IF EXISTS foodflight;
CREATE DATABASE foodflight;

-- select the database
USE foodflight;

-- create the tables
CREATE TABLE menu_items
(
  rest_id        	BIGINT             NOT NULL,
  dish_id   	 	BIGINT   			PRIMARY KEY AUTO_INCREMENT,
  dish_name		 	VARCHAR(50) 	NOT NULL,
  dish_type 		VARCHAR(50),
  dish_description 	VARCHAR(200),
  price			 	DECIMAL(9,2)    NOT NULL
);


CREATE TABLE customers
(
  cust_id                     	BIGINT            PRIMARY KEY   AUTO_INCREMENT,
  first_name                   	VARCHAR(50)    NOT NULL,
  last_name						VARCHAR(50)    NOT NULL,
  cust_address1               	VARCHAR(50),
  cust_address2               	VARCHAR(50),
  cust_city                   	VARCHAR(50)    NOT NULL,
  cust_state                  	CHAR(2)        NOT NULL,
  cust_zip_code               	VARCHAR(20)    NOT NULL,
  cust_phone                  	VARCHAR(50)	 NOT NULL
);

CREATE TABLE orders
(
  order_id            	BIGINT            PRIMARY KEY   AUTO_INCREMENT,
  cust_id             	BIGINT            NOT NULL,
  order_datetime       	DATETIME       NOT NULL,
  order_total         	DECIMAL(9,2)   NOT NULL,
  tip         			DECIMAL(9,2)   NOT NULL      DEFAULT 0,
  grand_total	        DECIMAL(9,2)   NOT NULL      DEFAULT 0,
  payment_type          VARCHAR(50)    NOT NULL,
  CONSTRAINT orders_fk_customers
    FOREIGN KEY (cust_id)
    REFERENCES customers (cust_id)
);

CREATE TABLE order_line_items
(
  order_id              BIGINT            NOT NULL,
  order_sequence        INT            NOT NULL,
  dish_id				BIGINT			   NOT NULL,
  qty					INT			   NOT NULL,
  line_item_amount      DECIMAL(9,2)   NOT NULL,
  CONSTRAINT line_items_pk
    PRIMARY KEY (order_id, order_sequence),
  CONSTRAINT line_items_fk_orders
    FOREIGN KEY (order_id)
    REFERENCES orders (order_id),
  CONSTRAINT line_items_fk_menu_items
    FOREIGN KEY (dish_id)
    REFERENCES menu_items (dish_id)
);

CREATE TABLE session
(
  id		BIGINT PRIMARY KEY   AUTO_INCREMENT,
  rest_id        	BIGINT,
  first_name                   	VARCHAR(50),
  last_name						VARCHAR(50),
  cust_address1               	VARCHAR(50),
  cust_address2               	VARCHAR(50),
  cust_city                   	VARCHAR(50),
  cust_state                  	CHAR(2),
  cust_zip_code               	VARCHAR(20),
  cust_phone                  	VARCHAR(50),
  order_total         	DECIMAL(9,2),
  tip         			DECIMAL(9,2)  DEFAULT 0,
  grand_total	        DECIMAL(9,2)  DEFAULT 0,
  payment_type          VARCHAR(50),
  order_line_items		JSON  
);

-- create the indexes
CREATE INDEX orders_order_datetime_ix
  ON orders (order_datetime DESC);


-- insert rows into the tables
--  rest_id        	INT             PRIMARY KEY,
--  dish_id   	 	INT   			UNIQUE,
--  dish_name		 	VARCHAR(50) 	NOT NULL,
--  dish_type			VARCHAR(50),
--  dish_description	VARCHAR(100),
-- 	price			 	DECIMAL(9,2)    NOT NULL

INSERT INTO menu_items VALUES 
(17072771, DEFAULT, 'Chicken Teriyaki', 'Entree', '', 9.95), 
(17072771, DEFAULT, 'Beef Teriyaki', 'Entree', '', 14.95), 
(17072771, DEFAULT, 'Salmon Teriyaki', 'Entree', '', 10.95), 
(17072771, DEFAULT, 'Sesame Chicken', 'Entree', '', 10.95), 
(17072771, DEFAULT, 'Chicken Katsu', 'Entree', '', 10.95), 
(17072771, DEFAULT, 'Pork Katsu', 'Entree', '', 9.95), 
(17072771, DEFAULT, 'Chicken Curry', 'Entree', '', 9.95), 
(17072771, DEFAULT, 'Salmon Roll', 'Sushi Roll', '', 4.95), 
(17072771, DEFAULT, 'Eel Avocado Roll', 'Sushi Roll', '', 6.50), 
(17072771, DEFAULT, 'Salmon Skin Roll', 'Sushi Roll', '', 5.50), 
(17072771, DEFAULT, 'Spicy Tuna Roll', 'Sushi Roll', '', 5.95), 
(17072771, DEFAULT, 'Spider Roll', 'Sushi Roll', '', 9.95), 

(17075260, DEFAULT, 'Zaatar', 'Oven-baked Flatbread', 'Imported organic zaatar, sumac, and sesame', 5.95), 
(17075260, DEFAULT, 'Soujouk', 'Oven-baked Flatbread', 'Specialty spice blend of Armenian spices with ground beef, tomato, onion, and fresh white cheese', 9.95), 
(17075260, DEFAULT, 'Chicken Tawook', 'Oven-baked Flatbread', 'Marinated chicken, garlic paste, and pickles', 9.95),
(17075260, DEFAULT, 'Falafel Wrap', 'Alforon World-famous Falafel', 'Our mix of falafel pieces, fava & gabanzo beans specially mixed with spices and herbs, deep-fried upon ordering and mixed with sliced romaine lettuce, diced tomato, tahini, parsley, and pickles.', 8.95),
(17075260, DEFAULT, 'Falafel Salad', 'Alforon World-famous Falafel', 'Healthy, Filling and delicious Falafel Nuggets over Romain lettuce, Diced Tomato then topped with an amazing Tahini sauce', 7.95),   
(17075260, DEFAULT, 'Labni Plate', 'Alforon Mezza', 'Kefir cheese, olives & zaatar.', 13.95),
(17075260, DEFAULT, 'Foul', 'Alforon Mezza', 'Traditional fava beans in a bed of extra virgin olive oil, garlic and fresh lemon juice.', 7.95),
(17075260, DEFAULT, 'Balilah', 'Alforon Mezza', 'Garbanzo beans in a bed of extra virgin olive oil, garlic & fresh lemon juice.', 7.95),
(17075260, DEFAULT, 'Baba Ghannouj', 'Alforon Mezza', 'Oven-roasted eggplant, tahini & lemon.', 7.95),
(17075260, DEFAULT, 'Humous', 'Alforon Mezza', 'Garbanzo, tahini sauce, lemon.', 7.95), 
(17075260, DEFAULT, 'Alforon Grape Leaves', 'Alforon Mezza', 'Stuffed with rice, tomato, parsley onion, mint and lemon juices and spices.', 7.95),
 
(17070562, DEFAULT, 'Grilled Eggplant Pesto with Spinach', 'Signature Sandwiches', 'Grilled eggplant, topped with fresh spinach, tomatoes, onions, and cheese. Served with chips and pickles.', 9.99), 
(17070562, DEFAULT, 'Grilled Chicken and Roasted Red Peppers', 'Signature Sandwiches', 'Grilled chicken breast, roasted red peppers, topped with fresh lettuce, tomatoes, onions, cheese, drizzled with ranch dressing. Served with chips and pickles.', 9.99),
(17070562, DEFAULT, 'Gyro Sandwich', 'Signature Sandwiches', 'Beef gyro wrapped in Greek-style pita bread. Served with tomatoes, lettuce, onions, tzatziki, and chips.', 9.99),
(17070562, DEFAULT, 'Iced Coffee', 'Cold Drinks', '', 2.85),
(17070562, DEFAULT, 'Iced Chai Latte', 'Cold Drinks', '', 4.80),
(17070562, DEFAULT, 'Iced Green Tea', 'Cold Drinks', '', 2.75),
(17070562, DEFAULT, 'Iced Black Tea', 'Cold Drinks', '', 2.75),
(17070562, DEFAULT, 'Arnold Palmer', 'Cold Drinks', 'Black iced tea with lemonade', 3.00),
(17070562, DEFAULT, 'Lemonade', 'Cold Drinks', '', 3.50),
(17070562, DEFAULT, 'Hammerhead', 'Hair-Raising Drinks', 'Espresso and Coffee', 4.80),
(17070562, DEFAULT, 'Slammer', 'Hair-Raising Drinks', 'Four shots of espresso', 4.80),
(17070562, DEFAULT, 'Trembler', 'Hair-Raising Drinks', 'Three shots of espresso and hot chocolate', 4.80),

(17073076, DEFAULT, 'Kickin\' Carnitas', '8" Personal Pizza', 'Southern Chipotle sauce, slow marinated carnitas, crispy bacon, red onions, and fresh cilantro', 11.50),
(17073076, DEFAULT, 'Aztec Classic', '8" Personal Pizza', 'Pepperoni, sausage, black olives, \'shrooms, and onion slices', 11.50),
(17073076, DEFAULT, 'Grateful Veg', '8" Personal Pizza', 'Sliced bell peppers, white onions, fresh tomatoes, black olives, & magical \'shrooms', 11.50),
(17073076, DEFAULT, 'Monty\'s Revenge', '8" Personal Pizza', 'Pepperoni, Italian sausage, freshly sliced bell pepper medley, white onions & \'shrooms', 11.50),
(17073076, DEFAULT, 'Kickin\' Carnitas', '12" Medium Pizza', 'Southern Chipotle sauce, slow marinated carnitas, crispy bacon, red onions, and fresh cilantro', 21.35),
(17073076, DEFAULT, 'Aztec Classic', '12" Medium Pizza', 'Pepperoni, sausage, black olives, \'shrooms, and onion slices', 21.35),
(17073076, DEFAULT, 'Grateful Veg', '12" Medium Pizza', 'Sliced bell peppers, white onions, fresh tomatoes, black olives, & magical \'shrooms', 21.35),
(17073076, DEFAULT, 'Monty\'s Revenge', '12" Medium Pizza', 'Pepperoni, Italian sausage, freshly sliced bell pepper medley, white onions & \'shrooms', 21.35),
(17073076, DEFAULT, 'Kickin\' Carnitas', '14" Large Pizza', 'Southern Chipotle sauce, slow marinated carnitas, crispy bacon, red onions, and fresh cilantro', 26.95),
(17073076, DEFAULT, 'Aztec Classic', '14" Large Pizza', 'Pepperoni, sausage, black olives, \'shrooms, and onion slices', 26.95),
(17073076, DEFAULT, 'Grateful Veg', '14" Large Pizza', 'Sliced bell peppers, white onions, fresh tomatoes, black olives, & magical \'shrooms', 26.95),
(17073076, DEFAULT, 'Monty\'s Revenge', '14" Large Pizza', 'Pepperoni, Italian sausage, freshly sliced bell pepper medley, white onions & \'shrooms', 26.95),

(17072000, DEFAULT, 'Pad Thai', 'Noodles', 'Stir-fried narrow rice noodles, bean sprouts, green onions, crushed peanuts, eggs, and Thai seasoning.', 10.95),
(17072000, DEFAULT, 'Pad See Eew', 'Noodles', 'Stir-fried wide rice noodles, broccoli, eggs, and soy sauce.', 10.95),
(17072000, DEFAULT, 'Pad Woonsen', 'Noodles', 'Stir-fried bean thread noodles, eggs, broccoli, carrots, zucchini, and cabbage.', 10.95),
(17072000, DEFAULT, 'Spicy Noodles', 'Noodles', 'Stir fried wide rice noodles, our house special chili sauce, bean sprouts, and basil.', 10.95),
(17072000, DEFAULT, 'Massaman Curry', 'Curry', 'Potatoes, onions, and peanuts in massaman curry with coconut milk. Served with rice.', 10.95),
(17072000, DEFAULT, 'Yellow Curry', 'Curry', 'Potatoes in yellow curry paste with coconut milk. Served with rice.', 10.95),
(17072000, DEFAULT, 'Red Curry', 'Curry', 'Bamboo shoots, carrots, green beans, and basil in red curry paste with coconut milk. Served with rice.', 10.95),
(17072000, DEFAULT, 'Green Curry', 'Curry', 'Bamboo shoots, carrots, green beans, and basil in green curry paste with coconut milk. Served with rice.', 10.95),
(17072000, DEFAULT, 'Garlic Cripsy Duck', 'House Specialty', 'Crispy duck, stir-fried with garlic, and green beans. Served with rice.', 12.95),
(17072000, DEFAULT, 'Spicy Seafood Combination', 'House Specialty', 'Seafood combination stir-fried with onions, carrots, broccoli, celery, bell peppers, and basil in the red curry paste. Served with rice.', 17.95),
(17072000, DEFAULT, 'Popeye', 'House Specialty', 'Marinated chicken, fried tofu, steamed spinach, broccoli, carrots, zucchini, and green beans topped with peanut sauce. Served with rice.', 10.95),
(17072000, DEFAULT, 'Thai Beef Jerky & Sticky Rice', 'House Specialty', 'Marinated beef strips deep fried served with sticky rice and tamarind chili sauce.', 12.95),

(17611814, DEFAULT, 'BIGFOOT Chicken Fried Steak', 'Dinner', 'Our best-selling item. Tender beef, breadedthen deep-fried & smothered in our own country gravy.', 16.99),
(17611814, DEFAULT, 'Homestyle Fried Chicken', 'Dinner', 'Bone in leg, thigh, wing & breast of chicken lightly battered and fried golden-brown. Served with a side of country gravy.', 16.99),
(17611814, DEFAULT, 'Wild Alaska Pesto Salmon', 'Dinner', 'Lightly seasoned, 8 oz. grilled salmon served on a bed of steamed spinach, topped with pesto.', 16.99),
(17611814, DEFAULT, 'New York Steak', 'Dinner', '10 oz. steak topped with deep-fried onion rings.', 19.99),
(17611814, DEFAULT, 'Bob\'s Big Bear Burger', 'Lunch', 'A 10 oz. all beef patty is specially seasoned and served with grilled onions, tomato, dill pickle chips, lettuce, mayonnaise & Thousand Island dressing. Served with your choice of side.', 13.99),
(17611814, DEFAULT, 'California Burger', 'Lunch', 'A 7 oz. all beef patty built on a golden brioche bun, shredded lettuce, tomato, diced red onion, dill pickle chips, mayonnaise & Thousand Island dressing. Topped with Avocado & jack cheese.', 12.99),
(17611814, DEFAULT, 'Turkey Club', 'Lunch', 'Triple-decker stacked with roasted turkey breast, bacon, ham, tomato, lettuce & mayonnaise.', 12.95),
(17611814, DEFAULT, 'Chicken Avocado Club', 'Lunch', 'This triple-stack includes marinated grilled chicken breast, avocado, bacon, lettuce, tomato, Swiss cheese & mayonnaise.', 12.99),
(17611814, DEFAULT, 'The Grizz', 'Breakfast', '2 sweet cream pancakes, 3 eggs, 2 slices of bacon, 2 sausage links & a ham steak, served with your choice of potato.', 14.99),
(17611814, DEFAULT, 'BIGFOOT Chicken Fried Steak & Eggs', 'Breakfast', 'Served with 3 eggs, strip-cut hash browns or country red potatoes& 2 housemade biscuits.', 14.99),
(17611814, DEFAULT, 'Sirloin Steak & Eggs', 'Breakfast', '8 oz Choice cut.', 13.99),
(17611814, DEFAULT, 'Link Sausage & Eggs', 'Breakfast', '3 large links of our specially seasoned pork sausage.', 11.49),

(17611651, DEFAULT, 'Chow Mein', 'Noodles', 'Pan-fried linguini with meat and assorted vegetables.', 11.95),
(17611651, DEFAULT, 'Baan Thai Noodles', 'Noodles', '	Ground chicken sauté with black mushrooms, tofu and dry shrimp over steam noodles.', 12.95),
(17611651, DEFAULT, 'Pad Thai', 'Noodles', 'Thin rice noodles pan-fried with meat, egg, bean sprouts, and green onions.', 11.95),
(17611651, DEFAULT, 'Singapore Noodles', 'Noodles', 'Small thin noodles stir-fried with chicken, Chinese sausages, cabbage, onions and bell peppers in curry pepper.', 12.95),
(17611651, DEFAULT, 'Seafood Curry', 'Curry', 'Curry coconut milk with green chili paste, prawns, squid, green mussels, fish, bell peppers, carrots, eggplant, and Thai basil.', 17.95),
(17611651, DEFAULT, 'Red Curry', 'Curry', 'Curry coconut milk with red chili paste, bell peppers, carrots, bamboo shoots and Thai basil.', 12.95),
(17611651, DEFAULT, 'Green Curry', 'Curry', 'Curry coconut milk with green chili paste, bell peppers, carrots, eggplant, and Thai basil.', 12.95),
(17611651, DEFAULT, 'Pumpkin Curry', 'Curry', 'Curry coconut milk with red chili paste, bell pepper, carrots, pumpkin and Thai basil.', 12.95),
(17611651, DEFAULT, 'Nam Prik Ong', 'Specialty', 'Ground chicken stir-fried with chili paste, onions, and tomatoes, served with cucumbers and lettuce.', 12.95),
(17611651, DEFAULT, 'Spicy BBQ Duck', 'Specialty', 'Stir- fried BBQ duck with chili, bell peppers, onions, and topped with deep-fried Thai basil.', 15.95),
(17611651, DEFAULT, 'Spicy Catfish', 'Specialty', 'Crispy cat fish fillets sauteed in chili paste with green beans, bell peppers, onions, carrots and Thai basil.', 17.95),
(17611651, DEFAULT, 'Baan Thai Trout', 'Specialty', 'Deep-fried whole trout topped with golden apple relish.', 17.95),

(17611676, DEFAULT, 'Agedashi Tofu', 'Appetizer', 'DDeep-fried tofu with special Japanese sauce.', 4.95),
(17611676, DEFAULT, 'Takoyaki', 'Appetizer', 'Deep-fried wheat balls with octopis and special sauce. 6 pieces.', 5.50),
(17611676, DEFAULT, 'Gyoza', 'Appetizer', 'Deep-fried pork and vegetables dumplings. 6 pieces.', 5.50),
(17611676, DEFAULT, 'Shumai', 'Appetizer', 'Deep-fried shrimp dumplings. 6 pieces.', 4.90),
(17611676, DEFAULT, 'Hamachi Sashimi', 'Sashimi', '6 pieces of fresh yellowtail.', 13.50),
(17611676, DEFAULT, 'Maguro Sashimi', 'Sashimi', '6 pieces of fresh tuna.', 12.50),
(17611676, DEFAULT, 'Sake Sashimi', 'Sashimi', '6 pieces of fresh salmon.', 11.50),
(17611676, DEFAULT, 'Combo Sashimi', 'Sashimi', 'Chef\'s choice of 12 pieces of fresh assorted fish.', 16.95),
(17611676, DEFAULT, 'I Love You Roll', 'Sushi Rolls', 'Unagi, yellowtail, avocado, cucumber, mademia nuts with tobiko, green onion, sweet sauce.', 9.95),
(17611676, DEFAULT, 'Garden Roll', 'Sushi Rolls', 'Yam tempura, cream cheese, cucumber, avocado, fried asparagus, sweet sauce.', 8.50),
(17611676, DEFAULT, 'Ebi Carnival', 'Sushi Rolls', 'Shrimp tempura, avocado, cucumber, topped with crab salad, tobiko, green onion, sweet sauce.', 10.25),
(17611676, DEFAULT, 'Eternal Sunshine', 'Sushi Rolls', 'Shrimp tempura, cucumber, avocado, topped with salmon, lemon, sweet sauce.', 10.25),

(17611656, DEFAULT, 'Biscuits & Spicy Gravy', 'Local Favorites', 'Served with homefries.', 9.95),
(17611656, DEFAULT, 'S.O.S.', 'Local Favorites', 'Ground beef and spicy gravy over biscuits', 12.95),
(17611656, DEFAULT, 'Seaside Joe\'s Scramble', 'Local Favorites', 'Gluten-free. Ground beef, onion, spinach, and mushrooms, scrambled with eggs', 13.95),
(17611656, DEFAULT, 'Cheese Blintz', 'Local Favorites', 'Topped with strawberries and sour cream.', 10.95),
(17611656, DEFAULT, 'Waffle', 'Waffles', '', 9.95),
(17611656, DEFAULT,  'Bacon Waffles', 'Waffles', '', 10.95),
(17611656, DEFAULT, 'Waffle with Fresh Fruit', 'Waffles', 'Bananes, blueberry, raspberry, and strawberry', 10.95),
(17611656, DEFAULT, 'Waffle Special', 'Waffles', 'Served with 2 eggs and bacon', 13.95),
(17611656, DEFAULT, 'Spinach, Mushroom, & Jack', 'Omelets', 'Gluten-free.', 13.45),
(17611656, DEFAULT, 'Ron\'s', 'Omelets', 'Gluten-free. Bacon, tomato and cheddar cheese topped with avocado and sour cream.', 14.45),
(17611656, DEFAULT, 'Ken\'s', 'Omelets', 'Gluten-free. Ortega chiles, salsa and cheddar cheese topped with avocado and sour cream.', 13.45),
(17611656, DEFAULT, 'Quintal\'s', 'Omelets', 'Gluten-free. Refried beans, salsa and cheddar cheese topped with avocado and sour cream.', 13.45);