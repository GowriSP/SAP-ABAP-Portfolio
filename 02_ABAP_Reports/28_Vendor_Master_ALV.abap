REPORT z_vendor_master_alv.

*---------------------------------------------------------------------*
* Program : Z_VENDOR_MASTER_ALV
* Purpose : Vendor Master ALV Report
*---------------------------------------------------------------------*

SELECT-OPTIONS:
  s_lifnr FOR lfa1-lifnr,
  s_ktokk FOR lfa1-ktokk.

TYPES: BEGIN OF ty_vendor,
         lifnr TYPE lfa1-lifnr,
         name1 TYPE lfa1-name1,
         land1 TYPE lfa1-land1,
         ort01 TYPE lfa1-ort01,
         pstlz TYPE lfa1-pstlz,
         ktokk TYPE lfa1-ktokk,
       END OF ty_vendor.

DATA:
  gt_vendor TYPE STANDARD TABLE OF ty_vendor,
  go_alv    TYPE REF TO cl_salv_table.

*---------------------------------------------------------------------*
* Fetch Vendor Data
*---------------------------------------------------------------------*

START-OF-SELECTION.

  SELECT lifnr,
         name1,
         land1,
         ort01,
         pstlz,
         ktokk
    FROM lfa1
    INTO TABLE @gt_vendor
    WHERE lifnr IN @s_lifnr
      AND ktokk IN @s_ktokk
    UP TO 100 ROWS.

  IF gt_vendor IS INITIAL.

    MESSAGE 'No vendor data found' TYPE 'I'.
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
          t_table      = gt_vendor ).

*---------------------------------------------------------------------*
* Enable Standard ALV Functions
*---------------------------------------------------------------------*

      go_alv->get_functions( )->set_all( abap_true ).

*---------------------------------------------------------------------*
* Optimize Column Width
*---------------------------------------------------------------------*

      go_alv->get_columns( )->set_optimize( abap_true ).

*---------------------------------------------------------------------*
* Sort by Vendor Number
*---------------------------------------------------------------------*

      go_alv->get_sorts( )->add_sort(
        columnname = 'LIFNR'
        sequence   = if_salv_c_sort=>sort_up ).

*---------------------------------------------------------------------*
* Set ALV Header
*---------------------------------------------------------------------*

      go_alv->get_display_settings( )->set_list_header(
        'Vendor Master Report' ).

*---------------------------------------------------------------------*
* Display ALV
*---------------------------------------------------------------------*

      go_alv->display( ).

    CATCH cx_salv_msg INTO DATA(gx_salv).

      MESSAGE gx_salv->get_text( ) TYPE 'I'.

    CATCH cx_salv_not_found INTO DATA(gx_not_found).

      MESSAGE gx_not_found->get_text( ) TYPE 'I'.

  ENDTRY.
