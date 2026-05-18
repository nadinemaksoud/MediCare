using System;
using System.Collections.Generic;
using System.Linq;

namespace MediCare.Pages.Patient
{
    public partial class Nutritions : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadNutritionPlan();
                LoadCustomFoods();
                LoadUserPlan();
            }
        }

        // =========================
        // SMART FOOD SEARCH
        // =========================
        protected void btnSearchFoods_Click(object sender, EventArgs e)
        {

        }


        // =========================
        // NUTRITION PLAN
        // =========================
        private void LoadNutritionPlan()
        {

        }

        private void LoadUserPlan()
        {

        }

        protected void btnSaveMyPlan_Click(object sender, EventArgs e)
        {

        }

        // =========================
        // CUSTOM FOODS
        // =========================
        private void LoadCustomFoods()
        {

        }

        protected void btnSaveFood_Click(object sender, EventArgs e)
        {
        }

        protected void gvCustomFoods_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {

        }

    }
}