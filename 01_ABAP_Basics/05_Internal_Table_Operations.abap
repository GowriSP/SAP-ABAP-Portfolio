REPORT z_internal_table_operations.

*---------------------------------------------------------------------*
* Program : Z_INTERNAL_TABLE_OPERATIONS
* Purpose : Demonstration of Internal Table Operations
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

*---------------------------------------------------------------------*
* APPEND - Add Records
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

*---------------------------------------------------------------------*
* READ TABLE - Read a Specific Record
*---------------------------------------------------------------------*

READ TABLE gt_employee INTO gs_employee
  WITH KEY emp_id = 1002.

IF sy-subrc = 0.

  WRITE: / 'Employee Found:'.
  WRITE: / 'ID     :', gs_employee-emp_id.
  WRITE: / 'Name   :', gs_employee-name.
  WRITE: / 'Dept   :', gs_employee-dept.
  WRITE: / 'Salary :', gs_employee-salary.

ELSE.

  WRITE: / 'Employee Not Found'.

ENDIF.

SKIP.

*---------------------------------------------------------------------*
* MODIFY - Update a Record
*---------------------------------------------------------------------*

READ TABLE gt_employee INTO gs_employee
  WITH KEY emp_id = 1003.

IF sy-subrc = 0.

  gs_employee-salary = '65000.00'.

  MODIFY gt_employee FROM gs_employee
    INDEX sy-tabix.

ENDIF.

*---------------------------------------------------------------------*
* SORT - Sort Internal Table
*---------------------------------------------------------------------*

SORT gt_employee BY salary DESCENDING.

WRITE: / '--- Employees Sorted by Salary ---'.

LOOP AT gt_employee INTO gs_employee.

  WRITE: / gs_employee-emp_id,
           gs_employee-name,
           gs_employee-dept,
           gs_employee-salary.

ENDLOOP.

SKIP.

*---------------------------------------------------------------------*
* DELETE - Delete a Specific Record
*---------------------------------------------------------------------*

DELETE gt_employee
  WHERE emp_id = 1001.

WRITE: / '--- After Deleting Employee 1001 ---'.

LOOP AT gt_employee INTO gs_employee.

  WRITE: / gs_employee-emp_id,
           gs_employee-name,
           gs_employee-dept,
           gs_employee-salary.

ENDLOOP.
