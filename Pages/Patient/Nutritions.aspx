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

    <!-- PAGE HEADER -->
    <div class="nut-page-header">
        <div class="nut-page-header__left">
            <div class="nut-page-header__icon">
                <i class="fa-solid fa-bowl-food"></i>
            </div>
            <div>
                <h1 class="nut-page-header__title">Nutritions</h1>
                <p class="nut-page-header__sub">Meal plans, nutrition targets, and your personal food log</p>
            </div>
        </div>
    </div>

   <!-- TOP CONTROLS -->
    <div class="nut-toolbar">
        <div class="nut-toolbar__left">
            <!-- FILTER -->
            <div class="nut-filter-group">
                <label class="nut-label">Filter by nutrition</label>

                <div class="nut-filter-row">

                    <select id="ddlNutFilter"
                            class="nut-select"
                            onchange="filterNutritionPlan()">

                        <option value="">All foods</option>
                        <option value="highprotein">High protein</option>
                        <option value="highfiber">High fiber</option>
                        <option value="highcarb">High carbs</option>
                        <option value="highfat">High fat</option>
                        <option value="lowcal">Low calorie</option>

                    </select>

                    <!-- CALORIES TEXTBOX -->
                    <input type="number"
                           id="txtCaloriesFilter"
                           class="nut-input nut-input--small"
                           placeholder="Max calories"
                           onkeyup="filterNutritionPlan()" />
                </div>
            </div>
        </div>

        <div class="nut-toolbar__right">
            <span class="nut-toolbar__hint">
                <i class="fa-solid fa-circle-info"></i>
                Foods are filtered instantly based on calories and nutrition type
            </span>
        </div>
    </div>

    <!-- MAIN GRID -->
    <div class="nut-main-grid">

        <!-- NUTRITION PLAN -->
        <div class="nut-card">
            <div class="nut-card__header">
                <div class="nut-card__title-group">
                    <div class="nut-card__icon nut-card__icon--green">
                        <i class="fa-solid fa-plate-wheat"></i>
                    </div>
                    <div>
                        <h2 class="nut-card__title">Nutrition Plan</h2>
                        <p class="nut-card__subtitle">Breakfast, lunch, and snack suggestions based on patient needs</p>
                    </div>
                </div>
            </div>

            <!-- Breakfast -->
            <div class="nut-plan-section">
                <h3 class="nut-section-title">Breakfast</h3>
                <asp:GridView ID="gvBreakfast" runat="server"
                    CssClass="nut-grid"
                    AutoGenerateColumns="False"
                    ShowHeader="True"
                    GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="Food" HeaderText="Food" />
                        <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
                        <asp:BoundField DataField="Calories" HeaderText="Calories" />
                        <asp:BoundField DataField="Protein" HeaderText="Protein" />
                        <asp:BoundField DataField="Carbs" HeaderText="Carbs" />
                        <asp:BoundField DataField="Fiber" HeaderText="Fiber" />
                        <asp:BoundField DataField="Fat" HeaderText="Fat" />
                    </Columns>
                </asp:GridView>
            </div>

            <!-- Lunch -->
            <div class="nut-plan-section">
                <h3 class="nut-section-title">Lunch</h3>
                <asp:GridView ID="gvLunch" runat="server"
                    CssClass="nut-grid"
                    AutoGenerateColumns="False"
                    ShowHeader="True"
                    GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="Food" HeaderText="Food" />
                        <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
                        <asp:BoundField DataField="Calories" HeaderText="Calories" />
                        <asp:BoundField DataField="Protein" HeaderText="Protein" />
                        <asp:BoundField DataField="Carbs" HeaderText="Carbs" />
                        <asp:BoundField DataField="Fiber" HeaderText="Fiber" />
                        <asp:BoundField DataField="Fat" HeaderText="Fat" />
                    </Columns>
                </asp:GridView>
            </div>

            <!-- Snack -->
            <div class="nut-plan-section">
                <h3 class="nut-section-title">Snack</h3>
                <asp:GridView ID="gvSnack" runat="server"
                    CssClass="nut-grid"
                    AutoGenerateColumns="False"
                    ShowHeader="True"
                    GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="Food" HeaderText="Food" />
                        <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
                        <asp:BoundField DataField="Calories" HeaderText="Calories" />
                        <asp:BoundField DataField="Protein" HeaderText="Protein" />
                        <asp:BoundField DataField="Carbs" HeaderText="Carbs" />
                        <asp:BoundField DataField="Fiber" HeaderText="Fiber" />
                        <asp:BoundField DataField="Fat" HeaderText="Fat" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>

        <!-- MY OWN FOODS -->
        <div class="nut-card">
            <div class="nut-card__header">
                <div class="nut-card__title-group">
                    <div class="nut-card__icon nut-card__icon--blue">
                        <i class="fa-solid fa-utensils"></i>
                    </div>
                    <div>
                        <h2 class="nut-card__title">My Own Foods</h2>
                        <p class="nut-card__subtitle">Foods you add manually with nutrition facts</p>
                    </div>
                </div>
            </div>

            <div class="nut-table-wrap">
                <asp:GridView ID="gvOwnFoods" runat="server"
                    CssClass="nut-grid"
                    AutoGenerateColumns="False"
                    ShowHeader="True"
                    GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="Name" HeaderText="Name" />
                        <asp:BoundField DataField="Calories" HeaderText="Calories" />
                        <asp:BoundField DataField="Protein" HeaderText="Protein" />
                        <asp:BoundField DataField="Carbs" HeaderText="Carbs" />
                        <asp:BoundField DataField="Fiber" HeaderText="Fiber" />
                        <asp:BoundField DataField="Fat" HeaderText="Fat" />
                        <asp:TemplateField HeaderText="">
                            <ItemTemplate>
                                <asp:Button ID="btnDelete" runat="server" Text="Delete"
                                    CssClass="nut-delete-btn"
                                    CommandName="Delete"
                                    CommandArgument='<%# Eval("Id") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>

                <div class="nut-empty-state" id="emptyOwnFoods" runat="server" visible="false">
                    <div class="nut-empty-state__icon"><i class="fa-solid fa-utensils"></i></div>
                    <p class="nut-empty-state__text">No personal foods added.</p>
                    <p class="nut-empty-state__sub">Use the button below to add your own food item.</p>
                </div>
            </div>

            <div class="nut-card__footer">
                <asp:Button ID="btnAddFood" runat="server" CssClass="nut-btn nut-btn--primary"
                    Text="Add Food to Own Plan"/>
            </div>
        </div>
    </div>


    <!-- ADD FOOD PANEL -->
    <!-- ADD FOOD PANEL -->
    <div class="nut-card nut-card--collapsible">
        <!-- Keep this clickable header as pure HTML so JS works -->
        <div class="nut-card__header nut-card__header--clickable"
             id="btnToggleFoodPanel"
             onclick="toggleFoodPanel()"
             role="button"
             tabindex="0"
             aria-expanded="false"
             aria-controls="foodPanelBody">
            <div class="nut-card__title-group">
                <div class="nut-card__icon nut-card__icon--purple">
                    <i class="fa-solid fa-wand-magic-sparkles"></i>
                </div>
                <div>
                    <h2 class="nut-card__title">Add Custom Food</h2>
                    <p class="nut-card__subtitle">Enter a food that is not in the database</p>
                </div>
            </div>
            <div class="nut-collapse-arrow" id="foodCollapseArrow">
                <i class="fa-solid fa-chevron-down"></i>
            </div>
        </div>

        <!-- Collapsible body -->
        <div class="nut-collapse-body" id="foodPanelBody" aria-hidden="true">
            <div class="nut-custom-form">

                <div class="nut-form-row">
                    <div class="nut-form-group">
                        <label class="nut-label">Food Name <span class="nut-required">*</span></label>
                        <asp:TextBox ID="txtFoodName" runat="server" CssClass="nut-input" />
                    </div>
                    <div class="nut-form-group">
                        <label class="nut-label">Calories <span class="nut-required">*</span></label>
                        <asp:TextBox ID="txtFoodCalories" runat="server" CssClass="nut-input" TextMode="Number" />
                    </div>
                </div>

                <div class="nut-form-row">
                    <div class="nut-form-group">
                        <label class="nut-label">Protein (g)</label>
                        <asp:TextBox ID="txtFoodProtein" runat="server" CssClass="nut-input" TextMode="Number" />
                    </div>
                    <div class="nut-form-group">
                        <label class="nut-label">Carbs (g)</label>
                        <asp:TextBox ID="txtFoodCarbs" runat="server" CssClass="nut-input" TextMode="Number" />
                    </div>
                    <div class="nut-form-group">
                        <label class="nut-label">Fiber (g)</label>
                        <asp:TextBox ID="txtFoodFiber" runat="server" CssClass="nut-input" TextMode="Number" />
                    </div>
                    <div class="nut-form-group">
                        <label class="nut-label">Fat (g)</label>
                        <asp:TextBox ID="txtFoodFat" runat="server" CssClass="nut-input" TextMode="Number" />
                    </div>
                </div>

                <div class="nut-form-footer">
                    <asp:Label ID="lblFoodMsg" runat="server" CssClass="nut-inline-msg" Visible="false"></asp:Label>
                    <!-- This button posts back to save -->
                    <asp:Button ID="btnSaveFood" runat="server" CssClass="nut-btn nut-btn--save"
                        Text="Save Food" />
                </div>
            </div>
        </div>
    </div>
</div>

<script src="/js/Nutritions.js"></script>

</asp:Content>

