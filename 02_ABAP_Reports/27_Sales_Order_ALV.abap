REPORT z_sales_order_alv.

*---------------------------------------------------------------------*
* Program : Z_SALES_ORDER_ALV
* Purpose : Sales Order Header and Item ALV Report
*---------------------------------------------------------------------*

SELECT-OPTIONS:
  s_vbeln FOR vbak-vbeln,
  s_erdat FOR vbak-erdat,
  s_vkorg FOR vbak-vkorg.

TYPES: BEGIN OF ty_sales_order,
         vbeln TYPE vbak-vbeln,
         erdat TYPE vbak-erdat,
         vkorg TYPE vbak-vkorg,
         kunnr TYPE vbak-kunnr,
         posnr TYPE vbap-posnr,
         matnr TYPE vbap-matnr,
         kwmeng TYPE vbap-kwmeng,
         vrkme TYPE vbap-vrkme,
       END OF ty_sales_order.

DATA:
  gt_sales_order TYPE STANDARD TABLE OF ty_sales_order,
  go_alv         TYPE REF TO cl_salv_table.

*---------------------------------------------------------------------*
* Fetch Sales Order Data
*---------------------------------------------------------------------*

START-OF-SELECTION.

  SELECT
    FROM vbak AS h
    INNER JOIN vbap AS i
      ON i~vbeln = h~vbeln
    FIELDS
      h~vbeln,
      h~erdat,
      h~vkorg,
      h~kunnr,
      i~posnr,
      i~matnr,
      i~kwmeng,
      i~vrkme
    WHERE h~vbeln IN @s_vbeln
      AND h~erdat IN @s_erdat
      AND h~vkorg IN @s_vkorg
    INTO TABLE @gt_sales_order
    UP TO 500 ROWS.

  IF gt_sales_order IS INITIAL.

    MESSAGE 'No sales order data found' TYPE 'I'.
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
          t_table      = gt_sales_order ).

*---------------------------------------------------------------------*
* Enable Standard ALV Functions
*---------------------------------------------------------------------*

      go_alv->get_functions( )->set_all( abap_true ).

*---------------------------------------------------------------------*
* Optimize Columns
*---------------------------------------------------------------------*

      go_alv->get_columns( )->set_optimize( abap_true ).

*---------------------------------------------------------------------*
* Sort by Sales Order
*---------------------------------------------------------------------*

      go_alv->get_sorts( )->add_sort(
        columnname = 'VBELN'
        sequence   = if_salv_c_sort=>sort_up ).

*---------------------------------------------------------------------*
* Set ALV Header
*---------------------------------------------------------------------*

      go_alv->get_display_settings( )->set_list_header(
        'Sales Order Item Report' ).

*---------------------------------------------------------------------*
* Display ALV
*---------------------------------------------------------------------*

      go_alv->display( ).

    CATCH cx_salv_msg INTO DATA(gx_salv).

      MESSAGE gx_salv->get_text( ) TYPE 'I'.

    CATCH cx_salv_not_found INTO DATA(gx_not_found).

      MESSAGE gx_not_found->get_text( ) TYPE 'I'.

  ENDTRY.
