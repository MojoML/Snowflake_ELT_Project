CREATE OR REPLACE TABLE foreign_trade_processed AS 

WITH cleaned_year AS
   (SELECT * 
    FROM foreign_trade_raw
    WHERE "Year" NOT IN ('created: 2022-04-01 / 12:58:15', '__________' )),
    
cleaned_country AS
    (SELECT REPLACE(SPLIT("Country", '(')[0], '""', '') as country, "Year" as year, "Week" as week, "Commodity" as commodity, 
     "Exports: Net mass t" exports_net_mass, "Exports: Value Tsd. EUR" exports_value_eur, "Exports: Value (US-Dollar) Tsd. US $" exports_value_usd,
     "Imports: Net mass t" imports_net_mass, "Imports: Value Tsd. EUR" imports_value_eur, "Imports: Value (US-Dollar) Tsd. US $" imports_value_usd
    FROM cleaned_year),
    
cleaned_strings AS (
    SELECT 
    country,
    year,
    week,
    commodity,
    replace(exports_net_mass, '-', '0') exports_net_mass,
    replace(exports_value_eur, '-', '0') exports_value_eur, 
    replace(exports_value_usd, '-', '0') exports_value_usd,     
    replace(imports_net_mass, '-', '0') imports_net_mass, 
    replace(imports_value_eur, '-', '0') imports_value_eur, 
    replace(imports_value_usd, '-', '0') imports_value_usd     
    FROM cleaned_country),
    
final_foreign_trade AS (
SELECT 
    CAST(country AS VARCHAR) country,
    year,
    week,
    commodity,
    CAST(REGEXP_REPLACE(imports_net_mass, '[JänFebMärAprMaiJunJulAugSepOktNovDez\.]', '' ) AS INT)
    imports_net_mass_tons,
    CAST(imports_value_eur AS INT) imports_value_eur,
    CAST(imports_value_usd AS INT) imports_value_usd,
    CAST(REGEXP_REPLACE(exports_net_mass, '[JänFebMärAprMaiJunJulAugSepOktNovDez\.]', '' ) AS INT) exports_net_mass_tons,
    CAST(exports_value_eur AS INT) exports_value_eur,
    CAST(exports_value_usd AS INT) exports_value_usd
FROM cleaned_strings )


SELECT * FROM final_foreign_trade





