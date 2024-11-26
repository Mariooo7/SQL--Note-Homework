USE learnsql;

-- 使用WHERE子句指定搜索条件(search criteria)/过滤条件(filter condition)
-- WHERE在FROM子句之后

-- 简单的相等检验
SELECT prod_name, prod_price
FROM products
WHERE prod_price = 3.490;
-- 小数点后有几位取决于DBMS指定或默认行为

-- 应用层（客户端）过滤 影响应用的性能,可伸缩性 且浪费网络带宽

-- ORDER BY 应当在 WHERE 后面

-- WHERE 特殊操作符:
-- 不等于: <>, !=
-- 小于等于: <=, !>
-- 不小于: !<, >=
-- BETWEEN AND
-- IS NULL
-- 上述操作符有些事冗余的 并非所有DBMS都支持它们

-- 4.4.1
SELECT prod_id, prod_name
FROM products
WHERE prod_price = 9.49;

-- 4.4.2
SELECT prod_id, prod_name
FROM products
WHERE prod_price >= 9;

-- 4.4.3
SELECT DISTINCT order_num
FROM orderitems
WHERE quantity >= 100;

-- 4.4.4
SELECT prod_name, prod_price
FROM products
WHERE prod_price BETWEEN 3 AND 6
ORDER BY prod_price;

