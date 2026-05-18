


using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace MediCare.Patient
{
    public partial class Dashboard : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPatientInfo();
                LoadDoses();
                LoadInventory();
                LoadDoctors();
            }
        }

        // =========================
        // PATIENT INFO (demo)
        // =========================
        private void LoadPatientInfo()
        {
            lblGreeting.Text = "Good morning,";
            lblPatientName.Text = "John Doe";
            lblCurrentDate.Text = DateTime.Now.ToString("dddd, MMMM d");
            lblPatientStatus.Text = "Active";

            lblHeight.Text = "175";
            lblWeight.Text = "72";
            lblCalories.Text = "2200";
            lblBloodType.Text = "A+";
            lblAge.Text = "34";
            lblDisease.Text = "None";
            lblDisability.Text = "None";
            lblFamilyHistory.Text = "Diabetes";
        }

        // =========================
        // DOSES
        // =========================
        private void LoadDoses()
        {
           
        }


        protected void chkTaken_CheckedChanged(object sender, EventArgs e)
        {
            
        }

        protected void gvDoses_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            
        }

        // =========================
        // INVENTORY
        // =========================
        private void LoadInventory()
        {
            
        }

        // =========================
        // DOCTORS
        // =========================
        protected void gvDoctors_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var statusLabel = (Label)e.Row.FindControl("lblStatus");
                if (statusLabel != null)
                {
                    string status = statusLabel.Text.Trim().ToLower();
                    if (status == "pending")
                        statusLabel.CssClass = "pd-doctor-status-badge pd-doctor-status-badge--pending";
                    else
                        statusLabel.CssClass = "pd-doctor-status-badge"; // default green
                }
            }
        }
        private void LoadDoctors()
        {
            
        }

    }
}

