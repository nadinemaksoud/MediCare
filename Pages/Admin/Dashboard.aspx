<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="MediCare.Pages.Admin.Dashboard" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Dashboard — MediCare Admin</title>
    
  <link rel="stylesheet" href="/css/admin.css" />
  <link rel="stylesheet" href="/css/def.css" />

   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link rel="icon"
      href="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 32 32'%3E%3Crect width='32' height='32' rx='8' fill='%231A9E5C'/%3E%3Ctext x='6' y='23' font-size='20'%3E%E2%9A%95%3C/text%3E%3C/svg%3E" />
</head>
<body class="mc-admin-body">
  <form id="form1" runat="server">
 <!-- ══ ADMIN NAVBAR ══ -->

 <nav class="mc-navbar">
   <a class="mc-navbar__logo" href="Dashboard.aspx">
     <div class="mc-navbar__logo-icon">  <i class="fa-solid fa-staff-snake"></i></div>
     MediCare
   </a>
   <ul class="mc-navbar__links">
    <li><a href="/Pages/Admin/Dashboard.aspx"    data-page="dashboard"   >Dashboard</a></li>
   
 <li><a href="/Pages/Admin/DoctorManagement.aspx"      data-page="doctors"     >Doctors</a></li>
 <li><a href="/Pages/Admin/PatientManagement.aspx"     data-page="patients"    >Patients</a></li>
 <li><a href="/Pages/Admin/FoodCatalog.aspx"         data-page="food"        >Food</a></li>
 <li><a href="/Pages/Admin/MedicineCatalog.aspx"     data-page="medicine"    >Medicine</a></li>
   </ul>
   <div class="mc-navbar__actions">
     <div class="mc-profile-dropdown">
       <div class="mc-profile-trigger">
         <div class="mc-avatar" style="background:linear-gradient(135deg,#34C679,#1A9E5C);width:30px;height:30px;font-size:0.75rem">AD</div>
         <span>Admin</span>
         <span style="color:var(--text-muted);font-size:0.75rem"><i class="fa-solid fa-chevron-down" style="color:var(--text-muted);font-size:0.75rem"></i></span>
       </div>
       <div class="mc-dropdown-menu">
         <a href="Profile.aspx"> <i class="fa-solid fa-user"></i> My Profile</a>
         <a href="#"><i class="fa-solid fa-gear"></i> Settings</a>
         <a href="Default.aspx" style="color:#DC2626">  <i class="fa-solid fa-right-from-bracket"></i> Logout</a>
       </div>
     </div>
     <button class="mc-navbar__hamburger" id="hamburgerBtn"><span></span><span></span><span></span></button>
   </div>
 </nav>
 <div class="mc-navbar__mobile" id="mobileNav">
   <a href="Dashboard.aspx">Dashboard</a>
   <a href="Appointments.aspx">Appointments</a>
   <a href="Doctors.aspx">Doctors</a>
   <a href="Patients.aspx">Patients</a>
   <a href="Food.aspx">Food</a>
   <a href="Medicine.aspx">Medicine</a>
 </div>

 <main class="mc-admin-main">
 

    <!-- Page Header -->
    <div class="mc-page-header">
      <div>
        <div class="mc-breadcrumb"> <i class="fa-solid fa-staff-snake"></i> MediCare <span>/ Dashboard</span></div>
        <h1>Good morning, Dr. Admin <i class="fa-solid fa-hand-wave"></i></h1>
        <p>Here's what's happening across your healthcare system today.</p>
      </div>
     
    </div>

   <!-- ── STAT CARDS ── -->
<div class="mc-stat-cards-grid">

  <!-- Doctors -->
  <div class="mc-stat-card mc-stat-card--green">
    <div class="mc-stat-card__icon">
      <!-- stethoscope -->
      <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
        <path d="M6 3v6a3 3 0 0 0 6 0V3" stroke="currentColor" stroke-width="2"/>
        <path d="M18 3v10a4 4 0 0 1-8 0" stroke="currentColor" stroke-width="2"/>
        <circle cx="18" cy="17" r="3" stroke="currentColor" stroke-width="2"/>
      </svg>
    </div>
    <div class="mc-stat-card__body">
      <div class="mc-stat-card__label">Total Doctors</div>
      <div class="mc-stat-card__value" data-count="48"><asp:Label ID="lblDoctors" runat="server"
                CssClass="mc-stat-card__value"
                Text="48">
            </asp:Label></div>
      
    </div>
  </div>

  <!-- Patients -->
  <div class="mc-stat-card mc-stat-card--blue">
    <div class="mc-stat-card__icon">
      <!-- users -->
      <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
        <path d="M16 11a4 4 0 1 0-8 0a4 4 0 0 0 8 0z" stroke="currentColor" stroke-width="2"/>
        <path d="M4 20c2-4 14-4 16 0" stroke="currentColor" stroke-width="2"/>
      </svg>
    </div>
    <div class="mc-stat-card__body">
      <div class="mc-stat-card__label">Total Patients</div>
      
      <asp:Label ID="lblPatients" runat="server"
                CssClass="mc-stat-card__value"
                Text="2847">
            </asp:Label>
    </div>
  </div>

  <!-- Foods -->
  <div class="mc-stat-card mc-stat-card--orange">
    <div class="mc-stat-card__icon">
      <!-- apple / food -->
      <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
        <path d="M12 8c-3-3-7-1-7 3 0 5 4 9 7 9s7-4 7-9c0-4-4-6-7-3z"
              stroke="currentColor" stroke-width="2"/>
      </svg>
    </div>
    <div class="mc-stat-card__body">
      <div class="mc-stat-card__label">Total  Foods</div>
                  <asp:Label ID="lblFoods" runat="server"
                CssClass="mc-stat-card__value"
                Text="312">
            </asp:Label>

     
    </div>
  </div>

  <!-- Medicines -->
  <div class="mc-stat-card mc-stat-card--purple">
    <div class="mc-stat-card__icon">
      <!-- pill -->
      <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
        <path d="M4 12a6 6 0 0 1 10-4l4 4a6 6 0 0 1-10 4l-4-4z"
              stroke="currentColor" stroke-width="2"/>
      </svg>
    </div>
    <div class="mc-stat-card__body">
      <div class="mc-stat-card__label">Total Medicines</div>
 <asp:Label ID="lblMedicines" runat="server"
                CssClass="mc-stat-card__value"
                Text="584">
            </asp:Label>
   
    </div>
  </div>

</div>
  <!-- ── MAIN CONTENT GRID ── -->
<div class="mc-dashboard-grid">

  <!-- LEFT COLUMN -->
  <div style="display:flex;flex-direction:column;gap:1.5rem">

    <!-- Recent Patients -->
    <div class="mc-card mc-card--flat" style="padding:0;overflow:hidden">
      <div style="padding:1.25rem 1.5rem;border-bottom:1px solid var(--border-light);display:flex;align-items:center;justify-content:space-between">
        <h4 style="font-family:var(--font-body);font-size:1rem">Recent Patients</h4>
        <a href="Patients.aspx" class="mc-btn mc-btn--outline mc-btn--sm">View All</a>
      </div>

      <div class="mc-table-wrap" style="border:none;border-radius:0;box-shadow:none">
        <!-- table 그대로 -->
       <asp:GridView ID="gvPatients" runat="server" AutoGenerateColumns="False" 
    CssClass="mc-table" GridLines="None">
    
    <Columns>

       <asp:TemplateField HeaderText="Patient">
    <ItemTemplate>

        <div class="mc-table-name">

            <asp:Panel ID="pnlAvatar"
                runat="server"
                CssClass="mc-avatar">
                
                <%# Eval("Initials") %>

            </asp:Panel>

            <%# Eval("Name") %>

        </div>

    </ItemTemplate>
</asp:TemplateField>


       
        <asp:BoundField DataField="Age" HeaderText="Age" />

        
        <asp:BoundField DataField="Contact" HeaderText="Contact" />

    </Columns>

</asp:GridView>
      </div>
    </div>

  </div>

  
  <div style="display:flex;flex-direction:column;gap:1.5rem">

    
    <div style="display:grid;grid-template-columns:1fr;gap:1rem">

      <a href="Doctors.aspx" class="mc-card" style="text-align:center;text-decoration:none">
        <div style="font-size:1.75rem;margin-bottom:0.5rem">
          <i class="fa-solid fa-user-doctor"></i>
        </div>
        <div style="font-weight:600;font-size:0.9rem;color:var(--text-primary)">Manage Doctors</div>
        <div style="font-size:0.78rem;color:var(--text-muted);margin-top:4px"><asp:Label ID="lblDoctorCount" runat="server" Text="48"></asp:Label></div>
      </a>

      <a href="Medicine.aspx" class="mc-card" style="text-align:center;text-decoration:none">
        <div style="font-size:1.75rem;margin-bottom:0.5rem">
          <i class="fa-solid fa-pills"></i>
        </div>
        <div style="font-weight:600;font-size:0.9rem;color:var(--text-primary)">Medicines</div>
        <div style="font-size:0.78rem;color:var(--text-muted);margin-top:4px"> <asp:Label ID="lblMedicineCount" runat="server" Text="584"></asp:Label></div>
      </a>

      <a href="Food.aspx" class="mc-card" style="text-align:center;text-decoration:none">
        <div style="font-size:1.75rem;margin-bottom:0.5rem">
          <i class="fa-solid fa-apple-whole"></i>
        </div>
        <div style="font-weight:600;font-size:0.9rem;color:var(--text-primary)">Food & Nutrition</div>
        <div style="font-size:0.78rem;color:var(--text-muted);margin-top:4px"><asp:Label ID="lblFoodCount" runat="server" Text="312"></asp:Label></div>
      </a>

    </div>

  </div>

</div>
   
  </main>
  </form>
   <script src="/js/def.js"></script>
</body>
</html>
