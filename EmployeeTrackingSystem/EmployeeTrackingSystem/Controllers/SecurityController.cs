using EmployeeTrackingSystem.Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace EmployeeTrackingSystem.Controllers
{
    [AllowAnonymous]
    public class SecurityController : Controller
    {
        EmployeeTrackingEntities db = new EmployeeTrackingEntities();
        // GET: Security
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(Employees user)
        {
            //Giriş bilgileri karsilastiriliyor
            var userInDb = db.Employees.FirstOrDefault(u => u.ProdmaID == user.ProdmaID && u.Password == user.Password);
            
            if (userInDb!=null)
            {
                //Session, kullanici tarayiciyi kapatana kadar ya da session suresi dolana kadar gecen suredir. Veri saklanabilmektedir.
                Session["userInDb"] = userInDb.EmployeeID.ToString();
                FormsAuthentication.SetAuthCookie((user.ProdmaID).ToString(),false);
                return RedirectToAction("Index", "Employee" );
            }
            else
            {
                ViewBag.message = "Not valid person. Try again..";
                return View();
            }                       
        }

        
        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Login");
        }
    }
}