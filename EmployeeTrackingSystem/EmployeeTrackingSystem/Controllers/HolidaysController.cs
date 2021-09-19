using EmployeeTrackingSystem.Models.Entities;
using EmployeeTrackingSystem.Models.MyModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EmployeeTrackingSystem.Controllers
{

    public class HolidaysController : Controller
    {
        EmployeeTrackingEntities db = new EmployeeTrackingEntities();
        HolidayModel holidayModel = new HolidayModel();
        // GET: Holidays
        //[Authorize]
        public ActionResult Index()
        {
            holidayModel.holidays = db.Holidays.Where(m=>m.ByUser==false).ToList();
            holidayModel.holidaysByUser = db.Holidays.Where(m => m.ByUser == true).ToList();
            
            return View(holidayModel);
        }
                
        [HttpPost]
        public ActionResult Index(Holidays holiday)
        {
            //Holidays holiday = new Holidays();
           
            holiday.ByUser = true;
            db.Holidays.Add(holiday);
            db.SaveChanges();
            return RedirectToAction("Index");
        }
   
        public ActionResult Delete(int id)
        {
            //Holidays holiday = new Holidays();         

            db.Holidays.Remove(db.Holidays.Find(id));
            db.SaveChanges();
            return RedirectToAction("Index");
        }




    }
}