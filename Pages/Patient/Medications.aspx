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

    <!-- ══════════════════════════════════════
         PAGE HEADER
    ══════════════════════════════════════ -->
    <div class="med-page-header">
        <div class="med-page-header__left">
            <div class="med-page-header__icon">
                <i class="fa-solid fa-pills"></i>
            </div>
            <div>
                <h1 class="med-page-header__title">Medications</h1>
                <p class="med-page-header__sub">Manage your prescriptions and personal medications</p>
            </div>
        </div>
        
    </div>

    <!-- ══════════════════════════════════════
         MAIN TWO-COLUMN GRID
    ══════════════════════════════════════ -->
    <div class="med-main-grid">

        <!-- ════════════════════════════
             LEFT CARD — APPROVED MEDICATIONS
        ════════════════════════════ -->
        <div class="med-card" id="cardApproved">
            <div class="med-card__header">
                <div class="med-card__title-group">
                    <div class="med-card__icon med-card__icon--green">
                        <i class="fa-solid fa-clipboard-check"></i>
                    </div>
                    <div>
                        <h2 class="med-card__title">Approved Medications</h2>
                        <p class="med-card__subtitle">Prescribed by your doctor</p>
                    </div>
                </div>
            </div>

            <!-- Search Box -->
            <div class="med-search-wrap">
                <i class="fa-solid fa-magnifying-glass med-search-icon"></i>
                <input type="text" id="txtSearchApproved" class="med-search-input" placeholder="Search medications..." oninput="filterApprovedGrid(this.value)" />
            </div>

         
            <!-- GridView -->
        <div class="med-table-wrap">

            <asp:GridView ID="tblApproved" runat="server"
                CssClass="med-grid"
                AutoGenerateColumns="False"
                ShowHeader="True"
                GridLines="None">

                <Columns>

                    <asp:TemplateField HeaderText="">
                        <HeaderTemplate>
                            <span><i class="fa-solid fa-pills"></i> Medication</span>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <div class="med-grid-pill">
                                <div class="med-pill-dot med-pill-dot--green"></div>
                                <span class="med-grid-name"><%# Eval("Medication") %></span>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField DataField="Dosage" HeaderText="Dosage"
                        ItemStyle-CssClass="med-grid-cell" />

                    <asp:BoundField DataField="Frequency" HeaderText="Frequency"
                        ItemStyle-CssClass="med-grid-cell" />

                    <asp:TemplateField HeaderText="Start">
                        <ItemTemplate>
                            <span class="med-grid-cell med-grid-cell--muted">
                                <%# Eval("StartDate", "{0:yyyy-MM-dd}") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="End">
                        <ItemTemplate>
                            <span class="med-grid-cell med-grid-cell--muted">
                                <%# Eval("EndDate", "{0:yyyy-MM-dd}") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>

                <HeaderStyle CssClass="med-grid-header" />
                <RowStyle CssClass="med-grid-row" />
                <AlternatingRowStyle CssClass="med-grid-row med-grid-row--alt" />

            </asp:GridView>

            <!-- Empty state (unchanged) -->
            <div class="med-empty-state" id="emptyApproved" style="display:none;">
                <div class="med-empty-state__icon">
                    <i class="fa-solid fa-pills"></i>
                </div>
                <p class="med-empty-state__text">No medications found.</p>
                <p class="med-empty-state__sub">Try a different search term.</p>
            </div>

        </div>

        <!-- Footer Button -->
        <div class="med-card__footer">
            <a href="Search.aspx" class="med-btn med-btn--primary">
                <i class="fa-solid fa-plus"></i>
                Add New Medication
            </a>
        </div>

        <!-- ════════════════════════════
             RIGHT CARD — MY OWN MEDICATIONS
        ════════════════════════════ -->
        <div class="med-card" id="cardOwn">
            <div class="med-card__header">
                <div class="med-card__title-group">
                    <div class="med-card__icon med-card__icon--blue">
                        <i class="fa-solid fa-user-nurse"></i>
                    </div>
                    <div>
                        <h2 class="med-card__title">My Own Medications</h2>
                        <p class="med-card__subtitle">Self-reported medications</p>
                    </div>
                </div>
            </div>

            <!-- Own Meds Table -->
            <div class="med-table-wrap">
                <asp:GridView ID="tblOwn" runat="server"
                    CssClass="med-grid"
                    AutoGenerateColumns="False"
                    ShowHeader="True"
                    GridLines="None">

                    <Columns>
                        <asp:TemplateField HeaderText="">
                            <HeaderTemplate>
                                <span><i class="fa-solid fa-capsules"></i> Medication</span>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div class="med-grid-pill">
                                    <div class="med-pill-dot med-pill-dot--blue"></div>
                                    <span class="med-grid-name"><%# Eval("Medication") %></span>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="Dosage" HeaderText="Dosage"
                            ItemStyle-CssClass="med-grid-cell" />

                        <asp:BoundField DataField="Frequency" HeaderText="Frequency"
                            ItemStyle-CssClass="med-grid-cell" />

                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <span class='<%# Eval("StatusCssClass") %>'>
                                    <i class='<%# Eval("StatusIcon") %>'></i>
                                    <%# Eval("StatusText") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="">
                            <ItemTemplate>
                                <button class="med-delete-btn" onclick="deleteOwnRow(this)" title="Delete">
                                    <i class="fa-solid fa-trash-can"></i>
                                </button>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>

                    <HeaderStyle CssClass="med-grid-header" />
                    <RowStyle CssClass="med-grid-row" />
                    <AlternatingRowStyle CssClass="med-grid-row med-grid-row--alt" />
                </asp:GridView>

                <!-- Empty state -->
                <div class="med-empty-state" id="emptyOwn" style="display:none;">
                    <div class="med-empty-state__icon"><i class="fa-solid fa-capsules"></i></div>
                    <p class="med-empty-state__text">No personal medications added.</p>
                    <p class="med-empty-state__sub">Use the form below to add your own.</p>
                </div>
            </div>

            <!-- Approval Request Bar -->
            <div class="med-approval-bar">
                <div class="med-approval-bar__label">
                    <i class="fa-solid fa-paper-plane"></i>
                    <span>Request doctor approval</span>
                </div>
                <div class="med-approval-bar__controls">
                    <a href="Search.aspx" class="med-btn med-btn--teal">
                        <i class="fa-solid fa-paper-plane"></i>
                        Find Doctor
                    </a>
                </div>
            </div>


            <div id="requestMsg" class="med-inline-msg" style="display:none; margin: 0 26px 16px;"></div>

        </div>

    </div>

    <!-- ══════════════════════════════════════
         CUSTOM MEDICATION COLLAPSIBLE CARD
    ══════════════════════════════════════ -->
    <div class="med-card med-card--collapsible">
        <!-- Keep header as plain HTML so JS toggle works -->
        <div class="med-card__header med-card__header--clickable"
             id="btnToggleCustom"
             onclick="toggleCustomForm()"
             role="button"
             tabindex="0"
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

        <!-- Collapsible Body -->
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
                        <asp:DropDownList ID="ddlFrequency" runat="server" CssClass="med-input med-select-inline">
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

                <div class="med-form-row med-form-row--full">
                    <div class="med-form-group med-form-group--full">
                        <label class="med-label">Notes <small>(optional)</small></label>
                        <asp:TextBox ID="txtNotes" runat="server" CssClass="med-input med-textarea" TextMode="MultiLine" Rows="3" />
                    </div>
                </div>

                <div class="med-form-footer">
                    <asp:Label ID="lblCustomMsg" runat="server" CssClass="med-inline-msg" Visible="false"></asp:Label>
                    <asp:Button ID="btnSaveCustomMed" runat="server" CssClass="med-btn med-btn--save"
                        Text="Save Medication" />
                </div>

            </div>
        </div>
    </div>


</div>

<!-- ══════════════════════════════════════
     ALL PAGE JAVASCRIPT
══════════════════════════════════════ -->
<script>
(function () {

    /* ── Card entrance animation ──────────────────────────────── */
    document.querySelectorAll('.med-card').forEach(function (card, i) {
        card.style.opacity    = '0';
        card.style.transform  = 'translateY(22px)';
        card.style.transition = 'opacity .5s ease, transform .5s ease';
        card.style.transitionDelay = (i * 100) + 'ms';
        setTimeout(function () {
            card.style.opacity   = '1';
            card.style.transform = 'translateY(0)';
        }, 60);
    });

    /* ── Collapse header keyboard support ─────────────────────── */
    var collapseHeader = document.getElementById('btnToggleCustom');
    if (collapseHeader) {
        collapseHeader.addEventListener('keydown', function (e) {
            if (e.key === 'Enter' || e.key === ' ') {
                e.preventDefault();
                window.toggleCustomForm();
            }
        });
    }

    /* ── Live search filter for approved table ────────────────── */
    window.filterApprovedGrid = function (query) {
        query = query.toLowerCase();
        var rows  = document.querySelectorAll('#tblApproved tbody tr');
        var empty = document.getElementById('emptyApproved');
        var shown = 0;

        rows.forEach(function (row) {
            var match = row.textContent.toLowerCase().indexOf(query) !== -1;
            row.style.display = match ? '' : 'none';
            if (match) shown++;
        });

        if (empty) empty.style.display = shown === 0 ? 'block' : 'none';
    };

    /* ── Delete own medication row ────────────────────────────── */
    window.deleteOwnRow = function (btn) {
        if (!confirm('Remove this medication?')) return;
        var row   = btn.closest('tr');
        var tbody = document.querySelector('#tblOwn tbody');
        row.style.transition = 'opacity .3s ease, transform .3s ease';
        row.style.opacity    = '0';
        row.style.transform  = 'translateX(20px)';
        setTimeout(function () {
            row.remove();
            var remaining = tbody.querySelectorAll('tr').length;
            var empty     = document.getElementById('emptyOwn');
            if (empty) empty.style.display = remaining === 0 ? 'block' : 'none';
        }, 300);
    };

    /* ── Send approval request ────────────────────────────────── */
    window.sendApprovalRequest = function () {
        var select  = document.getElementById('ddlDoctor');
        var msgBox  = document.getElementById('requestMsg');
        var doctors = ['Dr. Ahmad Karimi', 'Dr. Sara Hassan', 'Dr. Karim Mansour'];

        if (!select.value) {
            showMsg(msgBox, 'error', '⚠ Please select a doctor first.');
            return;
        }
        var docName = select.options[select.selectedIndex].text;
        showMsg(msgBox, 'success', '✓ Approval request sent to ' + docName + ' successfully.');
        select.selectedIndex = 0;
    };

    /* ── Toggle collapsible custom form ───────────────────────── */
    window.toggleCustomForm = function () {
        var body   = document.getElementById('customFormBody');
        var arrow  = document.getElementById('collapseArrow');
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

    /* ── Save custom medication ───────────────────────────────── */
    window.saveCustomMed = function () {
        var name  = document.getElementById('txtMedName');
        var dose  = document.getElementById('txtDosage');
        var freq  = document.getElementById('ddlFrequency');
        var msgBox = document.getElementById('customMsg');
        var valid  = true;

        function setErr(input, errId, show) {
            var errEl = document.getElementById(errId);
            if (errEl) errEl.style.display = show ? 'block' : 'none';
            input.style.borderColor = show ? '#EF4444' : '';
        }

        setErr(name, 'errMedName',   !name.value.trim());
        setErr(dose, 'errDosage',    !dose.value.trim());
        setErr(freq, 'errFrequency', !freq.value);

        if (!name.value.trim() || !dose.value.trim() || !freq.value) return;

        /* Add row to own table */
        var tbody = document.querySelector('#tblOwn tbody');
        var empty = document.getElementById('emptyOwn');
        var rows  = tbody.querySelectorAll('tr');
        var isAlt = rows.length % 2 !== 0;

        var tr = document.createElement('tr');
        tr.className = 'med-grid-row' + (isAlt ? ' med-grid-row--alt' : '');
        tr.style.opacity   = '0';
        tr.style.transform = 'translateY(-10px)';
        tr.style.transition = 'opacity .35s ease, transform .35s ease';
        tr.innerHTML =
            '<td><div class="med-grid-pill"><div class="med-pill-dot med-pill-dot--blue"></div>' +
            '<span class="med-grid-name">' + escHtml(name.value.trim()) + '</span></div></td>' +
            '<td class="med-grid-cell">' + escHtml(dose.value.trim()) + '</td>' +
            '<td class="med-grid-cell">' + escHtml(freq.options[freq.selectedIndex].text) + '</td>' +
            '<td><span class="med-status-badge med-status-badge--orange"><i class="fa-solid fa-clock"></i> Pending</span></td>' +
            '<td><button class="med-delete-btn" onclick="deleteOwnRow(this)" title="Delete"><i class="fa-solid fa-trash-can"></i></button></td>';

        tbody.appendChild(tr);
        requestAnimationFrame(function () {
            tr.style.opacity   = '1';
            tr.style.transform = 'translateY(0)';
        });
        if (empty) empty.style.display = 'none';

        showMsg(msgBox, 'success', '✓ ' + escHtml(name.value.trim()) + ' added successfully!');

        /* Reset form */
        name.value  = '';
        dose.value  = '';
        freq.selectedIndex = 0;
        document.getElementById('txtStartDate').value = '';
        document.getElementById('txtEndDate').value   = '';
        document.getElementById('txtNotes').value     = '';
    };

    /* ── Helpers ──────────────────────────────────────────────── */
    function showMsg(el, type, text) {
        el.className = 'med-inline-msg med-inline-msg--' + type;
        el.textContent = text;
        el.style.display = 'inline-flex';
        setTimeout(function () {
            el.style.opacity = '0';
            el.style.transition = 'opacity .4s ease';
            setTimeout(function () {
                el.style.display  = 'none';
                el.style.opacity  = '1';
                el.style.transition = '';
            }, 400);
        }, 4000);
    }

    function escHtml(str) {
        return str.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;');
    }

})();
</script>

    </div>
</asp:Content>