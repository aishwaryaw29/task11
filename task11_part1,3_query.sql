--part1) create 5 function on ecom

--1)This function assigns a loyalty status ('Platinum', 'Gold', 'Silver', 'Bronze') based on the number of purchases made by a customer

select * from sales 

CREATE OR REPLACE FUNCTION check_status(purchase_count int)
RETURNS varchar as $$
DECLARE loyalty_status varchar;
BEGIN
    CASE
        WHEN purchase_count > 12 THEN loyalty_status := 'Platinum';
        WHEN purchase_count BETWEEN 8 AND 12 THEN loyalty_status := 'Gold';
        WHEN purchase_count BETWEEN 3 AND 7 THEN loyalty_status := 'Silver';
        ELSE loyalty_status :='Bronze';
    END CASE;
    RETURN loyalty_status;
END;
$$ LANGUAGE plpgsql

select check_status(13)


	
--2)This function calculates shipping cost depending on the region of the customer

select * from customer

CREATE OR REPLACE FUNCTION check_shipping_cost(region varchar)
RETURNS float as $$
DECLARE shipping_cost float;
BEGIN
    CASE
        WHEN region ='South' THEN shipping_cost := 8.00;
        WHEN region ='East' THEN shipping_cost := 7.00;
        WHEN region ='West' THEN shipping_cost := 9.00;
        ELSE shipping_cost := 10.00; 
    END CASE;
    RETURN shipping_cost;
END;
$$ LANGUAGE plpgsql

select check_shipping_cost('Central')



--3)This function calculates the sales tax based on the product category

select distinct category from product

CREATE OR REPLACE FUNCTION calculate_sales_tax(category varchar)
RETURNS float as $$
DECLARE sales_tax float;
BEGIN
    CASE 
        WHEN category = 'Technology' THEN sales_tax := 0.15;
        WHEN category ='Furniture' THEN sales_tax := 0.10;
        WHEN category ='Office Supplies' THEN sales_tax := 0.08;
        ELSE sales_tax := 0.05; 
    END CASE;
    RETURN sales_tax;
END;
$$ LANGUAGE plpgsql

select calculate_sales_tax('Furniture')


	

--4)This function checks if a product is in high demand based on the number of sales

select distinct product_id, count(sales) from sales group by product_id

CREATE OR REPLACE FUNCTION product_demand(sales_count int)
RETURNS varchar as $$
DECLARE result varchar;
BEGIN
     if sales_count > 10 THEN result := 'product is in high demand';
     else result = 'product is not in high demand';
     END IF;
     RETURN result;
END;
$$ LANGUAGE plpgsql

select product_demand(4)




--5)This function check if the customer is an adult or an senior citizen based on the age

select min(age), max(age) from customer

CREATE OR REPLACE FUNCTION check_age(cust_age int)
RETURNS varchar as $$
DECLARE output varchar;
BEGIN
    if cust_age >= 50 THEN output := 'customer is a senior citizen';
    else output := 'customer is an adult';
    END IF;
    RETURN output;
END;
$$ LANGUAGE plpgsql

select check_age(70)




--part3) create select and find function

CREATE OR REPLACE FUNCTION check_sales(productId varchar)
RETURNS varchar as $$
DECLARE 
    output varchar;
    SumOfSales float;
BEGIN
    select SUM(sales) INTO SumOfSales FROM sales WHERE product_id = productId;

    IF SumOfSales > 10000 THEN output := 'Sales are high';
    ELSE output := 'Sales are low';
    END IF;
RETURN output;
END;
$$ LANGUAGE plpgsql

select check_sales('OFF-FA-10000304')
 
select product_id, sum(sales) from sales group by product_id 
