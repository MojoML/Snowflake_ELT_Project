CREATE OR REPLACE TABLE dim_country (
    country_id INT AUTOINCREMENT, 
    country VARCHAR ,
    PRIMARY KEY (country_id)
    );
    
CREATE OR REPLACE TABLE dim_date (
    date_id INT AUTOINCREMENT,
    year VARCHAR,
    week VARCHAR,
    PRIMARY KEY (date_id));
    
CREATE OR REPLACE TABLE dim_commodity(
    commodity_id INT AUTOINCREMENT,
    commodity VARCHAR,
    PRIMARY KEY (commodity_id));


INSERT INTO dim_country (country)
    SELECT DISTINCT(country)
    FROM foreign_trade_processed;
    
INSERT INTO dim_date(year, week)
    SELECT year, week 
    FROM foreign_trade_processed
    GROUP BY week, year;
    
INSERT INTO dim_commodity(commodity)
    SELECT DISTINCT(commodity)
    FROM foreign_trade_processed;

SELECT * FROM dim_date