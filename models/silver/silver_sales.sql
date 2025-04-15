select 
    SALES_ORDER_NUMBER,
	SALES_ORDER_LINENUMBER,
	ORDER_DATE,
	CUSTOMER_NAME,
	EMAIL,
	ITEM,
	QUANTITY,
	UNITPRICE,
	TAX,
    case 
        WHEN ORDER_DATE < '2019-08-01' THEN 
          TRUE
        ELSE 
          FALSE        
    end as IS_FLAGGED ,
    {{ dbt_utils.current_timestamp()}} as CREATED_TS
from {{ ref("bronze_sales") }}
