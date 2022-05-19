/*Заявки за база данни - авто сервиз */
/* Прости заявки - 5 бр.*/
/*1.Имената и ранга на производителите с имена започшащи с 'B' подредени по рейтинг.*/
SELECT M.NAME,
       M.manufacturer_rating
FROM   manufacturer M
WHERE  M.NAME LIKE 'B%'
ORDER  BY M.manufacturer_rating

/*2.Всички части с цена за смяна по-голяма или равна на 400.*/
SELECT *
FROM   parts
WHERE  replacement_price >= 400;

/*3.Имената на служителите със заплата по-голяма или равна на 1500.*/
SELECT W.NAME
FROM   worker W
WHERE  W.salary >= 1500

/*4.Името и възрастта на всички собственици между 18 и 30 години.*/
SELECT NAME,
       age
FROM   owner
WHERE  age > 18
       AND age < 30;

/*5.Средната заплата на работниците.*/
SELECT Avg(salary) AS avgSalary
FROM   worker w 


/* Заявки върху две или повече релации - 5 бр.*/


/* 1.Името и годините на собствениците на превозни средства 'Toyota'. */
select o.name, o.age
from owner o, vehicle v, manufacturer m
where o.id = v.owner_id 
	  and m.id = v.manufacturer_id
	  and m.name = 'Toyota'
order by o.name 

/*2.Всички поръчки за 'airbag'.*/
select po.message
from  partition_order po, partition_order_parts_mapping pm, parts p
where po.id = pm.order_id 
	  and pm.part_id = p.id
	  and p.name = 'Airbag'

/*3. Всички поръчки за поправка и работещите по тях за коли с производител 'Toyota'.*/
select ro.message as repairment_order_message, w.name as worker_name
from vehicle v, repairment_order ro, worker w, manufacturer m
where v.id = ro.vehicle_id and ro.worker_id = w.id
	  and v.manufacturer_id = m.id
	  and m.name = 'Toyota'

/*4. Имената на собствениците на 'Dodge' и моделът, който карат. */
select o.name, v.model
from owner o, vehicle v, manufacturer m
	where o.id = v.owner_id
		  and v.manufacturer_id = m.id
		  and m.name = 'Dodge'
order by o.name

/*5.Имената на работниците, които работят по поръчки за коли с марка 'Oldsmobile'.*/
select w.name as worker, m.name as carBrand
from worker w, repairment_order ro, vehicle v, manufacturer m
	 where w.id = ro.id
		   and ro.vehicle_id = v.id
		   and v.manufacturer_id = m.id
		   and m.name = 'Oldsmobile'

/* Подзаявки - 5 бр.*/

/*1. Моделите на превозни средства на мъже под 50г.*/
SELECT DISTINCT ls.model
FROM vehicle ls, (SELECT * FROM OWNER WHERE age<50 AND gender = 'male')ow
WHERE ls.owner_id = ow.id;

/*2. Моделите на превозни средства на жени над или на 35г.*/
select m.name as carBrand, v.model as model
from vehicle v, manufacturer m
	 where	v.manufacturer_id = m.id
			and v.owner_id in (select o.id
							from owner o
							where o.gender = 'Female'
							and o.age >= 35)

/*3.Имената на работниците, които работят върху модел 'Sienna'*/
SELECT DISTINCT name 
FROM worker
WHERE id IN (SELECT worker_id 
			 FROM repairment_order 
			 WHERE vehicle_id in 
			 (SELECT id from VEHICLE WHERE model='Sienna'));

/*4.Името и възрастта на най-възрастният собственик*/
select o.name as oldest_olner, o.age
from owner o
where o.age >= all(select owner.age from owner)

/*5.Името и цената на всички части по-скъпи от гумите.*/

select name as part_name, parts.price
from parts 
where replacement_price >(select p.replacement_price
						  from parts p
						  where p.name = 'Tires')
order by price desc



/* Заявки със съединения - 5 бр.*/
/*1.Име и възраст на owner-и, които само поръчват части и са под 60г.*/
select o.name, o.age
from owner o left join vehicle v on o.id = v.owner_id
where v.id is null
	  and o.age < 60

/*2.Име на производителя и модел на всички превозни средства на 'Anthe Hearfield'*/
select m.name , v.model
from manufacturer m join vehicle v on m.id = v.manufacturer_id join owner o on v.owner_id = o.id
where o.name = 'Anthe Hearfield'

/*3.Имената на всички работници които не работят по BMW*/
SELECT DISTINCT w.name 
FROM WORKER w
JOIN repairment_order RO ON RO.worker_id=w.id
JOIN vehicle vh ON vh.id = RO.vehicle_id
WHERE vh.manufacturer_id NOT IN (SELECT id FROM manufacturer WHERE name = 'BMW');

/*4.Имената на всички owner-и мъже, над 30г., чиито поръчки за части са готови.*/
SELECT DISTINCT o.name
FROM OWNER o
JOIN partition_order po ON po.owner_id = o.id
JOIN partition_order_history poh ON po.id = poh.partition_order_id
WHERE poh.is_completed = 1
AND o.age>30
AND o.gender = 'male';

/*5.Име на owner, модел на превозното средство, 
съобщение на поръчката за поправка и старт/енд дата 
подредени по старт дата за поръчки направени преди '2022-06-10'*/
select o.name, v.model, ro.message, b.start_date, b.end_date
from owner o join vehicle v on o.id = v.owner_id 
			join repairment_order ro on v.id = ro.id 
			join booking b on ro.id = b.repairment_order_id
where b.start_date < '2022-06-10'
order by b.start_date

/* Заявки с групиране и агрегация - 10 бр.*/

/*1.Поръчки със стойност(сума от цената на всички части + цената за смяната им) по-голяма от 3000.*/
select po.message, sum( p.price + p.replacement_price) as summedPrice
from partition_order po  join partition_order_parts_mapping m on po.id = m.order_id 
						 join parts p on m.part_id = p.id
group by po.message
having sum( p.price + p.replacement_price) >= 3000

/*2.Общата стойност на частите заедно със смяната за поръчка с име 'Gift'*/
select po.message, sum( p.price + p.replacement_price) as summedPrice
from partition_order po  join partition_order_parts_mapping m on po.id = m.order_id join parts p on m.part_id = p.id
group by po.message
having po.message = 'Gift'

/*3. Име на всеки owner и брой на притежаваните превозни средства, подредени по броя.*/
select o.name, count(v.id) as numVehicles
from owner o left join vehicle v on o.id = v.owner_id
group by o.name
order by numVehicles desc

/*4.Съобщенията на поръчките и броя части за тях, ако той е над 3.*/
select po.message, count(p.price) as numberOfParts
from partition_order po join partition_order_parts_mapping m on po.id = m.order_id
						join parts p on m.part_id = p.id
group by po.message
having count(p.price) > 3

/*5. Брой модели от всяка марка.*/
select m.name, count(v.model) as numModels
from manufacturer m left join vehicle v on m.id = v.manufacturer_id
group by m.name 
order by numModels desc

/*6. Брой превозни средства разпределени по пол.*/
select o.gender, count(partition_order_id) as numOrders
from owner o join partition_order po on o.id = po.owner_id 
			 join partition_order_history h on po.id = h.partition_order_id
group by o.gender

/*7. Марки превозни средства и колко работници работят по тях. */
select m.name, count(w.id) as numWorkers
from worker w join repairment_order ro on w.id = ro.worker_id 
			  join vehicle v on ro.vehicle_id = v.id 
			  join manufacturer m on v.manufacturer_id = m.id
group by m.name
order by numWorkers desc

/*8. Изчислява колко би струвала поправката на модел 'Sienna' на 'Eolanda Teresse' със съобщение 'Mitsu'.*/
select ro.message, sum(price + replacement_price) as totalPrice
from repairment_order ro join vehicle v on ro.vehicle_id = v.id 
	join owner o on o.id = v.owner_id 
	join partition_order po on o.id = po.owner_id
	join partition_order_parts_mapping m on po.id = m.order_id
	join parts p on p.id = m.part_id
where o.name = 'Eolanda Teresse'
	  and v.model = 'Sienna'
	  and ro.message = 'Mitsu'
group by ro.message


/*9. Извежда броя производители за всеки ранк.*/
select manufacturer_rating as rating, count(m.name) as numManufacturers
from manufacturer m
group by manufacturer_rating
order by manufacturer_rating desc

/*10. Броя налични части по производители. */
select m.name, count(p.name) as numParts
from manufacturer m join parts p on m.id = p.manufacturer_id
group by m.name 
order by numParts desc