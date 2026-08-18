REPORT z_select_into_internal_table.

*---------------------------------------------------------------------*
* Program : Z_SELECT_INTO_INTERNAL_TABLE
* Purpose : Read Multiple Material Records from MARA
*---------------------------------------------------------------------*

PARAMETERS:
  p_mtart TYPE mara-mtart DEFAULT 'FERT'.

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
* Read Multiple Records
*---------------------------------------------------------------------*

START-OF-SELECTION.

  SELECT matnr,
         mtart,
         matkl,
         meins
    FROM mara
    INTO TABLE @gt_material
    WHERE mtart = @p_mtart.

  IF sy-subrc = 0.

    WRITE: / '------------------------------------------------------------'.
    WRITE: / '                 MATERIAL DETAILS'.
    WRITE: / '------------------------------------------------------------'.

    LOOP AT gt_material INTO gs_material.

      WRITE: / 'Material :', gs_material-matnr,
               'Type :', gs_material-mtart,
               'Group :', gs_material-matkl,
               'Unit :', gs_material-meins.

    ENDLOOP.

    WRITE: / '------------------------------------------------------------'.
    WRITE: / 'Total Records:', lines( gt_material ).

  ELSE.

    WRITE: / 'No material records found for Material Type:', p_mtart.

  ENDIF.
