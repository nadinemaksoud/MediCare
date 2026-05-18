<%@ Page Title="Nutritions – MediCare"
    Language="C#"
    MasterPageFile="~/MasterPage/PatientSite.Master"
    AutoEventWireup="true"
    CodeBehind="Nutritions.aspx.cs"
    Inherits="MediCare.Pages.Patient.Nutritions" %>

<asp:Content ID="HeadExtra" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" href="/css/nutritions.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
</asp:Content>

<asp:Content ID="PageContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="nut-root">

    <!-- HEADER -->
    <div class="nut-page-header">
        <div class="nut-page-header__left">
            <div class="nut-page-header__icon">
                <i class="fa-solid fa-bowl-food"></i>
            </div>
            <div>
                <h1 class="nut-page-header__title">Nutrition Center</h1>
                <p class="nut-page-header__sub">
                    Search foods by macros and manage your nutrition plans
                </p>
            </div>
        </div>
    </div>

    <!-- SMART FOOD SEARCH -->
    <div class="nut-card">
        <div class="nut-card__header">
            <div class="nut-card__title-group">
                <div class="nut-card__icon nut-card__icon--purple">
                    <i class="fa-solid fa-magnifying-glass"></i>
                </div>
                <div>
                    <h2 class="nut-card__title">Smart Food Search</h2>
                    <p class="nut-card__subtitle">Find foods with similar nutrition values</p>
                </div>
            </div>
        </div>
        <div class="nut-custom-form">
            <div class="nut-form-row">
                <div class="nut-form-group">
                    <label class="nut-label">Calories</label>
                    <asp:TextBox ID="txtCalories" runat="server" CssClass="nut-input" TextMode="Number" />
                </div>
                <div class="nut-form-group">
                    <label class="nut-label">Protein</label>
                    <asp:TextBox ID="txtProtein" runat="server" CssClass="nut-input" TextMode="Number" />
                </div>
                <div class="nut-form-group">
                    <label class="nut-label">Carbs</label>
                    <asp:TextBox ID="txtCarbs" runat="server" CssClass="nut-input" TextMode="Number" />
                </div>
                <div class="nut-form-group">
                    <label class="nut-label">Fat</label>
                    <asp:TextBox ID="txtFat" runat="server" CssClass="nut-input" TextMode="Number" />
                </div>
            </div>
            <div class="nut-form-footer">
                <asp:Label ID="lblSearchMsg" runat="server" CssClass="nut-inline-msg" Visible="false" />
                <asp:Button ID="btnSearchFoods" runat="server"
                    Text="Search Foods"
                    CssClass="nut-btn nut-btn--primary"
                    OnClick="btnSearchFoods_Click" />
            </div>
        </div>
    </div>

    <!-- SEARCH RESULTS -->
    <div class="nut-card">
        <div class="nut-card__header">
            <h2 class="nut-card__title">Search Results</h2>
        </div>
        <asp:GridView ID="gvSearchResults" runat="server"
            CssClass="nut-grid"
            AutoGenerateColumns="False"
            GridLines="None"
            EmptyDataText="No foods found. Try adjusting your search.">
            <Columns>
                <asp:BoundField DataField="Name" HeaderText="Food" />
                <asp:BoundField DataField="Calories" HeaderText="Calories" />
                <asp:BoundField DataField="Protein" HeaderText="Protein" />
                <asp:BoundField DataField="Carbs" HeaderText="Carbs" />
                <asp:BoundField DataField="Fat" HeaderText="Fat" />
            </Columns>
        </asp:GridView>
    </div>

    <!-- NUTRITION PLAN (DOCTOR + PATIENT) -->
    <div class="nut-card">
        <div class="nut-card__header">
            <div class="nut-card__title-group">
                <div class="nut-card__icon nut-card__icon--green">
                    <i class="fa-solid fa-clipboard-list"></i>
                </div>
                <div>
                    <h2 class="nut-card__title">Nutrition Plan</h2>
                    <p class="nut-card__subtitle">
                        Doctor recommendation vs your personal plan
                    </p>
                </div>
            </div>
        </div>
        <asp:GridView ID="gvNutritionPlan" runat="server"
            CssClass="nut-grid"
            AutoGenerateColumns="False"
            GridLines="None"
            EmptyDataText="No nutrition plan available.">
            <Columns>
                <asp:BoundField DataField="Source" HeaderText="Type" />
                <asp:BoundField DataField="Calories" HeaderText="Calories" />
                <asp:BoundField DataField="Protein" HeaderText="Protein" />
                <asp:BoundField DataField="Carbs" HeaderText="Carbs" />
                <asp:BoundField DataField="Fiber" HeaderText="Fiber" />
                <asp:BoundField DataField="Fat" HeaderText="Fat" />
            </Columns>
        </asp:GridView>
    </div>

    <!-- MY NUTRITION PLAN EDITOR -->
    <div class="nut-card">
        <div class="nut-card__header">
            <div class="nut-card__title-group">
                <div class="nut-card__icon nut-card__icon--blue">
                    <i class="fa-solid fa-user-pen"></i>
                </div>
                <div>
                    <h2 class="nut-card__title">My Nutrition Plan</h2>
                    <p class="nut-card__subtitle">Create or update your personal targets</p>
                </div>
            </div>
        </div>
        <div class="nut-custom-form">
            <div class="nut-form-row">
                <div class="nut-form-group">
                    <label class="nut-label">Calories</label>
                    <asp:TextBox ID="txtMyCalories" runat="server" CssClass="nut-input" TextMode="Number" />
                </div>
                <div class="nut-form-group">
                    <label class="nut-label">Protein</label>
                    <asp:TextBox ID="txtMyProtein" runat="server" CssClass="nut-input" TextMode="Number" />
                </div>
                <div class="nut-form-group">
                    <label class="nut-label">Carbs</label>
                    <asp:TextBox ID="txtMyCarbs" runat="server" CssClass="nut-input" TextMode="Number" />
                </div>
                <div class="nut-form-group">
                    <label class="nut-label">Fiber</label>
                    <asp:TextBox ID="txtMyFiber" runat="server" CssClass="nut-input" TextMode="Number" />
                </div>
                <div class="nut-form-group">
                    <label class="nut-label">Fat</label>
                    <asp:TextBox ID="txtMyFat" runat="server" CssClass="nut-input" TextMode="Number" />
                </div>
            </div>
            <div class="nut-form-footer">
                <asp:Label ID="lblPlanMsg" runat="server" CssClass="nut-inline-msg" Visible="false" />
                <asp:Button ID="btnSaveMyPlan" runat="server"
                    Text="Save My Plan"
                    CssClass="nut-btn nut-btn--primary"
                    OnClick="btnSaveMyPlan_Click" />
            </div>
        </div>
    </div>

    <!-- ADD CUSTOM FOOD -->
    <div class="nut-card">
        <div class="nut-card__header">
            <h2 class="nut-card__title">Add Custom Food</h2>
        </div>
        <div class="nut-custom-form">
            <div class="nut-form-row">
                <div class="nut-form-group">
                    <label class="nut-label">Food Name</label>
                    <asp:TextBox ID="txtFoodName" runat="server" CssClass="nut-input" />
                </div>
                <div class="nut-form-group">
                    <label class="nut-label">Calories</label>
                    <asp:TextBox ID="txtFoodCalories" runat="server" CssClass="nut-input" TextMode="Number" />
                </div>
                <div class="nut-form-group">
                    <label class="nut-label">Protein</label>
                    <asp:TextBox ID="txtFoodProtein" runat="server" CssClass="nut-input" TextMode="Number" />
                </div>
                <div class="nut-form-group">
                    <label class="nut-label">Carbs</label>
                    <asp:TextBox ID="txtFoodCarbs" runat="server" CssClass="nut-input" TextMode="Number" />
                </div>
                <div class="nut-form-group">
                    <label class="nut-label">Fat</label>
                    <asp:TextBox ID="txtFoodFat" runat="server" CssClass="nut-input" TextMode="Number" />
                </div>
            </div>
            <div class="nut-form-footer">
                <asp:Label ID="lblFoodMsg" runat="server" CssClass="nut-inline-msg" Visible="false" />
                <asp:Button ID="btnSaveFood" runat="server"
                    Text="Save Food"
                    CssClass="nut-btn nut-btn--primary"
                    OnClick="btnSaveFood_Click" />
            </div>
        </div>
    </div>

    <!-- CUSTOM FOODS LIST -->
    <div class="nut-card" id="cardCustomFoods" runat="server" visible="false">
        <div class="nut-card__header">
            <h2 class="nut-card__title">My Custom Foods</h2>
        </div>
        <asp:GridView ID="gvCustomFoods" runat="server"
            CssClass="nut-grid"
            AutoGenerateColumns="False"
            GridLines="None"
            EmptyDataText="No custom foods added yet."
            OnRowCommand="gvCustomFoods_RowCommand">
            <Columns>
                <asp:BoundField DataField="Name" HeaderText="Food" />
                <asp:BoundField DataField="Calories" HeaderText="Calories" />
                <asp:BoundField DataField="Protein" HeaderText="Protein" />
                <asp:BoundField DataField="Carbs" HeaderText="Carbs" />
                <asp:BoundField DataField="Fat" HeaderText="Fat" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="btnDeleteFood" runat="server"
                            Text="Delete"
                            CssClass="nut-btn nut-btn--delete"
                            CommandName="DeleteFood"
                            CommandArgument='<%# Eval("Id") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>

</div>

</asp:Content>