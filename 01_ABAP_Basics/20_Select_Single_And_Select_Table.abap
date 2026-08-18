REPORT z_select_single_and_table.

*---------------------------------------------------------------------*
* Program : Z_SELECT_SINGLE_AND_TABLE
* Purpose : Demonstration of SELECT SINGLE and SELECT INTO TABLE
*---------------------------------------------------------------------*

PARAMETERS:
  p_matnr TYPE mara-matnr.

TYPES: BEGIN OF ty_material,
         matnr TYPE mara-matnr,
         mtart TYPE mara-mtart,
         matkl TYPE mara-matkl,
         meins TYPE mara-meins,
       END OF ty_material.

DATA:
  gs_material TYPE ty_material,
  gt_material TYPE STANDARD TABLE OF ty_material.

*---------------------------------------------------------------------*
* SELECT SINGLE - Read One Record
*---------------------------------------------------------------------*

START-OF-SELECTION.

  SELECT SINGLE
         matnr,
         mtart,
         matkl,
         meins
    FROM mara
    INTO CORRESPONDING FIELDS OF @gs_material
    WHERE matnr = @p_matnr.

  IF sy-subrc = 0.

    WRITE: / '--- SELECT SINGLE RESULT ---'.
    WRITE: / 'Material Number :', gs_material-matnr.
    WRITE: / 'Material Type   :', gs_material-mtart.
    WRITE: / 'Material Group  :', gs_material-matkl.
    WRITE: / 'Base Unit       :', gs_material-meins.

  ELSE.

    WRITE: / 'Material not found.'.

  ENDIF.

SKIP.

*---------------------------------------------------------------------*
* SELECT INTO TABLE - Read Multiple Records
*---------------------------------------------------------------------*

  SELECT matnr,
         mtart,
         matkl,
         meins
    FROM mara
    INTO TABLE @gt_material
    UP TO 10 ROWS.

  IF sy-subrc = 0.

    WRITE: / '--- SELECT INTO TABLE RESULT ---'.

    LOOP AT gt_material INTO gs_material.

      WRITE: / gs_material-matnr,
               gs_material-mtart,
               gs_material-matkl,
               gs_material-meins.

    ENDLOOP.

    WRITE: / 'Records Read:', sy-dbcnt.

  ELSE.

    WRITE: / 'No records found.'.

  ENDIF.
