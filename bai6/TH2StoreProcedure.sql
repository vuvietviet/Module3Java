use classicModels;

delimiter //
DROP PROCEDURE IF EXISTS `findAllCustomers`//
create procedure findAllCustomers()
begin
	SELECT * FROM customers;
end //
delimiter ;

call findAllCustomers();

DELIMITER //
DROP PROCEDURE IF EXISTS `findAllCustomers`//

CREATE PROCEDURE findAllCustomers()

BEGIN

SELECT * FROM customers where customerNumber = 175;

END //
delimiter ;