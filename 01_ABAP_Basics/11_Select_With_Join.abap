REPORT z_select_with_join.

*---------------------------------------------------------------------*
* Program : Z_SELECT_WITH_JOIN
* Purpose : Read Material Number and Description using JOIN
*---------------------------------------------------------------------*

PARAMETERS:
  p_mtart TYPE mara-mtart DEFAULT 'FERT',
  p_spras TYPE makt-spras DEFAULT 'E'.

TYPES: BEGIN OF ty_material,
         matnr TYPE mara-matnr,
         mtart TYPE mara-mtart,
         matkl TYPE mara-matkl,
         meins TYPE mara-meins,
         maktx TYPE makt-maktx,
       END OF ty_material.

DATA:
  gt_material TYPE STANDARD TABLE OF ty_material,
  gs_material TYPE ty_material.

*---------------------------------------------------------------------*
* SELECT using INNER JOIN
*---------------------------------------------------------------------*

START-OF-SELECTION.

  SELECT
    FROM mara AS m
    INNER JOIN makt AS t
      ON t~matnr = m~matnr
    FIELDS
      m~matnr,
      m~mtart,
      m~matkl,
      m~meins,
      t~maktx
    WHERE m~mtart = @p_mtart
      AND t~spras = @p_spras
    INTO TABLE @gt_material.

*---------------------------------------------------------------------*
* Display Result
*---------------------------------------------------------------------*

  IF sy-subrc = 0.

    WRITE: / '------------------------------------------------------------'.
    WRITE: / '              MATERIAL DETAILS'.
    WRITE: / '------------------------------------------------------------'.

    LOOP AT gt_material INTO gs_material.

      WRITE: / 'Material Number :', gs_material-matnr.
      WRITE: / 'Description     :', gs_material-maktx.
      WRITE: / 'Material Type   :', gs_material-mtart.
      WRITE: / 'Material Group  :', gs_material-matkl.
      WRITE: / 'Base Unit       :', gs_material-meins.
      WRITE: / '------------------------------------------------------------'.

    ENDLOOP.

    WRITE: / 'Total Records:', lines( gt_material ).

  ELSE.

    WRITE: / 'No material data found.'.

  ENDIF.
