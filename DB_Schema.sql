CREATE DATABASE CRM_Data_Project;
USE CRM_Data_Project;

-- Geography Table
CREATE TABLE geography (
    GeographyID INT PRIMARY KEY,
    Country VARCHAR(50),
    City VARCHAR(50)
);

-- Customers Table
CREATE TABLE customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Email VARCHAR(100),
    Gender VARCHAR(10),
    Age INT,
    GeographyID INT,
    FOREIGN KEY (GeographyID) REFERENCES geography(GeographyID)
);

-- Products Table
CREATE TABLE products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Brand VARCHAR(50),
    Price DECIMAL(10,2)
);

-- Customer Journey Table
CREATE TABLE customer_journey (
    JourneyID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    VisitDate DATE,
    Stage VARCHAR(50),
    Action VARCHAR(50),
    Duration INT,
    FOREIGN KEY (CustomerID) REFERENCES customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES products(ProductID)
);

-- Customer Reviews Table
CREATE TABLE customer_reviews (
    ReviewID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    ReviewDate DATE,
    Rating INT,
    ReviewText VARCHAR(255),
    FOREIGN KEY (CustomerID) REFERENCES customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES products(ProductID)
);

-- Engagements Table
CREATE TABLE engagements (
    EngagementID INT PRIMARY KEY,
    ContentID INT,
    ContentType VARCHAR(50),
    Likes INT,
    EngagementDate DATE,
    CampaignID INT,
    ProductID INT,
    ViewsClicksCombined VARCHAR(20),
    FOREIGN KEY (ProductID) REFERENCES products(ProductID)
);



