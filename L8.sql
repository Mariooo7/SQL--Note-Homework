USE learnsql;

-- SQL函数可移植性很差
-- 所谓可移植(portable) 即跨DBMS运行
-- 因此使用函数注意注释

-- SQL函数的类型
-- 文本 数值 日期和时间 格式化 系统 ...

-- 回忆SQL不区分大小写 因此写SQL函数时大小写并不影响函数的功能 但应注意风格统一

-- 文本处理函数
-- LEFT() RIGHT() 指定长度返回字符串左/右边的字符
-- SUBSTRING() 指定区间提取子字符串
-- LTRIM() RTRIM() TRIM() 去除空格
-- SOUNDEX() 返回字母数字模式表示的文本发音的值 使得字符串的发音可以被比较 经试验对中文字符没用
-- UPPER() LOWER() 大小写

-- 使用范例
-- 提取子字符串
-- 注意,的使用
SELECT SUBSTRING('Michael' FROM 3 FOR 2);
SELECT SUBSTRING('Michael' FROM 3);
SELECT SUBSTRING('Michael', 3, 2);
SELECT SUBSTRING('Michael', 3);

SELECT SUBSTRING('Michael', -4);
SELECT RIGHT('Michael', 4);

-- 使用SOUNDEX函数获取发音类似的数据
-- 注意WHERE子句中使用的是 = 而不是 LIKE —— 此处无通配符不需要LIKE
SELECT cust_name, cust_contact
FROM customers
WHERE SOUNDEX(cust_contact) = SOUNDEX('Michael Green');

-- 日期和时间处理函数
-- 每种DBMS都以特殊的格式存储日期数据 而应用程序并不会这些存储格式 因此这类函数非常有用
-- 但其可移植性也最差

-- 使用范例
-- 根据订单年份筛选订单 返回订单号
-- MySQL中的三种方法
SELECT order_num
FROM orders
WHERE YEAR(order_date) = 2020;

SELECT order_num
FROM orders
WHERE EXTRACT(year FROM order_date) = 2020;

SELECT order_num
FROM orders
WHERE order_date
    BETWEEN STR_TO_DATE('2020/01/01', '%Y/%m/%d')
    AND STR_TO_DATE('2020/12/31', '%Y/%m/%d');

-- 还有其他可以 比较日期 执行日期运算 选择日期格式等的函数 考虑低可移植性 最好参阅对应的文档

-- 数值处理函数
-- 常常使用不频繁 可移植性却很高
-- 常用数值处理函数如下

SELECT ABS(-2);

-- 经检验 SQL三角函数的输入为弧度 且输出应为零时并不准确地为零 而是接近零的很多位的小数
SELECT COS(PI());
SELECT COS(3.14);
SELECT SIN(PI());
SELECT TAN(PI());

-- 指数函数
SELECT EXP(2);

-- 开根
SELECT SQRT(2);

-- 8.4.1
SELECT cust_id,
       cust_name
           AS customer_name,
       UPPER(CONCAT(LEFT(cust_contact,2), LEFT(cust_city,3)))
           AS user_login
FROM customers;

-- 8.4.2
SELECT order_num, order_date
FROM orders
WHERE YEAR(order_date) = 2020
    AND MONTH(order_date) = 1
ORDER BY order_date;


