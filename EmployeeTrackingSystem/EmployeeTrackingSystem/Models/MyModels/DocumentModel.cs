using EmployeeTrackingSystem.Models.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EmployeeTrackingSystem.Models.MyModels
{
    // View icerisinde birden fazla model kullanilamamakta. Bu sebeple kullanilmasi gereken model'leri kendi olusturdugum 
    // farkli bir sınıf icerisinde tanimladim. Kendi model'imi olusturmus oldum
    public class DocumentModel
    { 
        public Employees Employee { get; set; }
        public Shift Shift { get; set; }
       
        public List<Shift> ListOfShift { get; set; }

        public DocumentModel()
        {
            this.ListOfShift = new List<Shift>();
        }
    }
}