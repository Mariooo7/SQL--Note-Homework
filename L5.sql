USE learnsql;

-- 两种使用方式组合多个 WHERE 子句: AND 或 OR
-- 操作符(operator) 或称 逻辑操作符(logical operator) 联结或改变WHERE子句中的子句的关键字

-- AND 和 OR 可以组合
-- AND 优先级比 OR 高！
-- 规定优先级: 使用 ( )

-- IN 操作符: 取一组由 , 分隔 括在 ( )中 的 合法值
-- 与 OR 的功能相近 但更直观 性能更好
-- 最大优点: 能包含其他 SELECT 更动态地建立 WHERE 子句

-- NOT: 对其后所有条件的否定
-- 用在列名之前

-- 5.5.1
SELECT vend_name
FROM vendors
WHERE vend_country = 'USA' AND vend_state = 'CA';

-- 5.5.2
SELECT order_num, prod_id, quantity
FROM orderitems
WHERE prod_id IN ('BR01','BR02','BR03')
  AND quantity >= 100;

-- 5.5.3
SELECT prod_name, prod_price
FROM products
WHERE prod_price >= 3
  AND prod_price <= 6
ORDER BY prod_price;

-- 5.5.4
-- ORDER BY 应在 WHERE 子句后面
SELECT vend_name
FROM vendors
WHERE vend_country = 'USA'
  AND vend_state = 'CA'
ORDER BY vend_name;
