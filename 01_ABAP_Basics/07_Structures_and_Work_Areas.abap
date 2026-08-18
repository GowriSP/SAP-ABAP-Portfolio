REPORT z_structures_work_area.

*---------------------------------------------------------------------*
* Program : Z_STRUCTURES_WORK_AREA
* Purpose : Demonstration of Structures and Work Areas
*---------------------------------------------------------------------*

TYPES: BEGIN OF ty_employee,
         emp_id   TYPE i,
         name     TYPE string,
         dept     TYPE string,
         salary   TYPE p DECIMALS 2,
       END OF ty_employee.

DATA:
  gs_employee TYPE ty_employee.

*---------------------------------------------------------------------*
* Populate Work Area
*---------------------------------------------------------------------*

gs_employee-emp_id = 1001.
gs_employee-name   = 'Arun'.
gs_employee-dept   = 'SAP BASIS'.
gs_employee-salary = '50000.00'.

*---------------------------------------------------------------------*
* Display Work Area
*---------------------------------------------------------------------*

WRITE: / '----------------------------------------'.
WRITE: / '        EMPLOYEE DETAILS'.
WRITE: / '----------------------------------------'.
WRITE: / 'Employee ID :', gs_employee-emp_id.
WRITE: / 'Name        :', gs_employee-name.
WRITE: / 'Department  :', gs_employee-dept.
WRITE: / 'Salary      :', gs_employee-salary.
WRITE: / '----------------------------------------'.

*---------------------------------------------------------------------*
* CLEAR - Reset Work Area
*---------------------------------------------------------------------*

CLEAR gs_employee.

WRITE: / 'Work Area cleared successfully.'.
