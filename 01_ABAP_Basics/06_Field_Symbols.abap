REPORT z_field_symbols.

*---------------------------------------------------------------------*
* Program : Z_FIELD_SYMBOLS
* Purpose : Demonstration of Field Symbols
*---------------------------------------------------------------------*

TYPES: BEGIN OF ty_employee,
         emp_id TYPE i,
         name   TYPE string,
         dept   TYPE string,
         salary TYPE p DECIMALS 2,
       END OF ty_employee.

DATA:
  gs_employee TYPE ty_employee,
  gt_employee TYPE STANDARD TABLE OF ty_employee.

FIELD-SYMBOLS:
  <fs_employee> TYPE ty_employee.

*---------------------------------------------------------------------*
* Populate Internal Table
*---------------------------------------------------------------------*

gs_employee-emp_id = 1001.
gs_employee-name   = 'Arun'.
gs_employee-dept   = 'SAP BASIS'.
gs_employee-salary = '50000.00'.
APPEND gs_employee TO gt_employee.

gs_employee-emp_id = 1002.
gs_employee-name   = 'Priya'.
gs_employee-dept   = 'SAP ABAP'.
gs_employee-salary = '55000.00'.
APPEND gs_employee TO gt_employee.

gs_employee-emp_id = 1003.
gs_employee-name   = 'Karthi'.
gs_employee-dept   = 'SAP HANA'.
gs_employee-salary = '60000.00'.
APPEND gs_employee TO gt_employee.

*---------------------------------------------------------------------*
* Access Internal Table using Field Symbol
*---------------------------------------------------------------------*

WRITE: / '--- Employee Details ---'.

LOOP AT gt_employee ASSIGNING <fs_employee>.

  WRITE: / 'Employee ID :', <fs_employee>-emp_id,
           'Name :', <fs_employee>-name,
           'Department :', <fs_employee>-dept,
           'Salary :', <fs_employee>-salary.

ENDLOOP.

*---------------------------------------------------------------------*
* Modify Data using Field Symbol
*---------------------------------------------------------------------*

LOOP AT gt_employee ASSIGNING <fs_employee>.

  IF <fs_employee>-emp_id = 1002.

    <fs_employee>-salary = '60000.00'.

  ENDIF.

ENDLOOP.

SKIP.

WRITE: / '--- After Salary Update ---'.

LOOP AT gt_employee ASSIGNING <fs_employee>.

  WRITE: / 'Employee ID :', <fs_employee>-emp_id,
           'Name :', <fs_employee>-name,
           'Salary :', <fs_employee>-salary.

ENDLOOP.
