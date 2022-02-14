/*3) Display the number of the customer group by their genders who have placed any order of amount
 greater than or equal to Rs.3000.*/
select customer.CUS_GENDER, count(customer.CUS_GENDER) AS COUNT FROM 
customer INNER JOIN `orders` ON customer.CUS_ID WHERE `orders`.ORD_AMOUNT >=3000
group by customer.CUS_GENDER;


/*4) Display all the orders along with the product name ordered by a customer having Customer_Id=2.*/
SELECT `orders`.*, product.PRO_NAME FROM `orders`, productdetails, product WHERE `orders`.CUS_ID = 2
AND `orders`.PROD_ID = productdetails.PRO_ID AND productdetails.PRO_ID = product.PRO_ID;

/*5) Display the Supplier details who can supply more than one product.*/
SELECT supplier.* FROM supplier, productdetails WHERE supplier.SUPP_ID IN 
(SELECT productdetails.SUPP_ID FROM productdetails GROUP BY productdetails.SUPP_ID HAVING 
count(productdetails.SUPP_ID) > 1) GROUP BY supplier.SUPP_ID;

/*6) Find the category of the product whose order amount is minimum.*/
SELECT category.* FROM `orders` INNER JOIN productdetails ON
`orders`.PROD_ID = productdetails.PROD_ID INNER JOIN product ON
product.PRO_ID = productdetails.PROD_ID INNER JOIN category ON
category.CAT_ID = product.CAT_ID HAVING min(`orders`.ORD_AMOUNT);

/*7) Display the Id and Name of the Product ordered after “2021-10-05”.*/
SELECT product.PRO_ID, product.PRO_NAME FROM `orders` INNER JOIN productdetails ON
productdetails.PROD_ID = `orders`.PROD_ID INNER JOIN product ON 
product.PRO_ID = productdetails.PRO_ID WHERE `orders`.ORD_DATE > "2021-10-05";

/*8) Display customer name and gender whose names start or end with character 'A'.*/
SELECT customer.CUS_NAME, customer.CUS_GENDER FROM customer WHERE customer.CUS_NAME 
LIKE 'A%' OR customer.CUS_NAME LIKE '%A';

/*9) Create a stored procedure to display the Rating for a Supplier if any along with the 
Verdict on that rating if any like if rating >4 then “Genuine Supplier” if rating >2 “Average Supplier” 
else “Supplier should not be considered”.*/ 

DELIMITER $$

create procedure proc1()
BEGIN
	Select supplier.SUPP_ID, supplier.SUPP_NAME, rating.RAT_RATSTARS,
	CASE
		WHEN rating.RAT_RATSTARS > 4 THEN "Genuine Supplier"
		WHEN rating.RAT_RATSTARS > 2 THEN "Average Supplier"
		ELSE "Supplier should not be considered"
	END
	As verdict FROM rating INNER JOIN supplier ON supplier.SUPP_ID = rating.SUPP_ID;
END $$

CALL proc1;


 