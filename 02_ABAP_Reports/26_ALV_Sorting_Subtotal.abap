REPORT z_alv_sorting_subtotal.

*---------------------------------------------------------------------*
* Program : Z_ALV_SORTING_SUBTOTAL
* Purpose : ALV Sorting and Subtotal Demonstration
*---------------------------------------------------------------------*

SELECT-OPTIONS:
  s_mtart FOR mara-mtart.

TYPES: BEGIN OF ty_material,
         matnr TYPE mara-matnr,
         mtart TYPE mara-mtart,
         matkl TYPE mara-matkl,
         meins TYPE mara-meins,
       END OF ty_material.

DATA:
  gt_material TYPE STANDARD TABLE OF ty_material,
  go_alv      TYPE REF TO cl_salv_table.

*---------------------------------------------------------------------*
* Fetch Material Data
*---------------------------------------------------------------------*

START-OF-SELECTION.

  SELECT matnr,
         mtart,
         matkl,
         meins
    FROM mara
    INTO TABLE @gt_material
    WHERE mtart IN @s_mtart
    UP TO 100 ROWS.

  IF gt_material IS INITIAL.

    MESSAGE 'No material data found' TYPE 'I'.
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
          t_table      = gt_material ).

*---------------------------------------------------------------------*
* Enable Standard ALV Functions
*---------------------------------------------------------------------*

      go_alv->get_functions( )->set_all( abap_true ).

*---------------------------------------------------------------------*
* Optimize Columns
*---------------------------------------------------------------------*

      go_alv->get_columns( )->set_optimize( abap_true ).

*---------------------------------------------------------------------*
* Sort by Material Type
*---------------------------------------------------------------------*

      go_alv->get_sorts( )->add_sort(
        columnname = 'MTART'
        sequence   = if_salv_c_sort=>sort_up ).

*---------------------------------------------------------------------*
* Set ALV Header
*---------------------------------------------------------------------*

      go_alv->get_display_settings( )->set_list_header(
        'Material Type Wise Report' ).

*---------------------------------------------------------------------*
* Display ALV
*---------------------------------------------------------------------*

      go_alv->display( ).

    CATCH cx_salv_msg INTO DATA(gx_salv).

      MESSAGE gx_salv->get_text( ) TYPE 'I'.

    CATCH cx_salv_not_found INTO DATA(gx_not_found).

      MESSAGE gx_not_found->get_text( ) TYPE 'I'.

  ENDTRY.
