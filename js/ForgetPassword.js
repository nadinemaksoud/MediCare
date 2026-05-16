/* ═══════════════════════════════════════════════════════════════════
   FILE: ForgetPassword.js
   LOCATION: /Scripts/ForgetPassword.js
   ═══════════════════════════════════════════════════════════════════ */

(function () {
    'use strict';

    /* ── Configuration ──────────────────────────────────────────── */
    var FAKE_CODE = '123456'; // Simulated verification code
    var MAX_ATTEMPTS = 3;        // Max wrong tries before lock
    var CODE_EXPIRY_S = 300;      // 5 minutes in seconds

    /* ── State ──────────────────────────────────────────────────── */
    var attemptsLeft = MAX_ATTEMPTS;
    var timerInterval = null;
    var timerSeconds = CODE_EXPIRY_S;
    var codeSent = false;
    var locked = false;

    /* ── Element refs (resolved after DOM ready) ─────────────────── */
    var elEmail, elCode, elBtnSend, elBtnVerify;
    var elSendSuccess, elStepVerify, elStepDivider;
    var elLockedMsg, elWrongMsg, elWrongDetail;
    var elTimerCount, elResendWrap;
    var elDots;

    /* ── Init ───────────────────────────────────────────────────── */
    function init() {
        /* Grab elements by ID/class — IDs are ASP.NET-rendered ClientIDs */
        elEmail = document.querySelector('input[id$="txtEmail"]');
        elCode = document.querySelector('input[id$="txtCode"]');
        elBtnSend = document.querySelector('input[id$="btnSendCode"]');
        elBtnVerify = document.querySelector('input[id$="btnVerify"]');

        elSendSuccess = document.getElementById('sendSuccessMsg');
        elStepVerify = document.getElementById('stepVerify');
        elStepDivider = document.getElementById('stepDivider');
        elLockedMsg = document.getElementById('lockedMsg');
        elWrongMsg = document.getElementById('wrongCodeMsg');
        elWrongDetail = document.getElementById('wrongCodeDetail');
        elTimerCount = document.getElementById('timerCount');
        elResendWrap = document.getElementById('resendWrap');
        elDots = [
            document.getElementById('dot1'),
            document.getElementById('dot2'),
            document.getElementById('dot3')
        ];

        /* Only enter key on code input triggers verify */
        if (elCode) {
            elCode.addEventListener('keydown', function (e) {
                if (e.key === 'Enter') { e.preventDefault(); handleVerify(e); }
            });
            /* Allow only digits */
            elCode.addEventListener('input', function () {
                this.value = this.value.replace(/\D/g, '').slice(0, 6);
            });
        }
    }

    /* ─────────────────────────────────────────────────────────────
       SEND CODE
    ───────────────────────────────────────────────────────────── */
    window.handleSendCode = function (e) {
        e.preventDefault();
        if (!elEmail) return;

        var email = elEmail.value.trim();

        /* Validate email */
        if (!email || !isValidEmail(email)) {
            shakeElement(elEmail);
            elEmail.classList.add('fp-input--error');
            elEmail.focus();
            setTimeout(function () { elEmail.classList.remove('fp-input--error'); }, 2000);
            return;
        }

        /* Show loading state */
        setButtonLoading(elBtnSend, true, 'Sending...');

        /* Simulate network delay */
        setTimeout(function () {
            setButtonLoading(elBtnSend, false, 'Send Verification Code');
            codeSent = true;
            attemptsLeft = MAX_ATTEMPTS;
            locked = false;

            /* Show success alert */
            show(elSendSuccess);

            /* Reveal step 2 */
            show(elStepDivider);
            elStepVerify.classList.remove('fp-step--hidden');
            elStepVerify.style.animation = 'fp-fadeIn .4s ease both';

            /* Reset dots */
            resetDots();

            /* Hide old messages */
            hide(elLockedMsg);
            hide(elWrongMsg);
            hide(elResendWrap);

            /* Re-enable verify button */
            elBtnVerify.disabled = false;

            /* Start countdown */
            startTimer();

            /* Focus code input */
            if (elCode) elCode.focus();

        }, 1800);
    };

    /* ─────────────────────────────────────────────────────────────
       VERIFY CODE
    ───────────────────────────────────────────────────────────── */
    window.handleVerify = function (e) {
        e.preventDefault();
        if (locked || !codeSent) return;

        var code = elCode ? elCode.value.trim() : '';

        /* Empty check */
        if (!code) {
            shakeElement(elCode);
            elCode.classList.add('fp-input--error');
            setTimeout(function () { elCode.classList.remove('fp-input--error'); }, 2000);
            return;
        }

        /* Show loading */
        setButtonLoading(elBtnVerify, true, 'Verifying...');

        setTimeout(function () {
            setButtonLoading(elBtnVerify, false, 'Verify Code');

            if (code === FAKE_CODE) {
                /* ── SUCCESS ── */
                clearInterval(timerInterval);
                hide(elWrongMsg);
                hide(elLockedMsg);

                /* Redirect to New Password page */
                showSuccessAndRedirect();

            } else {
                /* ── WRONG CODE ── */
                attemptsLeft--;
                shakeElement(elCode);
                elCode.classList.add('fp-input--error');
                setTimeout(function () { elCode.classList.remove('fp-input--error'); }, 1500);

                /* Mark dot as used */
                var usedDotIndex = MAX_ATTEMPTS - attemptsLeft - 1;
                if (elDots[usedDotIndex]) {
                    elDots[usedDotIndex].classList.remove('fp-attempt-dot--active');
                    elDots[usedDotIndex].classList.add('fp-attempt-dot--used');
                }

                if (attemptsLeft <= 0) {
                    /* ── LOCKED ── */
                    locked = true;
                    clearInterval(timerInterval);
                    elBtnVerify.disabled = true;
                    hide(elWrongMsg);
                    show(elLockedMsg);
                    show(elResendWrap);
                } else {
                    /* ── WRONG but not locked ── */
                    elWrongDetail.textContent =
                        attemptsLeft === 1
                            ? 'Last attempt remaining. Please try again carefully.'
                            : attemptsLeft + ' attempts remaining.';
                    show(elWrongMsg);
                    hide(elLockedMsg);
                }

                /* Clear input */
                if (elCode) { elCode.value = ''; elCode.focus(); }
            }
        }, 1200);
    };

    /* ─────────────────────────────────────────────────────────────
       RESEND CODE
    ───────────────────────────────────────────────────────────── */
    window.handleResend = function (e) {
        e.preventDefault();
        /* Reset everything and re-trigger send */
        locked = false;
        attemptsLeft = MAX_ATTEMPTS;
        resetDots();
        hide(elLockedMsg);
        hide(elWrongMsg);
        hide(elResendWrap);
        elBtnVerify.disabled = false;
        if (elCode) { elCode.value = ''; }
        clearInterval(timerInterval);
        startTimer();
        show(elSendSuccess);
    };

    /* ─────────────────────────────────────────────────────────────
       COUNTDOWN TIMER
    ───────────────────────────────────────────────────────────── */
    function startTimer() {
        clearInterval(timerInterval);
        timerSeconds = CODE_EXPIRY_S;
        updateTimerDisplay();

        timerInterval = setInterval(function () {
            timerSeconds--;
            updateTimerDisplay();

            if (timerSeconds <= 30) {
                elTimerCount.classList.add('fp-timer__count--urgent');
            } else {
                elTimerCount.classList.remove('fp-timer__count--urgent');
            }

            if (timerSeconds <= 0) {
                clearInterval(timerInterval);
                /* Expire: lock and show resend */
                locked = true;
                elBtnVerify.disabled = true;
                elTimerCount.textContent = 'EXPIRED';
                show(elResendWrap);
            }
        }, 1000);
    }

    function updateTimerDisplay() {
        var m = Math.floor(timerSeconds / 60);
        var s = timerSeconds % 60;
        elTimerCount.textContent =
            String(m).padStart(2, '0') + ':' + String(s).padStart(2, '0');
    }

    /* ─────────────────────────────────────────────────────────────
       SUCCESS REDIRECT
    ───────────────────────────────────────────────────────────── */
    function showSuccessAndRedirect() {
        /* Replace card content with success state */
        var card = document.querySelector('.fp-card');
        if (!card) return;

        card.innerHTML =
            '<div style="text-align:center; padding: 20px 0;">' +
            '<div style="width:80px;height:80px;background:#D1FAE5;border-radius:50%;display:flex;align-items:center;justify-content:center;margin:0 auto 24px;animation:fp-icon-pulse 2s ease-in-out infinite;">' +
            '<svg width="36" height="36" viewBox="0 0 24 24" fill="none" stroke="#059669" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>' +
            '</div>' +
            '<h2 style="font-family:var(--mc-font-display);font-size:26px;color:#065F46;margin-bottom:10px;">Identity Verified!</h2>' +
            '<p style="font-size:15px;color:#6B7280;margin-bottom:28px;line-height:1.6;">Your identity has been confirmed.<br>Redirecting you to reset your password...</p>' +
            '<div style="width:48px;height:4px;background:#D1FAE5;border-radius:4px;margin:0 auto;overflow:hidden;">' +
            '<div id="redirectBar" style="height:100%;width:0%;background:#1A9E5C;border-radius:4px;transition:width 2.5s linear;"></div>' +
            '</div>' +
            '</div>';

        /* Animate progress bar then redirect */
        setTimeout(function () {
            var bar = document.getElementById('redirectBar');
            if (bar) bar.style.width = '100%';
        }, 50);

        setTimeout(function () {
            window.location.href = '/Pages/NewPassword.aspx';
        }, 2700);
    }

    /* ─────────────────────────────────────────────────────────────
       HELPERS
    ───────────────────────────────────────────────────────────── */
    function isValidEmail(email) {
        return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
    }

    function setButtonLoading(btn, isLoading, defaultText) {
        if (!btn) return;
        btn.disabled = isLoading;
        if (isLoading) {
            btn.innerHTML =
                '<span class="fp-btn-spinner"></span>' + '&nbsp;' + defaultText;
        } else {
            btn.value = defaultText;
            btn.innerHTML = '';
        }
    }

    function shakeElement(el) {
        if (!el) return;
        el.style.animation = 'none';
        el.offsetHeight; /* reflow */
        el.style.animation = 'fp-shake .4s ease';
        setTimeout(function () { el.style.animation = ''; }, 500);
    }

    function show(el) { if (el) el.style.display = 'flex'; }
    function hide(el) { if (el) el.style.display = 'none'; }

    function resetDots() {
        elDots.forEach(function (dot) {
            if (!dot) return;
            dot.className = 'fp-attempt-dot fp-attempt-dot--active';
        });
    }

    /* ── Inject shake keyframe ──────────────────────────────────── */
    function injectKeyframes() {
        if (document.getElementById('fp-kf')) return;
        var s = document.createElement('style');
        s.id = 'fp-kf';
        s.textContent =
            '@keyframes fp-shake {' +
            '0%,100%{transform:translateX(0)}' +
            '20%{transform:translateX(-8px)}' +
            '40%{transform:translateX(8px)}' +
            '60%{transform:translateX(-6px)}' +
            '80%{transform:translateX(6px)}' +
            '}';
        document.head.appendChild(s);
    }

    /* ── Boot ───────────────────────────────────────────────────── */
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', function () { injectKeyframes(); init(); });
    } else {
        injectKeyframes(); init();
    }

})();