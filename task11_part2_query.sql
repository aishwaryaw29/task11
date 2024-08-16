--part2) create 2 function on your own data

select * from cars
	
--1)The function categorizes the car's price into 'Budget friendly', 'Mid-range', or 'Premium'

CREATE OR REPLACE FUNCTION check_price_category(price float) 
RETURNS varchar as $$
DECLARE price_category varchar;
BEGIN
	CASE
	     WHEN price < 20000 THEN price_category := 'Budget friendly';    
         WHEN price BETWEEN 20000 AND 40000 THEN price_category := 'Mid-range';
         ELSE price_category := 'Premium';
    END CASE;
    RETURN price_category;
END;
$$ LANGUAGE plpgsql

select check_price_category(13445)


--2)This function determines if a car is classified as a sports car based on engine size

CREATE OR REPLACE FUNCTION check_car_type(engine_size float) 
RETURNS varchar as $$
DECLARE car_type varchar;
BEGIN
    IF engine_size > 3.0 THEN car_type := 'sports car';
    ELSE car_type := 'not a sports car';
    END IF;
    RETURN car_type;
END;
$$ LANGUAGE plpgsql;

select check_car_type(3.7)


