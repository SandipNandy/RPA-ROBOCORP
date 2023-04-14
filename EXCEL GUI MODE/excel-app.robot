*** Settings ***
Documentation   Excel Application Operation Keyword File
Library         RPA.Excel.Application


# +
*** Keywords ***

Add New WorkSheet Into WorkBook
    [Arguments]     ${EXCEL_FILE}      ${SHEET_NAME}
    Open Application
    Open Workbook    ${EXCEL_FILE}
    Add New Sheet    ${SHEET_NAME}  create_workbook=False
    Save Excel
    sleep  3
    Quit Application
    
Activate WorkSheet For WorkBook
    [Arguments]     ${EXCEL_FILE}      ${SHEET_NAME}    ${FLAG}=True
    Open Application
    Open Workbook    ${EXCEL_FILE}
    Run Keyword If  ${FLAG}==True       Add New Sheet    ${SHEET_NAME}  create_workbook=False
    Set Active Worksheet       sheetname=${SHEET_NAME}
    
Enter Data Into Cell
    [Arguments]     ${DATA}   ${ROW}   ${COL}
    Write To Cells    row=${ROW}   column=${COL}  value=${DATA}
    sleep   2
    
Save And Exit WorkSheet
    Save Excel
    Close Document
    Quit Application
    
Get Data From Cell
    [Arguments]       ${ROW}   ${COL}
    ${DATA} =  Read From Cells   row=${ROW}   column=${COL}  
    sleep  5
    [Return]   ${DATA}
