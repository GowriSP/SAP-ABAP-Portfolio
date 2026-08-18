REPORT z_join_vs_for_all_entries.

*---------------------------------------------------------------------*
* Program : Z_JOIN_VS_FOR_ALL_ENTRIES
* Purpose : Demonstration of JOIN and FOR ALL ENTRIES
*---------------------------------------------------------------------*

TYPES: BEGIN OF ty_material,
         matnr TYPE mara-matnr,
         mtart TYPE mara-mtart,
         maktx TYPE makt-maktx,
       END OF ty_material.

DATA:
  gt_material_join TYPE STANDARD TABLE OF ty_material,
  gt_material_fae  TYPE STANDARD TABLE OF ty_material,
  gt_matnr         TYPE STANDARD TABLE OF mara-matnr,
  gs_material      TYPE ty_material.

*---------------------------------------------------------------------*
* Approach 1: INNER JOIN
*---------------------------------------------------------------------*

SELECT
  FROM mara AS m
  INNER JOIN makt AS t
    ON t~matnr = m~matnr
  FIELDS
    m~matnr,
    m~mtart,
    t~maktx
  WHERE t~spras = @sy-langu
  INTO TABLE @gt_material_join
  UP TO 20 ROWS.

WRITE: / '--- INNER JOIN RESULT ---'.

IF gt_material_join IS NOT INITIAL.

  LOOP AT gt_material_join INTO gs_material.

    WRITE: / gs_material-matnr,
             gs_material-mtart,
             gs_material-maktx.

  ENDLOOP.

ELSE.

  WRITE: / 'No records found using INNER JOIN.'.

ENDIF.

SKIP.

*---------------------------------------------------------------------*
* Approach 2: FOR ALL ENTRIES
*---------------------------------------------------------------------*

SELECT matnr
  FROM mara
  INTO TABLE @gt_matnr
  UP TO 20 ROWS.

IF gt_matnr IS NOT INITIAL.

  SELECT
    FROM mara AS m
    INNER JOIN makt AS t
      ON t~matnr = m~matnr
    FIELDS
      m~matnr,
      m~mtart,
      t~maktx
    FOR ALL ENTRIES IN @gt_matnr
    WHERE m~matnr = @gt_matnr-table_line
      AND t~spras = @sy-langu
    INTO TABLE @gt_material_fae.

ENDIF.

WRITE: / '--- FOR ALL ENTRIES RESULT ---'.

IF gt_material_fae IS NOT INITIAL.

  LOOP AT gt_material_fae INTO gs_material.

    WRITE: / gs_material-matnr,
             gs_material-mtart,
             gs_material-maktx.

  ENDLOOP.

ELSE.

  WRITE: / 'No records found using FOR ALL ENTRIES.'.

ENDIF.
