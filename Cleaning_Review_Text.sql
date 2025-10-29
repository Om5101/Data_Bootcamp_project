USE CRM_Data_Project;

-- cleaning review text by removing double spaces

SELECT 
    ReviewID,  -- review id number
    CustomerID,  -- customer id number
    ProductID,  -- product id number
    ReviewDate,  -- date when review was written
    Rating,  -- rating out of 5 stars
    -- removing double spaces because some reviews have too many spaces between words
    REPLACE(ReviewText, '  ', ' ') AS ReviewText
FROM 
    customer_reviews;  -- from customer reviews table
