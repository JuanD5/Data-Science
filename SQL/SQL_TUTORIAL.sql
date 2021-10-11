--tutorial de sql

-- A las columnas también se les llaman 'fields' o campos
-- Una base de datos puede contener varias tablas
--Dentro de cada tabla las filas se conocen como registros 'records'

SELECT column1, column2 
FROM  customers

SELECT * --selecciona todas las columnas o campos de la tabla"
FROM customers

SELECT DISTINCT Country --Esto retorna todos los valores que son diferentes dentro de esa columna, es decir quita los repetidos
FROM customers

SELECT COUNT(DISTINCT Country) 
FROM customers; --Así contariamos cuantos registros diferentes existen en la columna

SELECT * FROM Customers
WHERE Country='Mexico'; --Seleccione todos los registros en donde el campo país sea igual a Mexico
                        --Cuando quiero filtrar haciendo uso de un string debo ponerlo entre comillas.

-- PARA EL WHERE FUNCIONAN LOS OPERADORES LÓGICOS 

-- =, > etc Acá no se utiliza el == sino solo uno para definir la igualdad. 

-- <> es el que corresponde a 'no igual'. Aunque también puede ser != en algunos otros sistemas. 



-- LIKE	Search for a pattern 

SELECT * FROM Customers
WHERE City LIKE 's%'; -- donde el nombre de la ciudad empiece por la letra s 

-- IN	To specify multiple possible values for a column

SELECT * FROM Customers
WHERE City IN ('Paris','London'); -- la ciudad debe encontrarse en paris y londres. Yo digo que esto funciona como un OR. 


-- AND, OR Y NOT 

SELECT * FROM Customers
WHERE Country='Germany' AND City='Berlin'; -- seleccione todos los campos donde el país sea alemania y la ciudad sea berlin 

SELECT * FROM Customers
WHERE City='Berlin' OR City='München'; -- selecione todos los campos donde la ciudad sea berlin o munchen 


-- Estos dos son equivalentes. 

SELECT * FROM Customers
WHERE NOT Country='Germany'; -- seleccione todos los campos donde el país no sea igual a alemania 

SELECT * FROM Customers
WHERE Country <> 'Germany'; -- seleccione todos los campos donde el país no sea igual a alemania 



-- se pueden combinar 
SELECT * FROM Customers
WHERE Country='Germany' AND (City='Berlin' OR City='München');

SELECT * FROM Customers
WHERE NOT Country='Germany' AND NOT Country='USA';-- donde el pais no sea alemania ni tampoco USA 


-- ORDER BY ( se ordena de forma ascendente por default)

SELECT column1, column2, ...
FROM table_name
ORDER BY column1, column2, ... ASC|DESC;

SELECT * FROM Customers
ORDER BY Country; -- ordena por el nombre del país de forma ascendente es decir desde la A hasta la Z. 

SELECT * FROM Customers
ORDER BY Country, CustomerName; -- Ordena por país pero si dos registros tienen el mismo país los ordena por el customer name 

SELECT * FROM Customers
ORDER BY Country ASC, CustomerName DESC;



-- INSERTAR NUEVOS VALORES A LA TABLA 
-- INSERT INTO 
-- Se especifican las columnas y luego los valores correspondientes. 
INSERT INTO Customers (CustomerName, ContactName, Address, City, PostalCode, Country)
VALUES ('Cardinal', 'Tom B. Erichsen', 'Skagen 21', 'Stavanger', '4006', 'Norway');

-- NULL 
SELECT CustomerName, ContactName, Address
FROM Customers
WHERE Address IS NULL; -- devolver los registros donde en el campo de Address haya un null 

SELECT CustomerName, ContactName, Address
FROM Customers
WHERE Address IS NOT NULL; -- devolver los registros donde en el campo de Address no haya un null 


--ALIASES : USADOS CUANDO
-- There are more than one table involved in a query
-- Functions are used in the query
-- Column names are big or not very readable
-- Two or more columns are combined together
SELECT CustomerID AS ID, CustomerName AS Customer -- cambia el nombre de esas dos columnas por los referidos después del AS
FROM Customers;

SELECT CustomerName AS Customer, ContactName AS [Contact Person]-- si el nombre del alias lleva un espacio se debe poner entre paréntesis. 
FROM Customers;

SELECT CustomerName, Address + ', ' + PostalCode + ' ' + City + ', ' + Country AS Address
FROM Customers;
--RESULTADO 
CustomerName	        Address
Alfreds Futterkiste 	Obere Str. 57, 12209 Berlin, Germany-- JUNTO TODO EN EL MISMO REGISTRO, ES COMO CONCATENAR LOS RESULTADOS DE CADA COLUMNA EN UNA SOLA. 


SELECT o.OrderID, o.OrderDate, c.CustomerName
FROM Customers AS c, Orders AS o -- caso en el que se pone un alias al nombre de una tabla. 
WHERE c.CustomerName='Around the Horn' AND c.CustomerID=o.CustomerID; 

-- UPDATE
UPDATE Customers
SET ContactName = 'Alfred Schmidt', City= 'Frankfurt'
WHERE CustomerID = 1; -- al cliente con ID1 actualize el contact name con alfred y la ciudad con frankfurt 

UPDATE Customers
SET ContactName='Juan'
WHERE Country='Mexico'; -- todos los registros cuyo país sea mexico serán actualizados con Juan en su contact name 

-- SI SE OMITE EL WHERE PAILA TODOS LOS REGISTROS SE ACTUALIZAN . ojo con eso manito 

--DELETE 

DELETE FROM Customers WHERE CustomerName='Alfreds Futterkiste'; -- ELIMINE EL REGISTRO DONDE EL NOMBRE SEA ESE 

DELETE FROM Customers; --elimina todos los registros de la tabla pero sin eliminar la tabla como tal 


-- Limit para limitar cuantos registros devolver. 
SELECT * FROM Customers
LIMIT 3; 

-- Because a table may store rows in an unspecified order, when you use the LIMIT clause, you should always use the ORDER BY clause to control the row order.
-- If you don’t use the ORDER BY clause, you may get a result set with the unspecified order of rows.


SELECT select_list
FROM table_name
LIMIT row_count OFFSET row_to_skip;

-- The statement first skips row_to_skip rows before returning row_count rows generated by the query. 
-- If row_to_skip is zero, the statement will work like it doesn’t have the OFFSET clause.

-- To retrieve 4 films starting from the fourth one ordered by film_id, you use both LIMIT and OFFSET clauses as follows:

SELECT
	film_id,
	title,
	release_year
FROM
	film
ORDER BY
	film_id
LIMIT 4 OFFSET 3; --el resultado empieza en este caso desde la fila 4. 


--Typically, you often use the LIMIT clause to select rows with the highest or lowest values from a table.

--For example, to get the top 10 most expensive films in terms of rental, you sort films by the rental rate in descending order and use the LIMIT clause to get the first 10 films. The following query illustrates the idea:

SELECT
	film_id,
	title,
	rental_rate
FROM
	film
ORDER BY
	rental_rate DESC
LIMIT 10;
--MIN Y MAX 

SELECT MIN(Price) AS SmallestPrice
FROM Products;

SELECT MAX(Price) AS BiggestPrice
FROM Products;


--COUNT 

SELECT COUNT(column_name) --cuenta cuantos registros cumplen con esa condición 
FROM table_name
WHERE condition;


--AVG 
SELECT AVG(Price) -- devuelve el precio promedio de la columna de los precios 
FROM Products;

--SUM
SELECT SUM(Quantity)-- devuelve la suma de los números de esa columna 
FROM OrderDetails;



        
--LIKE : para buscar un patron en específico 
SELECT * FROM Customers
WHERE CustomerName LIKE 'a%';-- busca nombres que empiecen por la letra a. 



-- BETWEEN y NOT BETWEEN también se puede con strings 
SELECT * FROM Products
WHERE ProductName NOT BETWEEN 'Carnarvon Tigers' AND 'Mozzarella di Giovanni' --The following SQL statement selects all products with a ProductName between Carnarvon Tigers and Mozzarella di Giovanni:
ORDER BY ProductName;

SELECT * FROM Products
WHERE Price NOT BETWEEN 10 AND 20;

SELECT * FROM Products
WHERE Price BETWEEN 50 AND 60;

--JOINS

-- https://programacionymas.com/blog/como-funciona-inner-left-right-full-join

-- INNER JOIN : records que tienen valores que emparejan con los de la otra tabla. Solo los que se emparejan con la columna descrita 
SELECT Orders.OrderID, Customers.CustomerName -- selecciones la columna OrderID de la tabla Orders y la columna CustomerName de la tabla Customers 
FROM Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID; -- Se hace la union con base en la columna CustomerId
--  Selecciona los registros donde haya un match entre los CustomerID en la tabla de Orders y la tabla de customers. 



--LEFT JOIN 
-- LEFT JOIN: Devuelve todos los registros  de la tabla izquierda sumado al match que encontraron correspondencia de la tabla derecha. 
-- Customers es la Tabla Izquierda 
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers -- la tabla que aparece en el from es siempre la tabla izquierda 
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
ORDER BY Customers.CustomerName;
-- En este caso se devuelve todos los customers (tabla izquierda) y cualquier orden que tengan asociada (tabla derecha Orders) . 

--RIGHT JOIN
SELECT Orders.OrderID, Employees.LastName, Employees.FirstName
FROM Orders -- tabla izquierda 
RIGHT JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID --tabla derecha Employees 
ORDER BY Orders.OrderID;
--Devuelve todos los empleados y cualesquiera la orden que hayan ordenado. 

--FULL JOIN TODO LO QUE HAGA MATCH EN LAS DOS TABLAS Y LO QUE NO TAMBIÉN 
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
FULL OUTER JOIN Orders ON Customers.CustomerID=Orders.CustomerID
ORDER BY Customers.CustomerName;
-- The FULL OUTER JOIN keyword returns all matching records from both tables whether the other table matches or not. 
-- So, if there are rows in "Customers" that do not have matches in "Orders", or if there are rows in "Orders" that do not have matches in "Customers", those rows will be listed as well.


--SELF JOIN 
-- Se emparejan los clientes con la misma ciudad. 
SELECT A.CustomerName AS CustomerName1, B.CustomerName AS CustomerName2, A.City 
FROM Customers A, Customers B -- Self Join.  El alias es A y B. 
WHERE A.CustomerID <> B.CustomerID -- los ID son diferentes. 
AND A.City = B.City -- la ciudad de A es igual a la de B. 
ORDER BY A.City; --Ordenado por la ciudad. 

CustomerName1                   CustomerName2                           City 
Rancho grande	                Océano Atlántico Ltda.	                Buenos Aires
Furia Bacalhau e Frutos do Mar	Princesa Isabel Vinhoss	                Lisboa
Princesa Isabel Vinhoss	Furia   Bacalhau e Frutos do Mar	            Lisboa
Around the Horn	                --B's Beverages	                        London



--UNION 
-- Une dos select statements  de dos diferentes tablas. En este caso solo se retorna los valores no repetidos de la columna ciudad. 
SELECT City FROM Customers
UNION
SELECT City FROM Suppliers
ORDER BY City;
-- Se devuelve las ciudades (solo valores distintos) tanto de la tabla customers como de la tabla suppliers. 
SELECT City FROM Customers
UNION ALL -- de esta forma se admiten valores duplicados. 
SELECT City FROM Suppliers
ORDER BY City;


--The UNION operator is used to combine the result-set of two or more SELECT statements.
--Every SELECT statement within UNION must have the same number of columns
--The columns must also have similar data types
--The columns in every SELECT statement must also be in the same order

SELECT City, Country FROM Customers 
WHERE Country='Germany'
UNION ALL
SELECT City, Country FROM Suppliers
WHERE Country='Germany'
ORDER BY City;

--Mismo número de columnas en cada select statement (2 en este caso)
--Las columnas tienen un tipo de datos similar. 
--El orden en que se escriben las columnas en el select statement debe ser el mismo. 





-- GROUP BY 
-- The GROUP BY statement is often used with aggregate functions (COUNT(), MAX(), MIN(), SUM(), AVG()) to group the result-set by one or more columns.

-- CUENTE CUANTOS CLIENTES HAY POR CADA PAÍS. 
SELECT COUNT(CustomerID), Country 
FROM Customers
GROUP BY Country;-- ACÁ ES DONDE SE AGRUPA POR PAÍS. 

COUNT(CustomerID)	Country
3	                Argentina
2	                Austria
2	                Belgium

-- Lo mismo que el anterior solo que ese conteo lo retorna de forma descendente 
SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country
ORDER BY COUNT(CustomerID) DESC;



-- CUENTA CUANTAS ORDENES HAN SIDO REGISTRADAS POR CADA SHIPPER. 
SELECT Shippers.ShipperName, COUNT(Orders.OrderID) AS NumberOfOrders 
FROM Orders -- tabla de la izquierda de la cual queremos saber si la orden tiene asociado un shipper 
LEFT JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID
GROUP BY ShipperName;


-- Devuelve todos los records de la tabla Orders y ahí mira el shiper asociado a esa orden. Luego lo agrupamos por el nombre de cada Shipper. 


--HAVING 
-- CONTAMOS LOS NUMEROS DE CLIENTES EN CADA PAIS Y DEVOLVEMOS SOLO AQUELLOS DONDE AQUEL CONTEO SEA MAYOR A 5 
SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country
HAVING COUNT(CustomerID) > 5;



-- Registra a los empleados que hayan hecho más de 10 ordenes 
SELECT Employees.LastName, COUNT(Orders.OrderID) AS NumberOfOrders
FROM Orders
INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID-- miramos que haya un match entre la tabla ordenes y la de empleados con base al empleado. Solo aquellos que aparezcan en las dos tablas se contarán 
GROUP BY LastName
HAVING COUNT(Orders.OrderID) > 10;


-- CASE STATEMENT 
-- The CASE statement goes through conditions and returns a value when the first condition is met (like an if-then-else statement).
-- So, once a condition is true, it will stop reading and return the result. 
-- If no conditions are true, it returns the value in the ELSE clause.
-- If there is no ELSE part and no conditions are true, it returns NULL.

SELECT OrderID, Quantity,
CASE
    WHEN Quantity > 30 THEN 'The quantity is greater than 30'
    WHEN Quantity = 30 THEN 'The quantity is 30'
    ELSE 'The quantity is under 30'
END AS QuantityText
FROM OrderDetails;

OrderID	Quantity	QuantityText
10248	12	        The quantity is under 30
10248	10	        The quantity is under 30
10248	5	          The quantity is under 30
10253	20	        The quantity is under 30
10253	42	        The quantity is greater than 30
10253	40	        The quantity is greater than 30
-- Sirve como para clasificar los registros en ciertos grupitos  y ya 




--TUTORIAL KAGGLE 

--https://www.kaggle.com/dansbecker/getting-started-with-sql-and-bigquery

--CTE : common table expressions. 

WITH regional_sales AS ( -- regional_sales es otra tabla 
        SELECT region, SUM(amount) AS total_sales
        FROM orders -- orders es una tabla 
        GROUP BY region
     ), top_regions AS ( -- top_regions es una tabla 
        SELECT region
        FROM regional_sales
        WHERE total_sales > (SELECT SUM(total_sales)/10 FROM regional_sales)
     )
SELECT region,
       product,
       SUM(quantity) AS product_units,
       SUM(amount) AS product_sales
FROM orders -- orders es una tabla 
WHERE region IN (SELECT region FROM top_regions)
GROUP BY region, product;

--Explicación. 

--PARTIENDO DE ARRIBA HACIA ABAJO 

WITH regional_sales AS ( -- regional_sales es otra tabla 
        SELECT region, SUM(amount) AS total_sales
        FROM orders -- orders es una tabla 
        GROUP BY region

-- Declaramos regional_sales cómo una tabla la cual se define cómo : 
-- seleccionamos la columna región y la suma de la columna amount se define con el nombre de total_sales 
-- Todo esto de la tabla orders 
-- Agrupado por la región
-- Obteniendo las ventas por región y los guardamos en una tabla que se llama regional_sales
-- Esta tabla tiene dos columnas, region y total_sales 



 top_regions AS ( -- top_regions es una tabla 
        SELECT region
        FROM regional_sales
        WHERE total_sales > (SELECT SUM(total_sales)/10 FROM regional_sales)

-- De la tabla anterior (regional_sales), seleccionamos la columna region 
-- Se guardarán los registros donde las ventas totales sean mayores a suma de las ventas totales/10 
-- Esto se guardará en una tabla llamada top_regions 
-- Las regiones que cumplan con esa condición se guardaran en la tabla top_regions



SELECT region,
       product,
       SUM(quantity) AS product_units,
       SUM(amount) AS product_sales
FROM orders -- orders es una tabla 
WHERE region IN (SELECT region FROM top_regions) 
GROUP BY region, product;


-- Para que la region de la tabla orders se guarde, debe encontrarse dentro de las regiones de la tabla top_regions 
-- Agrupamos por region y por producto 

WITH RECURSIVE t(n) AS (
    VALUES (1)
  UNION ALL
    SELECT n+1 FROM t WHERE n < 100
)
SELECT sum(n) FROM t;


-- Según entiendo la tabla se llama t 
-- Tiene una columna llamada n 
-- Inicializamos poniendole un registro con el valor de 1 
-- Seleccionamos el valor n+1 
-- Luego sumamos todos los valores desde n hasta 100 

-- In the example above, the working table has just a single row in each step, and it takes on the values from 1 through 100 in successive steps. In the 100th step, there is no output because of the WHERE clause, and so the query terminates.



-- A useful example is this query to find all the direct and indirect sub-parts of a product, given only a table that shows immediate inclusions: 

WITH RECURSIVE included_parts(sub_part, part, quantity) -- así entiendo que se definen las columnas de esa nueva tabla 
    AS (
    SELECT sub_part, part, quantity 
	FROM parts 
	WHERE part = 'our_product'
  UNION ALL
    SELECT p.sub_part, p.part, p.quantity
    FROM included_parts pr, parts p
    WHERE p.part = pr.sub_part
  )
SELECT sub_part, SUM(quantity) as total_quantity
FROM included_parts -- la tabla que se creo anteriormente 
GROUP BY sub_part -- agrupelas por subpartes 


WITH RECURSIVE included_parts(sub_part, part, quantity) -- así entiendo que se definen las columnas de esa nueva tabla 
    AS (
    SELECT sub_part, part, quantity 
	FROM parts  -- tabla parts 
	WHERE part = 'our_product'

-- se crea una tabla que se llama included_parts
-- tiene tres columnas  sub_part, part, quantity
-- Los valores de estas columnas se sacarán de :
-- La tabla parts 
-- Con estas tres columnas  SELECT sub_part, part, quantity  
-- Donde part = 'our_product'

-- Esto se unirá completamente aceptando valores repetidos con 
SELECT p.sub_part, p.part, p.quantity
    FROM included_parts pr, parts p
    WHERE p.part = pr.sub_part

-- donde las subpartes de la tabla included_parts sean iguales a las partes de la tabla part 
)
SELECT sub_part, SUM(quantity) as total_quantity
FROM included_parts -- la tabla que se creo anteriormente 
GROUP BY sub_part -- agrupelas por subpartes 






--WINDOW FUNCTIONS 

-- Utiles para hacer reportes. 

--Duration – Duration of trip
--Start Date – Includes start date and time
--End Date – Includes end date and time
--Start Station – Includes starting station name and number
--End Station – Includes ending station name and number
--Bike Number – Includes ID number of bike used for the trip
--Member Type – Indicates whether user was a "registered" member (Annual Member, 30-Day Member or Day Key Member) or a "casual" rider (Single Trip, 24-Hour Pass, 3-Day Pass or 5-Day Pass)

--Una función de ventana lleva a cabo un calculo a lo largo de un conjunto de filas 
--Las cuales están relacionadas de alguna forma con la fila en cuestion

-- EJEMPLOS 
SELECT
Maker, 
Price, 
RANK() 
OVER (ORDER BY Price) as RankValue
FROM CAR_MAKERS;

-- Esto sería seleccione las columnas marker y price
-- Ranquee sobre el orden del precio de forma ascendente
-- Llame a esa columna del ranqueo como RankValue

Maker	Price	RankValue
Fiat	40000	1
Honda	40000	1
Toyota	45000	3

-- Se devuelve en la columna rankvalue los números del 1 hasta n 
-- Donde se repiten los números si el valor en la columna descrita para ranquear es igual.

SELECT
Maker, 
ProductionYear, 
Price, 
RANK() -- se salta números. 
OVER (PARTITION BY ProductionYear ORDER BY Price) 
as RankValue
FROM CAR_MAKERS;


Maker	        ProductionYear	Price	RankValue
Citroen	                2015	50000	1
Volkswagen	            2015	70000	2
Ford Motor Company     	2015	80000	3
BMW	                    2015	100000	4
Fiat	                2017	40000	1
Honda	                2017	40000	1
Nissan Motors	        2017	50000	3



-- Se hace el rankeo sobre la columna de precio y se hace la partición de los registros con base en el año de producción. 
-- Particione los datos con base al año de producción. 
-- Luego dentro de cada uno de esos grupos rankeelos con base en el precio. 

SELECT
Maker, 
ProductionYear, 
Price, 
DENSE_RANK() -- no se salta ningún número 
OVER (PARTITION BY ProductionYear ORDER BY Price) 
as DenseRankValue
FROM CAR_MAKERS;


Maker	                  ProductionYear	Price	DenseRankValue
Citroen                          	2015	50000	1
Volkswagen	                        2015	70000	2
Ford Motor Company	                2015	80000	3
BMW	                                2015	100000	4
Fiat	                            2017	40000	1
Honda	                            2017	40000	1
Nissan Motors	                    2017	50000	2
Opel	                            2017	65000	3
Daimler Benz	                    2017	110000	4


-- ROW NUMBER SIMPLEMENTE LE ASIGNA UN NUMERO A CADA FILA. 
SELECT
CountryName, 
Continent,
ROW_NUMBER() OVER () as RowNumberValue
FROM COUNTRIES;


CountryName	Continent	RowNumberValue
USA              	1	1
Germany	            2	2
France	            2	3
Japan	            3	4
Italy	            2	5
Sweden	            2	6



SELECT
Maker, 
ProductionYear, 
Price, 
ROW_NUMBER() 
OVER (PARTITION BY ProductionYear ORDER BY Price) 
as RowNumberValue
FROM CAR_MAKERS;


Maker	                  ProductionYear	Price	 RowNumberValue
Citroen                          	2015	50000	1
Volkswagen	                        2015	70000	2
Ford Motor Company	                2015	80000	3
BMW	                                2015	100000	4
Fiat	                            2017	40000	1
Honda	                            2017	40000	2
Nissan Motors	                    2017	50000	3
Opel	                            2017	65000	4
Daimler Benz	                    2017	110000	5




SELECT
Maker, 
ProductionYear, 
Country, 
TotalCountrySales,
SUM(TotalCountrySales) 
OVER (PARTITION BY ProductionYear) as SumValue,
COUNT(TotalCountrySales) 
OVER (PARTITION BY ProductionYear) as CountValue,
AVG(TotalCountrySales) 
OVER (PARTITION BY ProductionYear) as AvgValue
FROM CAR_MAKERS cm JOIN COUNTRIES c 
ON cm.Country = c.CountryID;


Maker	                        ProductionYear	Country	TotalCountrySales	SumValue	CountValue	AvgValue
Volkswagen	                              2015	      2	               95	360	                  4	90.0000
BMW	                                      2015     	  2	               95	360	                  4	90.0000
Ford Motor Company	                      2015	      1	               90	360	                  4	90.0000
Citroen                                   2015	      3	               80	360	                  4	90.0000
Nissan Motors	                          2017	      4	               60	385	                  5	77.0000
Fiat	                                  2017	      5	               75	385	                  5	77.0000



SELECT Customercity, 
       CustomerName, 
       OrderAmount, 
       AVG(Orderamount) OVER(PARTITION BY Customercity) AS AvgOrderAmount, -- calcule el promedio del monto de la orden sobre la partición con base a la ciudad del cliente. 
       MIN(OrderAmount) OVER(PARTITION BY Customercity) AS MinOrderAmount, 
       SUM(Orderamount) OVER(PARTITION BY Customercity) TotalOrderAmount
FROM [dbo].[Orders];

-- Según entiendo, acá a cada registro se le colocá el correspondiente avg, min y total order. No se colapsan los registros como en el caso del groupby sino que se dejan intactos. 
-- Podemos utilizar la cláusula SQL PARTITION BY con la cláusula OVER para poder especificar la columna en la que necesitamos efectuar la agregación. En el ejemplo anterior, utilizamos Agrupar por, con la columna CustomerCity y calculamos los valores promedio, mínimo y máxim
--PARTITION BY columna: En este ejemplo, queremos particionar datos en la columna CustomerCity



-- Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name). If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.
SELECT *
FROM
    (SELECT CITY, LENGTH(CITY) 
    FROM STATION
    ORDER BY LENGTH(CITY), CITY) -- retorna la ciudad con el nombre más corto 
WHERE ROWNUM = 1
UNION
SELECT *
FROM
    (SELECT CITY, LENGTH(CITY)
    FROM STATION
    ORDER BY LENGTH(CITY) DESC, CITY) -- retorna la ciudad con el nombre más largo 
    -- primero ordena por la longitud del nombre y luego por orden alfabético. 
WHERE ROWNUM = 1


SELECT DISTINCT CITY 
FROM STATION 
WHERE CITY LIKE 'a%' OR CITY LIKE 'e%' OR CITY LIKE 'i%' OR CITY LIKE 'o%' OR CITY LIKE 'u%'

SELECT DISTINCT city FROM station WHERE city REGEXP "^[aeiou].*";

SELECT DISTINCT CITY FROM STATION WHERE RIGHT(CITY,1) IN ('a','i','e','o','u');-- right extrae la cantidad de caracteres que se le indique comenzando desde la derecha osea desde el final. 



SELECT DISTINCT CITY 
FROM STATION 
WHERE CITY NOT REGEXP '^[AEIOU]' OR CITY NOT REGEXP '[AEIOU]$';

SELECT 
    ROUND(MIN(LAT_N), 4)
FROM
    STATION
WHERE
    LAT_N > 38.7780;



--Given the CITY and COUNTRY tables, query the names of all cities where the CONTINENT is 'Africa'.
--Note: CITY.CountryCode and COUNTRY.Code are matching key columns.

SELECT CITY.NAME 
FROM CITY 
LEFT JOIN COUNTRY ON CITY.COUNTRYCODE = COUNTRY.CODE
WHERE COUNTRY.CONTINENT = 'Africa'



--Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) and their respective average city populations (CITY.Population) rounded down to the nearest integer. 
SELECT COUNTRY.CONTINENT, FLOOR(AVG(CITY.POPULATION))
FROM CITY INNER JOIN COUNTRY
ON CITY.COUNTRYCODE = COUNTRY.CODE
GROUP BY COUNTRY.CONTINENT;



SELECT IF(GRADE < 8, NULL, NAME), GRADE, MARKS
FROM STUDENTS JOIN GRADES
WHERE MARKS BETWEEN MIN_MARK AND MAX_MARK
ORDER BY GRADE DESC, NAME

-- si la calificación es menor ponga null de lo contrario deje el nombre 

SELECT
   CASE WHEN G.Grade > 7 THEN S.Name 
   ELSE 'NULL' 
   END AS NameOrNull
    , G.Grade
    , S.Marks
FROM Students S
JOIN Grades G ON S.Marks BETWEEN G.Min_Mark AND G.Max_Mark
ORDER BY G.Grade DESC, NameOrNull ASC, S.Marks ASC;




--HACKER TIENE EL ID Y EL NOMBRE ESO ES LO QUE TOCA DEVOLVER 
-- EL CHALLENGE TIENE UN NIVEL DE DIFICULTAD Y UN PUNTAJE EL CUAL DEBE SER COMPLETO 

-- UNA COSA ES EL SCORE DE LA SUMISIÓN Y OTRA EL SCORE DEL CHALLENGE 
-- HAY QUE VER QUE ESTOS DOS VALORES SEAN IGUALES. 

-- DEBE HABER UN FULL SCORE PARA MÁS DE UN CHALLENGE 


--UN HACKER HACE LA SUMISIÓN EN LA TABLA SUBMISSIONS (S)
--DEBO VER EL ID DEL CHALLENGE (S.CHALLENGE_ID)Y SU CORRESPONDIENTE SCORE (S.SCORE)
--LUEGO VOY Y MIRO EN LA TABLA CHALLENGES (C) EL NIVEL DE DIFICULTAD (C.DIFFICULTY_LEVEL) QUE CORRESPONDE A ESE CHALLENGE_ID (C.CHALLENGE_ID)
--EN LA TABLA DIFFICULTY (D) MIRO CON ESE DIFFICULTY LEVEL(D.DIFFICULTY_LEVEL) CUAL ES EL SCORE QUE CORRESPONDE (D.SCORE)
-- (D.SCORE = S.CORE) SI EL PUNTAJE DE LA SUMISIÓN DEL HACKER (S.SCORE) ES IGUAL A LA DEL CHALLENGE(D.SCORE) CUENTA COMO UN FULL SCORE 
-- GUARDO EL NOMBRE DE ESE HACKER (H.NAME) Y SU ID (H.HACKER_ID)
-- DEVUELVO SOLO EL NOMBRE Y EL ID DEL HACKER QUE TENGA MÁS DE UN FULL SCORE 

SELECT S.CHALLENGE_ID , S.SCORE
FROM SUBMISSIONS S
INNER JOIN CHALLENGES C ON S.CHALLENGE_ID = C.CHALLENGE_ID
WHERE 




select h.hacker_id, h.name
from submissions s
inner join challenges c on s.challenge_id = c.challenge_id-- se revisan los id en la tabla sumission y challenge 
inner join difficulty d on c.difficulty_level = d.difficulty_level -- los dos niveles de dificultad  en la tabla de de dificultad y challenges 
inner join hackers h on s.hacker_id = h.hacker_id -- el id del hacker en la sumisipn es igual que en el de la tabla hackers 
where s.score = d.score and c.difficulty_level = d.difficulty_level --el score en sumisión debe ser igual a la que aparece en difficulty al igual que la dificultad de los niveles 
group by h.hacker_id, h.name -- se agrupa todo por id y nombre 
having count(s.hacker_id) > 1 -- el id del hacker debe haber sido contado más de una vez 
order by count(s.hacker_id) desc, s.hacker_id asc


select h.hacker_id,h.name 
from hackers h, challenges c ,difficulty d,submissions s 
where h.hacker_id=s.hacker_id and c.challenge_id=s.challenge_id and c.difficulty_level=d.difficulty_level and s.score=d.score
group by h.hacker_id,h.name 
having  count(h.hacker_id)>1
order by count(c.challenge_id) desc,h.hacker_id


/* count total submissions of challenges of each user */
WITH data
AS
(
SELECT c.hacker_id as id, h.name as name, count(c.hacker_id) as counter
FROM Hackers h
JOIN Challenges c on c.hacker_id = h.hacker_id
GROUP BY c.hacker_id, h.name
-- contamos cuantas veces aparece el hacker_id en la tabla challenges y luego agrupamos eso por cada id y nombre 

id :1001 4veces 
id :2001 5veces 
)
/* select records from above */
SELECT id,name,counter
FROM data
WHERE counter=(SELECT max(counter) FROM data) /*select user that has max count submission*/
OR 
counter in (SELECT counter FROM data
GROUP BY counter
HAVING count(counter)=1 ) /*filter out the submission count which is unique*/
ORDER BY counter desc, id




SELECT CEIL((AVG(salary)) - (AVG(REPLACE(salary, '0', '')))) AS avg_salary -- replace quita todos los ceros de la columna números. 
FROM employees;



select w.id, p.age, w.coins_needed, w.power 
from Wands as w 
join Wands_Property as p on (w.code = p.code) 
where p.is_evil = 0 and w.coins_needed = (
                                          select min(coins_needed) 
                                          from Wands as w1 
                                          join Wands_Property as p1 on (w1.code = p1.code) 
                                          where w1.power = w.power and p1.age = p.age) 
order by w.power desc, p.age desc



-- Samantha interviews many candidates from different colleges using coding challenges and contests. Write a query to print the contest_id, hacker_id, name, and the sums of total_submissions, total_accepted_submissions, total_views, and total_unique_views for each contest sorted by contest_id. Exclude the contest from the result if all four sums are .


-- cada prueba tiene algún challenge asignado a un colegio 

-- El concurso con id 66406 en la (tabla contest, columna contest_id ) es usado en el college con id 11219 (tabla colleges, columna college_id)

-- Ese college en la tabla (challenges table)  tiene asociado dos challenges el 18765 y el 47127 (columna challenge_id de la tabla challenges )

-- tenemos dos challenge id 18765 y 47127 

-- en la tabla submission_stats y view stars  hay que revisar que se encuentre alguno de esos challenge id 


WITH SUM_View_Stats AS (
SELECT challenge_id
    , total_views = sum(total_views)
    , total_unique_views = sum(total_unique_views)
FROM View_Stats 
GROUP BY challenge_id
)-- de la tabla view stats tomamos el challenge id , la suma de las total views y la suma de los unique views y las agrupamos por challenge_id 
,SUM_Submission_Stats AS (
SELECT challenge_id
    , total_submissions = sum(total_submissions)
    , total_accepted_submissions = sum(total_accepted_submissions)
FROM Submission_Stats 
GROUP BY challenge_id -- de la tabla challenge_id tomamos el challenge id , la suma de las total submissions  y la suma de total_accepted_submissions y las agrupamos por challenge_id 
)

SELECT    con.contest_id
        , con.hacker_id
        , con.name
        , SUM(total_submissions)
        , sum(total_accepted_submissions)
        , sum(total_views)
        , sum(total_unique_views)
FROM Contests con
INNER JOIN Colleges col  ON con.contest_id = col.contest_id
INNER JOIN Challenges cha ON cha.college_id = col.college_id
LEFT JOIN SUM_View_Stats vs ON vs.challenge_id = cha.challenge_id
LEFT JOIN SUM_Submission_Stats ss ON ss.challenge_id = cha.challenge_id
GROUP BY con.contest_id,con.hacker_id,con.name
HAVING (SUM(total_submissions)
        +sum(total_accepted_submissions)
        +sum(total_views)
        +sum(total_unique_views)) <> 0
ORDER BY con.contest_ID

-- https://www.sqlshack.com/learn-sql-inner-join-vs-left-join/



-- hackers no repetidos que hicieron almenos una sumisión al día 
-- encuentre el hacker_id y name  que hizo el mayor número de sumisiones cada día 
-- se debe presentar esta información por cada día del concurso organizado por la fecha 


-- agrupar por hacker_id 

select submission_date, count(DISTINCT(hacker_id)) as different_person , hacker_id,  
from submissions 
group by  hacker_id 
order by submission_date

-- cómo saber si la persona ha sometido almenos una vez al día. 


-- si el id del hacker aparece al menos una vez en cada fecha distinta entonces vale 

select hacker_id 
from submission
where hacker_id in (select hacker_id, count(submission_id)
                    from submission
                    GROUP by  hacker_id)

-- como saber cual es el hacker que más sumisiones hizo en un día 

select hacker_id, count(submission_id) as num_submission 
from submission
GROUP by  hacker_id
order by num_submission desc 
limit 1 


-- en el día 1 el hacker tal hizo tantas sumisiones 


-- cuente cuantas personas distintas hicieron una sumision en cierto día 
select hacker_id , count(DISTINCT hacker_id) as different_person
from submission
group by submission_date
-- esto devolvería 4 personas en el día 2016-03-01


-- para que el hacker cuente debe haber hecho una sumisión almenos cada día 



select submission_date ,( SELECT COUNT(distinct hacker_id)  -- cuenta cuantos hackers distintos hay 
                        FROM Submissions s2  
                        WHERE s2.submission_date = s1.submission_date AND -- self join con la misma tabla 
                                                                          (SELECT COUNT(distinct s3.submission_date) -- cuenta cuantas fechas distintas hay 
                                                                           FROM Submissions s3 
                                                                           WHERE s3.hacker_id = s2.hacker_id -- el id del hacker sea el mismo que en el de la fecha pasada 
                                                                           AND  s3.submission_date < s1.submission_date) = dateDIFF(s1.submission_date , '2016-03-01')) , -- esto sería otra columna de la respuesta 

                        (select hacker_id  
                        from submissions s2 
                        where s2.submission_date = s1.submission_date 
                        group by hacker_id 
                        order by count(submission_id) desc , hacker_id limit 1) as hack,-- esto sería otra columna de la respuesta. 

                        (select name 
                        from hackers 
                        where hacker_id = hack)
from 
    (select distinct submission_date 
    from submissions) s1
group by submission_date;





SELECT SUBMISSION_DATE,-- obtenemos todas las fechas distintas del concurso 

      (SELECT COUNT(DISTINCT HACKER_ID)
       FROM SUBMISSIONS AS SUB2
       WHERE SUB2.SUBMISSION_DATE=SUB1.SUBMISSION_DATE
             AND (SELECT COUNT(DISTINCT SUBMISSION_DATE) -- el número de fechas distintas previo al día en el que estamos. el día en el que estamos entiendo que está determinado por sub1 
                  FROM SUBMISSIONS AS SUB3
                  WHERE SUB3.HACKER_ID=SUB2.HACKER_ID
                        AND SUB3.SUBMISSION_DATE<SUB1.SUBMISSION_DATE) = DATEDIFF(SUB1.SUBMISSION_DATE,'2016-03-01')), -- donde las submission3 que sean menores a las submission1 sean igual a la diferencia entre la sub1 y la fecha de inicio del concurso. 
                                  
      (SELECT HACKER_ID -- se obtiene el hacker que hizo mas sumisiones ese dia 
       FROM SUBMISSIONS AS SUB4
       WHERE SUB4.SUBMISSION_DATE=SUB1.SUBMISSION_DATE
       GROUP BY HACKER_ID
       ORDER BY COUNT(SUBMISSION_ID) DESC, HACKER_ID LIMIT 1) AS HID,
        
      (SELECT NAME-- obtiene el nombre del hacker que cumpla la condición dada. 
       FROM HACKERS
       WHERE HACKER_ID=HID)
        
FROM (SELECT DISTINCT SUBMISSION_DATE 
      FROM SUBMISSIONS) AS SUB1-- esta tabla guarda todas las fechas distintas del concurso 

--tabla sub1 : todas las fechas distintas del concurso 


(SELECT COUNT(DISTINCT HACKER_ID) -- contamos el número de hackers distintos hicieron una sumision ese día. 
FROM SUBMISSIONS AS SUB2 -- otro alias para la tabla 
WHERE SUB2.SUBMISSION_DATE=SUB1.SUBMISSION_DATE -- donde la fecha de la tabla sub2 concuerde con la de la tabla sub1 
      AND (SELECT COUNT(DISTINCT SUBMISSION_DATE) -- contamos cuantas fechas de sumision distintas hay para cada hacker 
           FROM SUBMISSIONS AS SUB3
           WHERE SUB3.HACKER_ID=SUB2.HACKER_ID
                AND SUB3.SUBMISSION_DATE<SUB2.SUBMISSION_DATE) = DATEDIFF(SUB1.SUBMISSION_DATE,'2016-03-01')),-- el numero de fechas de sumision distintas para cada hacker antes de la fecha actual   sea igual a cuantos días estamos del comienzo del concurso. 
                -- es decir si han pasado cuatro días desde que empezó el concurso , el número de fechas de sumisión distintas que debe tener el hacker deben ser 4. 

-- you are counting the number of distinct hackers (from the same base table, but this time listed as sub2), where BOTH the date (from sub2) matches the date in the main query (sub1) - (so basically, how many distinct hackers submitted that day) 
--  AND they only count towards that total if this condition is also true) the number of distinct submission dates (count them from same base table, but this time as sub3) for each hacker (sub3.hacker_id=sub2.hacker_id) PRIOR to the current date (sub3.submission_date < sub2.submission_date) - matches how many days we are BEYOND the start date (datediff).   
           


select h.hacker_id, h.name, total_score
from 

-- agrupo el resultado por hacker 

-- debo pedir el id del challenge y su correspondiente puntaje 
-- si hay más de un id debo pedir el máximo. 


select 
group by hacker_id 



SELECT h.hacker_id, h.name, SUM(score) 
FROM ( SELECT hacker_id, challenge_id, MAX(score) AS score 
       FROM SUBMISSIONS
       GROUP BY hacker_id, challenge_id )t -- seleccione el hacker_id, el challenge_id y el máximo puntaje obtenido en ese challenge 
                                           -- agrupamos también por el hacker_id y el challenge_id 

JOIN Hackers h on t.hacker_id = h.hacker_id
GROUP BY h.hacker_id, h.name
HAVING SUM(score) > 0 -- la suma debe ser mayor a 0 
ORDER BY SUM(score) desc, h.hacker_id





SELECT AVG(B.TotalBonus)
FROM   (SELECT   TerritoryID,
                 SUM(Bonus) AS TotalBonus
        FROM     Sales.SalesPerson
        GROUP BY TerritoryID) AS B

-- primero obtenemos las ventas por territorio y luego a eso le sacamos el promedio. 

-- https://www.essentialsql.com/introduction-to-subqueries/



-- A typical use for a correlated subquery is used one of the outer query’s columns in the inner query’s WHERE clause.  
--This is common sense in many cases you want to restrict the inner query to a subset of data.








SET sql_mode = '';
SELECT Start_Date , End_Date -- estas se sacan de los selects consecuentes. 
FROM 
    (SELECT Start_Date 
     FROM Projects 
     WHERE Start_Date NOT IN (SELECT End_Date FROM Projects)) a,
     
    (SELECT End_Date 
     FROM Projects 
     WHERE End_Date NOT IN (SELECT Start_Date FROM Projects)) b 
     
WHERE Start_Date < End_Date -- las fechas de inicio deben ser menores a las de fin 
GROUP BY Start_Date -- agrupamos por fecha de inicio 
ORDER BY DATEDIFF(End_Date, Start_Date), Start_Date -- ordenamos por la diferencia entre la fecha de fin y la fecha de inicio de forma asc 


SELECT Start_Date 
FROM Projects 
WHERE Start_Date NOT IN (SELECT End_Date FROM Projects)) -- seleccione las fechas inicio que no se encuentren en la columna de fin 

(SELECT End_Date 
FROM Projects 
WHERE End_Date NOT IN (SELECT Start_Date FROM Projects)) b -- seleccione las fechas de fin  que no se encuentren en la columna de inicio 



SET sql_mode = '';
SELECT Start_Date, End_Date, DATEDIFF(End_Date,Start_Date) as project_duration 
FROM 
    (SELECT Start_Date 
    FROM Projects 
    WHERE Start_Date NOT IN (SELECT End_Date FROM Projects)) a,

    (SELECT End_Date 
    FROM Projects 
    WHERE End_Date NOT IN (SELECT Start_Date FROM Projects)) b 
WHERE Start_Date < End_Date
GROUP BY Start_Date 
ORDER BY DATEDIFF(End_Date, Start_Date), Start_Date


SELECT p.name
FROM phones p 
Left join  calls c on p.phone_number = c.caller
Group by p.name 
HAVING  SUM(c.duration) > 10
