REPORT z_clear_refresh_free.

*---------------------------------------------------------------------*
* Program : Z_CLEAR_REFRESH_FREE
* Purpose : Demonstration of CLEAR, REFRESH and FREE
*---------------------------------------------------------------------*

DATA:
  gv_name TYPE string,
  gv_age  TYPE i.

TYPES: BEGIN OF ty_employee,
         emp_id TYPE i,
         name   TYPE string,
       END OF ty_employee.

DATA:
  gs_employee TYPE ty_employee,
  gt_employee TYPE STANDARD TABLE OF ty_employee.

*---------------------------------------------------------------------*
* CLEAR - Clear a Work Area
*---------------------------------------------------------------------*

gs_employee-emp_id = 1001.
gs_employee-name   = 'Arun'.

WRITE: / 'Before CLEAR:'.
WRITE: / 'ID   :', gs_employee-emp_id.
WRITE: / 'Name :', gs_employee-name.

CLEAR gs_employee.

WRITE: / 'After CLEAR:'.
WRITE: / 'ID   :', gs_employee-emp_id.
WRITE: / 'Name :', gs_employee-name.

SKIP.

*---------------------------------------------------------------------*
* Populate Internal Table
*---------------------------------------------------------------------*

gs_employee-emp_id = 1001.
gs_employee-name   = 'Arun'.
APPEND gs_employee TO gt_employee.

gs_employee-emp_id = 1002.
gs_employee-name   = 'Priya'.
APPEND gs_employee TO gt_employee.

gs_employee-emp_id = 1003.
gs_employee-name   = 'Karthi'.
APPEND gs_employee TO gt_employee.

WRITE: / 'Records before REFRESH:', lines( gt_employee ).

*---------------------------------------------------------------------*
* REFRESH - Remove Internal Table Contents
*---------------------------------------------------------------------*

REFRESH gt_employee.

WRITE: / 'Records after REFRESH :', lines( gt_employee ).

SKIP.

*---------------------------------------------------------------------*
* Populate Internal Table Again
*---------------------------------------------------------------------*

gs_employee-emp_id = 1004.
gs_employee-name   = 'Divya'.
APPEND gs_employee TO gt_employee.

gs_employee-emp_id = 1005.
gs_employee-name   = 'Rahul'.
APPEND gs_employee TO gt_employee.

WRITE: / 'Records before FREE:', lines( gt_employee ).

*---------------------------------------------------------------------*
* FREE - Clear Internal Table and Release Memory
*---------------------------------------------------------------------*

FREE gt_employee.

WRITE: / 'Records after FREE :', lines( gt_employee ).
