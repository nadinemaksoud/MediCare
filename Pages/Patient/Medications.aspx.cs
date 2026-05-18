using System;
using System.Collections.Generic;
using System.Linq;

namespace MediCare.Pages.Patient
{
    public partial class Medications : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindApprovedMedications();
                
            }
        }

        // =========================
        // APPROVED MEDICATIONS
        // =========================
        private void BindApprovedMedications(string search = "")
        {
            // TODO: fetch from DB using user ID and search term
            var approved = GetApprovedMedicationsFromDb(search);
            gvApprovedMedications.DataSource = approved;
            gvApprovedMedications.DataBind();
        }

        protected void btnSearchApproved_Click(object sender, EventArgs e)
        {
            string query = txtSearchApproved.Text.Trim();
            BindApprovedMedications(query);
        }

        // =========================
        // CUSTOM MEDICATIONS
        // =========================
        
        protected void btnSaveCustomMed_Click(object sender, EventArgs e)
        {
            
        }

        protected void btnDeleteCustom_Command(object sender, System.Web.UI.WebControls.CommandEventArgs e)
        { 
        }

        // =========================
        // STATIC DEMO DATA (replace with DB)
        // =========================
        private List<ApprovedMedicationItem> GetApprovedMedicationsFromDb(string search)
        {
            var list = new List<ApprovedMedicationItem>
            {
                new ApprovedMedicationItem { Medication = "Panadol", PillsNumber = 2, Dosage = "500mg", Frequency = "Twice daily", StartDate = DateTime.Now.AddDays(-10), EndDate = DateTime.Now.AddDays(20) },
                new ApprovedMedicationItem { Medication = "Amoxicillin", PillsNumber = 1, Dosage = "250mg", Frequency = "Three times daily", StartDate = DateTime.Now.AddDays(-5), EndDate = DateTime.Now.AddDays(5) }
            };

            if (!string.IsNullOrWhiteSpace(search))
                return list.Where(m => m.Medication.ToLower().Contains(search.ToLower())).ToList();
            return list;
        }


        // Model classes
        private class ApprovedMedicationItem
        {
            public string Medication { get; set; }
            public int PillsNumber { get; set; }
            public string Dosage { get; set; }
            public string Frequency { get; set; }
            public DateTime StartDate { get; set; }
            public DateTime EndDate { get; set; }
        }
    }
}