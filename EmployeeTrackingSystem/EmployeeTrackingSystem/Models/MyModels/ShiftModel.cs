using EmployeeTrackingSystem.Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EmployeeTrackingSystem.Models.MyModels
{
    // View icerisinde birden fazla model kullanilamamakta. Bu sebeple kullanilmasi gereken model'leri kendi olusturdugum 
    // farkli bir sınıf icerisinde tanimladim. Kendi model'imi olusturmus oldum
    public class ShiftModel
    {
        public Employees Employee { get; set; }
        public Shift Shift { get; set; }
        public TimeModel Time { get; set; }
        public List<Employees> Employees { get; set; }

        public ShiftModel()
        {
            this.Employees = new List<Employees>();            
        }
    }
}