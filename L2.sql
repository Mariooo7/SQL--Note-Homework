USE learnsql;

-- 使用SELECT从表中检索一个或多个数据列
-- 保留字/关键字不能用作表或列的名字
-- 结束语句用';'
-- SQL不区分大小写,忽视空格
-- 检索多个列, 列名之间使用','
-- '*'可以检索未知列名的列
-- 'DISTINCT'不能部分使用 —— 在检索多列中使用的结果是返回组合不同的行
-- 'LIMIT'限制输出行数, 'OFFSET'指定跳过几行开始数 —— 第一行是第'0'行

-- LIMIT 4,3 == LIMIT 3 OFFSET 4


-- 2.9.1
SELECT cust_id
FROM customers;

-- 2.9.2
SELECT DISTINCT prod_id
FROM orderitems;
-- DISTINCT:选取不同（独特）的产品

-- 2.9.3
SELECT *
FROM customers;

SELECT cust_id
FROM customers;
-- sql中的注释： 1.'-- comment' 2. '# comment' 3. '/* start comment...rows...end */'


