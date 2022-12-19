# Актуализация модели данных
## Создание витрины данных для RFM-классификации пользователей приложения для компании, которая разрабатывает приложение по доставке еды.

## 1. Построение витрины для RFM-анализа
### 1.1. Требования к целевой витрине
В базе две схемы: production и analysis. В схеме `production` содержатся оперативные таблицы.

**Задача:** — построить витрину для RFM-классификации. 
Витрину нужно назвать `dm_rfm_segments`. Сохранить в хранилище данных, а именно — в схему `analysis`.

**Факторы RFM-классификации**

Присвойте каждому клиенту три значения — значение фактора Recency, значение фактора Frequency и значение фактора Monetary Value:
* Фактор **Recency** измеряется по последнему заказу. Распределите клиентов по шкале от одного до пяти, где значение 1 получат те, кто либо вообще не делал заказов, либо делал их очень давно, а 5 — те, кто заказывал относительно недавно.
* Фактор **Frequency** оценивается по количеству заказов. Распределите клиентов по шкале от одного до пяти, где значение 1 получат клиенты с наименьшим количеством заказов, а 5 — с наибольшим.
* Фактор **Monetary Value** оценивается по потраченной сумме. Распределите клиентов по шкале от одного до пяти, где значение 1 получат клиенты с наименьшей суммой, а 5 — с наибольшей.

**Период:** с начала 2022 года

**Поля:**
* `user_id` - идентификатор клиента
* `recency` (число от 1 до 5) — сколько времени прошло с момента последнего заказа.
* `frequency` (число от 1 до 5) — количество заказов.
* `monetary_value` (число от 1 до 5) — сумма затрат клиента.

**Обновление данных:** не требуется.

**Дополнительные условия**
* Для анализа нужно отобрать только успешно выполненные заказы (со статусом 'Closed').
* Количество клиентов в каждом сегменте должно быть одинаково. Например, если в базе всего 100 клиентов, то 20 клиентов должны получить значение 1, ещё 20 — значение 2 и т. д.

### 1.2. Структура исходных данных
Исходные данные содержатся в схеме `production`, состоящей из 6 таблиц. Из них нам необходимы 3: `users`, `orders`, `orderstatuses`

Для построения витрины нам понадобятся следующие поля:
* `users.id` - идентификатор клиента (тип int4)
* `orderstatuses.key`- статус заказа (тип varchar(255))
* `orderstatuses.id` - идентификатор статуса заказа (тип int4)
* `orders.user_id` - идентификатор клиента (тип int4)
* `orders.order_id` - идентификатор заказа (тип int4)
* `orders.order_ts` - дата и время совершения заказа (тип timestamp)
* `orders.status` -  статус заказа (тип int4)
* `orders.payment` - сумма оплаты по заказу (тип numeric(19,5))


### 1.3. Качество данных
<code>[Проверка качества данных](https://github.com/elenabityukova/RFM/blob/main/data_quality.md)</code>

###  1.4. Построение витрины данных

#### 1.4.1 Представления для таблиц из базы `production`
<code>[Представления для таблиц](https://github.com/elenabityukova/RFM/blob/main/views.sql)</code>

#### 1.4.2 DDL-запрос для создания витрины
<code>[DDL-запрос для создания витрины](https://github.com/elenabityukova/RFM/blob/main/datamart_ddl.sql)</code>

#### 1.4.3 SQL-запрос для заполнения витрины

**Создание таблиц под показатели**
```
CREATE TABLE analysis.tmp_rfm_recency (  
 user_id INT NOT NULL PRIMARY KEY,  
 recency INT NOT NULL CHECK(recency >= 1 AND recency <= 5)  
);  

CREATE TABLE analysis.tmp_rfm_frequency (  
 user_id INT NOT NULL PRIMARY KEY,  
 frequency INT NOT NULL CHECK(frequency >= 1 AND frequency <= 5)  
);  

CREATE TABLE analysis.tmp_rfm_monetary_value (  
 user_id INT NOT NULL PRIMARY KEY,  
 monetary_value INT NOT NULL CHECK(monetary_value >= 1 AND monetary_value <= 5)  
);  
```
<code>[SQL-запрос для заполнения таблицы analysis.tmp_rfm_recency](https://github.com/elenabityukova/RFM/blob/main/tmp_rfm_recency.sql)</code>

<code>[SQL-запрос для заполнения таблицы analysis.tmp_rfm_frequency](https://github.com/elenabityukova/RFM/blob/main/tmp_rfm_frequency.sql)</code>

<code>[SQL-запрос для заполнения таблицы analysis.tmp_rfm_monetary_value](https://github.com/elenabityukova/RFM/blob/main/tmp_rfm_monetary_value.sql)</code>

<code>[SQL-запрос для заполнения витрины analysis.dm_rfm_segments](https://github.com/elenabityukova/RFM/blob/main/datamart_query.sql)</code>

## 1. Доработка представлений

<code>[SQL-запрос по обновлению представления analysis.Orders](https://github.com/elenabityukova/RFM/blob/main/orders_view.sql)</code>
