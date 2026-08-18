REPORT z_alv_material_description.

*---------------------------------------------------------------------*
* Program : Z_ALV_MATERIAL_DESCRIPTION
* Purpose : Display Material Data with Description using SALV
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

*---------------------------------------------------------------------*
* Set ALV Title
*---------------------------------------------------------------------*

      go_alv->get_display_settings( )->set_list_header(
        'Material Master Report' ).

*---------------------------------------------------------------------*
* Display ALV
*---------------------------------------------------------------------*

      go_alv->display( ).

    CATCH cx_salv_msg INTO DATA(gx_salv).

      MESSAGE gx_salv->get_text( ) TYPE 'I'.

  ENDTRY.
