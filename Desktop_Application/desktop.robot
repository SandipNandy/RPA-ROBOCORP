*** Settings ***
Documentation   Desktop Related Custom Keywords
Library         RPA.Desktop


# +
*** Keywords ***
Open Stocks Application On MAC
    [Documentation]  please install the rpaframework-recognition package for image/ocr
    
    Press Keys   cmd    space
    Type Text       Stocks
    ${elem} =   Wait For Element        image:Images/Stocks.png         
    Click      ${elem}  double click    
    ${status} =
    ...    Run Keyword And Return Status
    ...    Wait For Element        image:Images/ContinueButton.png 
    
    Run Keyword If         ${status}
    ...    Click      image:Images/ContinueButton.png 

Get Summary Report
    ${element} =    Find Element    alias:SearchButton
    ${info_region} =   Resize Region      ${element}   50   0   0   600
    Take Screenshot     locator=${info_region}

Search Stock
    ${element} =    Find Element    alias:SearchButton
    Type Text Into     locator=${element}      text=Nike   clear=True
    Copy To Clipboard       ${element}
    
    ${ClearIcon} =  Find Element    alias:ClearTextIcon
    Click   ${ClearIcon}
    
    ${element} =    Find Element     alias:SearchButton || alias:SearchButtonSelected
    Click   ${element} 
    Paste From Clipboard      ${element}  
    
    
Quit Stock Application
    Press Keys   cmd    q
    
    
# -


