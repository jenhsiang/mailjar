import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.activation.DataHandler;
import javax.activation.FileDataSource;
/*
 * 程式發送E-mail(包含附件)
 * */
public class JavaMail2 {
	public static void main(String[] args) {
		String host = "smtp.gmail.com";
		int port = 587;
		final String username = "test@gmail.com";
		final String password = "";

		Properties props = new Properties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.port", port);

		Session session = Session.getInstance(props, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});

		try {

			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(username));
			/* 收件者
			message.setRecipients(Message.RecipientType.TO,
					InternetAddress.parse("test@gmail.com"));
			*/
			
			message.setRecipients(Message.RecipientType.TO,
					InternetAddress.parse("test@egat.com.tw"));
			
			/* 副本
			message.setRecipients(Message.RecipientType.CC,
					InternetAddress.parse("test@hotmail.com"));
			*/
			message.setSubject("Hello JavaMail");
			message.setText("Mail Send Done");
			
			MimeBodyPart attachFilePart = new MimeBodyPart();
			 //the path of the file e.g. : "c:/Users/nikos7/Desktop/myFile.txt"
			FileDataSource fds = new FileDataSource("C:/temp/TEST v1.0.doc");
			attachFilePart.setDataHandler(new DataHandler(fds));
			attachFilePart.setFileName(fds.getName());
			
			Multipart mp = new MimeMultipart();
			mp.addBodyPart(attachFilePart);		
			
			message.setContent(mp);

			Transport transport = session.getTransport("smtp");
			transport.connect(host, port, username, password);

			Transport.send(message);

			System.out.println("Mail Send Done");

		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
	}
}
