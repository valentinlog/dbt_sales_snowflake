SELECT
*
FROM 
{{ source('landing', 'bronze_products') }}