USE CRM_Data_Project;

-- joining customer table with geography table to get customer location 

SELECT 
    c.CustomerID,  -- customer id number
    c.CustomerName,  -- name of customer
    c.Email,  -- customer email
    c.Gender,  -- male or female
    c.Age,  -- age of customer
    g.Country,  -- country name from geography table
    g.City  -- city name from geography table
FROM 
    customers as c  -- customer table aliased as c
LEFT JOIN
    geography g  -- geography table aliased as g
ON 
    c.GeographyID = g.GeographyID;  -- matching on geography id so we get location for each customer

