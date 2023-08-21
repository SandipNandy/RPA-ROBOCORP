*** Settings ***
Library         RPA.FileSystem
Library         String

*** Keywords ***
Search Files Info From Directory
    [Arguments]     ${DIR}      ${EXT_TYPE}    ${LOG_FILE}
    ${file_list} =  List Files In Directory     ${DIR}
    
    # ITERATE FOR ALL FILES #
    FOR    ${file}   IN   @{file_list}
        ${file_path} =  Convert To String   ${file}
        ${extension} =  Get File Extension   ${file}
        ${status} =  
        ...     Run Keyword And Return Status  
        ...     Should Be Equal     ${extension}    ${EXT_TYPE}
        
        Run Keyword If      ${status}==True     Store File Details    ${file}     ${LOG_FILE}
        ...     ELSE      Log       File Is Not A Robot File
    END
    
    # ITERATE FOR ALL CHILD DIRECTORY #
    ${dir_list} =   List Directories In Directory       ${DIR}
    FOR    ${child_dir}   IN    @{dir_list}
            Search Files Info From Directory     ${child_dir}    ${EXT_TYPE}   ${LOG_FILE}
    END
    

Store File Details
    [Arguments]     ${FILE}     ${LOG_FILE}
    
    ${FILE_PATH} =   Convert To String   ${FILE}  
    Append To File    ${LOG_FILE}       ${FILE_PATH}${\n}
     
    ${FileSize} =   Get File Size   ${FILE}
    ${FileSizeStr} =    Convert To String   ${FileSize}
    Append To File    ${LOG_FILE}       ${FileSizeStr}${\n}
    
    ${FileContent} =    Read File   ${FILE}
    Append To File    ${LOG_FILE}       ${\n}${FileContent}${\n}


Create A New Log File
    [Arguments]     ${FILE_PATH}
    ${status} =     Does File Exist     ${FILE_PATH}
    Run Keyword If      ${status}==True     Remove File     ${FILE_PATH}
    Create File     ${FILE_PATH}
# -


