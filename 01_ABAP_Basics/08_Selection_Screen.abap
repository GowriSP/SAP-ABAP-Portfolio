REPORT z_selection_screen.

*---------------------------------------------------------------------*
* Program : Z_SELECTION_SCREEN
* Purpose : Demonstration of Selection Screen
*---------------------------------------------------------------------*

PARAMETERS:
  p_name   TYPE string DEFAULT 'Gowri',
  p_age    TYPE i,
  p_salary TYPE p DECIMALS 2.

*---------------------------------------------------------------------*
* Validate Input
*---------------------------------------------------------------------*

AT SELECTION-SCREEN.

  IF p_age < 18.
    MESSAGE 'Age must be 18 or above' TYPE 'E'.
  ENDIF.

  IF p_salary < 0.
    MESSAGE 'Salary cannot be negative' TYPE 'E'.
  ENDIF.

*---------------------------------------------------------------------*
* Display Input
*---------------------------------------------------------------------*

START-OF-SELECTION.

  WRITE: / '----------------------------------------'.
  WRITE: / '        EMPLOYEE INFORMATION'.
  WRITE: / '----------------------------------------'.
  WRITE: / 'Name   :', p_name.
  WRITE: / 'Age    :', p_age.
  WRITE: / 'Salary :', p_salary.
  WRITE: / '----------------------------------------'.
