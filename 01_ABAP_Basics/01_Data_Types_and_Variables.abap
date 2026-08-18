REPORT z_abap_data_types.

*---------------------------------------------------------------------*
* Program : Z_ABAP_DATA_TYPES
* Purpose : Demonstration of ABAP Data Types and Variables
*---------------------------------------------------------------------*

DATA:
  gv_name    TYPE string,
  gv_age     TYPE i,
  gv_salary  TYPE p DECIMALS 2,
  gv_active  TYPE abap_bool,
  gv_date    TYPE sy-datum.

gv_name   = 'Gowri'.
gv_age    = 25.
gv_salary = '45000.50'.
gv_active = abap_true.
gv_date   = sy-datum.

WRITE: / '----------------------------------------'.
WRITE: / '        ABAP DATA TYPES DEMO'.
WRITE: / '----------------------------------------'.
WRITE: / 'Name   :', gv_name.
WRITE: / 'Age    :', gv_age.
WRITE: / 'Salary :', gv_salary.
WRITE: / 'Active :', gv_active.
WRITE: / 'Date   :', gv_date.
WRITE: / '----------------------------------------'.
