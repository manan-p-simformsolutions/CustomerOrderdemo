using CRUDusingSP.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CRUDusingSP.Controllers
{
    public class ShowListController : Controller
    {
        private readonly SPPracticeEntities dbObj = new SPPracticeEntities();

        // GET: ShowList
        public ActionResult Index(DateTime? Startdate, DateTime? EndDate,int? SortColumn,string SortOrder, int Cpage = 1)
        {
            ViewBag.NameSortParam = SortOrder == "asc" && SortColumn == 2 ? "desc" : "asc";
            ViewBag.DateSortParam = SortOrder == "asc" && SortColumn == 3 ? "desc" : "asc";
            ViewBag.CPage = Cpage;
            var pagesize = 5;
            var orders = dbObj.ShowList(Cpage, pagesize,Startdate,EndDate,SortColumn,SortOrder).ToList();
            var ordertotal = dbObj.Orders.ToList();
            ViewBag.PageCount = (int)Math.Ceiling((double)((decimal)ordertotal.Count() / pagesize));
            return View(orders);
        }
    }
}
