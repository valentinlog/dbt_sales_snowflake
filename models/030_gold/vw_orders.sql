{{ config(materialized='view') }}

select * from {{ref('fct_orders')}}