USE learnsql;

-- 字段(field) 与 列(column) 基本意思相同 主要在计算字段场景下使用
-- 计算字段在 SELECT 语句内创建

-- 数据库知道 哪些列实际在表中 哪些是计算字段
-- 对客户端则没有区别
-- 数据库服务器上完成计算操作比在客户端中完成要快

-- 拼接(concatenate)
-- 将值联结到一起构成单个值
-- SQL Server: +
-- Oracle等: ||
-- 经检验MySQL中使用'+'或'||'不能完成拼接操作 前者会进行加法数值计算
SELECT vend_name || '(' || vend_country || ')'
FROM vendors
ORDER BY vend_name;

-- MySQL中的正确操作 使用CONCAT函数
SELECT CONCAT(vend_name, '(', vend_country, ')')
FROM vendors
ORDER BY vend_name;

-- 去除字符串附近多余的空格
-- 有时数据库会用空格填充列宽 为使输出正确去除多余的空格很有用
-- 左右TRIM() 左LTRIM() 右RTRIM()
SELECT CONCAT(TRIM(vend_name), '(', TRIM(vend_country), ')')
FROM vendors
ORDER BY vend_name;

-- 别名(alias) 一个字段或值的替换名
-- AS 关键字赋予别名 以便对新计算列的引用
SELECT CONCAT(TRIM(vend_name), '(', TRIM(vend_country), ')')
    AS vend_title
FROM vendors
ORDER BY vend_name;

-- AS 关键字常常是可选的 但最好使用它
-- 别名还有其他用途 比如必要的时候对原表中列名进行重命名或修改

-- 别名可以是一个单词 也可以是字符串 字符串应用引号括起来
-- 不建议将字符串用作别名 通常是将多单词的字符串列名使用别名改成一个单词 以免在客户端引发问题

-- 别名也被叫作 导出列(derived column)

-- 计算字段另一常见用途是算术计算
-- 算术操作符: + - * /
SELECT prod_id, quantity, item_price,
       quantity*item_price AS expanded_price
FROM orderitems
WHERE order_num = 20008;

-- 省略 FROM 的 SELECT 语句就是简单地访问和处理表达式 可用于测试 检验 函数与计算
-- 测试计算
SELECT 3*2;
-- 测试函数
SELECT TRIM(' abb c  ');
-- 获取当前日期
SELECT  CURDATE();

-- 7.5.1
SELECT vend_id,
       vend_name AS vname,
       vend_address AS vaddress,
       vend_city AS vcity
FROM vendors
ORDER BY vend_name;

-- 7.5.2
SELECT prod_id, prod_price,
       prod_price*0.9 AS sale_price
FROM products;
