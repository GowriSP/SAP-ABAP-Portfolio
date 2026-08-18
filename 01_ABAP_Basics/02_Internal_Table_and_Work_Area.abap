REPORT z_internal_table_demo.

*---------------------------------------------------------------------*
* Program : Z_INTERNAL_TABLE_DEMO
* Purpose : Demonstration of Internal Table and Work Area
*---------------------------------------------------------------------*

TYPES: BEGIN OF ty_employee,
         emp_id   TYPE i,
         name     TYPE string,
         dept     TYPE string,
         salary   TYPE p DECIMALS 2,
       END OF ty_employee.

DATA:
  gs_employee TYPE ty_employee,
  gt_employee TYPE STANDARD TABLE OF ty_employee.

*---------------------------------------------------------------------*
* Populate Internal Table
*---------------------------------------------------------------------*

gs_employee-emp_id = 1001.
gs_employee-name   = 'Arun'.
gs_employee-dept   = 'SAP BASIS'.
gs_employee-salary = '50000.00'.
APPEND gs_employee TO gt_employee.

CLEAR gs_employee.

gs_employee-emp_id = 1002.
gs_employee-name   = 'Priya'.
gs_employee-dept   = 'SAP ABAP'.
gs_employee-salary = '55000.00'.
APPEND gs_employee TO gt_employee.

CLEAR gs_employee.

gs_employee-emp_id = 1003.
gs_employee-name   = 'Karthi'.
gs_employee-dept   = 'SAP HANA'.
gs_employee-salary = '60000.00'.
APPEND gs_employee TO gt_employee.

*---------------------------------------------------------------------*
* Display Internal Table Data
*---------------------------------------------------------------------*

WRITE: / '------------------------------------------------------------'.
WRITE: / '                 EMPLOYEE DETAILS'.
WRITE: / '------------------------------------------------------------'.

LOOP AT gt_employee INTO gs_employee.

  WRITE: / 'Employee ID :', gs_employee-emp_id,
         ' Name :', gs_employee-name,
         ' Department :', gs_employee-dept,
         ' Salary :', gs_employee-salary.

ENDLOOP.

WRITE: / '------------------------------------------------------------'.
