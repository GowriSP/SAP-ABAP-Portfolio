REPORT z_control_statements.

*---------------------------------------------------------------------*
* Program : Z_CONTROL_STATEMENTS
* Purpose : Demonstration of IF, ELSEIF, ELSE and CASE statements
*---------------------------------------------------------------------*

DATA:
  gv_salary TYPE p DECIMALS 2,
  gv_rating  TYPE c LENGTH 1,
  gv_status  TYPE string.

*---------------------------------------------------------------------*
* IF / ELSEIF / ELSE
*---------------------------------------------------------------------*

gv_salary = '55000.00'.

IF gv_salary >= 60000.
  gv_status = 'High Salary'.

ELSEIF gv_salary >= 40000.
  gv_status = 'Medium Salary'.

ELSE.
  gv_status = 'Low Salary'.

ENDIF.

WRITE: / 'Salary :', gv_salary.
WRITE: / 'Status :', gv_status.

SKIP.

*---------------------------------------------------------------------*
* CASE Statement
*---------------------------------------------------------------------*

gv_rating = 'A'.

CASE gv_rating.

  WHEN 'A'.
    WRITE: / 'Rating : Excellent'.

  WHEN 'B'.
    WRITE: / 'Rating : Good'.

  WHEN 'C'.
    WRITE: / 'Rating : Average'.

  WHEN OTHERS.
    WRITE: / 'Rating : Invalid'.

ENDCASE.
