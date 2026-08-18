REPORT z_select_options.

*---------------------------------------------------------------------*
* Program : Z_SELECT_OPTIONS
* Purpose : Demonstration of SELECT-OPTIONS
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
  gt_material TYPE STANDARD TABLE OF ty_material,
  gs_material TYPE ty_material.

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
      AND mtart IN @s_mtart.

*---------------------------------------------------------------------*
* Display Result
*---------------------------------------------------------------------*

  IF sy-subrc = 0.

    WRITE: / '------------------------------------------------------------'.
    WRITE: / '                 MATERIAL DETAILS'.
    WRITE: / '------------------------------------------------------------'.

    LOOP AT gt_material INTO gs_material.

      WRITE: / 'Material Number :', gs_material-matnr.
      WRITE: / 'Material Type   :', gs_material-mtart.
      WRITE: / 'Material Group  :', gs_material-matkl.
      WRITE: / 'Base Unit       :', gs_material-meins.
      WRITE: / '------------------------------------------------------------'.

    ENDLOOP.

    WRITE: / 'Total Records:', lines( gt_material ).

  ELSE.

    WRITE: / 'No material records found.'.

  ENDIF.
