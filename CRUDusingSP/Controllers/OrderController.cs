using CRUDusingSP.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CRUDusingSP.Controllers
{
    public class OrderController : Controller
    {
        private readonly SPPracticeEntities dbObj = new SPPracticeEntities();
        // GET: Order
        public ActionResult Index(string SearchString, int? SortColumn, string SortOrder = "asc", int Cpage = 1)
        {
            ViewBag.NameSortParam = SortOrder == "asc" && SortColumn == 2 ? "desc" : "asc";

            ViewBag.CPage = Cpage;
            var pagesize = 5;
            var orders = dbObj.OrderList(SearchString, Cpage, pagesize, SortOrder, SortColumn).ToList();
            var ordertotal = dbObj.Orders.ToList();
            ViewBag.PageCount = (int)Math.Ceiling((double)((decimal)ordertotal.Count() / pagesize));
            return View(orders);
        }

        // GET: Order/Create
        public ActionResult Create()
        {
            ViewBag.CustomerCode = dbObj.Customers.ToList();
            return View();
        }

        // POST: Order/Create
        [HttpPost]
        public ActionResult Create(Order ord)
        {
            try
            {
                // TODO: Add insert logic here
                dbObj.AddOrder(ord.OrderAmount, ord.AdvanceAmount, ord.OrderDate, ord.CustomerCode, ord.OrderDescription);
                dbObj.SaveChanges();
                ModelState.Clear();
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: Order/Edit/5
        public ActionResult Edit(int id)
        {
            ViewBag.CustomerCode = dbObj.Customers.ToList();
            var order = dbObj.FindOrder(id).FirstOrDefault();
            return View(order);
        }

        // POST: Order/Edit/5
        [HttpPost]
        public ActionResult Edit(int id, Order ord)
        {
            try
            {
                // TODO: Add update logic here
                dbObj.UpdeteOrder(id, ord.OrderAmount, ord.AdvanceAmount, ord.OrderDate, ord.CustomerCode, ord.OrderDescription);
                dbObj.SaveChanges();
                ModelState.Clear();
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        public ActionResult Delete(int id)
        {
            dbObj.DeleteOrder(id);
            dbObj.SaveChanges();
            return RedirectToAction("Index");
        }
    }
}
