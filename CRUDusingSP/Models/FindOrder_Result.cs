//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace CRUDusingSP.Models
{
    using System;
    
    public partial class FindOrder_Result
    {
        public int OrderNum { get; set; }
        public Nullable<decimal> OrderAmount { get; set; }
        public Nullable<decimal> AdvanceAmount { get; set; }
        public Nullable<System.DateTime> OrderDate { get; set; }
        public int CustomerCode { get; set; }
        public string OrderDescription { get; set; }
    }
}
