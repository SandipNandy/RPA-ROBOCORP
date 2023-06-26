*** Settings ***
Documentation   RPA Browser Related Keywords Example
Resource        KeywordLibrary/browser.robot
Library         RPA.FileSystem
Library         RPA.Desktop
Library         String
Library         BuiltIn


*** Variables   ***
${SRC_DIR}       /Users/sandipmac/Projects/RobotAppium/Captions   
${TARGET_LAN}    Japanese
${status}        False

*** Keywords  ***
Convert Document
    [Arguments]     ${file}     ${DEST_FILE_NAME}
    ${FileContent} =  Read File   ${file}
    ${content} =  Split To Lines  ${FileContent}
        
    FOR  ${line}  IN  @{content}
        
        run keyword If    ${status}     Convert Sentence And Copy To ClipBoard      ${line}
        ...  ELSE    Set clipboard value   ${line}   
        
        ${converted_text} =  Get Clipboard Value
        Append To File    ${DEST_FILE_NAME}       ${converted_text}${\n}
        ${status} =   BuiltIn.Set Variable    False
        
        ${status} =  
        ...     Run Keyword And Return Status  
        ...     Should Contain     ${line}    -->
        
    END

*** Tasks ***
Example of Browser Selenium Library
    Open Google Translate Page
    Set Source Language     English
    Set Target Language     ${TARGET_LAN}
    
    ${DIR_NAME} =	Catenate	SEPARATOR=/	    ${SRC_DIR} 	    ${TARGET_LAN}
    Create Directory    ${DIR_NAME}
    
    ${file_list} =  List Files In Directory     ${SRC_DIR}
    FOR  ${file}  IN  @{file_list}
    
        ${file_ext} =   Get File Extension   ${file}
        Continue For Loop If    '${file_ext}'!='.vtt'
        
        ${srcFileName} =  Get File Name   ${file}
        ${DEST_FILE_NAME} =	 Catenate	SEPARATOR=/	    ${DIR_NAME} 	  ${srcFileName}
        Create File     ${DEST_FILE_NAME}
        
        Convert Document    ${file}     ${DEST_FILE_NAME}
    END
    Close Current Browser


