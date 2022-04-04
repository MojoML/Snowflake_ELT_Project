CREATE OR REPLACE TABLE foreign_trade_raw(
    "Year"  VARCHAR, 
    "Country" VARCHAR,
    "Week" VARCHAR, 
    "Commodity" VARCHAR,
    "Exports: Net mass t" VARCHAR,
    "Exports: Value Tsd. EUR" VARCHAR, 
    "Exports: Value (US-Dollar) Tsd. US $" VARCHAR,
    "Imports: Net mass t" VARCHAR,
    "Imports: Value Tsd. EUR" VARCHAR,
    "Imports: Value (US-Dollar) Tsd. US $" VARCHAR    
    
);


COPY INTO foreign_trade_raw
FROM @S3_STAGE/foreign_trade_stats.csv
FILE_FORMAT =(encoding = 'iso-8859-1', error_on_column_count_mismatch=false, type = "csv", field_delimiter =";", skip_header=1);



SELECT * FROM foreign_trade_raw LIMIT 10;



