USE learnsql;

-- 聚集函数(aggregate function)
-- 为了汇总 分析数据 而非实际检索出它们
-- 对某些行运行 计算并返回一个值
-- 以下5个聚集函数在各DBMS中是一致的

-- 求平均值 AVG()
-- AVG() 忽略NULL
SELECT AVG(prod_price) AS avg_price
FROM products;

SELECT AVG(prod_price) AS avg_price
FROM products
WHERE vend_id = 'DLL01';


-- 计算行数 COUNT()
-- 不同情况下对NULL的处理不同
-- 1. 全表计数 不论值是否为空
SELECT COUNT(*) AS num_cust
FROM customers;

-- 2. 特定列 忽略不计空值
SELECT COUNT(cust_email) AS num_cust
FROM customers;

-- 最大值 MAX()
-- 要求指定列名
-- 忽略NULL
SELECT MAX(prod_price) AS max_price
FROM products;
-- 通常用于找出最大的数值或日期
-- 许多DBMS支持将其用于非数值列 对文本该函数返回排序后的最后一行的值
SELECT cust_contact
FROM customers;

SELECT MAX(cust_contact) AS max_contact
FROM customers;

-- 最小值 MIN()
-- 与MAX()相反

-- 对指定列的值求和 SUM()
-- 忽略NULL
SELECT SUM(quantity) AS items_ordered
FROM orderitems
WHERE order_num = 20005;

-- 该函数也能对计算值求和
SELECT SUM(quantity*item_price) AS total_price
FROM orderitems
WHERE order_num = 20005;
-- 与本例类似的 其他聚集函数也可以通过使用标准算术操作符完成多列上的计算

-- 以上5个函数在使用时都隐含了默认指定的ALL参数 即对所有行执行操作
-- 为聚集不同的值 也可以指定 DISTINCT 参数 这样函数仅考虑各个不同的值
SELECT AVG(DISTINCT  prod_price) AS avg_price
FROM products
WHERE vend_id = 'DLL01';

-- 指定DISTINCT 必须使用列名 也就是说 DDISTINCT 不能用于 COUNT(*) 也不能用于计算或表达式
-- DISTINCT 虽然可以用于 MIN() 和 MAX() 但这显然没有意义
-- 聚集函数还可能有其他参数 参见各DBMS文档

-- SELECT语句可根据需要包含多个聚集函数
-- 在指定别名时注意不使用表中实际存在的列名 即使这么做合法

-- 9.5.1
SELECT SUM(quantity) AS total_quantity
FROM orderitems;

-- 9.5.2
SELECT SUM(quantity) AS BRO1_quantity
FROM orderitems
WHERE prod_id = 'BR01';

-- 9.5.3
SELECT MAX(prod_price) AS max_price
FROM products
WHERE prod_price <= 10;
