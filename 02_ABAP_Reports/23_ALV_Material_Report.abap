REPORT z_alv_material_report.

*---------------------------------------------------------------------*
* Program : Z_ALV_MATERIAL_REPORT
* Purpose : Display Material Master Data using SALV ALV
*---------------------------------------------------------------------*

SELECT-OPTIONS:
  s_matnr FOR mara-matnr,
  s_mtart FOR mara-mtart.

TYPES: BEGIN OF ty_material,
         matnr TYPE mara-matnr,
         mtart TYPE mara-mtart,
         matkl TYPE mara-matkl,
         meins TYPE mara-meins,
       END OF ty_material.

DATA:
  gt_material TYPE STANDARD TABLE OF ty_material.

DATA:
  go_alv TYPE REF TO cl_salv_table.

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
    WHERE matnr IN @s_matnr
      AND mtart IN @s_mtart
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
* Enable ALV Functions
*---------------------------------------------------------------------*

      go_alv->get_functions( )->set_all( abap_true ).

*---------------------------------------------------------------------*
* Optimize Columns
*---------------------------------------------------------------------*

      go_alv->get_columns( )->set_optimize( abap_true ).

*---------------------------------------------------------------------*
* Display ALV
*---------------------------------------------------------------------*

      go_alv->display( ).

    CATCH cx_salv_msg INTO DATA(gx_salv).

      MESSAGE gx_salv->get_text( ) TYPE 'I'.

  ENDTRY.
