-- Представление для таблицы `orderitems`
CREATE OR REPLACE VIEW analysis.orderitems AS
SELECT *
FROM production.orderitems;

-- Представление для таблицы `orderstatuses`
CREATE OR REPLACE VIEW analysis.orderstatuses AS
SELECT *
FROM production.orderstatuses;

-- Представление для таблицы `orderstatuslog`
CREATE OR REPLACE VIEW analysis.orderstatuslog AS
SELECT *
FROM production.orderstatuslog;

-- Представление для таблицы `products`
CREATE OR REPLACE VIEW analysis.products AS
SELECT *
FROM production.products;

-- Представление для таблицы `users`
CREATE OR REPLACE VIEW analysis.users AS
SELECT *
FROM production.users;

-- Представление для таблицы `orders`
CREATE OR REPLACE VIEW analysis.orders AS
SELECT *
FROM production.orders;
