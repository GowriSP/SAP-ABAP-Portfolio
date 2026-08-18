REPORT z_modify_delete_internal_table.

*---------------------------------------------------------------------*
* Program : Z_MODIFY_DELETE_INTERNAL_TABLE
* Purpose : Demonstration of MODIFY and DELETE operations
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

*---------------------------------------------------------------------*
* MODIFY - Update Employee Salary
*---------------------------------------------------------------------*

READ TABLE gt_employee INTO gs_employee
  WITH KEY emp_id = 1002.

IF sy-subrc = 0.

  gs_employee-salary = '65000.00'.

  MODIFY gt_employee FROM gs_employee
    INDEX sy-tabix.

ENDIF.

*---------------------------------------------------------------------*
* DELETE - Delete Employee
*---------------------------------------------------------------------*

DELETE gt_employee
  WHERE emp_id = 1001.

*---------------------------------------------------------------------*
* Display Updated Internal Table
*---------------------------------------------------------------------*

WRITE: / '------------------------------------------------------------'.
WRITE: / '             UPDATED EMPLOYEE DETAILS'.
WRITE: / '------------------------------------------------------------'.

LOOP AT gt_employee INTO gs_employee.

  WRITE: / 'Employee ID :', gs_employee-emp_id.
  WRITE: / 'Name        :', gs_employee-name.
  WRITE: / 'Department  :', gs_employee-dept.
  WRITE: / 'Salary      :', gs_employee-salary.
  WRITE: / '------------------------------------------------------------'.

ENDLOOP.

WRITE: / 'Total Records:', lines( gt_employee ).
