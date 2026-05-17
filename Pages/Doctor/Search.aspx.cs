using System;
using System.Web.UI.WebControls;

namespace MediCare.Pages.Doctor
{
    public partial class Search : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void gvMedicines_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "AddMedicine")
            {
                int id = Convert.ToInt32(e.CommandArgument);

                // your logic here
            }
        }
    }
}