using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;

namespace EmployeeTrackingSystem.Models.MyModels
{
    public class Mail
    {
        public static void MailSender(string body,string EmployeeEmail)
        {
            var fromAddress = new MailAddress("arslanbrs5b@gmail.com");
            var toAddress = new MailAddress(EmployeeEmail);
            const string subject = "Eksik/Fazla Mesai Bilgisi Hk.";
            using (var smtp = new SmtpClient
            {
                Host = "smtp.gmail.com",  // gmail formatı, diğer serverlar için host ve port değiştirilebilir
                Port = 587,
                EnableSsl = true,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(fromAddress.Address, "140316140316") // fromAddress şifresi
            })
            {
                using (var message = new MailMessage(fromAddress, toAddress) { Subject = subject, Body = body })
                {
                    smtp.Send(message);
                }
            }
        }
    }
}