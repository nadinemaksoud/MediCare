(function () {
    window.toggleFoodPanel = function () {
        var body = document.getElementById('foodPanelBody');
        var arrow = document.getElementById('foodCollapseArrow');
        var header = document.getElementById('btnToggleFoodPanel');
        var isOpen = body.classList.contains('nut-collapse-body--open');

        if (isOpen) {
            body.style.maxHeight = body.scrollHeight + 'px';
            requestAnimationFrame(function () { body.style.maxHeight = '0px'; });
            setTimeout(function () {
                body.classList.remove('nut-collapse-body--open');
                body.setAttribute('aria-hidden', 'true');
            }, 350);
            arrow.classList.remove('nut-collapse-arrow--open');
            header.setAttribute('aria-expanded', 'false');
        } else {
            body.classList.add('nut-collapse-body--open');
            body.setAttribute('aria-hidden', 'false');
            body.style.maxHeight = '0px';
            requestAnimationFrame(function () {
                body.style.maxHeight = body.scrollHeight + 'px';
            });
            setTimeout(function () { body.style.maxHeight = 'none'; }, 360);
            arrow.classList.add('nut-collapse-arrow--open');
            header.setAttribute('aria-expanded', 'true');
        }
    };

    window.filterNutritionPlan = function () {

        var filter = document.getElementById('ddlNutFilter').value.toLowerCase();
        var caloriesInput = document.getElementById('txtCaloriesFilter').value;

        var maxCalories = parseInt(caloriesInput);

        var rows = document.querySelectorAll(
            '#tblBreakfast tbody tr,' +
            '#tblLunch tbody tr,' +
            '#tblSnack tbody tr'
        );

        rows.forEach(function (row) {

            var tds = row.querySelectorAll('td');

            var calories = parseInt(tds[2].textContent);

            var protein = parseInt(tds[3].textContent);
            var carbs = parseInt(tds[4].textContent);
            var fiber = parseInt(tds[5].textContent);
            var fat = parseInt(tds[6].textContent);

            var matchesNutrition = true;
            var matchesCalories = true;

            // CALORIES FILTER
            if (!isNaN(maxCalories)) {
                matchesCalories = calories <= maxCalories;
            }

            // NUTRITION FILTER
            switch (filter) {

                case "highprotein":
                    matchesNutrition = protein > 10;
                    break;

                case "highfiber":
                    matchesNutrition = fiber > 5;
                    break;

                case "highcarb":
                    matchesNutrition = carbs > 20;
                    break;

                case "highfat":
                    matchesNutrition = fat > 10;
                    break;

                case "lowcal":
                    matchesNutrition = calories < 200;
                    break;

                default:
                    matchesNutrition = true;
            }

            // SHOW / HIDE
            if (matchesNutrition && matchesCalories) {
                row.style.display = "";
            }
            else {
                row.style.display = "none";
            }
        });
    };

    window.deleteOwnFood = function (btn) {
        if (!confirm('Remove this food item?')) return;
        var row = btn.closest('tr');
        var tbody = document.querySelector('#tblOwnFoods tbody');
        row.remove();

        var empty = document.getElementById('emptyOwnFoods');
        if (tbody.querySelectorAll('tr').length === 0) {
            empty.style.display = 'block';
        }
    };

    window.saveCustomFood = function () {
        var name = document.getElementById('txtFoodName').value.trim();
        var cal = document.getElementById('txtFoodCalories').value.trim();
        var protein = document.getElementById('txtFoodProtein').value.trim() || '0';
        var carbs = document.getElementById('txtFoodCarbs').value.trim() || '0';
        var fiber = document.getElementById('txtFoodFiber').value.trim() || '0';
        var fat = document.getElementById('txtFoodFat').value.trim() || '0';
        var msg = document.getElementById('foodMsg');

        if (!name || !cal) {
            msg.className = 'nut-inline-msg nut-inline-msg--error';
            msg.textContent = 'Food name and calories are required.';
            msg.style.display = 'inline-flex';
            return;
        }

        var tbody = document.querySelector('#tblOwnFoods tbody');
        var empty = document.getElementById('emptyOwnFoods');
        var tr = document.createElement('tr');
        tr.innerHTML =
            '<td>' + escapeHtml(name) + '</td>' +
            '<td>' + escapeHtml(cal) + '</td>' +
            '<td>' + escapeHtml(protein) + 'g</td>' +
            '<td>' + escapeHtml(carbs) + 'g</td>' +
            '<td>' + escapeHtml(fiber) + 'g</td>' +
            '<td>' + escapeHtml(fat) + 'g</td>' +
            '<td><button type="button" class="nut-delete-btn" onclick="deleteOwnFood(this)"><i class="fa-solid fa-trash-can"></i></button></td>';

        tbody.appendChild(tr);
        empty.style.display = 'none';

        msg.className = 'nut-inline-msg nut-inline-msg--success';
        msg.textContent = 'Food added successfully.';
        msg.style.display = 'inline-flex';

        document.getElementById('txtFoodName').value = '';
        document.getElementById('txtFoodCalories').value = '';
        document.getElementById('txtFoodProtein').value = '';
        document.getElementById('txtFoodCarbs').value = '';
        document.getElementById('txtFoodFiber').value = '';
        document.getElementById('txtFoodFat').value = '';
    };

    function escapeHtml(str) {
        return String(str)
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;')
            .replace(/'/g, '&#39;');
    }
})();