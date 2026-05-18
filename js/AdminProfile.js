/* ============================================================
   Profile.js  –  MediCare Admin | Profile Page Logic
   All profile data lives in a JS object for easy future
   backend/database integration (see integration comments).
   ============================================================ */

const ProfilePage = (() => {

    /* ----------------------------------------------------------
       1. PROFILE DATA OBJECT
          TODO (Backend Integration): Replace this static object
          with a fetch() call to your API endpoint, e.g.:
          GET /api/admin/profile?id=<session_user_id>
          Then populate the `data` variable from the response.
    ---------------------------------------------------------- */
    

    /* ----------------------------------------------------------
       2. EDIT MODE STATE
          Tracks whether the page is currently in edit mode.
    ---------------------------------------------------------- */
    let isEditing = false;

    /* ----------------------------------------------------------
       3. RENDER  –  injects profile data into the DOM
          Called once on DOMContentLoaded.
          TODO (Backend Integration): Call render() again after
          a successful fetch from the server to refresh the UI.
    ---------------------------------------------------------- */
    

    /* ----------------------------------------------------------
       4. TOGGLE EDIT MODE
          Shows/hides editable inputs and the save/cancel bar.
    ---------------------------------------------------------- */
   
    /* ----------------------------------------------------------
       5. CANCEL EDIT  –  restores previous values, exits mode
    ---------------------------------------------------------- */
    

    /* ----------------------------------------------------------
       6. SAVE EDIT  –  reads input values and updates the data
          object, then re-renders and exits edit mode.

          TODO (Backend Integration): Replace the local data
          update below with a PATCH/PUT request:

          fetch('/api/admin/profile', {
              method: 'PATCH',
              headers: { 'Content-Type': 'application/json' },
              body: JSON.stringify({
                  email: newEmail,
                  phone: newPhone,
              })
          })
          .then(res => res.json())
          .then(updatedProfile => {
              Object.assign(data, updatedProfile);
              render();
              exitEditMode();
              showToast('Profile updated successfully!');
          })
          .catch(err => showToast('Failed to save changes.', 'error'));
    ---------------------------------------------------------- */
    
    /* ----------------------------------------------------------
       7. CHANGE PASSWORD  –  front-end stub
          TODO (Backend Integration): Open a modal with current
          password + new password + confirm fields, then call
          POST /api/admin/change-password.
    ---------------------------------------------------------- */
    function changePassword() {
        showToast("Change password feature coming soon.", "info");
        /* TODO: Open a password-change modal here */
    }

    /* ----------------------------------------------------------
       8. TOGGLE 2FA  –  front-end stub
          TODO (Backend Integration): Call
          POST /api/admin/toggle-2fa
          and update the button label based on the current state.
    ---------------------------------------------------------- */
    function toggle2FA() {
        showToast("Two-factor authentication setup coming soon.", "info");
        /* TODO: show QR code / OTP entry modal */
    }

    /* ----------------------------------------------------------
       9. HELPER – Simple email regex validator
    ---------------------------------------------------------- */
    function isValidEmail(email) {
        return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
    }

    /* ----------------------------------------------------------
       10. HELPER – Toast notification (pure JS, no libs)
           type: "success" | "warn" | "info" | "error"
    ---------------------------------------------------------- */
    function showToast(message, type = "success") {
        // Remove any existing toast
        const existing = document.getElementById("mc-toast");
        if (existing) existing.remove();

        const colors = {
            success: { bg: "#ECFDF5", border: "#6EE7B7", text: "#065F46", icon: "fa-circle-check" },
            warn: { bg: "#FFFBEB", border: "#FCD34D", text: "#92400E", icon: "fa-triangle-exclamation" },
            info: { bg: "#EFF6FF", border: "#BFDBFE", text: "#1E40AF", icon: "fa-circle-info" },
            error: { bg: "#FEF2F2", border: "#FECACA", text: "#991B1B", icon: "fa-circle-xmark" },
        };

        const c = colors[type] || colors.success;

        const toast = document.createElement("div");
        toast.id = "mc-toast";
        toast.style.cssText = `
            position: fixed;
            top: 1.25rem;
            right: 1.5rem;
            z-index: 9999;
            display: flex;
            align-items: center;
            gap: .65rem;
            background: ${c.bg};
            border: 1.5px solid ${c.border};
            color: ${c.text};
            padding: .75rem 1.25rem;
            border-radius: 12px;
            font-family: 'DM Sans', sans-serif;
            font-size: .88rem;
            font-weight: 600;
            box-shadow: 0 6px 24px rgba(15,23,42,.13);
            animation: toastIn .25s cubic-bezier(.4,0,.2,1);
            max-width: 340px;
        `;

        toast.innerHTML = `<i class="fa-solid ${c.icon}" style="font-size:.95rem"></i> ${message}`;

        // Inject keyframes if not already present
        if (!document.getElementById("toast-keyframes")) {
            const style = document.createElement("style");
            style.id = "toast-keyframes";
            style.textContent = `
                @keyframes toastIn  { from { opacity:0; transform:translateY(-10px); } to { opacity:1; transform:translateY(0); } }
                @keyframes toastOut { from { opacity:1; } to { opacity:0; transform:translateY(-6px); } }
            `;
            document.head.appendChild(style);
        }

        document.body.appendChild(toast);

        // Auto-dismiss after 3s
        setTimeout(() => {
            toast.style.animation = "toastOut .3s ease forwards";
            setTimeout(() => toast.remove(), 320);
        }, 3000);
    }

    /* ----------------------------------------------------------
       11. MOBILE HAMBURGER NAV  –  shared across all admin pages
    ---------------------------------------------------------- */
    function initMobileNav() {
        const btn = document.getElementById("hamburgerBtn");
        const nav = document.getElementById("mobileNav");
        if (!btn || !nav) return;

        btn.addEventListener("click", () => {
            nav.classList.toggle("open");
        });
    }

    /* ----------------------------------------------------------
       12. INIT  –  called on DOMContentLoaded
    ---------------------------------------------------------- */
    function init() {
        render();
        initMobileNav();
    }

    // Boot
    document.addEventListener("DOMContentLoaded", init);

    /* Expose public API so inline onclick handlers can reach these */
    return {
     
        changePassword,
        toggle2FA,
    };

})();