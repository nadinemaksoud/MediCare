using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace MediCare.Pages.Account
{
    public partial class DoctorProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            EnsureDoctorId();
            if (!IsPostBack)
            {
                ToggleEditMode(false);
            }
        }

        private void EnsureDoctorId()
        {
            if (Session["DoctorId"] == null && Session["UserId"] != null)
            {
                string connStr = System.Configuration.ConfigurationManager
                    .ConnectionStrings["DefaultConnection"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connStr))
                using (SqlCommand cmd = new SqlCommand("SELECT DoctorId FROM Doctors WHERE UserId = @UserId", conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", Convert.ToInt32(Session["UserId"]));
                    conn.Open();
                    object doctorIdObj = cmd.ExecuteScalar();
                    if (doctorIdObj != null)
                    {
                        Session["DoctorId"] = Convert.ToInt32(doctorIdObj);
                    }
                }
            }
        }


        // ── Edit mode helpers ──────────────────────────────
        private void ToggleEditMode(bool editing)
        {
            // Banner fields
            txtSpecialty.ReadOnly = !editing;
            txtExperience.ReadOnly = !editing;
            txtDepartment.ReadOnly = !editing;
            txtLicense.ReadOnly = !editing;

            // Contact fields
            txtPhone.ReadOnly = !editing;
            txtEmail.ReadOnly = !editing;
            txtClinicAddress.ReadOnly = !editing;

            // Professional details
            txtSubSpecialty.ReadOnly = !editing;
            txtDepartmentProf.ReadOnly = !editing;
            txtLanguages.ReadOnly = !editing;
            txtYearsExperience.ReadOnly = !editing;
            txtConsultationFee.ReadOnly = !editing;
            txtLicenseProf.ReadOnly = !editing;

            // Buttons
            btnEdit.Visible = !editing;
            btnSave.Visible = editing;
            btnCancel.Visible = editing;
        }

        // ── Edit button click ──────────────────────────────
        protected void btnEdit_Click(object sender, EventArgs e)
        {
            ToggleEditMode(true);
        }
        
        // ── Cancel button click ────────────────────────────
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ToggleEditMode(false);
        }

        // ── Save button click ──────────────────────────────
        protected void btnSave_Click(object sender, EventArgs e)
        {
            // Ensure doctor id is present
            if (Session["DoctorId"] == null)
            {
                EnsureDoctorId();
            }

            if (Session["DoctorId"] == null)
            {
                lblError.Text = "Doctor identity not available. Please sign in again.";
                lblError.Visible = true;
                return;
            }

            int doctorId;
            try
            {
                doctorId = Convert.ToInt32(Session["DoctorId"]);
            }
            catch
            {
                lblError.Text = "Invalid doctor identity.";
                lblError.Visible = true;
                return;
            }

            string connStr = System.Configuration.ConfigurationManager
                                .ConnectionStrings["DefaultConnection"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    string query = @"UPDATE Doctors
                             SET Specialty = @Specialty,
                                 Experience = @Experience,
                                 Department = @Department,
                                 License = @License,
                                 PhoneNumber = @Phone,
                                 Email = @Email,
                                 ClinicAddress = @ClinicAddress,
                                 SubSpecialty = @SubSpecialty,
                                 DepartmentProf = @DepartmentProf,
                                 Languages = @Languages,
                                 YearsExperience = @YearsExperience,
                                 ConsultationFee = @ConsultationFee,
                                 LicenseProf = @LicenseProf
                             WHERE DoctorId = @DoctorId";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        

                        // Other parameters (kept simple; convert/validate as needed)
                        cmd.Parameters.AddWithValue("@Specialty", txtSpecialty.Text);
                        cmd.Parameters.AddWithValue("@Experience", txtExperience.Text);
                        cmd.Parameters.AddWithValue("@Department", txtDepartment.Text);
                        cmd.Parameters.AddWithValue("@License", txtLicense.Text);
                        cmd.Parameters.AddWithValue("@Phone", txtPhone.Text);
                        cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                        cmd.Parameters.AddWithValue("@ClinicAddress", txtClinicAddress.Text);
                        cmd.Parameters.AddWithValue("@SubSpecialty", txtSubSpecialty.Text);
                        cmd.Parameters.AddWithValue("@DepartmentProf", txtDepartmentProf.Text);
                        cmd.Parameters.AddWithValue("@Languages", txtLanguages.Text);
                        cmd.Parameters.AddWithValue("@YearsExperience", txtYearsExperience.Text);
                        cmd.Parameters.AddWithValue("@ConsultationFee", txtConsultationFee.Text);
                        cmd.Parameters.AddWithValue("@LicenseProf", txtLicenseProf.Text);
                        // Typed doctor id parameter
                        cmd.Parameters.Add("@DoctorId", System.Data.SqlDbType.Int).Value = doctorId;

                        cmd.ExecuteNonQuery();
                    }
                }

                ToggleEditMode(false);
            }
            catch (Exception)
            {
                lblError.Text = "An error occurred while saving the profile.";
                lblError.Visible = true;
                // log the exception as appropriate
            }
        }

        protected void btnAddSlot_Click(object sender, EventArgs e)
        {
            // Ensure we have a doctor id in session
            if (Session["DoctorId"] == null)
            {
                EnsureDoctorId();
            }

            if (Session["DoctorId"] == null)
            {
                lblError.Text = "Doctor identity not available. Please sign in again.";
                lblError.Visible = true;
                return;
            }

            int doctorId;
            try
            {
                doctorId = Convert.ToInt32(Session["DoctorId"]);
            }
            catch
            {
                lblError.Text = "Invalid doctor identity.";
                lblError.Visible = true;
                return;
            }

            DateTime startTime, endTime;
            if (!DateTime.TryParse(txtStartTime.Text, out startTime) ||
                !DateTime.TryParse(txtEndTime.Text, out endTime))
            {
                lblError.Text = "Please enter valid date and time values (e.g., 2026-05-19 14:30).";
                lblError.Visible = true;
                return;
            }

            string connStr = System.Configuration.ConfigurationManager
                .ConnectionStrings["DefaultConnection"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    string query = @"INSERT INTO DoctorAvailability (DoctorId, StartTime, EndTime)
                                     VALUES (@DoctorId, @StartTime, @EndTime)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        // ensure session value exists (after your existing checks)
                        int doctorId = Convert.ToInt32(Session["DoctorId"]); // keep your try/catch earlier

                        // strongly-typed parameters — do not use AddWithValue
                        cmd.Parameters.Add("@DoctorId", SqlDbType.Int).Value = doctorId;
                        cmd.Parameters.Add("@StartTime", SqlDbType.DateTime).Value = startTime;
                        cmd.Parameters.Add("@EndTime", SqlDbType.DateTime).Value = endTime;

                        cmd.ExecuteNonQuery();
                    }
                }

                var ds = (SqlDataSource)FindControl("SqlDataSourceAvailability"); // replace with your ID
                if (ds != null)
                {
                    ds.SelectParameters["DoctorId"].DefaultValue = doctorId.ToString();
                }
                gvAvailability.DataBind();
            }
            catch (Exception ex)
            {
                // Log exception as appropriate for your app (omitted here)
                lblError.Text = "An error occurred while saving the availability.";
                lblError.Visible = true;
            }
        }



        protected void gvAvailability_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteSlot")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                int slotId = Convert.ToInt32(gvAvailability.DataKeys[rowIndex].Value);

                string connStr = System.Configuration.ConfigurationManager
                                    .ConnectionStrings["DefaultConnection"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    string query = "DELETE FROM DoctorAvailability WHERE AvailabilityId = @Id";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Id", slotId);
                        cmd.ExecuteNonQuery();
                    }
                }

                gvAvailability.DataBind();
            }
        }

    }
}