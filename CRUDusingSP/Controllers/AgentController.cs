using CRUDusingSP.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CRUDusingSP.Controllers
{
    public class AgentController : Controller
    {

        private readonly SPPracticeEntities dbObj = new SPPracticeEntities();
        // GET: Agent
        public ActionResult Index(string SearchString,int? SortColumn, string SortOrder = "asc", int Cpage = 1)
        {

            ViewBag.NameSortParam = SortOrder=="asc" && SortColumn==2 ? "desc" : "asc";
            //ViewBag.NameSortParam = SortOrder == "Name" ? "Name_desc" : "Name";


            ViewBag.CPage = Cpage;
            var pagesize = 5;
            var agentlist = dbObj.PageAgentList(SearchString,Cpage, pagesize,SortOrder,SortColumn).ToList();
            var agents = dbObj.Agents.ToList();
            ViewBag.PageCount = (int)Math.Ceiling((double)((decimal)agents.Count() / pagesize));
            return View(agentlist);
        }

        // GET: Agent/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Agent/Create
        [HttpPost]
        public ActionResult Create(Agent age)
        {
            try
            {
                // TODO: Add insert logic here
                if (ModelState.IsValid) //checking model is valid or not    
                {
                    dbObj.AddAgent(age.AgentName,age.WorkingArea,age.Commission,age.PhoneNo,age.Country);
                    dbObj.SaveChanges();
                    ModelState.Clear();  
                    return RedirectToAction("Index");
                }

                else
                {
                    ModelState.AddModelError("", "Error in saving data");
                    return View();
                }
            }
            catch
            {
                return View();
            }
        }

        // GET: Agent/Edit/5
        public ActionResult Edit(int id)
        {
            var agent = dbObj.FindAgent(id).FirstOrDefault();
            return View(agent);
        }

        // POST: Agent/Edit/5
        [HttpPost]
        public ActionResult Edit(int id, Agent age)
        {
            try
            {
                // TODO: Add update logic here
                dbObj.UpdateAgent(id,age.AgentName, age.WorkingArea, age.Commission, age.PhoneNo, age.Country);
                dbObj.SaveChanges();
                ModelState.Clear(); 
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: Agent/Delete/5
        public ActionResult Delete(int id)
        {
            try
            {
                // TODO: Add delete logic here
                dbObj.DeleteAgent(id);
                dbObj.SaveChanges();
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
