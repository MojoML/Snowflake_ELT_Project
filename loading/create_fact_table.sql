  CREATE OR REPLACE TABLE trade_fact (
    country_id INT REFERENCES dim_country(country_id),
    commodity_id INT REFERENCES dim_commodity(commodity_id),
    date_id INT REFERENCES dim_date(date_id),
    imports_net_mass_tons INT,
    imports_value_eur INT, 
    imports_value_usd INT, 
    exports_net_mass_tons INT,
    exports_value_eur INT,
    exports_value_usd INT);
 
 INSERT INTO trade_fact  
     (SELECT 
        c.country_id, cm.commodity_id, d.date_id,
        imports_net_mass_tons, imports_value_eur, imports_value_usd,
        exports_net_mass_tons, exports_value_eur, exports_value_usd
        FROM foreign_trade_processed fp 
        INNER JOIN dim_country c
            ON fp.country = c.country
        INNER JOIN dim_commodity cm 
            ON fp.commodity = cm.commodity
        INNER JOIN dim_date d
            ON (fp.year = d.year AND fp.week = d.week));


SELECT * FROM TRADE_FACT;
