REPORT z_database_performance.

*---------------------------------------------------------------------*
* Program : Z_DATABASE_PERFORMANCE
* Purpose : Demonstration of efficient SELECT and FOR ALL ENTRIES
*---------------------------------------------------------------------*

TYPES: BEGIN OF ty_material,
         matnr TYPE mara-matnr,
         mtart TYPE mara-mtart,
         matkl TYPE mara-matkl,
       END OF ty_material.

DATA:
  gt_material TYPE STANDARD TABLE OF ty_material,
  gt_mara     TYPE STANDARD TABLE OF ty_material,
  gs_material TYPE ty_material.

*---------------------------------------------------------------------*
* Step 1: Select Only Required Fields
*---------------------------------------------------------------------*

SELECT matnr,
       mtart,
       matkl
  FROM mara
  INTO TABLE @gt_material
  UP TO 20 ROWS.

IF sy-subrc = 0.

  WRITE: / '--- Required Fields Selected ---'.

  LOOP AT gt_material INTO gs_material.

    WRITE: / gs_material-matnr,
             gs_material-mtart,
             gs_material-matkl.

  ENDLOOP.

ELSE.

  WRITE: / 'No material records found.'.

ENDIF.

SKIP.

*---------------------------------------------------------------------*
* Step 2: FOR ALL ENTRIES
*---------------------------------------------------------------------*

IF gt_material IS NOT INITIAL.

  SELECT matnr,
         mtart,
         matkl
    FROM mara
    INTO TABLE @gt_mara
    FOR ALL ENTRIES IN @gt_material
    WHERE matnr = @gt_material-matnr.

ENDIF.

*---------------------------------------------------------------------*
* Display Result
*---------------------------------------------------------------------*

IF gt_mara IS NOT INITIAL.

  WRITE: / '--- FOR ALL ENTRIES Result ---'.
  WRITE: / 'Records Retrieved:', lines( gt_mara ).

  LOOP AT gt_mara INTO gs_material.

    WRITE: / gs_material-matnr,
             gs_material-mtart,
             gs_material-matkl.

  ENDLOOP.

ELSE.

  WRITE: / 'No records retrieved.'.

ENDIF.
