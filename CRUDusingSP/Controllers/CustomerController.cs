using CRUDusingSP.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CRUDusingSP.Controllers
{
    public class CustomerController : Controller
    {
        private readonly SPPracticeEntities dbObj = new SPPracticeEntities();

        // GET: Customer
        public ActionResult Index(string SearchString, int? SortColumn, string SortOrder = "asc", int Cpage = 1)
        {
            ViewBag.NameSortParam = SortOrder == "asc" && SortColumn == 2 ? "desc" : "asc";
            ViewBag.CPage = Cpage;
            var pagesize = 5;
            var customers = dbObj.CustomerList(SearchString, Cpage, pagesize, SortOrder, SortColumn).ToList();
            var customersTotal = dbObj.Customers.ToList();
            ViewBag.PageCount = (int)Math.Ceiling((double)((decimal)customersTotal.Count() / pagesize));
            return View(customers);
        }

        // GET: Customer/Create
        public ActionResult Create()
        {
            ViewBag.AgentCode = dbObj.Agents.ToList();
            return View();
        }

        // POST: Customer/Create
        [HttpPost]
        public ActionResult Create(Customer cus)
        {
            try
            {
                // TODO: Add insert logic here
                dbObj.AddCustomer(cus.FirstName, cus.LastName, cus.CustomerCity, cus.WorkingArea, cus.CustomerCountry,
                    cus.Gread, cus.OpeningAmount, cus.RecevingAmount, cus.PaymentAmount, cus.OutstandingAmount, cus.PhoneNo, cus.AgentCode);
                dbObj.SaveChanges();
                ModelState.Clear();
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: Customer/Edit/5
        public ActionResult Edit(int id)
        {
            ViewBag.AgentCode = dbObj.Agents.ToList();
            var customer = dbObj.FindCustomer(id).FirstOrDefault();
            return View(customer);
        }

        // POST: Customer/Edit/5
        [HttpPost]
        public ActionResult Edit(int id, Customer cus)
        {
            try
            {
                // TODO: Add update logic here
                dbObj.UpdateCustomer(id, cus.FirstName, cus.LastName, cus.CustomerCity, cus.WorkingArea, cus.CustomerCountry,
                    cus.Gread, cus.OpeningAmount, cus.RecevingAmount, cus.PaymentAmount, cus.OutstandingAmount, cus.PhoneNo, cus.AgentCode);
                dbObj.SaveChanges();
                ModelState.Clear();
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: Customer/Delete/5
        public ActionResult Delete(int id)
        {
            dbObj.DeleteCustomer(id);
            dbObj.SaveChanges();
            return RedirectToAction("Index");
        }
    }
}
