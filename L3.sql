USE learnsql;

-- 关系数据库设计理论认为 如果不明确规定排序顺序 则不应该假定检索的数据顺序有任何意义
-- 子句（从句）:clause 例如: FROM;ORDER BY...
-- ORDER BY 子句 应当是 SELECT 语句中最后一条子句
-- 可以用非检索的列来排序
-- 可以按多个列排序: 用','隔开列名
-- 可以按相对列位置排序: ORDER BY 2,3 即按SELECT选择的第二,三个列排序
-- 如有必要 实际列名和相对列位置可以混用

-- 3.4 指定排序方向检索
-- ORDER BY 默认按升序排列(A-Z) 降序使用 DESC 关键字

-- 按单列排序
SELECT prod_id, prod_price, prod_name
FROM products
ORDER BY prod_price DESC;

-- 若使用多个列排序
SELECT prod_id, prod_price, prod_name
FROM products
ORDER BY prod_price DESC, prod_name; -- prod_price 降序； prod_name 升序

-- DESCENDING 可以替代 DESC
-- 默认的升序即 ASC/ASCENDING
-- 按多个列降序则需对每个列加 DESC
-- 排序时对大小写的区分取决于数据库的设置方式

-- 3.6.1
SELECT cust_name
FROM customers
ORDER BY cust_name DESC;

-- 3.6.2
SELECT cust_id, order_num
FROM orders
ORDER BY cust_id;

SELECT cust_id, order_num
FROM orders
ORDER BY order_date DESC;

-- 3.6.3
SELECT quantity, item_price
FROM orderitems
ORDER BY quantity DESC, item_price DESC;

-- 3.6.4
-- 1. SELECT语句 列名最后不应用','
-- 2. ORDER --> ORDER BY
SELECT vend_name
FROM vendors
ORDER BY vend_name DESC;
-- 运行通过

