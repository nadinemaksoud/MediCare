(function () {

    function getText(el) {
        return (el.textContent || el.innerText || '').toLowerCase();
    }

    function showMessage(type, text) {

        var msg = document.getElementById('searchMsg');

        if (!msg) return;

        msg.className = 'sea-inline-msg sea-inline-msg--' + type;
        msg.textContent = text;
        msg.style.display = 'inline-flex';

        clearTimeout(window.__seaMsgTimer);

        window.__seaMsgTimer = setTimeout(function () {
            msg.style.display = 'none';
        }, 3000);
    }

    function setCardVisible(cardId, visible) {

        var card = document.getElementById(cardId);

        if (card) {
            card.style.display = visible ? '' : 'none';
        }
    }

    function filterGrid(gridId, query) {

        var grid = document.getElementById(gridId);

        if (!grid) return 0;

        var rows = grid.querySelectorAll('tbody tr');

        var shown = 0;

        rows.forEach(function (row) {

            var match = !query || getText(row).indexOf(query) !== -1;

            row.style.display = match ? '' : 'none';

            if (match) {
                shown++;
            }
        });

        return shown;
    }

    window.performSearch = function () {

        var scope =
            (document.getElementById('ddlSearchScope') || {}).value || 'all';

        var query =
            ((document.getElementById('txtSearchQuery') || {}).value || '')
                .trim()
                .toLowerCase();

     

        var searchMedicines =
            scope === 'all' || scope === 'medicines';

        var searchFoods =
            scope === 'all' || scope === 'foods';

        setCardVisible('cardMedicines', searchMedicines);
        setCardVisible('cardFoods', searchFoods);




        var medicinesCount =
            searchMedicines
                ? filterGrid('<%= gvMedicines.ClientID %>', query)
                : 0;

        var foodsCount =
            searchFoods
                ? filterGrid('<%= gvFoods.ClientID %>', query)
                : 0;

        var total =
            
            medicinesCount +
            foodsCount;

        if (total > 0) {
            showMessage(
                'success',
                'Found ' + total + ' result(s).'
            );
        }
        else {
            showMessage(
                'error',
                'No results found.'
            );
        }
    };

    document.addEventListener('DOMContentLoaded', function () {

        var queryInput =
            document.getElementById('txtSearchQuery');

        var scopeSelect =
            document.getElementById('ddlSearchScope');

        if (queryInput) {

            queryInput.addEventListener('keydown', function (e) {

                if (e.key === 'Enter') {

                    e.preventDefault();

                    window.performSearch();
                }
            });
        }

        if (scopeSelect) {

            scopeSelect.addEventListener('change', function () {

                window.performSearch();
            });
        }

        window.performSearch();
    });

})();