.open restaurant.db

-- create table
CREATE TABLE IF NOT EXISTS customers (
    Id int unique,
    Name text,
    City text,
    Tel int);
INSERT INTO customers VALUES 
    (1, "Nice", "BKK" ,0987665544),
    (2, "Jane", "Phuket", 084567891),
    (3, "Kan", "Chiangmai", 0897456123),
    (4, "Ploy", "Nan", 0912345678),
    (5, "Mee", "Chiangmai", 0845184154),
    (6, "Pang", "BKK", 0654897823),
    (7, "Mean","Khonkaen", 0897462654),
    (8, "Ant", "Korat",0948256355),
    (9, "Fah", "Korat", 0884362123) ;


CREATE TABLE IF NOT EXISTS MENU(
	Menu_name TEXT,
	Detail TEXT,
	Ingredien TEXT,
	Price int);
INSERT INTO MENU VALUES 
("ผัดกะเพรา", "เนื้อสัตว์ผัดพร้อมใบกะเพรา", "เนื้อสัตว์ กระเทียม พริก ใบกะเพรา", 120),
("ผัดพริกแกง", "เนื้อสัตว์ผัดรวมกับพริกแกงแดง", "เนื้อสัตว์ พริกแกงแดง", 100),
("ข้าวผัด", "ผัดข้าวพร้อมไข่และเนื้อสัตว์", "ข้าวสวย ไข่ไก่ เนื้อสัตว์ ผักชี", 100),
("ผัดคะน้าหมูกรอบ", "ผัดผักคะน้าใส่หมูกรอบ", "กระเทียม พริก คะน้า หมูกรอบ", 120),
("ผัดไทย", "เส้นเล็กผัดกับไข่,ผักและเครื่องปรุงรส", "เส้นเล็ก ไข่ไก่ ใบกุยช่าย ถั่วงอก เต้าหู้เหลือง กุ้งแห้ง", 120),
("ก๋วยเตี๋ยวคั่วไก่", "เส้นใหญ่ผัดพร้อมกับเนื้อสัตว์ โรยด้วยต้นหอม", "เส้นใหญ่ ไข่ไก่ ต้นหอม เนื้อไก่ หมึกกรอบ", 120);


CREATE TABLE IF NOT EXISTS EMPLOYEE (
	Employeeid INT UNIQUE,
	Emolyeename TEXT,
	Position TEXT);
INSERT INTO EMPLOYEE VALUES 
(123,"Miko","Server"),(666,"Ann","Server"),
(428,"Jame","Cashier"),(326,"Tine","Cleaner"),
(818,"Dang","Cleaner"),(687,"Joe","Chef"), 
(224,"Maria","Manager");


CREATE TABLE IF NOT EXISTS PAYMENT (
	Name text,
	PaymentCode char(20),
	PaymentMethod text,
	Employeename int,
	Time date );
INSERT INTO PAYMENT VALUES 
("Jane", 264895128, "Cash", "Jame", '2023-06-06'),
("Kan", 1845245615, "CreditCard", "Jame",'2023-06-07'),
("Mee", 8595548848, "CreditCard", "Jame", '2023-06-07'),
("Ant", 7184454846, "Cash", "Jame", '2023-06-07'),
("Nice", 4615855484, "Cash", "Jame", '2023-06-08'),
("Kan", 1564812845,"CreditCard", "Jame",'2023-06-08');


  
--subquery
SELECT * from menu
ORDER BY price;

select cus.Name, pay.PaymentCode, pay.PaymentMethod
from (select * from CUSTOMERS
    where Name Like 'Jane') AS cus
join (select * from PAYMENT) AS pay
on cus.Name = pay.Name

  
select customers.name, payment.Time
FROM customers
LEFT JOIN payment 
on payment.Name = customers.name

WITH sub1 AS (
			SELECT * FROM customers
      		WHERE Tel = '09%' ) ,
	   sub2 AS (
					SELECT * FROM payment
					WHERE STRFTIME("%M", payment.Time) = "06")
SELECT 
	sub1.name,
	sub2.Time
FROM sub1
JOIN sub2
ON sub1.name = sub2.name

SELECT customers.city ,COUNT(city) 
FROM customers
GROUP by city;



