REPORT z_read_table_operations.

*---------------------------------------------------------------------*
* Program : Z_READ_TABLE_OPERATIONS
* Purpose : Demonstration of READ TABLE operations
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

gs_employee-emp_id = 1003.
gs_employee-name   = 'Karthi'.
gs_employee-dept   = 'HANA'.
gs_employee-salary = '60000.00'.
APPEND gs_employee TO gt_employee.

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

*---------------------------------------------------------------------*
* READ TABLE - Using INDEX
*---------------------------------------------------------------------*

READ TABLE gt_employee INTO gs_employee INDEX 1.

IF sy-subrc = 0.

  WRITE: / '--- READ USING INDEX ---'.
  WRITE: / 'Employee ID :', gs_employee-emp_id.
  WRITE: / 'Name        :', gs_employee-name.
  WRITE: / 'Department  :', gs_employee-dept.

ENDIF.

SKIP.

*---------------------------------------------------------------------*
* READ TABLE - Using KEY
*---------------------------------------------------------------------*

READ TABLE gt_employee INTO gs_employee
  WITH KEY emp_id = 1002.

IF sy-subrc = 0.

  WRITE: / '--- READ USING KEY ---'.
  WRITE: / 'Employee ID :', gs_employee-emp_id.
  WRITE: / 'Name        :', gs_employee-name.
  WRITE: / 'Department  :', gs_employee-dept.

ELSE.

  WRITE: / 'Employee not found.'.

ENDIF.

SKIP.

*---------------------------------------------------------------------*
* SORT Internal Table
*---------------------------------------------------------------------*

SORT gt_employee BY emp_id.

*---------------------------------------------------------------------*
* READ TABLE - Using BINARY SEARCH
*---------------------------------------------------------------------*

READ TABLE gt_employee INTO gs_employee
  WITH KEY emp_id = 1003
  BINARY SEARCH.

IF sy-subrc = 0.

  WRITE: / '--- READ USING BINARY SEARCH ---'.
  WRITE: / 'Employee ID :', gs_employee-emp_id.
  WRITE: / 'Name        :', gs_employee-name.
  WRITE: / 'Department  :', gs_employee-dept.
  WRITE: / 'Salary      :', gs_employee-salary.

ELSE.

  WRITE: / 'Employee not found.'.

ENDIF.
