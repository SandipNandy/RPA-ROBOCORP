*** Settings ***
Documentation   PDF Operation Keyword File
Library         RPA.PDF
Library         RPA.Browser.Selenium
Library         String

*** Variables   ***
${HTML_CONTENT}      <!DOCTYPE html><html><head></head><body><h1>Page URL</h1><p>URL_TO_UPADTE</p><h2>ScreenShot of page</h2></body></html>
${DRIVER_PATH}       /Users/sandipmac/Projects/RoboCorp RPA/FirstRPAProj/browser-driver/chromedriver
${DEST_FOLDER}       /Users/sandipmac/Projects/RoboCorp RPA/FirstRPAProj/DataSets/pdfout


# +
*** Keywords ***
Create A New File Name
    ${time_stamp} =	    Get Time	epoch
    ${DEST_FILE_NAME} =	 Catenate	SEPARATOR=/	    ${DEST_FOLDER} 	  ${time_stamp}.pdf
    [Return]    ${DEST_FILE_NAME}


Save URL As Image In PDF
    [Arguments]      ${URL}
    ${dest_file} =  Create A New File Name
    
    ${HTML} =	Replace String	  ${HTML_CONTENT}	 URL_TO_UPADTE	  ${URL}
    Open Browser    ${URL}     browser=Chrome   executable_path=${DRIVER_PATH}
    sleep   3
    Html To Pdf     ${HTML}   ${dest_file}
    ${path} =   Capture Page Screenshot   temp.png
    Log     ${path}
    Add Image To Pdf     imagefile=${path}  source=${dest_file}   target=${dest_file}   
    Close Browser


Extract Pages With Images
    [Arguments]      ${SRC_FILE}
    
    Open Pdf Document   ${SRC_FILE}
    
    ${pdf_info} =   Get Info   ${SRC_FILE}
    Log     ${pdf_info}
    ${page_no} =    Get Number Of Pages     ${SRC_FILE}
    Log     ${page_no}
    
    
    ${SourceText} =     Get Text From Pdf     ${SRC_FILE}
    FOR    ${page}    IN    @{SourceText.keys()}
        Log     ${SourceText[${page}]}
        
        ${matched} =	
        ...     Run Keyword And Return Status 
        ...     Should Match Regexp     ${SourceText[${page}]}      (.*)Figure(\\s)(\\d+):(.*)
        
        ${pageNo} =   Convert To String   ${page}
        ${dest_file} =	 Catenate	SEPARATOR=/	    ${DEST_FOLDER} 	  out_${pageNo}.pdf
        run keyword If   ${matched}    
        ...     Extract Pages From Pdf      ${SRC_FILE}    ${dest_file}    ${pageNo}
    END
    
    Close Pdf Document  ${SRC_FILE}
