using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;
using EmployeeTrackingSystem.Models.Entities;
using EmployeeTrackingSystem.Models.MultipleModels;
using EmployeeTrackingSystem.Models.MyModels;

namespace EmployeeTrackingSystem.Controllers
{
    public class EmployeeController : Controller
    {
        // GET: Employee
        EmployeeTrackingEntities db = new EmployeeTrackingEntities();
        EmployeeViewModel modelForAddTransact = new EmployeeViewModel();
        DocumentModel modelForDocument = new DocumentModel();
        //ShiftModel shiftModel = new ShiftModel();

        //[Authorize]
        public ActionResult Index()
        {

            List<Employees> employees = new List<Employees>();

            int employeeID;
            Employees userInDb;
            if (Session["userInDb"] == null) // Giriş yapan kullanıcı id değeri boş ise tekrar giriş sayfasına yönlendiriliyor
            {
                return RedirectToAction("Logout", "Security");
            }
            else  // Veri tabanından giriş yapan kullanıcının bilgileri çekiliyor
            {
                employeeID = Convert.ToInt32(Session["userInDb"]);
                userInDb = db.Employees.Find(employeeID);
            }


            if (userInDb.UserType == 1) // YÖnetici ise tüm personel verilerine erişim
            {
                employees = db.Employees.ToList();
            }
            else if (userInDb.UserType == 2) // Departman yöneticisi ise yalnızca kendi departman çalışanlarına erişim
            {
                employees = db.Employees.Where(p => p.Department == userInDb.Department).ToList();
            }
            else if (userInDb.UserType == 5) // Çalışan personel ise yalnızca kendi verilerine erişim
            {
                employees = db.Employees.Where(p => p.EmployeeID == userInDb.EmployeeID).ToList();
            }

            // Shift tablosundaki bugün hariç tüm mesailerin listesi
            //  Bugünün çıkış saati girimediği için alınmıyor. Dönem bilgisi de eklenmiyor. Dolayısıyla diğer metotlarda da hariç tutuluyor.
            var tempDate = DateTime.Now.AddDays(-1);
            var listOfShift = db.Shift.Where(u=>u.ShiftDate < tempDate).ToList();   

            foreach (var item in listOfShift) // Fazla/Eksik mesai ve Dönem bilgisi  eklemekte
            {
                Shift shift = db.Shift.Find(item.ShiftID);
                TimeSpan entryTime = (TimeSpan)item.EntryTime; //Giriş saati  
                TimeSpan exitTime = (TimeSpan)item.ExitTime; //Çıkış saati

                TimeSpan timeHourFormat = exitTime - entryTime;  //Calisma süresi
                string strTemp = Convert.ToString(db.Employees.Find(item.EmployeeID).NormalShiftTime); // Normalde calismasi gereken saat
                DateTime normalMesai = DateTime.Parse(strTemp);


                if (DateTime.Parse(item.ShiftDate.ToString()).DayOfWeek == DayOfWeek.Saturday ||
                    DateTime.Parse(item.ShiftDate.ToString()).DayOfWeek == DayOfWeek.Sunday)  // Haftasonu çalışma süresi fazla mesai olarak eklenmekte
                {
                    shift.OverTime = exitTime - entryTime;
                    shift.WorkTime = exitTime - entryTime;
                    shift.MissingTime = new TimeSpan(0, 0, 0);
                }
                else
                {
                    if (timeHourFormat < TimeSpan.Zero)  //Çalışma süresi negatif ise (Giriş saati-> 20:00 | Çıkış saati-> 04:00)
                    {                                                                                   // Fazla mesai yapma durumu
                        if (((exitTime + new TimeSpan(24, 0, 0)) - entryTime) > normalMesai.TimeOfDay)  // Çıkış saatine 24 saat eklenerek fark alınıyor. Sebebi gece başlayıp ertesi gün çıkması durumu
                        {
                            var overTime = ((exitTime + new TimeSpan(24, 0, 0)) - entryTime) - normalMesai.TimeOfDay;

                            shift.WorkTime = normalMesai.TimeOfDay;
                            shift.OverTime = ((exitTime + new TimeSpan(24, 0, 0)) - entryTime) - normalMesai.TimeOfDay;
                            shift.MissingTime = TimeSpan.Parse("00:00:00");
                        }
                        else if (((exitTime + new TimeSpan(24, 0, 0)) - entryTime) < normalMesai.TimeOfDay)  //Eksik mesai durumu
                        {
                            var littleTime = (((exitTime + new TimeSpan(24, 0, 0)) - entryTime) - normalMesai.TimeOfDay).Negate();

                            shift.MissingTime = littleTime;
                            shift.WorkTime = ((exitTime + new TimeSpan(24, 0, 0)) - entryTime);
                            shift.OverTime = TimeSpan.Parse("00:00:00");
                        }
                        else // Tam mesai yapma durumu
                        {
                            shift.OverTime = TimeSpan.Parse("00:00:00");
                            shift.MissingTime = TimeSpan.Parse("00:00:00");
                            shift.WorkTime = (exitTime - entryTime);
                        }
                    }
                    if (normalMesai.TimeOfDay == new TimeSpan(10, 0, 0)) // Arge bölümü için farklı hesaplama kullanılmakta
                    {
                        // Normal giriş
                        if (entryTime >= new TimeSpan(7, 0, 0) && entryTime <= new TimeSpan(7, 30, 0)) // Normal mesai süresi için kabul edilen giriş saatleri (07:00 - 07:30) içerisinde giriş 
                        {
                            if (exitTime <= new TimeSpan(17, 45, 0) && exitTime >= new TimeSpan(17, 30, 0)) // Normal mesai (17:30 - 17:45 arası çıkış) 
                            {
                                shift.OverTime = new TimeSpan(0, 0, 0);
                                shift.MissingTime = new TimeSpan(0, 0, 0);
                                shift.WorkTime = new TimeSpan(10, 0, 0);
                            }
                            else if (exitTime < new TimeSpan(17, 30, 0))    // Eksik mesai (17:30 öncesi çıkış)
                            {
                                entryTime = new TimeSpan(7, 30, 0);
                                var littleTime = (((exitTime) - entryTime) - normalMesai.TimeOfDay).Negate();  // Eksik mesai süresi negatif çkacağından pozitife çevriliyor

                                shift.MissingTime = littleTime;
                                shift.WorkTime = (exitTime - entryTime);
                                shift.OverTime = new TimeSpan(0, 0, 0);
                            }
                            else if (exitTime > new TimeSpan(17, 45, 0))   // Fazla Mesai (17:45 sonrası çıkış)
                            {
                                entryTime = new TimeSpan(7, 30, 0);
                                shift.MissingTime = new TimeSpan(0, 0, 0);
                                shift.WorkTime = (exitTime - entryTime);
                                shift.OverTime = (exitTime - new TimeSpan(17, 30, 0));
                            }
                        }                                           // Erken giriş
                        else if (entryTime < new TimeSpan(7, 0, 0)) // Fazla Mesai sayılabilmesi için giriş saati (07:00 öncesi)
                        {
                            if (exitTime <= new TimeSpan(17, 45, 0) && exitTime >= new TimeSpan(17, 30, 0)) // Normal çıkış saatleri içerisisnde çıkış (17:30 - 17:45 arası çıkış) 
                            {
                                exitTime = new TimeSpan(17, 30, 0);
                                shift.OverTime = (exitTime - entryTime) - normalMesai.TimeOfDay;
                                shift.MissingTime = new TimeSpan(0, 0, 0);
                                shift.WorkTime = exitTime - entryTime;
                            }
                            else if (exitTime < new TimeSpan(17, 30, 0))    // Erken çıkma durumu (17:30 öncesi çıkış)
                            {

                                var littleTime = (((exitTime) - new TimeSpan(7, 30, 0)) - normalMesai.TimeOfDay).Negate();  // Eksik mesai süresi negatif çkacağından pozitife çevriliyor
                                var overTime = ((new TimeSpan(17, 30, 0) - entryTime) - normalMesai.TimeOfDay).Negate();

                                TimeSpan total;
                                if (littleTime > overTime)
                                {
                                    total = (littleTime - overTime).Negate();
                                    shift.MissingTime = total;
                                }
                                else if (overTime > littleTime)
                                {
                                    total = (overTime - littleTime).Negate();
                                    shift.OverTime = total;
                                }
                                else
                                {
                                    shift.OverTime = new TimeSpan(0, 0, 0);
                                    shift.MissingTime = new TimeSpan(0, 0, 0);
                                    shift.WorkTime = new TimeSpan(10, 0, 0);
                                }
                                shift.WorkTime = (exitTime - entryTime);

                            }
                            else if (exitTime > new TimeSpan(17, 45, 0))   // Fazla Mesai (17:45 sonrası çıkış)
                            {
                                var overTime = (new TimeSpan(7, 30, 0) - entryTime) + (exitTime - new TimeSpan(17, 30, 0));
                                shift.MissingTime = new TimeSpan(0, 0, 0);
                                shift.WorkTime = (exitTime - entryTime);
                                shift.OverTime = overTime;
                            }
                        }
                        else if (entryTime > new TimeSpan(7, 30, 0)) // Geç giriş (07:30 sonrası)
                        {
                            if (exitTime <= new TimeSpan(17, 45, 0) && exitTime >= new TimeSpan(17, 30, 0)) // Normal çıkış saatleri içerisisnde çıkış (17:30 - 17:45 arası çıkış) 
                            {
                                exitTime = new TimeSpan(17, 30, 0);
                                var littleTime = (entryTime - new TimeSpan(7, 30, 0));

                                shift.OverTime = new TimeSpan(0, 0, 0);
                                shift.MissingTime = littleTime;
                                shift.WorkTime = exitTime - entryTime;
                            }
                            else if (exitTime < new TimeSpan(17, 30, 0))    // Erken çıkma durumu (17:30 öncesi çıkış)
                            {
                                var littleTime = ((exitTime - entryTime) - normalMesai.TimeOfDay).Negate();  // Eksik mesai süresi negatif çkacağından pozitife çevriliyor

                                shift.OverTime = new TimeSpan(0, 0, 0);
                                shift.MissingTime = littleTime;
                                shift.WorkTime = (exitTime - entryTime);
                            }
                            else if (exitTime > new TimeSpan(17, 45, 0))   // Geç çıkış (17:45 sonrası çıkış)
                            {
                                var overTime = (exitTime - new TimeSpan(17, 30, 0));
                                var littleTime = (entryTime - new TimeSpan(7, 30, 0));

                                TimeSpan total;
                                if (littleTime > overTime)
                                {
                                    total = (littleTime - overTime);
                                    shift.MissingTime = total;
                                    shift.OverTime = new TimeSpan(0, 0, 0); ;
                                    shift.WorkTime = (exitTime - entryTime);
                                }
                                else if (overTime > littleTime)
                                {
                                    total = (overTime - littleTime);
                                    shift.OverTime = total;
                                    shift.MissingTime = new TimeSpan(0, 0, 0);
                                    shift.WorkTime = (exitTime - entryTime);
                                }
                                else
                                {
                                    shift.OverTime = new TimeSpan(0, 0, 0);
                                    shift.MissingTime = new TimeSpan(0, 0, 0);
                                    shift.WorkTime = new TimeSpan(10, 0, 0);
                                }                                
                            }
                        }

                    }
                    else // Normal mesai suresi 10:00 saatten farklı olanlar için
                    {
                        if ((exitTime - entryTime) > normalMesai.TimeOfDay)  // Cikis saatine 24 saat eklenerek fark alınıyor. Sebebi gece baslayip ertesi gün cikması durumu
                        {                                                                    // Fazla mesai yapma durumu
                            var overTime = (exitTime - entryTime) - normalMesai.TimeOfDay;

                            shift.WorkTime = normalMesai.TimeOfDay;
                            shift.OverTime = overTime;
                            shift.MissingTime = TimeSpan.Parse("00:00:00");
                        }
                        else if ((exitTime - entryTime) < normalMesai.TimeOfDay)  //Eksik mesai durumu
                        {
                            var littleTime = ((exitTime - entryTime) - normalMesai.TimeOfDay).Negate();

                            shift.MissingTime = littleTime;
                            shift.WorkTime = (exitTime - entryTime);
                            shift.OverTime = TimeSpan.Parse("00:00:00");
                        }
                        else // Tam mesai yapma durumu
                        {
                            shift.OverTime = TimeSpan.Parse("00:00:00");
                            shift.MissingTime = TimeSpan.Parse("00:00:00");
                            shift.WorkTime = (exitTime - entryTime);
                        }
                    }
                }
                string donem = Convert.ToString(item.ShiftDate).Substring(3, 2) + "/" //Mesai Tarihi -> Dd.Mm.YYYY Hh.Mm.Ss 
                             + Convert.ToString(item.ShiftDate).Substring(6, 4);

                shift.Period = donem;
                db.SaveChanges();
            }

            DateTime today = DateTime.Now;
            foreach (var employee in employees)
            {
                Employees employeeInDb = db.Employees.Find(employee.EmployeeID);
                DateTime initTime = DateTime.Parse("00:00");
                DateTime totalTime = DateTime.Parse("00:00");

                foreach (var shift in listOfShift)  // Her calisanin bulundugu ay icerisindeki mevcut durumu hesaplanıyor
                {
                    if (employee.EmployeeID == shift.EmployeeID)
                    {
                        if (shift.Period == ("0" + (today.Month.ToString())) + "/" + (today.Year.ToString())) // only this month  (Donem format in db -> MM/YYYY)(09/2021)
                        {
                            totalTime += (TimeSpan)shift.OverTime;    // Eksik ve Fazla mesai süreleri 
                            totalTime -= (TimeSpan)shift.MissingTime;
                        }
                    }
                }

                int totalHour = CalculateTotalHour(totalTime); // Hesaplama metoduna toplam sure gönderiliyor
                int totalMinute = CalculateTotalMinute(totalTime);

                
                employee.Total = (totalHour.ToString() + " h " + totalMinute.ToString() + " m");

                employeeInDb.Total = employee.Total;
                db.SaveChanges();
            }
            return View(employees);
        }

        [HttpPost]
        public ActionResult EmployeeDetail(int id) // Personel detay kismi icin olusturulan modal pop-up icerigi
        {
            Employees employee = new Employees();
            employee = db.Employees.FirstOrDefault(e => e.EmployeeID == id);
            return PartialView("EmployeeDetail", db.Employees.FirstOrDefault(e => e.EmployeeID == id));
        }

        [HttpGet]
        public ActionResult AddOvertime(int id) //Manuel mesai ekleme ekrani
        {
            List<int> hour = new List<int>();
            List<string> sHour = new List<string>();

            for (int i = 0; i < 24; i++)
            {
                hour.Add(i);
            }
            for (int i = 0; i < 24; i++)
            {
                if (hour[i].ToString().Length == 1)
                {
                    sHour.Add(hour[i].ToString().PadLeft(hour[i].ToString().Length + 1, '0'));
                }
                else
                    sHour.Add(hour[i].ToString());
            }

            List<SelectListItem> items = new List<SelectListItem>();
            for (int i = 0; i < 24; i++)
            {
                items.Add(new SelectListItem { Text = sHour[i], Value = (i).ToString() });
            }
            ViewBag.Hour = items;

            List<int> minute = new List<int>();
            List<string> sMinute = new List<string>();

            for (int i = 0; i < 60; i++)
            {
                minute.Add(i);
            }
            for (int i = 0; i < 60; i++)
            {
                if (minute[i].ToString().Length == 1)
                {
                    sMinute.Add(minute[i].ToString().PadLeft(minute[i].ToString().Length + 1, '0'));
                }
                else
                    sMinute.Add(minute[i].ToString());
            }


            List<SelectListItem> items2 = new List<SelectListItem>();
            for (int i = 0; i < 60; i++)
            {
                items2.Add(new SelectListItem { Text = sMinute[i], Value = (i).ToString() });
            }
            ViewBag.Minute = items2;


            modelForAddTransact.Employee = db.Employees.Find(id);
            return View("AddOvertime", modelForAddTransact);
        }

        [HttpPost]
        public ActionResult AddOvertime(EmployeeViewModel employeeViewModel)  // Mesai ekleme islemleri
        {
            if (!ModelState.IsValid)  // Veri girişinde validasyon kontrolü sağlanıyor mu?
            {
                return View("AddOvertime");
            }

            int id;

            id = employeeViewModel.Employee.EmployeeID;
            employeeViewModel.Shift.EmployeeID = id;

            DateTime dt1 = DateTime.Parse(employeeViewModel.Time.EHour + ":" + employeeViewModel.Time.EMinute); //Giriş saati  String(hour+minute) 
            DateTime dt2 = DateTime.Parse(employeeViewModel.Time.XHour + ":" + employeeViewModel.Time.XMinute); //Çıkış saati

            TimeSpan timeHourFormat = dt2 - dt1;  //Çalışma süresi
            string gecici = Convert.ToString(db.Employees.Find(id).NormalShiftTime); // Normalde çalışması gereken saat
            DateTime normalShift = DateTime.Parse(gecici);

            if (timeHourFormat < TimeSpan.Zero)  //Çalışma süresi negatif ise (Giriş saati-> 20:00 | Çıkış saati-> 04:00)
            {
                if (((dt2 + new TimeSpan(24, 0, 0)) - dt1) > normalShift.TimeOfDay)  // Çıkış saatine 24 saat eklenerek fark alınıyor. Sebebi gece başlayıp ertesi gün çıkması durumu
                {                                                                    // Fazla mesai yapma durumu
                    var overTime = ((dt2 + new TimeSpan(24, 0, 0)) - dt1) - normalShift.TimeOfDay;

                    employeeViewModel.Shift.WorkTime = normalShift.TimeOfDay;
                    employeeViewModel.Shift.OverTime = ((dt2 + new TimeSpan(24, 0, 0)) - dt1) - normalShift.TimeOfDay;
                    employeeViewModel.Shift.MissingTime = TimeSpan.Parse("00:00:00");
                }
                else if (((dt2 + new TimeSpan(24, 0, 0)) - dt1) < normalShift.TimeOfDay)  //Eksik mesai durumu
                {
                    var littleTime = (((dt2 + new TimeSpan(24, 0, 0)) - dt1) - normalShift.TimeOfDay).Negate();

                    employeeViewModel.Shift.MissingTime = littleTime;
                    employeeViewModel.Shift.WorkTime = ((dt2 + new TimeSpan(24, 0, 0)) - dt1);
                    employeeViewModel.Shift.OverTime = TimeSpan.Parse("00:00:00");
                }
            }
            else
            {
                if (timeHourFormat > normalShift.TimeOfDay)   // Fazla mesai durumu
                {
                    var overTime = (((dt2.TimeOfDay) - dt1.TimeOfDay) - normalShift.TimeOfDay);  //((Çıkış saati - Giriş Saati)-Normal çalışma süresi)

                    employeeViewModel.Shift.WorkTime = timeHourFormat;
                    employeeViewModel.Shift.OverTime = overTime;
                    employeeViewModel.Shift.MissingTime = TimeSpan.Parse("00:00:00");
                }
                else if (timeHourFormat < normalShift.TimeOfDay)  // Eksik mesai durumu
                {
                    var littleTime = (((dt2.TimeOfDay) - dt1.TimeOfDay) - normalShift.TimeOfDay).Negate();  // Eksik mesai süresi negatif çkacağından pozitife çevriliyor

                    employeeViewModel.Shift.MissingTime = littleTime;
                    employeeViewModel.Shift.WorkTime = (dt2 - dt1);
                    employeeViewModel.Shift.OverTime = TimeSpan.Parse("00:00:00");
                }
                else // Tam mesai yapma durumu
                {
                    employeeViewModel.Shift.WorkTime = (dt2 - dt1);
                    employeeViewModel.Shift.OverTime = TimeSpan.Parse("00:00:00");
                    employeeViewModel.Shift.MissingTime = TimeSpan.Parse("00:00:00");
                }
            }

            employeeViewModel.Shift.EntryTime = TimeSpan.Parse(employeeViewModel.Time.EHour + ":" + employeeViewModel.Time.EMinute); // Giriş Saati
            employeeViewModel.Shift.ExitTime = TimeSpan.Parse(employeeViewModel.Time.XHour + ":" + employeeViewModel.Time.XMinute); // Çıkış saati

            string donem = Convert.ToString(employeeViewModel.Shift.ShiftDate).Substring(3, 2) + "/" //Mesai Tarihi -> Dd.Mm.YYYY Hh.Mm.Ss 
                         + Convert.ToString(employeeViewModel.Shift.ShiftDate).Substring(6, 4);
            employeeViewModel.Shift.Period = donem;


            db.Shift.Add(employeeViewModel.Shift);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        [HttpGet]
            public ActionResult Document(int id)
        {
            DateTime today = DateTime.Now;

            List<Shift> listOfShift = db.Shift.Where(p => p.EmployeeID == id && p.Period == ("0" + (today.Month.ToString())) + "/" + (today.Year.ToString())).ToList();
            List<Shift> listOfShift2 = new List<Shift>();


            foreach (var shift in listOfShift)
            {
                if (shift.MissingTime != TimeSpan.Zero || shift.OverTime != TimeSpan.Zero)
                {
                    modelForDocument.ListOfShift.Add(shift);
                }
            }

            modelForDocument.Employee = db.Employees.Find(id);
            ViewBag.Period = new SelectList(db.Shift.Where(s => s.EmployeeID == id).Select(m => m.Period).Distinct(), "Dönem");
            return View(modelForDocument);
        }

        [HttpGet]
        public ActionResult AllTime(int id)
        {
            List<Shift> listOfShift = db.Shift.Where(p => p.EmployeeID == id).ToList();

            modelForDocument.Employee = db.Employees.Find(id);
            modelForDocument.ListOfShift = listOfShift;
            return View(modelForDocument);
        }


        [HttpGet]
        public ActionResult Calculate(DocumentModel documentModel)
        {
            
            
            if (documentModel.Shift.Period == null) // Null değer döndürülürse ana sayfaya yönlendiriyor.
            {
                int id = documentModel.Employee.EmployeeID;
                return RedirectToAction("Index" );
            }           
              
            // Model icerisindeki ana modellere atama gerceklesitiriliyor.
            modelForDocument.Employee = db.Employees.Find(documentModel.Employee.EmployeeID);
            //Secilen doneme ve personele ait mesailer cekiliyor.
            modelForDocument.ListOfShift = db.Shift.Where(s => s.Period == documentModel.Shift.Period && s.EmployeeID == documentModel.Employee.EmployeeID).ToList();

            DateTime initTime = DateTime.Parse("00:00"); // Sonrasında fark alarak arada gecen zamani bulmak icin olusturulmus degisken
            DateTime totalOverTime = DateTime.Parse("00:00"); // Fazla mesailerin toplam suresi
            DateTime totalLittleTime = DateTime.Parse("00:00");  // Eksik mesailerin toplam suresi

            foreach (var item in modelForDocument.ListOfShift)
            {
                if (item.EmployeeID == modelForDocument.Employee.EmployeeID)
                {
                    totalOverTime += (TimeSpan)item.OverTime;
                    totalLittleTime += (TimeSpan)item.MissingTime;
                }
            } 
            int overHour = CalculateTotalHour(totalOverTime); // Fazla mesai için hesaplama
            int overMinute = CalculateTotalMinute(totalOverTime);

            int littleHour = CalculateTotalHour(totalLittleTime);  // Eksik mesai için hesaplama
            int littleMinute = CalculateTotalMinute(totalLittleTime);

            DateTime total = DateTime.Parse("00:00");
            TimeSpan totalTime = totalOverTime - totalLittleTime;
            total = total + totalTime;
            
            int totalHour = CalculateTotalHour(total); // Gönderilen zamanın saat cinsinden değeri hesaplanıyor
            int totalMinute = CalculateTotalMinute(total); // Gönderilen zamanın dakika cinsinden değeri hesaplanıyor


            ViewBag.overTime = (overHour.ToString() + " h " + overMinute.ToString() + " m");
            ViewBag.litleTime = (littleHour.ToString() + " h " + littleMinute.ToString() + " m");

            ViewBag.total = (totalHour.ToString() + " h " + totalMinute.ToString()+ " m");

            return View(modelForDocument);
        }

        public ActionResult SendMail(int id)
        {
            if (ModelState.IsValid)
            {
                var employee = db.Employees.Find(id);
                
                var body = new StringBuilder();
                body.AppendLine("Sayın "+ employee.EmployeeName+" "+employee.EmployeeSurname );              
                body.AppendLine("Bulunulan ay içerisindeki toplam mesai durumunuz şu şekildedir :" + employee.Total);
                body.AppendLine("----TAKOSAN ----");
                Mail.MailSender(body.ToString(),employee.Email);
            }
           
            return RedirectToAction("Index");
        }

        public int CalculateTotalHour(DateTime totalTime) // Gönderilen zamanın saat cinsinden değeri hesaplanıyor
        {
            DateTime initTime = DateTime.Parse("00:00");

            string totalHour = ((totalTime - initTime).TotalHours).ToString(); // (DateTime - DateTime) -> TimeSpan 
           
            if (totalHour.IndexOf(",") != -1)   // Total Hour : 6,345 -> 6 (Virgulden sonrasi siliniyor. Dakika bilgisi)
            {
                totalHour = totalHour.Remove(totalHour.IndexOf(","));
            }
            int hour = Convert.ToInt32(totalHour);           

            return hour;
        }

        public int CalculateTotalMinute(DateTime totalTime) // Gönderilen zamanın dakika cinsinden değeri hesaplanıyor
        {
            DateTime initTime = DateTime.Parse("00:00");
           
            string totalMinute = ((totalTime - initTime).TotalMinutes).ToString();

            int minute = Convert.ToInt32(totalMinute);
            minute = minute % 60;  //Modunu alarak devreden dakika bulunuyor
            if (minute < 0)
                minute = minute * -1;
            return minute;
        }


    }
}