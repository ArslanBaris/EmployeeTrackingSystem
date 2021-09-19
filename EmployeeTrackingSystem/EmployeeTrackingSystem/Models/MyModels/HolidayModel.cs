using EmployeeTrackingSystem.Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EmployeeTrackingSystem.Models.MyModels
{
    // View icerisinde birden fazla model kullanilamamakta. Bu sebeple kullanilmasi gereken model'leri kendi olusturdugum 
    // farkli bir sınıf icerisinde tanimladim. Kendi model'imi olusturmus oldum
    public class HolidayModel
    {
        public Holidays holiday;
        public List<Holidays> holidays;
        public List<Holidays> holidaysByUser;

        public HolidayModel()
        {
            this.holidays = new List<Holidays>();
            this.holidaysByUser = new List<Holidays>();
        }
    }
}