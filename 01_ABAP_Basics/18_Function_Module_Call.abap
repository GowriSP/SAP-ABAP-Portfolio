REPORT z_function_module_call.

*---------------------------------------------------------------------*
* Program : Z_FUNCTION_MODULE_CALL
* Purpose : Demonstration of Calling a Function Module
*---------------------------------------------------------------------*

DATA:
  gv_date TYPE sy-datum,
  gv_time TYPE sy-uzeit.

*---------------------------------------------------------------------*
* Call Standard SAP Function Module
*---------------------------------------------------------------------*

START-OF-SELECTION.

  CALL FUNCTION 'DATE_GET_WEEK'
    EXPORTING
      date         = sy-datum
    IMPORTING
      week         = DATA(gv_week)
    EXCEPTIONS
      date_invalid = 1
      OTHERS       = 2.

  IF sy-subrc = 0.

    WRITE: / '----------------------------------------'.
    WRITE: / '       FUNCTION MODULE DEMO'.
    WRITE: / '----------------------------------------'.
    WRITE: / 'Current Date :', sy-datum.
    WRITE: / 'Current Week :', gv_week.
    WRITE: / '----------------------------------------'.

  ELSE.

    WRITE: / 'Function Module execution failed.'.

  ENDIF.
