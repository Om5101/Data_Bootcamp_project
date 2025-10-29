USE CRM_Data_Project;

-- categorizing products by their price into low medium high

SELECT 
    ProductID,  -- product id number
    ProductName,  -- name of product
    Price,  -- price of product
	-- Category, -- product category

    CASE  -- checking price and putting it in bucket
        WHEN Price < 50 THEN 'Low'  -- less than 50 is cheap
        WHEN Price BETWEEN 50 AND 200 THEN 'Medium'  -- between 50 and 200 is medium
        ELSE 'High'  -- more than 200 is expensive
    END AS PriceCategory  -- calling this column PriceCategory

FROM 
    products;  -- from products table