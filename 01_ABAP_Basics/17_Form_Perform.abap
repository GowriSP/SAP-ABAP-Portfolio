REPORT z_form_perform.

*---------------------------------------------------------------------*
* Program : Z_FORM_PERFORM
* Purpose : Demonstration of FORM and PERFORM
*---------------------------------------------------------------------*

DATA:
  gv_num1   TYPE i VALUE 10,
  gv_num2   TYPE i VALUE 20,
  gv_result TYPE i.

*---------------------------------------------------------------------*
* Execute Subroutine
*---------------------------------------------------------------------*

START-OF-SELECTION.

  PERFORM calculate_sum
    USING
      gv_num1
      gv_num2
    CHANGING
      gv_result.

  WRITE: / 'Number 1 :', gv_num1.
  WRITE: / 'Number 2 :', gv_num2.
  WRITE: / 'Result   :', gv_result.

*---------------------------------------------------------------------*
* FORM - Reusable Subroutine
*---------------------------------------------------------------------*

FORM calculate_sum
  USING
    iv_num1 TYPE i
    iv_num2 TYPE i
  CHANGING
    cv_result TYPE i.

  cv_result = iv_num1 + iv_num2.

ENDFORM.
