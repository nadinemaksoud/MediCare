(function () {

    /*
        Example:
        this should come from DB later
    */

    let currentRole = "Patient";
    // Patient | Doctor | Admin

    initRoleUI();

    function initRoleUI() {

        let patientSection = document.getElementById("patientSection");
        let doctorSection = document.getElementById("doctorSection");
        let roleBadge = document.getElementById("roleBadge");

        roleBadge.innerHTML =
            '<i class="fa-solid fa-user-shield"></i> ' + currentRole;

        if (currentRole === "Patient") {

            patientSection.style.display = "block";
            doctorSection.style.display = "none";

            roleBadge.className =
                "pro-role-badge pro-role-badge--green";
        }

        else if (currentRole === "Doctor") {

            patientSection.style.display = "none";
            doctorSection.style.display = "block";

            roleBadge.className =
                "pro-role-badge pro-role-badge--blue";
        }

        else {

            patientSection.style.display = "none";
            doctorSection.style.display = "none";

            roleBadge.className =
                "pro-role-badge pro-role-badge--purple";
        }
    }

    window.saveProfile = function () {

        let msg = document.getElementById("profileMsg");

        msg.className = "pro-msg pro-msg--success";
        msg.innerHTML =
            '<i class="fa-solid fa-circle-check"></i> Profile updated successfully.';
        msg.style.display = "flex";

        setTimeout(function () {
            msg.style.display = "none";
        }, 3000);
    };

    window.resetProfile = function () {

        location.reload();
    };

})();