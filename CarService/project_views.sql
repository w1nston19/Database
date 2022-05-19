/*View to connect part with partition order and get the total price of each part*/
/*CREATE VIEW V_PARTITION_ORDER_MAP
AS
SELECT P.PART_ID, P.NAME, P.TOTAL_PRICE, PO.ORDER_ID, PO.message
	FROM (SELECT ID AS PART_ID, NAME, price + replacement_price AS TOTAL_PRICE FROM PARTS ) P, 
	     partition_order_parts_mapping M, 
		 (SELECT ID AS ORDER_ID, MESSAGE FROM partition_order) PO
	WHERE P.PART_ID = M.part_id AND M.order_id = PO.ORDER_ID
	*/

/*View to easily get the price for specific order .*/
CREATE VIEW V_CALCULATE_TOTAL_PRICE
AS
SELECT ORDER_ID, SUM(MAP.TOTAL_PRICE) AS TOTAL_PRICE
	FROM (SELECT ID AS ROREDER_ID, vehicle_id  FROM repairment_order) RO 
		  JOIN (SELECT ID AS VE_ID, MODEL, OWNER_ID FROM vehicle) V ON RO.vehicle_id = V.VE_ID
		  JOIN (SELECT ID AS O_ID FROM OWNER) O ON V.owner_id = O.O_ID
		  JOIN (SELECT ID AS PORDER_ID FROM partition_order) PO ON O.O_ID = PO.PORDER_ID
		  JOIN V_PARTITION_ORDER_MAP MAP ON PO.PORDER_ID = MAP.ORDER_ID
GROUP BY ORDER_ID
