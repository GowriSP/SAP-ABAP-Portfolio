REPORT z_sy_subrc_exception.

*---------------------------------------------------------------------*
* Program : Z_SY_SUBRC_EXCEPTION
* Purpose : Demonstration of SY-SUBRC and Exception Handling
*---------------------------------------------------------------------*

TYPES: BEGIN OF ty_employee,
         emp_id TYPE i,
         name   TYPE string,
         dept   TYPE string,
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
APPEND gs_employee TO gt_employee.

gs_employee-emp_id = 1002.
gs_employee-name   = 'Priya'.
gs_employee-dept   = 'ABAP'.
APPEND gs_employee TO gt_employee.

*---------------------------------------------------------------------*
* READ TABLE and Check SY-SUBRC
*---------------------------------------------------------------------*

READ TABLE gt_employee INTO gs_employee
  WITH KEY emp_id = 1002.

IF sy-subrc = 0.

  WRITE: / 'Employee found successfully.'.
  WRITE: / 'Employee ID :', gs_employee-emp_id.
  WRITE: / 'Name        :', gs_employee-name.
  WRITE: / 'Department  :', gs_employee-dept.

ELSE.

  WRITE: / 'Employee not found.'.

ENDIF.

SKIP.

*---------------------------------------------------------------------*
* Handle Record Not Found
*---------------------------------------------------------------------*

READ TABLE gt_employee INTO gs_employee
  WITH KEY emp_id = 9999.

IF sy-subrc <> 0.

  WRITE: / 'Employee 9999 does not exist in the internal table.'.

ENDIF.

SKIP.

*---------------------------------------------------------------------*
* DELETE and Check SY-SUBRC
*---------------------------------------------------------------------*

DELETE gt_employee
  WHERE emp_id = 1001.

IF sy-subrc = 0.

  WRITE: / 'Employee 1001 deleted successfully.'.

ELSE.

  WRITE: / 'Employee 1001 was not found.'.

ENDIF.
