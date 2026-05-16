using System;
using System.Data;
using System.Data.SqlClient;

namespace MediCare.Pages.Account
{
    public partial class NewPassword : System.Web.UI.Page
    {
        private readonly string connectionString =
            System.Configuration.ConfigurationManager
            .ConnectionStrings["DefaultConnection"]
            .ConnectionString;

        private string Email
        {
            get { return Request.QueryString["email"]; }
        }

        protected SqlConnection GetConnection()
        {
            return new SqlConnection(connectionString);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(Email))
            {
                Response.Redirect("ForgotPassword.aspx");
                return;
            }
        }

        protected void btnSavePassword_Click(object sender, EventArgs e)
        {
            lblNewPwdError.Visible = false;
            lblConfirmPwdError.Visible = false;

            if (!ValidateReset(out string errorMessage))
            {
                if (errorMessage.Contains("match"))
                {
                    lblConfirmPwdError.Text = errorMessage;
                    lblConfirmPwdError.Visible = true;
                }
                else
                {
                    lblNewPwdError.Text = errorMessage;
                    lblNewPwdError.Visible = true;
                }

                return;
            }

            string hash = BCrypt.Net.BCrypt.HashPassword(txtNewPassword.Text);

            using (SqlConnection conn = GetConnection())
            {
                conn.Open();

                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandType = CommandType.Text;

                    cmd.CommandText = @"
                        UPDATE Users
                        SET PasswordHash = @Pass,
                            ResetCode = NULL,
                            ResetExpiry = NULL,
                            ResetAttempts = 0,
                            ResetLockedUntil = NULL
                        WHERE Email = @Email";

                    cmd.Parameters.AddWithValue("@Pass", hash);
                    cmd.Parameters.AddWithValue("@Email", Email);

                    int rows = cmd.ExecuteNonQuery();

                    if (rows == 0)
                    {
                        lblNewPwdError.Text = "Invalid email.";
                        lblNewPwdError.Visible = true;
                        return;
                    }
                }
            }

            Response.Redirect("Login.aspx");
        }

        private bool ValidateReset(out string errorMessage)
        {
            errorMessage = null;

            if (string.IsNullOrWhiteSpace(txtNewPassword.Text))
            {
                errorMessage = "Password required.";
                return false;
            }

            if (txtNewPassword.Text.Length < 8)
            {
                errorMessage = "Minimum 8 characters required.";
                return false;
            }

            if (txtNewPassword.Text != txtConfirmPassword.Text)
            {
                errorMessage = "Passwords do not match.";
                return false;
            }

            return true;
        }
    }
}