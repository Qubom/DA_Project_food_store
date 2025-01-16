-- Our database will consist of the following tables:

-- 1. Customers
-- 2. Orders
-- 3. Order Items
-- 4. Products
-- 5. Product Categories
-- 6. Product Manufacturers
-- 7. Inventory
-- 8. Social Media Engagement
-- 9. Locations
-- 10. Staffing

-- Create Database
CREATE DATABASE haute_epicerie;
USE haute_epicerie;

-- 1. Customers Table
CREATE TABLE Customers (
  `CustomerID` int AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Email` varchar(255) UNIQUE NOT NULL,
  `Phone` varchar(20),
  `Address` text,
  `City` varchar(100),
  `Zip` varchar(10),
  `LoyaltyTier` enum('No Tier', 'Bronze', 'Silver', 'Gold') DEFAULT 'No Tier',
  PRIMARY KEY (`CustomerID`)
);

-- 2. Orders Table
CREATE TABLE Orders (
  `OrderID` int AUTO_INCREMENT,
  `CustomerID` int,
  `OrderDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `TotalCost` decimal(10, 2) NOT NULL,
  `SalesChannel` enum('In-Store', 'Online', 'Catering') NOT NULL,
  `LocationID` int,  -- References Locations Table
  PRIMARY KEY (`OrderID`),
  FOREIGN KEY (`CustomerID`) REFERENCES Customers(`CustomerID`)
);

-- 3. Order Items Table
CREATE TABLE OrderItems (
  `OrderItemID` int AUTO_INCREMENT,
  `OrderID` int,
  `ProductID` int,
  `Quantity` int NOT NULL,
  `UnitPrice` decimal(10, 2) NOT NULL,
  PRIMARY KEY (`OrderItemID`),
  FOREIGN KEY (`OrderID`) REFERENCES Orders(`OrderID`),
  FOREIGN KEY (`ProductID`) REFERENCES Products(`ProductID`)
);

-- 4. Products Table
CREATE TABLE Products (
  `ProductID` int AUTO_INCREMENT,
  `ProductName` varchar(255) NOT NULL,
  `Description` text,
  `ManufacturerID` int, -- References Product Manufacturers Table
  `CategoryID` int,  -- References Product Categories Table
  `UnitPrice` decimal(10, 2) NOT NULL,
  `EliteFood` boolean DEFAULT 0,
  `Delicatessen` boolean DEFAULT 0,
  PRIMARY KEY (`ProductID`),
  FOREIGN KEY (`CategoryID`) REFERENCES ProductCategories(`CategoryID`),
  FOREIGN KEY (`ManufacturerID`) REFERENCES ProductManufacturers(`ManufacturerID`)
);

-- 5. Product Categories Table
CREATE TABLE ProductCategories (
  `CategoryID` int AUTO_INCREMENT,
  `CategoryName` varchar(100) NOT NULL,
  PRIMARY KEY (`CategoryID`)
);

-- 6. Product Manufacturers Table
CREATE TABLE ProductManufacturers (
  `ManufacturerID` int AUTO_INCREMENT,
  `ManufacturerName` varchar(100) NOT NULL,
  PRIMARY KEY (`ManufacturerID`)
);

-- 7. Inventory Table
CREATE TABLE Inventory (
  `InventoryID` int AUTO_INCREMENT,
  `ProductID` int,
  `Quantity` int NOT NULL,
  `ReorderThreshold` int,
  `LastUpdated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`InventoryID`),
  FOREIGN KEY (`ProductID`) REFERENCES Products(`ProductID`)
);

-- 8. Social Media Engagement Table
CREATE TABLE SocialMediaEngagement (
  `EngagementID` int AUTO_INCREMENT,
  `Platform` enum('Twitter/X', 'Instagram', 'Facebook', 'TikTok', 'Other') NOT NULL,
  `PostDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `EngagementType` enum('Likes', 'Comments', 'Shares') NOT NULL,
  `Count` int NOT NULL,
  PRIMARY KEY (`EngagementID`)
);

-- 9. Locations Table
CREATE TABLE Locations (
  `LocationID` int AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Address` text,
  `City` varchar(100),
  `Zip` varchar(10),
  PRIMARY KEY (`LocationID`)
);

-- 10. Staffing Table
CREATE TABLE Staffing (
  `StaffID` int AUTO_INCREMENT,
  `Full Name` varchar(255) NOT NULL,
  `Role` varchar(100) NOT NULL,
  `Availability` json,  -- Stores availability in JSON format (e.g., {"Monday": "09:00-21:00", ...}),
  `LocationID` int,
  PRIMARY KEY (`StaffID`),
  FOREIGN KEY (`LocationID`) REFERENCES Locations(`LocationID`)
);
