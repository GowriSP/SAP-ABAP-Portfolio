REPORT z_customer_master_alv.

*---------------------------------------------------------------------*
* Program : Z_CUSTOMER_MASTER_ALV
* Purpose : Customer Master ALV Report
*---------------------------------------------------------------------*

SELECT-OPTIONS:
  s_kunnr FOR kna1-kunnr,
  s_land1 FOR kna1-land1.

TYPES: BEGIN OF ty_customer,
         kunnr TYPE kna1-kunnr,
         name1 TYPE kna1-name1,
         land1 TYPE kna1-land1,
         ort01 TYPE kna1-ort01,
         pstlz TYPE kna1-pstlz,
         ktokd TYPE kna1-ktokd,
       END OF ty_customer.

DATA:
  gt_customer TYPE STANDARD TABLE OF ty_customer,
  go_alv      TYPE REF TO cl_salv_table.

*---------------------------------------------------------------------*
* Fetch Customer Data
*---------------------------------------------------------------------*

START-OF-SELECTION.

  SELECT kunnr,
         name1,
         land1,
         ort01,
         pstlz,
         ktokd
    FROM kna1
    INTO TABLE @gt_customer
    WHERE kunnr IN @s_kunnr
      AND land1 IN @s_land1
    UP TO 100 ROWS.

  IF gt_customer IS INITIAL.

    MESSAGE 'No customer data found' TYPE 'I'.
    RETURN.

  ENDIF.

*---------------------------------------------------------------------*
* Create SALV ALV
*---------------------------------------------------------------------*

  TRY.

      cl_salv_table=>factory(
        IMPORTING
          r_salv_table = go_alv
        CHANGING
          t_table      = gt_customer ).

*---------------------------------------------------------------------*
* Enable Standard ALV Functions
*---------------------------------------------------------------------*

      go_alv->get_functions( )->set_all( abap_true ).

*---------------------------------------------------------------------*
* Optimize Column Width
*---------------------------------------------------------------------*

      go_alv->get_columns( )->set_optimize( abap_true ).

*---------------------------------------------------------------------*
* Sort by Customer Number
*---------------------------------------------------------------------*

      go_alv->get_sorts( )->add_sort(
        columnname = 'KUNNR'
        sequence   = if_salv_c_sort=>sort_up ).

*---------------------------------------------------------------------*
* Set ALV Header
*---------------------------------------------------------------------*

      go_alv->get_display_settings( )->set_list_header(
        'Customer Master Report' ).

*---------------------------------------------------------------------*
* Display ALV
*---------------------------------------------------------------------*

      go_alv->display( ).

    CATCH cx_salv_msg INTO DATA(gx_salv).

      MESSAGE gx_salv->get_text( ) TYPE 'I'.

    CATCH cx_salv_not_found INTO DATA(gx_not_found).

      MESSAGE gx_not_found->get_text( ) TYPE 'I'.

  ENDTRY.
