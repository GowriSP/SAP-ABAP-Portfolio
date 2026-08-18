REPORT z_select_from_mara.

*---------------------------------------------------------------------*
* Program : Z_SELECT_FROM_MARA
* Purpose : Read Material Master Data from MARA
*---------------------------------------------------------------------*

PARAMETERS:
  p_matnr TYPE mara-matnr DEFAULT '000000000000000001'.

DATA:
  gs_mara TYPE mara.

*---------------------------------------------------------------------*
* Read Material Data
*---------------------------------------------------------------------*

START-OF-SELECTION.

  SELECT SINGLE
         matnr,
         mtart,
         matkl,
         meins
    FROM mara
    INTO CORRESPONDING FIELDS OF @gs_mara
    WHERE matnr = @p_matnr.

  IF sy-subrc = 0.

    WRITE: / '----------------------------------------'.
    WRITE: / '        MATERIAL DETAILS'.
    WRITE: / '----------------------------------------'.
    WRITE: / 'Material Number :', gs_mara-matnr.
    WRITE: / 'Material Type   :', gs_mara-mtart.
    WRITE: / 'Material Group  :', gs_mara-matkl.
    WRITE: / 'Base Unit       :', gs_mara-meins.
    WRITE: / '----------------------------------------'.

  ELSE.

    MESSAGE 'Material not found' TYPE 'I'.

  ENDIF.
