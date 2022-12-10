CREATE DATABASE grocery;

CREATE TABLE public.groceryShops(
	shopId BIGINT NOT NULL,
 	sName VARCHAR(50) NOT NULL,
	sLocation VARCHAR(50) NOT NULL,
 	PRIMARY KEY (shopId)
);


CREATE TABLE public.products( 
	prodId BIGINT NOT NULL,
	prodName VARCHAR(50) NOT NULL,
 	price VARCHAR(50) NOT NULL DEFAULT 0,
	description VARCHAR(50) NOT NULL,
 	image VARCHAR(50) NOT NULL DEFAULT NULL,
 	shopId BIGINT NOT NULL,
	PRIMARY KEY (prodId),
	FOREIGN KEY (shopId) REFERENCES groceryShops(shopId)
);


CREATE TABLE public.wishlists(
	listId BIGINT NOT NULL PRIMARY KEY ,
	liked BOOLEAN ,
	added BOOLEAN,
	prodId BIGINT NOT NULL,
	FOREIGN KEY(prodId)REFERENCES products(prodId)
);
	
	
CREATE TABLE public.cakes(
	cakeId BIGINT NOT NULL PRIMARY KEY,
	cName VARCHAR(50) NOT NULL DEFAULT NULL, 			
	category VARCHAR(50) NOT NULL DEFAULT NULL,
 	description VARCHAR(50) NOT NULL DEFAULT NULL,
	price VARCHAR(50) NOT NULL DEFAULT 0,
	recipies VARCHAR(50) NOT NULL DEFAULT NULL,
	image VARCHAR(50) NOT NULL DEFAULT NULL
);


CREATE TABLE public.categories (
	categoryId BIGINT NOT NULL,
 	categoryType varchar NULL DEFAULT NULL,
	PRIMARY KEY (categoryId)
);
	

CREATE TABLE public.productCategories (
	prodId BIGINT NOT NULL,
	categoryId BIGINT NOT NULL,
 	PRIMARY KEY (prodId, categoryId),
 	FOREIGN KEY (prodId) REFERENCES products (prodId),
	FOREIGN KEY (categoryId) REFERENCES categories (categoryId)
);
	

CREATE TABLE public.orders(
	orderId BIGINT NOT NULL PRIMARY KEY,			
	category VARCHAR(50) NOT NULL DEFAULT NULL,
	quantity VARCHAR(30) NOT NULL DEFAULT NULL,
 	status VARCHAR(50) NOT NULL DEFAULT NULL,
	price VARCHAR(50) NOT NULL DEFAULT 0,
	cakeId BIGINT NOT NULL,
	prodId BIGINT NOT NULL,
	FOREIGN KEY(cakeId)REFERENCES cakes(cakeId),
	FOREIGN KEY(prodId)REFERENCES products(prodId)
);

	
CREATE TABLE public.payments(
	pId	BIGINT NOT NULL,
	orderId	BIGINT NOT NULL,
	Amount varchar NOT NULL DEFAULT NULL,
	deliveryCharge varchar NOT NULL DEFAULT 2000,
	totalAmt varchar NOT NULL DEFAULT NULL,
	pDate Varchar NOT NULL DEFAULT NULL,
 	PRIMARY KEY (pId),
	FOREIGN KEY(OrderId) REFERENCES orders(orderId)
);
	

CREATE TABLE public.customers(
	custId BIGINT NOT NULL PRIMARY KEY,
 	custName VARCHAR(50) NOT NULL,
 	email VARCHAR(50) NOT NULL,
 	contact VARCHAR(50) NOT NULL,
 	custPassword VARCHAR(50) NOT NULL,
 	custLocation VARCHAR(50) NOT NULL,
 	cakeId INT NOT NULL,
 	prodId INT NOT NULL,
 	FOREIGN KEY(cakeId)REFERENCES cakes(cakeId),
	FOREIGN KEY(prodId)REFERENCES products(prodId)
);
 

	
CREATE TABLE public.clients(
	clientId BIGINT NOT NULL PRIMARY KEY,
	clientName VARCHAR(50) NOT NULL,
	email VARCHAR(50) NOT NULL,
	contact integer NOT NULL,
	custId INT NOT NULL,
	prodId INT NOT NULL,
	orderId INT NOT NULL,
	pId	BIGINT NOT NULL,
	FOREIGN KEY(custId)REFERENCES customers(custId),
	FOREIGN KEY(prodId)REFERENCES products(prodId),
	FOREIGN KEY(orderId)REFERENCES orders(orderId),
	FOREIGN KEY(pId) REFERENCES payments(pId)
);
 
 
CREATE TABLE public.registers(
	regId BIGINT NOT NULL PRIMARY KEY,
	custId BIGINT NOT NULL,
	FOREIGN KEY (custId) REFERENCES customers(custId) 
);


CREATE TABLE public.sellers(
	vendorId BIGINT NOT NULL PRIMARY KEY,
	vName VARCHAR(50) NOT NULL,
	email VARCHAR(50) NOT NULL,
	contact VARCHAR(50) NOT NULL,
	vLocation VARCHAR(50) NOT NULL,
	cakeId INT NOT NULL,
	custId INT NOT NULL,
	prodId INT NOT NULL,
	orderId INT NOT NULL,
	FOREIGN KEY(custId)REFERENCES customers(custId),
	FOREIGN KEY(prodId)REFERENCES products(prodId),
	FOREIGN KEY(orderId)REFERENCES orders(orderId),
	FOREIGN KEY(cakeId)REFERENCES cakes(cakeId)
);
	

CREATE TABLE public.deliverymen(
	deliveryId BIGINT NOT NULL PRIMARY KEY,
	dName VARCHAR(50) NOT NULL,
	email VARCHAR(50) NOT NULL,
	contact VARCHAR(50) NOT NULL,
	prodId BIGINT NOT NULL,
	orderId BIGINT NOT NULL,
	cakeId BIGINT NOT NULL,
	FOREIGN KEY(cakeId)REFERENCES cakes(cakeId),
	FOREIGN KEY(prodId)REFERENCES products(prodId),
	FOREIGN KEY(orderId)REFERENCES orders(orderId)
);


CREATE TABLE public.users(
	userId BIGINT NOT NULL PRIMARY KEY,
	userType VARCHAR(50) NOT NULL,
	clientId BIGINT NOT NULL,
	vendorId BIGINT NOT NULL,
	custId BIGINT NOT NULL,
	deliveryId BIGINT NOT NULL,
 	shopId BIGINT NOT NULL,
	FOREIGN KEY(clientId) REFERENCES clients(clientId),
	FOREIGN KEY(vendorId) REFERENCES sellers(vendorId),
	FOREIGN KEY(custId) REFERENCES customers(custId),
	FOREIGN KEY(deliveryId) REFERENCES deliverymen(deliveryId),
	FOREIGN KEY (shopId) REFERENCES groceryShops(shopId)					
);


--i)
INSERT INTO groceryShops(shopId,sName,sLocation)
VALUES(60,'Edmond fruits','Natete'),
(61,'JJ fresh vegetables','Kasanga'),
(62,'Almond Bakery','Mukono'),
(63,'Meats','Banda');


INSERT INTO products(prodId, prodName, price, description, image, shopId )
VALUES(001,'apples','shs 2000','fresh','apple',60),
(002,'carrots','shs 5000','new stock','carrot',61),
(003,'cakes','shs 100,000','three flavors','cake',62),
(004,'chicken','shs 50,000','whole','chicken',63),
(005,'beef','shs 30,000','half kilo','meat',63);


INSERT INTO wishlists(listId, liked, added, prodId)
VALUES(200,'0','0',001),
(201,'1','1',003),
(202,'1','1',004),
(203,'0','0',005);


INSERT INTO cakes( cakeId ,cname,category ,description ,price ,recipies,image)
VALUES(01,'strawberry','Anniversary cake','lovely','shs 200000','use low temperature','strawberry'),
(02,'vanilla','valentine cake','beautiful','shs 80000','use moderate heat','vanilla'),
(03,'black forest','birthday cake','tasty','shs 50000','bake at low heat','black'),
(04,'white forest','wedding cake','delicious','shs 320000','mix evenly','white'),
(05, 'mixed flavor','graduation cake','spongy','shs 100000','add vanilla,strawberry and raspberry','mixed');


INSERT INTO categories (categoryId, categoryType)
VALUES(10001,'fruits'),
(10002,'snacks'),
(10003,'meat'),
(10004,'vegetables');


INSERT INTO productCategories(prodId, categoryId)
VALUES(001,10001),
(004,10003),
(003,10002),
(002,10004),
(005,10003);


INSERT INTO orders(orderId, category,quantity, status, price, cakeId, prodId )
VALUES(1,'meat','200kg','pending','shs 100,000',01,005),
(2,'fruits','1basket','pending','shs 10,000',02,001),
(3,'meat','2kg','taken','shs 20,000',03,004),
(4,'snacks','1 small size','pending','shs 50,000',04,003),
(5,'vegetables','2packets','taken','shs 30,000',05,002);


INSERT INTO payments(pId, orderId,Amount, deliveryCharge, totalAmt, pDate)
VALUES(100,1,'shs 10,000','shs 2000','shs 12,000','10/2/22'),
(200,2,'shs 20,000','shs 5000','shs 25,000','15/5/22'),
(300,3,'shs 30,000','shs 1000','shs 31,000','30,8,22');


INSERT INTO customers(custId,custName,email, contact,custPassword,custLocation,cakeId,prodId)
VALUES(122,'valentine Muwanguzi','valentine@gmail.com','0781233232','val120','Mityana',01,002),
(123,'Samuel Emudong','samuel@gmail.com','0705996789','Semu123','Bwaise',02,004),
(124,'Daniel Opolot','daniel@gmail.com','0789564330','opodan000','Wandegeya',03,005),
(121,'Irene Akello','irene@gmail.com','0777776665','ireneA444','Kyengera',05,003);


INSERT INTO clients(clientId, clientName, email, contact, custId, prodId, orderId, pId)
VALUES(1000,'Hadija Namubiru','hadija@gmail.com',0789294812,122,001,1,100);
 
 
INSERT INTO registers(regId, custId)
VALUES(11,122),
(12,124),
(14,121),
(15,123);


INSERT INTO sellers(vendorId, vName, email, contact, vLocation, cakeId, custId, prodId, orderId)
VALUES(333,'Anna Akello', 'annaakello@gmail.com', '0778904510','Kasangati',01,122,001,1),
(334,'James Bonds','james@gmail.com', '0300233456', 'Kiwatule',02,121,002,2),
(335,'Joseph Katale', 'josephk@gmail.com', '0789924355','Kikoni',03,123,003,3),
(336,'Mary Kisakye', 'marykis@gmail.com', '0720345673','Nansana',04,121,004,4);


INSERT INTO deliverymen(deliveryId, dName, email, contact, prodId, orderId, cakeId)
VALUES(900,'Gerald Otim', 'geraldOtim@gmail.com', '0700896432',001,1,02),
(901,'James Mwesigwa', 'james111@gmail.com', '0780004432',002,2,01),
(902,'Jade Lule', 'jadelule@gmail.com', '0799665443',003,3,03);


INSERT INTO users(userId, userType, clientId, vendorId, custId, deliveryId, shopId)
VALUES(300,'Vendor',1000,333,122,900,60),
(301,'Admin',1000,334,124,901,61),
(302,'Buyer',1000,335,121,902,62);


SELECT * FROM groceryShops;
SELECT * FROM products;
SELECT * FROM wishlists;
SELECT * FROM cakes;
SELECT * FROM categories;
SELECT * FROM productCategories;
SELECT * FROM orders;
SELECT * FROM payments;
SELECT * FROM customers;
SELECT * FROM clients;
SELECT * FROM registers;
SELECT * FROM sellers;
SELECT * FROM deliverymen;
SELECT * FROM users;


--ii)
SELECT orderId,category,quantity,status,prodName FROM orders,products
WHERE orders.prodId = products.prodId;

--iii)
SELECT prodName FROM clients,products
WHERE clients.prodId = products.prodId;

--iv)
SELECT prodName FROM sellers,products
WHERE sellers.prodId = products.prodId;

--v)
SELECT clientName, vName, custName, dName FROM users,clients,sellers,customers,deliverymen
WHERE (users.clientId = clients.clientId AND users.vendorId =sellers.vendorId) AND (users.custId = customers.custId AND users.deliveryId = deliverymen.deliveryId);

--vi)
SELECT userType,vName FROM users,sellers
WHERE userType = 'Vendor' AND users.vendorId = sellers.vendorId;

-- vii)
SELECT clientName,custName FROM users,clients,customers 
WHERE (userType = 'Admin' OR userType = 'Buyer') AND (users.clientId = clients.clientId OR users.custId = customers.custId);










