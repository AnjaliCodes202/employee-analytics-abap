CLASS zcl_employee_insert DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

ENDCLASS.



CLASS zcl_employee_insert IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA: ls_emp TYPE zemployee.

    "Clear old data to avoid duplicates
    DELETE FROM zemployee.
    COMMIT WORK.

    DO 150 TIMES.

      ls_emp-client = sy-mandt.
      ls_emp-emp_id = sy-index.
      ls_emp-name   = |Emp{ sy-index }|.

      CASE sy-index MOD 3.
        WHEN 0.
          ls_emp-department = 'IT'.
        WHEN 1.
          ls_emp-department = 'HR'.
        WHEN 2.
          ls_emp-department = 'Finance'.
      ENDCASE.

      ls_emp-salary = 30000 + ( sy-index * 100 ).
      ls_emp-experience = sy-index MOD 10.

      INSERT zemployee FROM @ls_emp.

    ENDDO.

    COMMIT WORK.

    out->write( '150 Employees Inserted Successfully' ).

  ENDMETHOD.

ENDCLASS.