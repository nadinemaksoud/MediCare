<%@ Page Title="Medications – MediCare" 
    Language="C#" 
    MasterPageFile="~/MasterPage/PatientSite.Master" 
    AutoEventWireup="true" 
    CodeBehind="Medications.aspx.cs" 
    Inherits="MediCare.Pages.Patient.Medications" %>

<asp:Content ID="HeadExtra" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" href="/css/medications.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
</asp:Content>

<asp:Content ID="PageContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="med-root">

    <!-- PAGE HEADER -->
    <div class="med-page-header">
        <div class="med-page-header__left">
            <div class="med-page-header__icon">
                <i class="fa-solid fa-pills"></i>
            </div>
            <div>
                <h1 class="med-page-header__title">My Medications</h1>
                <p class="med-page-header__sub">Manage your prescriptions and personal medications</p>
            </div>
        </div>
    </div>

    <!-- MAIN TWO-COLUMN GRID -->
    <div class="med-main-grid">

        <!-- LEFT CARD — APPROVED MEDICATIONS -->
        <div class="med-card">
            <div class="med-card__header">
                <div class="med-card__title-group">
                    <div class="med-card__icon med-card__icon--green">
                        <i class="fa-solid fa-clipboard-check"></i>
                    </div>
                    <div>
                        <h2 class="med-card__title">My Medications</h2>
                        <p class="med-card__subtitle">my planned medications</p>
                    </div>
                </div>
            </div>

            <!-- Server‑side search row -->

            <div class="med-search-row">
                <div class="med-search-wrap">
                    <i class="fa-solid fa-magnifying-glass med-search-icon"></i>
                    <asp:TextBox ID="txtSearchApproved" runat="server" CssClass="med-search-input"
                        placeholder="Search medications..." />
                </div>
                <asp:Button ID="btnSearchApproved" runat="server"
                    CssClass="med-btn med-btn--search"
                    Text="Search" OnClick="btnSearchApproved_Click" />
            </div>

            <!-- Message label -->
            <asp:Label ID="lblApprovedMsg" runat="server" CssClass="med-inline-msg" Visible="false" />

            <div class="med-table-wrap">
                <asp:GridView ID="gvApprovedMedications" runat="server"
                    CssClass="med-grid"
                    AutoGenerateColumns="False"
                    ShowHeader="True"
                    GridLines="None"
                    EmptyDataText="No approved medications found.">
                    <Columns>
                        <asp:BoundField DataField="Medication" HeaderText="Medication" />
                        <asp:BoundField DataField="PillsNumber" HeaderText="Pills" />
                        <asp:BoundField DataField="Dosage" HeaderText="Dosage" />
                        <asp:BoundField DataField="Frequency" HeaderText="Frequency" />
                        <asp:BoundField DataField="StartDate" HeaderText="Start Date" DataFormatString="{0:yyyy-MM-dd}" />
                        <asp:BoundField DataField="EndDate" HeaderText="End Date" DataFormatString="{0:yyyy-MM-dd}" />
                    </Columns>
                </asp:GridView>
            </div>

            <div class="med-card__footer">
                <a href="Search.aspx" class="med-btn med-btn--primary">
                    <i class="fa-solid fa-plus"></i> Add Medication
                </a>
            </div>
        </div>

        <!-- RIGHT CARD — CUSTOM MEDICATIONS -->
        <div class="med-card med-card--collapsible">
            <div class="med-card__header med-card__header--clickable"
                 id="btnToggleCustom"
                 onclick="toggleCustomForm()"
                 role="button" tabindex="0"
                 aria-expanded="false"
                 aria-controls="customFormBody">
                <div class="med-card__title-group">
                    <div class="med-card__icon med-card__icon--purple">
                        <i class="fa-solid fa-wand-magic-sparkles"></i>
                    </div>
                    <div>
                        <h2 class="med-card__title">Add Custom Medication</h2>
                        <p class="med-card__subtitle">Log a medication not in our database</p>
                    </div>
                </div>
                <div class="med-collapse-arrow" id="collapseArrow">
                    <i class="fa-solid fa-chevron-down"></i>
                </div>
            </div>

            <!-- Collapsible body with server‑side form -->
            <div class="med-collapse-body" id="customFormBody" aria-hidden="true">
                <div class="med-custom-form">
                    <div class="med-form-row">
                        <div class="med-form-group">
                            <label class="med-label">Medication Name <span class="med-required">*</span></label>
                            <asp:TextBox ID="txtMedName" runat="server" CssClass="med-input" />
                        </div>
                        <div class="med-form-group">
                            <label class="med-label">Dosage <span class="med-required">*</span></label>
                            <asp:TextBox ID="txtDosage" runat="server" CssClass="med-input" />
                        </div>
                    </div>
                    <div class="med-form-row">
                        <div class="med-form-group">
                            <label class="med-label">Frequency <span class="med-required">*</span></label>
                            <asp:DropDownList ID="ddlFrequency" runat="server" CssClass="med-input">
                                <asp:ListItem Text="Select frequency..." Value="" />
                                <asp:ListItem Text="Once daily" />
                                <asp:ListItem Text="Twice daily" />
                                <asp:ListItem Text="Three times daily" />
                                <asp:ListItem Text="Every 8 hours" />
                                <asp:ListItem Text="As needed" />
                                <asp:ListItem Text="Weekly" />
                            </asp:DropDownList>
                        </div>
                        <div class="med-form-group">
                            <label class="med-label">Start Date</label>
                            <asp:TextBox ID="txtStartDate" runat="server" CssClass="med-input" TextMode="Date" />
                        </div>
                        <div class="med-form-group">
                            <label class="med-label">End Date</label>
                            <asp:TextBox ID="txtEndDate" runat="server" CssClass="med-input" TextMode="Date" />
                        </div>
                    </div>
                    <div class="med-form-row">
                        <div class="med-form-group">
                            <label class="med-label">Pill Count <span class="med-required">*</span></label>
                            <asp:TextBox ID="txtPillCount" runat="server" CssClass="med-input" TextMode="Number" />
                        </div>
                    </div>
                    <div class="med-form-footer">
                        <asp:Label ID="lblCustomMsg" runat="server" CssClass="med-inline-msg" Visible="false" />
                        <asp:Button ID="btnSaveCustomMed" runat="server" CssClass="med-btn med-btn--save"
                            Text="Save Medication" OnClick="btnSaveCustomMed_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- DESIGN-ONLY JAVASCRIPT -->
<script>
    (function () {
        /* Card entrance animation */
        document.querySelectorAll('.med-card').forEach(function (card, i) {
            card.style.opacity = '0';
            card.style.transform = 'translateY(22px)';
            card.style.transition = 'opacity .5s ease, transform .5s ease';
            card.style.transitionDelay = (i * 100) + 'ms';
            setTimeout(function () {
                card.style.opacity = '1';
                card.style.transform = 'translateY(0)';
            }, 60);
        });

        /* Collapse header keyboard support */
        var collapseHeader = document.getElementById('btnToggleCustom');
        if (collapseHeader) {
            collapseHeader.addEventListener('keydown', function (e) {
                if (e.key === 'Enter' || e.key === ' ') {
                    e.preventDefault();
                    window.toggleCustomForm();
                }
            });
        }

        /* Toggle collapsible custom form */
        window.toggleCustomForm = function () {
            var body = document.getElementById('customFormBody');
            var arrow = document.getElementById('collapseArrow');
            var header = document.getElementById('btnToggleCustom');
            var isOpen = body.classList.contains('med-collapse-body--open');

            if (isOpen) {
                body.style.maxHeight = body.scrollHeight + 'px';
                requestAnimationFrame(function () { body.style.maxHeight = '0px'; });
                setTimeout(function () {
                    body.classList.remove('med-collapse-body--open');
                    body.setAttribute('aria-hidden', 'true');
                }, 350);
                arrow.classList.remove('med-collapse-arrow--open');
                header.setAttribute('aria-expanded', 'false');
            } else {
                body.classList.add('med-collapse-body--open');
                body.setAttribute('aria-hidden', 'false');
                body.style.maxHeight = '0px';
                requestAnimationFrame(function () {
                    body.style.maxHeight = body.scrollHeight + 'px';
                });
                setTimeout(function () { body.style.maxHeight = 'none'; }, 360);
                arrow.classList.add('med-collapse-arrow--open');
                header.setAttribute('aria-expanded', 'true');
            }
        };

    })();
</script>

</asp:Content>