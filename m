Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3FE1DC985
	for <linux-input@vger.kernel.org>; Wed, 20 May 2026 01:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779240724; cv=none; b=qUlKicO5TnFLlC6lW5zNQJrDlz36ZLKXRf0JWXU+oCNH8RFoWtOEeQ1cLfyXKe8NNQo49AYCnpla68RcjrxkUx/j5Db+9fmbTDW+dzPHYkQrtNMQGuxIaSpITP8/3NzswT7OeC/Y3PpRn9CoU5Pdz8PYLlnpfFgVo+tB+Svl6Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779240724; c=relaxed/simple;
	bh=EysvEabC5KXHR+zcjh9C35SbS5QT7b2jE8cdf7TB2lo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UwBzaOY8JsnhuREpNkTad1lIy4XBIrh/iODtPPF4ehD/PhLRVPOFXAonnHiURGqRDfRhbA/UDjtwvPkzWcgEnl99IlfGDZ7mJPtX+mlIXSIKKxFYvTHLGReW2BHSO+V/85PSFeT1/Otb0shCLZX9VRAfVOY+HRegiWSXfO8+FQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksKIj5Ua; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksKIj5Ua"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12ddbe104ccso3031016c88.0
        for <linux-input@vger.kernel.org>; Tue, 19 May 2026 18:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779240721; x=1779845521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xUDBo3x0ocFKmXZAnR6vFFcgSib4D5BDP6Q9yKyw4Bk=;
        b=ksKIj5Ua0AoYNgIfQKC1K+q9wVaXhQOptQXBpAxsp+7SXdpOhFIhQBSRJ2BxwC3DBe
         eN1oLIKuR0DobdKgcXkocj38Ijv7k0lW8bPZJQC7xCh8RUBz2qHMaUl2tFLC72W+cBHR
         Kr92hmL8Bw7ZTfUDtcwbrRKdZCCyDTCQmLkkdL+OJ9YB9OjH5nEloywdswxQead27NwX
         GW/AEmMQwUC7stFnORoI4P3GmuNK2phdrxpVG/DzJWLhkPAD/ti8a5/EfPhF3Dg0f+kW
         3vlJpFjDvvu9BKAJaigkXybZALiTaTLLfZzxo/U6FiDWoSFG0RMa7VFxL51xPNgVes7i
         zRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779240721; x=1779845521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUDBo3x0ocFKmXZAnR6vFFcgSib4D5BDP6Q9yKyw4Bk=;
        b=TRjqCYRsQss3ixqhjTBya8Z+w1INnLtbNMX8Iq+QS7aYVB7TA0tU1nWCfSggTpuiD+
         0P0kVeSBCUq5hGOjTWflImDY1y8LORh4/q72QVNGEYrZfTQOaCi1qvuOfglCOG2fUThs
         JzG7PLsRg6akbUm5FicyNCZMWgfAy7i68oVnE3Nr2sKFD7neRR3xZsYKdOdKb3Foi9UK
         2CXw6G1fYS5xFFORTJBCdFrURHhsOEk+SWtlbCvXdTlSbqDl9IEId3b7fuxcoAR9xLhs
         TQVbO4zVS1sCv7KbVtfkCKGMxJlS2xLdjwlQJdIvL8yAZA+3ymKGRjy3wGgUf+8Cr9Bz
         XZPw==
X-Forwarded-Encrypted: i=1; AFNElJ+iG/Y4L51ltATosf11hkQf0GAnWzN6TtU4waJKZWvdgEDdNni+5m9g/cPpQO34Imgi7WvraIUA/aJAjg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx10A6Nwxa0K2smFB8g2lrjqxG6qqOTrUocqdxlK2JnXLAdcxRe
	dZnGHwyqRaDaz8+xPUzmIlops2qks/am7p9DfrRHbdvQUAm3Gtv6+eiu
X-Gm-Gg: Acq92OEEyMoxfmAxbbPm3Vsiems5zM5O2tHBv+aBaCE+KGYH2IBiINVvOPFEKfzM54z
	ozKn3XEBLFXjiUj9RuozlLjOXW9pQWkgKnSo+y0jr7xgJ3FZ/41l6aadpb18eHhoTiFcFZp83v8
	g5tIIZF7+ryP23ZUGQdV7ynEjPLVMndMakmqnkSEaNz0zs/ELvSKIHe2I556owhE5rWA921P8V/
	RVg2EhltjFXZ/o2TVwLZ7zFL8G1ieD5BN6PUUnMwHs+lro4DU/UN2KuHXwiieQvXwRUIW0WSi0K
	OTf4UFM7+ZDjDslgtkRYeevJFdNSxdRCppBipaLG50+PwKC1LqOwZ3lHgvUa2q7hObl7owPMTI7
	da/MxzW6bb/pjnnMOBYNZ3UQiU995qd2lYZTPULUcsL0k7wxdv03vf15WHqkH1wQTMIOQZxnhMh
	TzqncIzx4i7vmkKHfE+ImBNIJlMqRACMK6c6APiHq6oo/NAf7VkXUPlPwdEdQQL4uwObjsW3pa3
	fCJ
X-Received: by 2002:a05:7022:b8f:b0:130:6978:c96 with SMTP id a92af1059eb24-13504738d6cmr9855637c88.19.1779240721285;
        Tue, 19 May 2026 18:32:01 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbdcf140sm25383312c88.5.2026.05.19.18.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 18:32:00 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	Denis Benato <denis.benato@linux.dev>,
	Zhouwang Huang <honjow311@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/4] Add MSI Claw HID Configuration Driver
Date: Wed, 20 May 2026 01:31:54 +0000
Message-ID: <20260520013158.3633277-1-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds an HID Configuration driver for the MSI Claw line of
Handheld Gaming PC's. The MSI Claw HID interface provides multiple
features, such as the ability to switch between xinput, dinput, and a
desktop mode, RGB control, rumble intensity, and mapping of the rear "M"
keys. There are additional gamepad modes that are not included in this
driver as they appear to be used in assembly line testing or are
incomplete in the firmware. During my testing I found them to be unstable.

The initial version of this driver was written by Denis Benato, which
contained the initial reverse-engineering and implementation for the
gamepad mode switching. This work was later expanded by Zhouwang Huang
to include more gamepad modes and additional features. Finally, I
refactored the entire driver, fixed multiple bugs, and refined the overall
format to conform to kernel driver best practices and style guide.

Claude was used initially by Zhouwang Huang to quickly parse HID captures
during the reverse-engineering of some of the features. Since Claude had
already been used, as a test of its capabilities I had it implement the
rumble intensity attribute after I had already rewritten most of the
driver, which I then manually edited to fix some mistakes. I also used
Claude to review the driver and these patches for any mistakes and bugs.

Assisted-by: Claude:claude-sonnet-4-6
Co-developed-by: Denis Benato <denis.benato@linux.dev>
Signed-off-by: Denis Benato <denis.benato@linux.dev>
Co-developed-by: Zhouwang Huang <honjow311@gmail.com>
Signed-off-by: Zhouwang Huang <honjow311@gmail.com>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
v7:
  - Use smp_[store_release|load_acquire] pattern for checking
    gamepad_registered and rgb_registered to avoid possible races during
    teardown.
  - Reorder reinit_completion in claw_hw_output_report to avoid race
    with possible incoming ACKs.
  - Reorder cancel_delayed_work_sync to ensure setup can't be re-armed
    after cancel.
  - Reset command state machine if hw_output_report has an error.
  - Add comments to (hopefully) silence sashinko-bot warnings about the
    use of endpoint matching and the impossible scenario of switching to
    the alternate endpoint from userspace while the driver is bound.
  - Don't use spinlock_irqsave when already in irq context.
  - Add profile_lock for read/write profile_pending.
  - Use struct for mkey reports and rumble reports, following the
    pattern established by rgb reports previously.
  - Add gating to cfg_setup_fn, allowing either gamepad settings or rgb
    settings to populate if the other fails for any reason.
  - Match on write address for rumble and mkey reports to prevent late
    ACK from causing synchronization errors.

v6: https://lore.kernel.org/linux-input/20260518222935.1802071-1-derekjohn.clark@gmail.com/
  - Add send/ack pattern to ensure synchronous acks.
  - Use spinlock_irqsave instead of mutex for read/write MODE event
    data.
  - add select NEW_LEDS to kconfig.
  - Make all timeouts 25ms to ensure at least 2 jiffies in a 100Hz
    config.
  - Gate all attribute show/store functions with gamepad_registered or
    rgb_registered, enabling use of devm_device_add_group and ending
    the need to hold a mutex during remove.
  - Don't set gamepad_mode on resume, MCU preserves state.
  - Ensure all count variables are checked for > 0 characters before
    setting buf - 1 to \n.
  - Re-arm cfg_setup in resume if it was canceled in an early suspend.
  - Remove duplicated argv_free macro.
  - Add spinlock_irqsave vice mutex for read/write access on attribute
    variables.
v5: https://lore.kernel.org/linux-input/20260517013925.3120314-1-derekjohn.clark@gmail.com/
  - Swap disabled & combination mkeys_function enum values.
  - Fix bug introduced in v5 where claw_buttons_store would return
    -EINVAL on all valid key entries.
  - Ensure mode_mutex is properly init.
  - Ensure claw_remove is calling hid_hw_close and not hid_hw_stop for
    all paths.
  - Ensure adding "DISABLED" key to valid entries is done in the correct
    patch.
  - Re-enable sending an empty string to clear button mappings in
    addition to setting DISABLED.
  - Move adding the RGB device into cfg_setup to prevent led core
    attributes from being written to prior to setup completing.
  - Ensure frame_lock is properly init.
  - Change variable names in RGB functions from frame and zone to f and
    z respectively to fit all scoped_guard actions in 100 columns.
v4: https://lore.kernel.org/linux-input/20260516042841.500299-1-derekjohn.clark@gmail.com/
  - Add msi_suspend/claw_suspend.
  - Reorder claw_remove to cancel all work before removing sysfs.
  - Add mutex lock for removing sysfs attributes.
  - Add mutex lock for MODE command data read/write.
  - Change dev_warn to dev_dbg in claw_profile_event.
  - use __free with DEFINE_FREE macro for argv instead of manually
    running argv_free, cleaining up scoped_guard goto.
  - Fix frame_calc validity check to use >=.
  - Use spinlock instead of mutex in raw_event and related attribute
    _store function.
  - Ensure delayed work is canceled in suspend & canceled before sysfs
    attribute removal.
v3: https://lore.kernel.org/linux-input/20260515033622.2095277-1-derekjohn.clark@gmail.com/
  - Add mutex for read/write if rgb frame data.
  - Ensure claw_hw_output_report is properly guarded.
  - Remove setting rgb_frame_count when reading rgb profiles as it always
    returns garbage data.
  - Ensure rgb_speed is getting drvdata from a valid lookup (not hdev).
  - Use scoped_guard where necessary.
  - Reoder claw_probe to ensure all mutex, completion, and variable
    assignments are in place prior to setting drvdata.
  - Ensure gamepad_mode is set to a valid enum value in claw_probe.
v2: https://lore.kernel.org/linux-input/20260513231445.3213501-1-derekjohn.clark@gmail.com/
  - Use mutexes to guard SYNC_TO_ROM calls and pending_profile calls.
  - Rename driver to hid-msi and add generic entrypoints for
    probe/resume/remove that call claw specific functions in order to
    future proof the driver for other MSI HID interfaces.
  - Fix various bugs and formatting issues.
v1: https://lore.kernel.org/linux-input/20260510043510.442807-1-derekjohn.clark@gmail.com/

Derek J. Clark (4):
  HID: hid-msi: Add MSI Claw configuration driver
  HID: hid-msi: Add M-key mapping attributes
  HID: hid-msi: Add RGB control interface
  HID: hid-msi: Add Rumble Intensity Attributes

 MAINTAINERS           |    6 +
 drivers/hid/Kconfig   |   13 +
 drivers/hid/Makefile  |    1 +
 drivers/hid/hid-ids.h |    5 +
 drivers/hid/hid-msi.c | 1911 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 1936 insertions(+)
 create mode 100644 drivers/hid/hid-msi.c

-- 
2.53.0

