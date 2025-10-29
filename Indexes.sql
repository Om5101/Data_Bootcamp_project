USE CRM_Data_Project;

-- customers table - GeographyID
-- Type: NON-CLUSTERED, DENSE INDEX
CREATE INDEX idx_customers_geography ON customers(GeographyID);

-- customer_journey table - CustomerID
-- Type: NON-CLUSTERED, DENSE INDEX  
CREATE INDEX idx_journey_customer ON customer_journey(CustomerID);

-- customer_journey table - ProductID
-- Type: NON-CLUSTERED, DENSE INDEX
CREATE INDEX idx_journey_product ON customer_journey(ProductID);

-- customer_journey table - VisitDate
-- Type: NON-CLUSTERED, DENSE INDEX
CREATE INDEX idx_journey_date ON customer_journey(VisitDate);

-- customer_reviews table - CustomerID
-- Type: NON-CLUSTERED, DENSE INDEX
CREATE INDEX idx_reviews_customer ON customer_reviews(CustomerID);

-- customer_reviews table - ProductID
-- Type: NON-CLUSTERED, DENSE INDEX
CREATE INDEX idx_reviews_product ON customer_reviews(ProductID);

-- engagements table - ProductID
-- Type: NON-CLUSTERED, DENSE INDEX
CREATE INDEX idx_engagements_product ON engagements(ProductID);

-- engagements table - EngagementDate
-- Type: NON-CLUSTERED, DENSE INDEX
CREATE INDEX idx_engagements_date ON engagements(EngagementDate);

-- engagements table - CampaignID
-- Type: NON-CLUSTERED, DENSE INDEX
CREATE INDEX idx_engagements_campaign ON engagements(CampaignID);




