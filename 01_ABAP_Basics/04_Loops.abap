REPORT z_loops.

*---------------------------------------------------------------------*
* Program : Z_LOOPS
* Purpose : Demonstration of DO, WHILE and LOOP AT statements
*---------------------------------------------------------------------*

DATA:
  gv_counter TYPE i VALUE 1,
  gv_number  TYPE i VALUE 1.

*---------------------------------------------------------------------*
* DO Loop
*---------------------------------------------------------------------*

WRITE: / '--- DO LOOP ---'.

DO 5 TIMES.

  WRITE: / 'DO Loop Iteration:', sy-index.

ENDDO.

SKIP.

*---------------------------------------------------------------------*
* WHILE Loop
*---------------------------------------------------------------------*

WRITE: / '--- WHILE LOOP ---'.

WHILE gv_counter <= 5.

  WRITE: / 'Counter:', gv_counter.

  gv_counter = gv_counter + 1.

ENDWHILE.

SKIP.

*---------------------------------------------------------------------*
* LOOP AT Internal Table
*---------------------------------------------------------------------*

TYPES: BEGIN OF ty_employee,
         emp_id TYPE i,
         name   TYPE string,
       END OF ty_employee.

DATA:
  gs_employee TYPE ty_employee,
  gt_employee TYPE STANDARD TABLE OF ty_employee.

gs_employee-emp_id = 1001.
gs_employee-name   = 'Arun'.
APPEND gs_employee TO gt_employee.

gs_employee-emp_id = 1002.
gs_employee-name   = 'Priya'.
APPEND gs_employee TO gt_employee.

gs_employee-emp_id = 1003.
gs_employee-name   = 'Karthi'.
APPEND gs_employee TO gt_employee.

SKIP.

WRITE: / '--- LOOP AT INTERNAL TABLE ---'.

LOOP AT gt_employee INTO gs_employee.

  WRITE: / 'Employee ID:', gs_employee-emp_id,
           'Name:', gs_employee-name.

ENDLOOP.
