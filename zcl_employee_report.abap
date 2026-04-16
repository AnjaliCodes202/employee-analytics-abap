CLASS zcl_employee_report DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

ENDCLASS.



CLASS zcl_employee_report IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    TYPES: BEGIN OF ty_employee,
             emp_id     TYPE zemployee-emp_id,
             name       TYPE zemployee-name,
             department TYPE zemployee-department,
             salary     TYPE zemployee-salary,
             experience TYPE zemployee-experience,
             bonus      TYPE decfloat16,
             category   TYPE string,
           END OF ty_employee.

    DATA: lt_data TYPE STANDARD TABLE OF ty_employee,
          lt_raw  TYPE STANDARD TABLE OF zemployee.

    "Fetch top 50 employees by salary
    SELECT *
      FROM zemployee
      ORDER BY salary DESCENDING
      INTO TABLE @lt_raw
      UP TO 50 ROWS.

    "Process Data
    DATA(ls_data) = VALUE ty_employee( ).

    LOOP AT lt_raw INTO DATA(ls_raw).

      ls_data = VALUE ty_employee(
        emp_id     = ls_raw-emp_id
        name       = ls_raw-name
        department = ls_raw-department
        salary     = ls_raw-salary
        experience = ls_raw-experience
      ).

      "Bonus (10%)
      ls_data-bonus = ls_data-salary * 10 / 100.

      "Category logic
      ls_data-category =
        COND string(
          WHEN ls_data-experience <= 2 THEN 'Junior'
          WHEN ls_data-experience <= 5 THEN 'Mid'
          ELSE 'Senior'
        ).

      APPEND ls_data TO lt_data.

    ENDLOOP.

    "===== REPORT =====
    out->write( '===== EMPLOYEE ANALYTICS REPORT =====' ).

    "Total Employees
    DATA(lv_count) = lines( lt_data ).
    out->write( |Total Employees: { lv_count }| ).

    "Total Salary (optimized)
    DATA(lv_total_salary) =
      REDUCE i( INIT sum = 0
                FOR wa IN lt_data
                NEXT sum = sum + wa-salary ).

    out->write( |Total Salary: { lv_total_salary }| ).
    out->write( '-----------------------------------' ).

    "Display Data
    LOOP AT lt_data INTO DATA(ls_final).

      out->write( |ID: { ls_final-emp_id }| ).
      out->write( |Name: { ls_final-name }| ).
      out->write( |Dept: { ls_final-department }| ).
      out->write( |Salary: { ls_final-salary }| ).
      out->write( |Experience: { ls_final-experience } years| ).
      out->write( |Bonus: { ls_final-bonus }| ).
      out->write( |Category: { ls_final-category }| ).
      out->write( '-----------------------------' ).

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.