REPORT z_purchase_order_vendor_alv.

*---------------------------------------------------------------------*
* Program : Z_PURCHASE_ORDER_VENDOR_ALV
* Purpose : Purchase Order with Vendor Details
*---------------------------------------------------------------------*

SELECT-OPTIONS:
  s_ebeln FOR ekko-ebeln,
  s_bedat FOR ekko-bedat,
  s_bukrs FOR ekko-bukrs,
  s_lifnr FOR ekko-lifnr.

TYPES: BEGIN OF ty_purchase_order,
         ebeln TYPE ekko-ebeln,
         bedat TYPE ekko-bedat,
         bukrs TYPE ekko-bukrs,
         lifnr TYPE ekko-lifnr,
         name1 TYPE lfa1-name1,
         ebelp TYPE ekpo-ebelp,
         matnr TYPE ekpo-matnr,
         menge TYPE ekpo-menge,
         meins TYPE ekpo-meins,
         netpr TYPE ekpo-netpr,
         peinh TYPE ekpo-peinh,
       END OF ty_purchase_order.

DATA:
  gt_purchase_order TYPE STANDARD TABLE OF ty_purchase_order,
  go_alv            TYPE REF TO cl_salv_table.

*---------------------------------------------------------------------*
* Fetch Purchase Order and Vendor Data
*---------------------------------------------------------------------*

START-OF-SELECTION.

  SELECT
    FROM ekko AS h
    INNER JOIN ekpo AS i
      ON i~ebeln = h~ebeln
    LEFT OUTER JOIN lfa1 AS v
      ON v~lifnr = h~lifnr
    FIELDS
      h~ebeln,
      h~bedat,
      h~bukrs,
      h~lifnr,
      v~name1,
      i~ebelp,
      i~matnr,
      i~menge,
      i~meins,
      i~netpr,
      i~peinh
    WHERE h~ebeln IN @s_ebeln
      AND h~bedat IN @s_bedat
      AND h~bukrs IN @s_bukrs
      AND h~lifnr IN @s_lifnr
    INTO TABLE @gt_purchase_order
    UP TO 500 ROWS.

  IF gt_purchase_order IS INITIAL.

    MESSAGE 'No purchase order data found' TYPE 'I'.
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
          t_table      = gt_purchase_order ).

*---------------------------------------------------------------------*
* Enable Standard ALV Functions
*---------------------------------------------------------------------*

      go_alv->get_functions( )->set_all( abap_true ).

*---------------------------------------------------------------------*
* Optimize Column Width
*---------------------------------------------------------------------*

      go_alv->get_columns( )->set_optimize( abap_true ).

*---------------------------------------------------------------------*
* Sort by Purchase Order
*---------------------------------------------------------------------*

      go_alv->get_sorts( )->add_sort(
        columnname = 'EBELN'
        sequence   = if_salv_c_sort=>sort_up ).

*---------------------------------------------------------------------*
* Set ALV Header
*---------------------------------------------------------------------*

      go_alv->get_display_settings( )->set_list_header(
        'Purchase Order and Vendor Report' ).

*---------------------------------------------------------------------*
* Display ALV
*---------------------------------------------------------------------*

      go_alv->display( ).

    CATCH cx_salv_msg INTO DATA(gx_salv).

      MESSAGE gx_salv->get_text( ) TYPE 'I'.

    CATCH cx_salv_not_found INTO DATA(gx_not_found).

      MESSAGE gx_not_found->get_text( ) TYPE 'I'.

  ENDTRY.
