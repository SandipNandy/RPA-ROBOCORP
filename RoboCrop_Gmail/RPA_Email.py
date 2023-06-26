# +
from RPA.Email.ImapSmtp import ImapSmtp

gmail_account = "Your Gmail Account"
gmail_password = "Gmail Passord"
mail = ImapSmtp(smtp_server="smtp.gmail.com", smtp_port=587)


def send_text_email(recipient_email, mail_subject, mail_body, mail_attachments=None):
    mail.authorize(account=gmail_account, password=gmail_password)
    mail.send_message(sender=gmail_account,
                      recipients=recipient_email,
                      subject=mail_subject,
                      body=mail_body,
                      attachments=mail_attachments)


def send_html_email_with_image(recipient_email, mail_subject, mail_body, image_file_path):
    mail.authorize(account=gmail_account, password=gmail_password)
    mail.send_message(sender=gmail_account,
                      recipients=recipient_email,
                      subject=mail_subject,
                      html=True,
                      images=image_file_path,
                      body=mail_body)

    
def save_attachment_where_subject_contains(mail_subject_to_search, out_dir):
    mail.authorize(account=gmail_account, password=gmail_password)
    email_list = mail.list_messages("SUBJECT \"" + mail_subject_to_search + "\"")
    for email in email_list:
        # Attributes : Subject, Date, From, Received, Has-Attachments #
        if email['Has-Attachments']:
            mail.save_attachment(email, target_folder=out_dir, overwrite=True)
