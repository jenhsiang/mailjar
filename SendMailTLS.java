package testmail1;

import java.io.UnsupportedEncodingException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
public class SendMailTLS {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		final String username = "test@test.com";
		final String password = "12345678";
 
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
 
		Session session = Session.getInstance(props,
		  new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		  });
 
		try {
 
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress("joe@comhere.com"));
			message.setRecipients(Message.RecipientType.TO,
				InternetAddress.parse("chentai008@yahoo.com"));
			message.setSubject("COMHERE CONTACT FORM","UTF-8");
			message.setText("Dear Mail Crawler,"
				+ "\n\n No spam to my email, please!¤¤¤å","UTF-8");
			
			Transport.send(message);
 
			System.out.println("Done");
 
		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
	}

}
