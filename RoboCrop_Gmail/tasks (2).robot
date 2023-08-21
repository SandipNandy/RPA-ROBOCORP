*** Settings ***
Documentation   RPA GMAIL Related Keywords Example
Library         PythonLibrary/RPA_Email.py
Library         Collections

# +
*** Variables   ***
${recipient_email}     GMAIL ACCOUNT
${mail_subject}        EMAIL WITH HTML AND IMAGE
${mail_body}           This is email body part
${file_one}            <FILE PATH>
${file_two}            <FILE PATH>
@{files_to_attach}

${email_html_body}     <h1>Stock For Day : <img src='Stocks.png' alt='daily stock image'/></h1>
${image}               <FILE PATH>


${download_folder}     <FOLDER PATH>
# -

*** Tasks   ***
Example of Email Library Use Cases
    Append To List      ${files_to_attach}     ${file_two}    ${file_one}
    Send Text Email     ${recipient_email}     ${mail_subject}    ${mail_body}      ${files_to_attach}
    
    Save Attachment Where Subject Contains      ${mail_subject}    ${download_folder}
    
    Send Html Email With Image   ${recipient_email}     ${mail_subject}     ${email_html_body}      ${image}
