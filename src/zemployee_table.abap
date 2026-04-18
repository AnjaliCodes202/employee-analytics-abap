@EndUserText.label : 'Employee Table'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #ALLOWED
define table zemployee {

  key client : abap.clnt not null;
  key emp_id : abap.int4 not null;
  name       : abap.char(20);
  department : abap.char(20);
  salary     : abap.int4;
  experience : abap.int4;

}
