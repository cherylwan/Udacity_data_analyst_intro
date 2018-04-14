/*项目1 course3 */

SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC
LIMIT 10;

SELECT id, account_id, total
FROM orders
ORDER BY TOTAL
LIMIT 20;

/*编写一个查询，
返回按从最新到最早排序的 订单 中的前 5 行，
但需首先列出每个日期的最大 total_amt_usd。 */

SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY occurred_at DESC, total_amt_usd DESC;

/* 23:从 订单 表提取出大于或等于 1000 的 gloss_amt_usd
美元数额的前五行数据（包含所有列）。*/
SELECT *
FROM orders
WHERE gloss_amt_usd>=1000
LIMIT 5;

/*26: WHERE 与非数字数据一起使用的练习
过滤账户（accounts ）表格，从该表格中筛选出 Exxon Mobil 的 name、
website 和 primary point of contact (primary_poc)。*/

SELECT name, website, primary_poc
FROM accounts
WHERE name='Exxon Mobil';

/*使用 订单 (order)表：
创建一个用 standard_amt_usd 除以 standard_qty 的列，
查找每个订单中标准纸的单价。将结果限制到前 10 个订单，
并包含 id 和 account_id 字段。 注意 - 对于这个问题，
即使采用正确的解决方案，也会遇到一个问题。这就是除以零。
 在后面的课程学习 CASE 语句时，你将学会不会让此查询发生错误的解决方案。*/

SELECT id, account_id, standard_amt_usd/standard_qty AS unit_price
FROM orders
LIMIT 10;

/*编写一个查询，查找每个订单海报纸的收入百分比。 只需使用以 _usd 结尾的列。
（在这个查询中试一下不使用总列）。包含 id 和 account_id 字段。*/
SELECT id, account_id, standard_amt_usd, gloss_amt_usd, poster_amt_usd/total_amt_usd AS percentage
FROM orders
LIMIT 10

/*使用 LIKE 运算符的问题
使用 accounts (客户) 表查找

所有以 'C' 开头公司名。

名称中包含字符串 'one' 的所有公司名。

所有以 's' 结尾的公司名。*/

SELECT *
FROM accounts
WHERE name LIKE 'C%';

SELECT *
FROM accounts
WHERE name LIKE '%one%';

SELECT *
FROM accounts
WHERE name LIKE '%s';

/*使用 IN 运算符的问题
使用 客户 表查找 Walmart、Target 和 Nordstrom 的name (客户名称),
 primary_poc (主要零售店), and sales_rep_id (销售代表 id)。
 使用 web_events 表查找有关通过 organic 或 adwords 联系的所有个人信息。*/
 SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart','Target','Nordstrom')

SELECT *
FROM web_events
WHERE channel IN ('organic','adwords');

/*使用 NOT 运算符的问题
我们可以使用这个新运算符来提取前两个概念中不属于查询内容的所有行。
使用客户表查找除 Walmart、Target 和 Nordstrom 之外的所有商店的客户名称、主要零售店和销售代表 id。
使用 web_events 表查找除通过任何方法联系的个人的所有信息，除了使用 organic 或 adwords 方法。
使用客户表查找：
所有不以 'C' 开头的公司名。
所有名称中不包含字符串 'one' 的公司名。
所有不以 's' 结尾的公司名。*/

SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom');

SELECT *
FROM web_events
WHERE channel NOT IN ('organic', 'adwords');

/*使用 AND 和 BETWEEN 运算符的问题
编写一个查询，返回所有订单，其中 standard_qty 超过 1000，
poster_qty 是 0，gloss_qty 也是 0。
使用客户表查找所有不以 'C' 开始但以 's' 结尾的公司名。
使用 web_events 表查找通过 organic 或 adwords 联系，
并在 2016 年的任何时间开通帐户的个人全部信息，并按照从最新到最旧的顺序排列。*/

SELECT *
FROM orders
WHERE standard_qty>1000 AND poster_qty=0 AND gloss_qty=0;

SELECT *
FROM accounts
WHERE name NOT LIKE 'C%' AND name LIKE '%s';

SELECT *
FROM web_events
WHERE channel IN ('organic','adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
-- between一般情况下不包括端点值，故设为2017-1-1
ORDER BY occurred_at DESC

/*使用 OR 运算符的问题
查找 订单 (orders) id 的列表，其中 gloss_qty 或 poster_qty 大于 4000。只在结果表中包含 id 字段。
编写一个查询，返回订单 (orders) 的列表，其中标准数量 (standard_qty)为零，
光泽度 (gloss_qty) 或海报数量 (poster_qty)超过 1000。
查找以 'C' 或 'W' 开头的所有公司名 (company names)，主要联系人 (primary contact)
包含 'ana' 或 'Ana'，但不包含 'eana'。*/


SELECT id
FROM orders
WHERE gloss_qty>4000 OR poster_qty>4000

SELECT *
FROM orders
WHERE standard_qty=0 AND (gloss_qty>1000 OR poster_qty>1000)

SELECT *
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%') AND (primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%') AND primary_poc NOT LIKE '%eana%'
