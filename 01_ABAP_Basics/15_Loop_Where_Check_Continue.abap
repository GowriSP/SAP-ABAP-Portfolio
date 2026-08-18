REPORT z_loop_where_check_continue.

*---------------------------------------------------------------------*
* Program : Z_LOOP_WHERE_CHECK_CONTINUE
* Purpose : Demonstration of WHERE, CHECK and CONTINUE
*---------------------------------------------------------------------*

TYPES: BEGIN OF ty_employee,
         emp_id TYPE i,
         name   TYPE string,
         dept   TYPE string,
         salary TYPE p DECIMALS 2,
       END OF ty_employee.

DATA:
  gt_employee TYPE STANDARD TABLE OF ty_employee,
  gs_employee TYPE ty_employee.

*---------------------------------------------------------------------*
* Populate Internal Table
*---------------------------------------------------------------------*

gs_employee-emp_id = 1001.
gs_employee-name   = 'Arun'.
gs_employee-dept   = 'BASIS'.
gs_employee-salary = '50000.00'.
APPEND gs_employee TO gt_employee.

gs_employee-emp_id = 1002.
gs_employee-name   = 'Priya'.
gs_employee-dept   = 'ABAP'.
gs_employee-salary = '55000.00'.
APPEND gs_employee TO gt_employee.

gs_employee-emp_id = 1003.
gs_employee-name   = 'Karthi'.
gs_employee-dept   = 'HANA'.
gs_employee-salary = '60000.00'.
APPEND gs_employee TO gt_employee.

gs_employee-emp_id = 1004.
gs_employee-name   = 'Divya'.
gs_employee-dept   = 'ABAP'.
gs_employee-salary = '45000.00'.
APPEND gs_employee TO gt_employee.

*---------------------------------------------------------------------*
* LOOP AT ... WHERE
*---------------------------------------------------------------------*

WRITE: / '--- ABAP Department Employees ---'.

LOOP AT gt_employee INTO gs_employee
  WHERE dept = 'ABAP'.

  WRITE: / gs_employee-emp_id,
           gs_employee-name,
           gs_employee-salary.

ENDLOOP.

SKIP.

*---------------------------------------------------------------------*
* CHECK Statement
*---------------------------------------------------------------------*

WRITE: / '--- Employees with Salary >= 55000 ---'.

LOOP AT gt_employee INTO gs_employee.

  CHECK gs_employee-salary >= 55000.

  WRITE: / gs_employee-emp_id,
           gs_employee-name,
           gs_employee-salary.

ENDLOOP.

SKIP.

*---------------------------------------------------------------------*
* CONTINUE Statement
*---------------------------------------------------------------------*

WRITE: / '--- Employees excluding ABAP Department ---'.

LOOP AT gt_employee INTO gs_employee.

  IF gs_employee-dept = 'ABAP'.
    CONTINUE.
  ENDIF.

  WRITE: / gs_employee-emp_id,
           gs_employee-name,
           gs_employee-dept.

ENDLOOP.
