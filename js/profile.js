// profile.js – handles edit mode toggle, field population, and cancel

(function () {
    'use strict';

    // Store original values of editable account/profile fields on page load
    var originalValues = {};

    function captureOriginalValues() {
        // Fields that become editable when Edit is pressed
        var editableFields = ['txtEmail', 'txtPassword', 'txtFullName', 'txtAge'];
        editableFields.forEach(function (id) {
            var el = document.getElementById(id);
            if (el) {
                originalValues[id] = el.value;
            }
        });
    }

    // Make fields editable (remove readonly, change styling)
    function setFieldsEditable(enable) {
        var fields = document.querySelectorAll('.readonly-input');
        fields.forEach(function (field) {
            if (enable) {
                field.readOnly = false;
                field.classList.remove('readonly-input');
            } else {
                field.readOnly = true;
                field.classList.add('readonly-input');
            }
        });
    }

    // Populate health edit fields from the view labels
    function populateHealthEditFields() {
        // Map label IDs to edit field IDs
        var map = {
            'lblHeight': 'txtHeight',
            'lblWeight': 'txtWeight',
            'lblCalories': 'txtCalories',
            'lblBloodType': 'ddlBloodType',
            'lblAge': 'txtHealthAge',
            'lblDisease': 'txtDisease',
            'lblDisability': 'txtDisability',
            'lblFamilyHistory': 'txtFamilyHistory'
        };

        for (var labelId in map) {
            var lbl = document.getElementById(labelId);
            var editCtrl = document.getElementById(map[labelId]);
            if (lbl && editCtrl) {
                // For labels, get text content (excluding <small> units)
                var text = lbl.textContent || lbl.innerText || '';
                // Remove any child <small> text by cloning and removing small elements
                var clone = lbl.cloneNode(true);
                var smalls = clone.querySelectorAll('small');
                smalls.forEach(function (s) { s.remove(); });
                var pureText = clone.textContent.trim();
                editCtrl.value = pureText;
            }
        }
    }

    // Restore original account/profile field values (on cancel)
    function restoreOriginalValues() {
        for (var id in originalValues) {
            var el = document.getElementById(id);
            if (el) {
                el.value = originalValues[id];
            }
        }
    }

    // Switch between view and edit panels
    function setHealthEditMode(enable) {
        var viewPanel = document.getElementById('pnlHealthView');
        var editPanel = document.getElementById('pnlHealthEdit');
        if (viewPanel && editPanel) {
            if (enable) {
                viewPanel.style.display = 'none';
                editPanel.style.display = '';
                populateHealthEditFields();
            } else {
                viewPanel.style.display = '';
                editPanel.style.display = 'none';
            }
        }
    }

    // Toggle edit mode ON
    window.toggleEditMode = function () {
        setFieldsEditable(true);
        setHealthEditMode(true);
        document.getElementById('proActions').style.display = 'flex';  // show Save/Cancel
        document.getElementById('btnEditProfile').style.display = 'none'; // hide Edit button
    };

    // Cancel edit mode (called by Cancel/Reset button)
    window.cancelEdit = function () {
        setFieldsEditable(false);
        setHealthEditMode(false);
        restoreOriginalValues();
        document.getElementById('proActions').style.display = 'none';
        document.getElementById('btnEditProfile').style.display = '';
    };

    // Initialise on page load
    document.addEventListener('DOMContentLoaded', function () {
        captureOriginalValues();
        // Ensure health edit panel is hidden and view panel visible (server already hides it, but safe)
        setHealthEditMode(false);
        // Ensure edit button is visible and action bar is hidden
        document.getElementById('btnEditProfile').style.display = '';
        document.getElementById('proActions').style.display = 'none';
    });

})();