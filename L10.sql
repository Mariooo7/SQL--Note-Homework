USE learnsql;

-- 如何分组数据以便汇总表内容的子集？
-- SELECT语句的两个子句: GROUP BY子句 和 HAVING子句

-- 目前为止的所有计算总在 全表 或 匹配WHERE子句筛选的数据上进行
SELECT COUNT(*) AS num_prods
FROM products
WHERE vend_id = 'DLL01';

-- 为了根据需要分出多个逻辑组 并分别对每个组进行聚集计算
-- 分组使用SELECT语句的GROUP BY子句建立
-- 通过如下例子理解
SELECT vend_id,
       COUNT(*) AS num_prods
FROM products
GROUP BY vend_id;
-- 分组后COUNT(*)对每个组分别进行聚集计算而非对整个表计算
-- GROUP BY 子句的作用是: 1. 按vend_id排序 2. 按vend_id分组

-- GROUP BY 可以包含任意数目的列 进行更细致的分组
SELECT vend_id, prod_id,
       SUM(prod_price) AS sum_price
FROM products
GROUP BY vend_id, prod_id;
-- 此处先以 vend_id 分组 再用 prod_id 分组 体现在结果中:先分组的列在左边

-- GROUP BY 中若嵌套了分组 最终返回的都是指定的所有列分组计算的结果
-- GROUP BY 中出现的所有列必须是 检索列 或 有效的表达式(但不能是聚集函数)
-- 如果 SELECT 语句中使用的是表达式 对应在 GROUP BY 后也必须指定相同的表达式 而不是别名！
-- 大多数SQL不允许GROUP BY指定的列是长度可变的数据类型(如文本 备注型字段)
-- 除了聚集计算语句 SELECT 语句中的每一列都应当在GROUP BY中给出
-- 分组时NULL会被视为一种类型 所有的NULL会被分为一组
-- GROUP BY 在WHERE 之后 在 ORDER BY 之前

-- 有些SQL支持GROUP BY中使用ALL子句 用于返回所有分组 若分组无对应行返回 NULL 经检验MySQL不支持
-- 有些SQL支持通过相对位置指定GROUP BY的列
SELECT vend_id, prod_id,
       SUM(prod_price) AS sum_price
FROM products
GROUP BY 1, 2;
-- 经检验 MySQL支持
-- 这种做法不利于编辑 容易出错

-- 为了根据条件进行分组(不是筛选符合特定条件的行 而是分组) 需要进行 过滤分组 其实就是选择保留哪些分组 使用 HAVING 子句
-- HAVING与WHERE非常类似 除了过滤行与过滤分组的不同 操作符 条件 句法是一样的
SELECT cust_id,
       COUNT(*) AS orders
FROM orders
GROUP BY cust_id;
-- 过滤掉订单数小于2的分组
SELECT cust_id,
       COUNT(*) AS orders
FROM orders
GROUP BY cust_id
HAVING COUNT(*) >= 2;
-- 我们可以尝试将HAVING换成WHERE
-- 注意WHERE子句与其他子句的排序 与HAVING不同
/*
SELECT cust_id,
       COUNT(*) AS orders
FROM orders
WHERE COUNT(*) >= 2
GROUP BY cust_id;
*/
-- 以上代码运行会报错分组无效 因为WHERE基于特定行的值进行过滤 根本没法接受 聚集函数 作为条件
-- 换个角度 是因为 WHERE 的过滤在分组之前进行 而HAVING在数据分组后再过滤
-- 基于以上特性 可以同时使用WHERE和HAVING WHERE过滤的行不会包含在分组中
-- 进一步筛选 只看一定时间段内的订单
SELECT cust_id,
       COUNT(*) AS orders
FROM orders
WHERE YEAR(order_date) = 2020
GROUP BY cust_id
HAVING COUNT(*) >= 2;

-- 考虑到相似性 不指定GROUP BY的话 HAVING和WHERE可能在DBMS中被同等地对待 但使用时仍应该注意区分

-- 虽然使用GROUP BY分组后数据常常以分组顺序给出 但这不是SQL规范要求的 也不总是可靠的 而且有时我们需要特定的输出顺序
-- 因此使用GROUP BY分组时总应该使用ORDER BY进行所需的排序
-- ORDER BY可以接受根据任意列进行排序 包括 未选择列 别名 而GROUP BY必须使用选择列或表达式列 不能使用聚集函数 别名
SELECT order_num,
       COUNT(*) AS items
FROM orderitems
GROUP BY order_num
HAVING COUNT(*) >= 3;
-- 加入ORDER BY 指定排序顺序
SELECT order_num,
       COUNT(*) AS items
FROM orderitems
GROUP BY order_num
HAVING COUNT(*) >= 3
ORDER BY items, order_num;

-- 回顾至今学过的SELECT语句中子句的顺序 以及是否必须使用
-- SELCET(必须使用)
-- FROM(从表选择时使用)
-- WHERE(对行过滤时使用)
-- GROUP BY(按组计算聚集时使用)
-- HAVING(对组进行过滤时使用)
-- ORDER BY(指定排序时使用)

-- 10.7.1
SELECT order_num,
       COUNT(*) AS order_lines
FROM orderitems
GROUP BY order_num
ORDER BY order_lines;

-- 10.7.2
SELECT vend_id,
       MIN(prod_price) AS cheapest_item
FROM products
GROUP BY vend_id
ORDER BY cheapest_item;
-- 虽然题目要求使用prod_price表示产品 但最符合题意的应当是同时检索出 vend_id prod_name(cheapest_item) prod_price
-- 根据后一章子查询相关内容可以优化这个问题的解决
SELECT p1.vend_id,
       p1.prod_name AS cheapest_item,
       p1.prod_price
FROM products p1
WHERE prod_price = (SELECT MIN(prod_price)
                    FROM products p2
                    WHERE p2.vend_id = p1.vend_id)
ORDER BY prod_price;
-- 此处外部查询中的WHERE的作用是对外部查询结果的行进行筛选 将价格列的数据与对应供应商所有产品的最低价格进行匹配
-- 以上操作可以达到我们期望的效果 但此处对外部查询的每一行都进行子查询效率很低 不适合数据量较大的情况
-- 更好的方法是使用INNER JOIN 只需要单次子查询就可以实现
SELECT p1.vend_id,
       p1.prod_name AS cheapest_item,
       p1.prod_price
FROM products p1
INNER JOIN(
    SELECT vend_id,
           MIN(prod_price) AS lowest_price
    FROM products
    GROUP BY vend_id)
    p2
    ON p1.vend_id = p2.vend_id
           AND prod_price = lowest_price
ORDER BY prod_price;

-- 10.7.3
SELECT order_num
FROM orderitems
GROUP BY order_num
HAVING SUM(quantity) >= 100;

-- 10.7.4
SELECT order_num
FROM orderitems
GROUP BY order_num
HAVING SUM(item_price*quantity) >= 1000
ORDER BY order_num;

-- 10.7.5
-- GROUP BY 应使用 order_num 列
SELECT order_num,
       COUNT(*) AS items
FROM orderitems
GROUP BY order_num
HAVING COUNT(*) >= 3
ORDER BY items, order_num;








