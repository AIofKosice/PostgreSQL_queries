-- Create the cars table
CREATE TABLE cars_ex (
    model_name VARCHAR(50),
    color VARCHAR(20),
    brand VARCHAR(50),
    price INT
);

-- Insert sample data into the cars table
INSERT INTO cars_ex (model_name, color, brand, price) VALUES
('Civic', 'Blue', 'Honda', 20000),
('Civic', 'Red', 'Honda', 21000),
('Civic', 'Black', 'Honda', 22000),
('Corolla', 'White', 'Toyota', 23000),
('Corolla', 'Blue', 'Toyota', 24000),
('Model 3', 'Silver', 'Tesla', 35000),
('Model 3', 'Black', 'Tesla', 36000);

select * from cars_ex

SELECT t1.model_name, t1.color, t1.brand, t1.price,
       ROW_NUMBER() OVER (PARTITION BY t1.model_name ORDER BY t1.price) AS row_num
FROM cars_ex t1
JOIN cars_ex t2 ON t1.model_name = t2.model_name
WHERE t1.price <= t2.price;


SELECT t1.model_name, t1.color, t1.brand, t1.price,
       ROW_NUMBER() OVER (PARTITION BY t1.model_name ORDER BY t1.price DESC) AS row_num
FROM cars_ex t1