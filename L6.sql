USE learnsql;

-- 前面的操作符都使用已知值进行过滤
-- 通配符(wildcard): 用来匹配值的一部分的特殊字符
-- 搜索模式(search pattern): 由字面值 通配符 或 两者组合构成的搜索条件
-- 利用通配符可创建比较特定数据的搜索模式
-- 通配符本质是WHERE子句中有特殊含义的字符
-- 为使用通配符 要同时使用 LIKE

-- 谓词: 个人理解 —— 当操作符被用来进行与逻辑(判断行的真值条件)相关的操作 即成为谓词
-- 通配符仅用于文本！

-- %
-- 表示任何字符(包括空格)出现任意次数
-- 不能匹配 NULL

-- 有些DBMS使用空格填充字段 会使文本的结尾是空格而不是指定的字符 例如使用 WHERE prod_name LIKE 'F%y' 会检索不到期望的结果
-- 解决方法: 改成 'F%y%' 即可 不过更好的方法是用函数去掉空格

-- _
-- 刚好匹配一个字符，不能多也不能少

-- []
-- 指定一个字符集与指定位置的一个字符匹配
-- 使用 ^ 否定集合内的字符
-- 并非所有DBMS 都支持

-- 经检验MySQL不支持


/*
SELECT cust_contact
FROM customers
WHERE cust_contact LIKE '[^JM]%'
ORDER BY cust_contact;

这两种检索结果相同

SELECT cust_contact
FROM customers
WHERE NOT cust_contact LIKE '[JM]%'
ORDER BY cust_contact;
*/

-- 注意事项
-- 通配符性能损耗通常较大
-- 尽量使用其他操作符完成通配符的功能
-- 就算使用 尽量不用在搜索模式的开始处
-- 用在正确的位置

-- 6.4.1
SELECT prod_name, prod_desc
FROM products
WHERE prod_desc LIKE '%toy%';

-- 6.4.2
SELECT prod_name, prod_desc
FROM products
WHERE NOT prod_desc LIKE '%toy%'
ORDER BY  prod_name;

-- 6.4.3
SELECT  prod_name, prod_desc
FROM products
WHERE prod_desc LIKE '%toy%'
  AND prod_desc LIKE '%carrots%';

-- 6.4.4
SELECT  prod_name, prod_desc
FROM products
WHERE prod_desc LIKE '%toy%carrots%';

