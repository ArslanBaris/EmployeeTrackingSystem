using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EmployeeTrackingSystem.Models.MyModels
{
    public class EmployeeDetailModel
    {
        public string EHour { get; set; }
        public string EMinute { get; set; }
        public string XHour { get; set; }
        public string XMinute { get; set; }
    }
}