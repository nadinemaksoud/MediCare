<%@ Page Title="Profile – MediCare"
    Language="C#"
    MasterPageFile="~/MasterPage/PatientSite.Master"
    AutoEventWireup="true"
    CodeBehind="PatientProfile.aspx.cs"
    Inherits="MediCare.Pages.Patient.PatientProfile" %>

<asp:Content ID="HeadExtra" ContentPlaceHolderID="HeadContent" runat="server">

<link rel="stylesheet" href="/css/profile.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="pro-root">

    <!-- HEADER -->
    <div class="pro-header">
        <div class="pro-header__left">
            <div class="pro-avatar">
                <i class="fa-solid fa-user"></i>
            </div>

            <div>
                <h1 class="pro-title">
                    <asp:Label ID="lblName" runat="server" />
                </h1>
                <p class="pro-subtitle">Profile Dashboard</p>
            </div>
        </div>

        <div class="pro-header__actions">
            <button type="button" id="btnEdit" class="pro-btn pro-btn--outline-light">
                <i class="fa-solid fa-pen"></i> Edit
            </button>
        </div>
    </div>

    <!-- GRID -->
    <div class="pro-grid">

        <!-- ACCOUNT -->
        <div class="pro-card">
            <div class="pro-card__header">
                <h2>Account Information</h2>
            </div>

            <div class="pro-card__body">

                <div class="pro-field">
                    <label>Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="pro-input" />
                </div>

                <div class="pro-field">
                    <label>Role</label>
                    <asp:TextBox ID="txtRole" runat="server" CssClass="pro-input" ReadOnly="true" />
                </div>

                <div class="pro-field">
                    <label>Created At</label>
                    <asp:TextBox ID="txtCreatedAt" runat="server" CssClass="pro-input" ReadOnly="true" />
                </div>

            </div>
        </div>

        <!-- PROFILE -->
        <div class="pro-card">
            <div class="pro-card__header">
                <h2>Profile Information</h2>
            </div>

            <div class="pro-card__body">

                <div class="pro-field">
                    <label>Full Name</label>
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="pro-input" />
                </div>

                <div class="pro-field">
                    <label>Age</label>
                    <asp:TextBox ID="txtAge" runat="server" CssClass="pro-input" TextMode="Number" />
                </div>

                <div class="pro-field">
                    <label>Height (cm)</label>
                    <asp:TextBox ID="txtHeight" runat="server" CssClass="pro-input" TextMode="Number" />
                </div>

                <div class="pro-field">
                    <label>Weight (kg)</label>
                    <asp:TextBox ID="txtWeight" runat="server" CssClass="pro-input" TextMode="Number" />
                </div>

                <div class="pro-field">
                    <label>Blood Type</label>
                    <asp:DropDownList ID="ddlBloodType" runat="server" CssClass="pro-input">
                        <asp:ListItem Text="Select..." Value="" />
                        <asp:ListItem Text="A+" Value="A+" />
                        <asp:ListItem Text="O+" Value="O+" />
                        <asp:ListItem Text="B+" Value="B+" />
                        <asp:ListItem Text="AB+" Value="AB+" />
                    </asp:DropDownList>
                </div>

                <div class="pro-field">
                    <label>Chronic Disease</label>
                    <asp:TextBox ID="txtDisease" runat="server" CssClass="pro-input" />
                </div>

                <div class="pro-field">
                    <label>Disability</label>
                    <asp:TextBox ID="txtDisability" runat="server" CssClass="pro-input" />
                </div>

                <div class="pro-field">
                    <label>Family History</label>
                    <asp:TextBox ID="txtFamilyHistory" runat="server" CssClass="pro-input pro-textarea" TextMode="MultiLine" Rows="3" />
                </div>

            </div>
        </div>

    </div>

    <!-- ACTIONS -->
    <div class="pro-actions" id="actions">
        <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="pro-btn pro-btn--primary" />
        <button type="button" id="btnCancel" class="pro-btn pro-btn--gray">Cancel</button>
    </div>

</div>

<script>
    (function () {

        const inputs = document.querySelectorAll(".pro-input");
        const btnEdit = document.getElementById("btnEdit");
        const btnCancel = document.getElementById("btnCancel");
        const actions = document.getElementById("actions");

        let original = {};

        function setMode(editable) {

            inputs.forEach(i => {
                if (editable) {
                    i.readOnly = false;
                    i.disabled = false;
                    i.classList.remove("is-locked");
                } else {
                    i.readOnly = true;
                    i.classList.add("is-locked");
                }
            });

            actions.style.display = editable ? "flex" : "none";
            btnEdit.style.display = editable ? "none" : "inline-flex";
        }

        function init() {
            inputs.forEach(i => {
                original[i.id] = i.value;
            });

            setMode(false);
        }

        btnEdit.addEventListener("click", () => {
            setMode(true);
        });

        btnCancel.addEventListener("click", () => {

            inputs.forEach(i => {
                if (original[i.id] !== undefined)
                    i.value = original[i.id];
            });

            setMode(false);
        });

        init();

    })();
</script>

</asp:Content>