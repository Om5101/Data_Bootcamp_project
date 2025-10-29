USE CRM_Data_Project;

-- View: Product Review Summary
CREATE VIEW vw_product_review_summary AS
SELECT 
    p.ProductID,
    p.ProductName,
    p.Brand,
    p.Price,
    COUNT(cr.ReviewID) AS TotalReviews,
    AVG(cr.Rating) AS AverageRating,
    MIN(cr.Rating) AS MinRating,
    MAX(cr.Rating) AS MaxRating
FROM 
    products p
    INNER JOIN customer_reviews cr ON p.ProductID = cr.ProductID
GROUP BY 
    p.ProductID, p.ProductName, p.Brand, p.Price;
    

-- Purpose: Analyzing product reviews to understand customer satisfaction.

-- Query 1: Products with high ratings but need review content analysis
-- Purpose: Find products with good ratings but may have hidden issues in review text
SELECT ProductName, Brand, AverageRating, TotalReviews
FROM vw_product_review_summary
WHERE AverageRating >= 4.0
ORDER BY TotalReviews DESC;

-- Query 1: Products with high ratings but need review content analysis
-- Purpose: Find products with good ratings but may have hidden issues in review text
SELECT ProductName, Brand, AverageRating, TotalReviews
FROM vw_product_review_summary
WHERE AverageRating >= 4.0
ORDER BY TotalReviews DESC;
-- Note: These products need sentiment analysis on ReviewText to validate satisfaction

-- Query 2: Products needing immediate attention
-- Purpose: Identify low-rated products that require improvement
SELECT ProductName, Brand, AverageRating, TotalReviews, MinRating, MaxRating
FROM vw_product_review_summary
WHERE AverageRating < 3.0
ORDER BY AverageRating ASC;
-- Note: ReviewText sentiment analysis needed to understand why customers are unhappy

-- Query 3: Products with mixed ratings (potential sentiment gap)
-- Purpose: Find products where ratings don't tell clear story
SELECT ProductName, Brand, AverageRating, MinRating, MaxRating, TotalReviews
FROM vw_product_review_summary
WHERE (MaxRating - MinRating) >= 3
ORDER BY TotalReviews DESC;
-- Note: Large gap between min/max rating suggests conflicting opinions in reviews

-- Query 4: Brand performance comparison
-- Purpose: See which brands have best/worst overall ratings
SELECT Brand, AVG(AverageRating) AS AvgBrandRating, SUM(TotalReviews) AS TotalBrandReviews
FROM vw_product_review_summary
GROUP BY Brand
ORDER BY AvgBrandRating DESC;
-- Note: Sentiment analysis can reveal if positive ratings match positive review text



    