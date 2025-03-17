
CREATE TABLE stock_prices (
    id INT , 
    market_date DATE ,
    open_price FLOAT,
    high_price FLOAT,
    low_price FLOAT,
    close_price FLOAT,
    volume INTEGER
);

SELECT *
FROM stock_prices 
LIMIT 5;

SELECT * FROM mysql.user;

SELECT market_date, close_price 
FROM stock_prices 
ORDER BY close_price DESC 
LIMIT 5;

-- 7 DAY MOVING AVERAGE
SELECT market_date, close_price,
       AVG(close_price) OVER (ORDER BY market_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS moving_avg
FROM stock_prices;

-- DAYS WITH HIGHEST TRADING VOLUME
SELECT market_date, volume 
FROM stock_prices 
ORDER BY volume DESC 
LIMIT 5;

-- PRICE VOLATILITY - STD OVER 30 DAYS
SELECT market_date, 
       close_price,
       STDDEV(close_price) OVER (ORDER BY market_date ROWS BETWEEN 29 PRECEDING AND CURRENT ROW) AS volatility
FROM stock_prices;

SELECT market_date, close_price,
       LAG(close_price) OVER (ORDER BY market_date) AS prev_close,
       (close_price - LAG(close_price) OVER (ORDER BY market_date)) / LAG(close_price) OVER (ORDER BY market_date) * 100 AS daily_return
FROM stock_prices;

SELECT market_date, close_price,
       close_price - LAG(close_price) OVER (ORDER BY market_date) AS price_change,
       CASE 
           WHEN close_price - LAG(close_price) OVER (ORDER BY market_date) > 0 THEN close_price - LAG(close_price) OVER (ORDER BY market_date)
           ELSE 0
       END AS gain,
       CASE 
           WHEN close_price - LAG(close_price) OVER (ORDER BY market_date) < 0 THEN ABS(close_price - LAG(close_price) OVER (ORDER BY market_date))
           ELSE 0
       END AS loss
FROM stock_prices;

SELECT market_date, close_price,
       AVG(close_price) OVER (ORDER BY market_date ROWS BETWEEN 49 PRECEDING AND CURRENT ROW) AS ma_50,
       AVG(close_price) OVER (ORDER BY market_date ROWS BETWEEN 199 PRECEDING AND CURRENT ROW) AS ma_200
FROM stock_prices;
