/* ═══════════════════════════════════════════════════════════════════
   FILE: NewPassword.js
   LOCATION: /Scripts/NewPassword.js
   ═══════════════════════════════════════════════════════════════════ */

(function () {
  'use strict';

  /* ── Element refs ───────────────────────────────────────────── */
  var elNewPwd, elConfirmPwd;
  var elStrengthWrap, elStrengthFill, elStrengthText;
  var elRulesWrap;
  var elRuleLength, elRuleUpper, elRuleNumber, elRuleMatch;
  var elSaveErrorMsg, elSaveErrorTitle, elSaveErrorDetail;
  var elNpForm, elNpSuccess;
  var elBackLink;
  var elBtnSave;

  /* ── Init ───────────────────────────────────────────────────── */
  function init() {
    /* Resolve ASP.NET-rendered ClientIDs using suffix match */
    elNewPwd     = document.querySelector('input[id$="txtNewPassword"]');
    elConfirmPwd = document.querySelector('input[id$="txtConfirmPassword"]');
    elBtnSave    = document.querySelector('input[id$="btnSavePassword"]');

    elStrengthWrap  = document.getElementById('strengthWrap');
    elStrengthFill  = document.getElementById('strengthFill');
    elStrengthText  = document.getElementById('strengthText');
    elRulesWrap     = document.getElementById('rulesWrap');

    elRuleLength = document.getElementById('rule-length');
    elRuleUpper  = document.getElementById('rule-upper');
    elRuleNumber = document.getElementById('rule-number');
    elRuleMatch  = document.getElementById('rule-match');

    elSaveErrorMsg    = document.getElementById('saveErrorMsg');
    elSaveErrorTitle  = document.getElementById('saveErrorTitle');
    elSaveErrorDetail = document.getElementById('saveErrorDetail');

    elNpForm    = document.getElementById('npForm');
    elNpSuccess = document.getElementById('npSuccess');
    elBackLink  = document.getElementById('backLinkWrap');

    /* Attach listeners */
    if (elNewPwd) {
      elNewPwd.addEventListener('input', onPasswordInput);
      elNewPwd.addEventListener('focus', function () {
        show(elStrengthWrap);
        show(elRulesWrap);
      });
    }
    if (elConfirmPwd) {
      elConfirmPwd.addEventListener('input', onConfirmInput);
    }
  }

  /* ─────────────────────────────────────────────────────────────
     LIVE PASSWORD VALIDATION
  ───────────────────────────────────────────────────────────── */
  function onPasswordInput() {
    var pwd = elNewPwd.value;

    /* Update individual rules */
    setRule(elRuleLength, pwd.length >= 8);
    setRule(elRuleUpper,  /[A-Z]/.test(pwd));
    setRule(elRuleNumber, /[0-9]/.test(pwd));

    /* Match rule */
    if (elConfirmPwd && elConfirmPwd.value.length > 0) {
      setRule(elRuleMatch, pwd === elConfirmPwd.value);
    }

    /* Strength score */
    updateStrength(pwd);
  }

  function onConfirmInput() {
    var pwd     = elNewPwd ? elNewPwd.value : '';
    var confirm = elConfirmPwd.value;
    if (confirm.length > 0) {
      setRule(elRuleMatch, pwd === confirm);
    } else {
      resetRule(elRuleMatch);
    }
  }

  /* ─────────────────────────────────────────────────────────────
     STRENGTH METER
  ───────────────────────────────────────────────────────────── */
  function updateStrength(pwd) {
    var score = 0;
    if (pwd.length >= 8)          score++;
    if (pwd.length >= 12)         score++;
    if (/[A-Z]/.test(pwd))        score++;
    if (/[0-9]/.test(pwd))        score++;
    if (/[^A-Za-z0-9]/.test(pwd)) score++;

    var levels = [
      { label: 'Weak',   cls: 'weak',   width: '20%' },
      { label: 'Fair',   cls: 'fair',   width: '45%' },
      { label: 'Good',   cls: 'good',   width: '70%' },
      { label: 'Strong', cls: 'strong', width: '100%' }
    ];

    var idx   = Math.min(Math.floor(score / 1.3), 3);
    var level = levels[idx];

    elStrengthFill.style.width = level.width;
    elStrengthFill.className   = 'np-strength-fill np-strength-fill--' + level.cls;
    elStrengthText.textContent = level.label;
    elStrengthText.className   = 'np-strength-text np-strength-text--' + level.cls;
  }

  /* ─────────────────────────────────────────────────────────────
     RULE HELPERS
  ───────────────────────────────────────────────────────────── */
  function setRule(el, passes) {
    if (!el) return;
    el.classList.toggle('np-rule--pass', passes);
    var icon = el.querySelector('.np-rule__icon');
    if (icon) icon.setAttribute('aria-label', passes ? 'Passed' : 'Not yet');
  }

  function resetRule(el) {
    if (!el) return;
    el.classList.remove('np-rule--pass');
  }

  /* ─────────────────────────────────────────────────────────────
     TOGGLE PASSWORD VISIBILITY
  ───────────────────────────────────────────────────────────── */
  window.toggleEye = function (inputSuffix, btnId) {
    /* Find input by ID suffix */
    var input = document.querySelector('input[id$="' + inputSuffix + '"]');
    var btn   = document.getElementById(btnId);
    if (!input || !btn) return;

    var isHidden = input.type === 'password';
    input.type   = isHidden ? 'text' : 'password';

    /* Swap icon between eye / eye-off */
    var icon = btn.querySelector('.np-eye-icon');
    if (icon) {
      if (isHidden) {
        /* Eye-off */
        icon.innerHTML =
          '<path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94"/>' +
          '<path d="M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19"/>' +
          '<line x1="1" y1="1" x2="23" y2="23"/>';
      } else {
        /* Eye */
        icon.innerHTML =
          '<path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/>' +
          '<circle cx="12" cy="12" r="3"/>';
      }
    }

    btn.setAttribute('aria-label', isHidden ? 'Hide password' : 'Show password');
    input.focus();
  };

  /* ─────────────────────────────────────────────────────────────
     SAVE PASSWORD
  ───────────────────────────────────────────────────────────── */
  window.handleSavePassword = function (e) {
    e.preventDefault();

    var pwd     = elNewPwd     ? elNewPwd.value     : '';
    var confirm = elConfirmPwd ? elConfirmPwd.value  : '';
    var errors  = [];

    /* Validate */
    if (pwd.length < 8)          errors.push('Password must be at least 8 characters.');
    if (!/[A-Z]/.test(pwd))      errors.push('Password must contain at least one uppercase letter.');
    if (!/[0-9]/.test(pwd))      errors.push('Password must contain at least one number.');
    if (pwd !== confirm)         errors.push('Passwords do not match.');

    if (errors.length > 0) {
      /* Show error */
      elSaveErrorTitle.textContent  = errors[0];
      elSaveErrorDetail.textContent = errors.length > 1
        ? errors.slice(1).join(' ')
        : 'Please check your password and try again.';
      show(elSaveErrorMsg);
      shakeCard();

      /* Highlight inputs */
      if (elNewPwd)     elNewPwd.classList.add('fp-input--error');
      if (elConfirmPwd && pwd !== confirm) elConfirmPwd.classList.add('fp-input--error');
      setTimeout(function () {
        if (elNewPwd)     elNewPwd.classList.remove('fp-input--error');
        if (elConfirmPwd) elConfirmPwd.classList.remove('fp-input--error');
      }, 2000);
      return;
    }

    /* Hide errors */
    hide(elSaveErrorMsg);

    /* Loading state */
    setButtonLoading(elBtnSave, true, 'Saving...');

    /* Simulate API call */
    setTimeout(function () {
      setButtonLoading(elBtnSave, false, 'Save New Password');
      showSuccess();
    }, 1800);
  };

  /* ─────────────────────────────────────────────────────────────
     SUCCESS STATE
  ───────────────────────────────────────────────────────────── */
  function showSuccess() {
    /* Hide form, show success */
    if (elNpForm)    elNpForm.style.display    = 'none';
    if (elRulesWrap) elRulesWrap.style.display = 'none';
    if (elStrengthWrap) elStrengthWrap.style.display = 'none';
    if (elBackLink)  elBackLink.style.display  = 'none';

    show(elNpSuccess);

    /* Countdown redirect */
    var count  = 5;
    var countEl = document.getElementById('redirectCount');
    var interval = setInterval(function () {
      count--;
      if (countEl) countEl.textContent = count;
      if (count <= 0) {
        clearInterval(interval);
        window.location.href = '/Default.aspx';
      }
    }, 1000);
  }

  /* ─────────────────────────────────────────────────────────────
     HELPERS
  ───────────────────────────────────────────────────────────── */
  function setButtonLoading(btn, isLoading, text) {
    if (!btn) return;
    btn.disabled = isLoading;
    btn.value    = isLoading ? '' : text;
    if (isLoading) {
      btn.innerHTML =
        '<span class="fp-btn-spinner"></span>&nbsp;' + text;
    }
  }

  function show(el) { if (el) el.style.display = 'block'; }
  function hide(el) { if (el) el.style.display = 'none';  }

  function shakeCard() {
    var card = document.querySelector('.np-card');
    if (!card) return;
    card.style.animation = 'none';
    card.offsetHeight;
    card.style.animation = 'fp-shake .4s ease';
    setTimeout(function () { card.style.animation = ''; }, 500);
  }

  /* ── Inject shake keyframe ──────────────────────────────────── */
  function injectKeyframes() {
    if (document.getElementById('np-kf')) return;
    var s = document.createElement('style');
    s.id  = 'np-kf';
    s.textContent =
      '@keyframes fp-shake{' +
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