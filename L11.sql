USE learnsql;

-- 查询(query): 任何SQL语句都是查询 但此术语一般指 SELECT 语句
-- 子查询(subquery): 嵌套在其他查询中的查询

-- 本书使用的都是关系表
-- Orders: 订单编号 客户ID 订单日期
-- OrderItems: 订单物品信息
-- Customers: 顾客的实际信息

-- 问题: 查询订购物品'RGAN01'的所有顾客
-- 步骤: 1. 检索包含该物品的订单编号 2. 检索这些订单编号对应的所有顾客ID 3. 检索顾客ID对应的顾客信息

-- 1. 检索包含该物品的订单编号
SELECT order_num
FROM orderitems
WHERE prod_id = 'RGAN01';
-- 2. 检索这些订单编号对应的所有顾客ID
SELECT cust_id
FROM orders
WHERE order_num IN (20007, 20008);
-- 1. + 2. 使用子查询
SELECT cust_id
FROM orders
WHERE order_num IN (SELECT order_num
                    FROM orderitems
                    WHERE prod_id = 'RGAN01');

-- 含有子查询会使阅读以及调试难度增加
-- 因此需要注意分解成多行并适当缩进

-- 3. 检索顾客ID对应的顾客信息
-- 可以使用WHERE语句 硬编码这些顾客ID
SELECT cust_name,
       cust_contact
FROM customers
WHERE cust_id IN (1000000004, 1000000005);
-- 子查询代替硬编码顾客ID
SELECT cust_name,
       cust_contact
FROM customers
WHERE cust_id IN (SELECT cust_id
                  FROM orders
                  WHERE order_num IN (SELECT order_num
                                      FROM orderitems
                                      WHERE prod_id = 'RGAN01'));

-- 子查询嵌套没有数目限制 但实际使用时有性能限制
-- 作为子查询的SELECT语句应只返回 单列数据 否则报错
-- 子查询并不总是最有效的 详见L12

-- 作为计算字段使用子查询
-- 问题: 显示每个顾客的订单总数 订单与相应顾客ID存储在Orders表中
-- 步骤: 1.从Customers表中检索顾客列表 2.对每个检索出的顾客 统计其在Orders表中的订单数目

-- 不使用子查询 对单个顾客的订单数计数
SELECT cust_id,
       COUNT(*) AS count_orders
FROM orders
WHERE cust_id = 1000000001;

-- 对每个顾客执行 Count(*) 要使用子查询
SELECT customers.cust_name,
       customers.cust_state,
       (SELECT COUNT(*)
               FROM orders
               WHERE orders.cust_id = customers.cust_id) AS count_orders
FROM customers
ORDER BY cust_name;
-- 用'.'分隔表名和列名的语法(完全限定列名) 在可能混淆时必须使用

-- 11.5.1
SELECT orders.cust_id
FROM orders
WHERE orders.order_num IN (SELECT order_num
                          FROM orderitems
                          WHERE item_price >= 10);

-- 11.5.2
SELECT cust_id,
       order_date
FROM orders
WHERE orders.order_num IN (SELECT orderitems.order_num
                           FROM orderitems
                           WHERE prod_id = 'BR01')
ORDER BY order_date;

-- 11.5.3
SELECT cust_email
FROM customers
WHERE customers.cust_id IN (SELECT orders.cust_id
                            FROM orders
                            WHERE orders.order_num IN (SELECT orderitems.order_num
                                                       FROM orderitems
                                                       WHERE prod_id = 'BR01'));

-- 11.5.4
SELECT cust_id,
       (SELECT SUM(item_price * quantity)
        FROM orderitems
        WHERE orderitems.order_num = orders.order_num) AS total_ordered
FROM orders
ORDER BY total_ordered DESC;

-- 11.5.5
SELECT prod_name,
       (SELECT SUM(orderitems.quantity)
        FROM orderitems
        WHERE prod_id = products.prod_id) AS quant_sold
FROM products;



