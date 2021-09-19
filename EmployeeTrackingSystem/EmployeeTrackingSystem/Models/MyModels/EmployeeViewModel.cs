using EmployeeTrackingSystem.Models.Entities;
using EmployeeTrackingSystem.Models.MyModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EmployeeTrackingSystem.Models.MultipleModels
{
    // View icerisinde birden fazla model kullanilamamakta. Bu sebeple kullanilmasi gereken model'leri kendi olusturdugum 
    // farkli bir sınıf icerisinde tanimladim. Kendi model'imi olusturmus oldum
    public class EmployeeViewModel
    {
        public Employees Employee { get; set; }
        public Shift Shift { get; set; }
        public TimeModel Time { get; set; }
    }
}