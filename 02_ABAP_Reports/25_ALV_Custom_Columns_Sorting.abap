REPORT z_alv_custom_columns.

*---------------------------------------------------------------------*
* Program : Z_ALV_CUSTOM_COLUMNS
* Purpose : ALV with Custom Column Headings and Sorting
*---------------------------------------------------------------------*

SELECT-OPTIONS:
  s_matnr FOR mara-matnr,
  s_mtart FOR mara-mtart.

TYPES: BEGIN OF ty_material,
         matnr TYPE mara-matnr,
         maktx TYPE makt-maktx,
         mtart TYPE mara-mtart,
         matkl TYPE mara-matkl,
         meins TYPE mara-meins,
       END OF ty_material.

DATA:
  gt_material TYPE STANDARD TABLE OF ty_material,
  go_alv      TYPE REF TO cl_salv_table.

DATA:
  go_columns TYPE REF TO cl_salv_columns_table,
  go_column  TYPE REF TO cl_salv_column_table.

*---------------------------------------------------------------------*
* Fetch Material Data
*---------------------------------------------------------------------*

START-OF-SELECTION.

  SELECT
    FROM mara AS m
    INNER JOIN makt AS t
      ON t~matnr = m~matnr
    FIELDS
      m~matnr,
      t~maktx,
      m~mtart,
      m~matkl,
      m~meins
    WHERE m~matnr IN @s_matnr
      AND m~mtart IN @s_mtart
      AND t~spras = @sy-langu
    INTO TABLE @gt_material
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
* Optimize Column Width
*---------------------------------------------------------------------*

      go_alv->get_columns( )->set_optimize( abap_true ).

      go_columns = go_alv->get_columns( ).

*---------------------------------------------------------------------*
* Change Column Headings
*---------------------------------------------------------------------*

      go_column ?= go_columns->get_column( 'MATNR' ).

      go_column->set_short_text( 'Material' ).
      go_column->set_medium_text( 'Material No.' ).
      go_column->set_long_text( 'Material Number' ).

      go_column ?= go_columns->get_column( 'MAKTX' ).

      go_column->set_short_text( 'Description' ).
      go_column->set_medium_text( 'Material Desc.' ).
      go_column->set_long_text( 'Material Description' ).

      go_column ?= go_columns->get_column( 'MTART' ).

      go_column->set_short_text( 'Type' ).
      go_column->set_medium_text( 'Material Type' ).
      go_column->set_long_text( 'Material Type' ).

      go_column ?= go_columns->get_column( 'MATKL' ).

      go_column->set_short_text( 'Group' ).
      go_column->set_medium_text( 'Material Group' ).
      go_column->set_long_text( 'Material Group' ).

      go_column ?= go_columns->get_column( 'MEINS' ).

      go_column->set_short_text( 'Unit' ).
      go_column->set_medium_text( 'Base Unit' ).
      go_column->set_long_text( 'Base Unit of Measure' ).

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
        'Material Master - ALV Report' ).

*---------------------------------------------------------------------*
* Display ALV
*---------------------------------------------------------------------*

      go_alv->display( ).

    CATCH cx_salv_msg INTO DATA(gx_salv).

      MESSAGE gx_salv->get_text( ) TYPE 'I'.

    CATCH cx_salv_not_found INTO DATA(gx_not_found).

      MESSAGE gx_not_found->get_text( ) TYPE 'I'.

  ENDTRY.
