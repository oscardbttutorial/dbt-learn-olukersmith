with payments as (

    select * from {{ ref('stg_payments') }}

), orders as (

    select * from {{ ref('stg_orders') }}

)

SELECT 
    orders.order_id,
    orders.customer_id,
    orders.order_date,
    SUM(payments.amount) AS amount
FROM
    orders
    LEFT JOIN payments ON orders.order_id = payments.orderid AND payments.status = 'success'
GROUP BY 1, 2, 3