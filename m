Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B05332628
	for <linux-input@vger.kernel.org>; Fri, 29 May 2026 07:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780039280; cv=none; b=CjJPrQjkQK395TO9Rd7Up+B3MIaXBqiBNhDP0nbiBBDmS/UFP4IX4jraKusud4ghGZFGROX80eTvmdMzNsZWudsJQr11P+kOFWLB9v5cN/P3xKcfunBg0K3akUH/T3zbs+o/15jYx474yoDA+nBCEyGCdIfdtS0hDXX8pFycKQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780039280; c=relaxed/simple;
	bh=nZW7vnJfYnLYQEMlY9hF5OzsgJoH+As5y+gaJI175Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bo9KXXslC/jV8XX+V3aZfU0MZzIkltxjYG72GakghfN/BMeWUjShKg5JvIKOC0r4p4uq7XhlFYIm+bIPE5lexBjtd2PCHhsDZc9y9ZrNmaSU4p3sd9figv+nHiE3Xl26aDA0R5zJUuo4PlI4ivTS0N47pWw7J9KElNZZy9ms0bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q7SAkmlZ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q7SAkmlZ"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf18c30bb2so6196215ad.0
        for <linux-input@vger.kernel.org>; Fri, 29 May 2026 00:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780039278; x=1780644078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MSwCFJW3lBYKnjmRoMMkl7mKUYyNzUGCf3sK/GxF83Y=;
        b=q7SAkmlZZ9438DH6pSgRmlFlaDsTeDCj3ZUt9ZW/96OFtmC4ldSI5HNME5lP2suxky
         yPt404QqlsD6eMsNYJR/ZA2Nqx3k1vvFnG9HwXRzeZHzLkir8Oqr2l4W/XI27NKuFXq4
         7QphVjiy+G0ZK8up92TBYmvoJKw1vB38CP4zo5EMzbz8B2mWf6DNNKdJLw/jS2niudGP
         HmLiPvblWLpnDzcQantIc61EQoEZ05QusAxka54RcjrrNh3fE7JnZPI1y4k2hXZcwKpF
         Ax4Zvx1tCCeLit24G0fIwuyAb9RSe2E+RExXrOMg9sK8gWchN/8s5AzrXbyK5KOZfUq6
         qjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780039278; x=1780644078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSwCFJW3lBYKnjmRoMMkl7mKUYyNzUGCf3sK/GxF83Y=;
        b=MUvYuloMmWm6DM4+eHU0YCxo0bUegCgDC9WBhha4ruMtk4em4ubWujLH0f2vTWeS2Z
         5b98Eswjm3BKYr9jBy+5I/Fg4xHKJ9WPU4xj5XwInMpmWQv2dMEq23NNPEmWjfIk3mHB
         eNuaxcG/gUT1Hh1MRCwTF4r0UqSyzPPNjd6iQQyy1rNg2E5nu+agFVU6uKIABrokImSM
         P+4pNQBiDOwI9vuIluctlqZTTh89FKsfZkFNqoa6X6RWKw+odZh0OCBmyQUfXVeiula1
         VZX+2oW7uAzNkO0XaN0wx96sFjY9EcuNUitItyfeAidbihJnxvhh/qj8sRdRGASYRUnP
         tt2g==
X-Forwarded-Encrypted: i=1; AFNElJ97IdCi5ZcUjwpKjUUHSyiH0B0sO0P6mnlIXtwd7MltJKJG9Ei7e3bV4HAfHqlZG798EnCUDTmTDqJnug==@vger.kernel.org
X-Gm-Message-State: AOJu0YySSVu6N00TpbCRuZk8X6cv/NgxuQ2X+bM5o+DPzSFNe1qhGJcB
	2XtFSV9P+rRdS/+3VkyU3CdIE0V4TykcdAs7KnWQmxx68cNJtZhiCobUMZs9qiXW
X-Gm-Gg: Acq92OGK6ieHVpehoX9HTT9jM1/EQAmY8WD1BsNrPJuKamXGqu4+evB9wAfIrdUYzA0
	a29sGj7jm5qMV+3iMxx2zh+arjRlG/WnjueABW8nLc7w0rU/yeoBT/x4w7Q03SnhjJvT2rlYsFe
	lZLXNoVwEgk+YhP8pI32vc8yORJuv3paENqu6oTsVkpqNKkggDyHVuKkPEgP3AlnBO2LYeTxg4H
	ehgVCkbTEJS4DihpLsnsZvMoqfRWVLDb839ITCgeszqiIC1gSYbZbwrE3cfChleLOdPT1cfn0Qn
	BvkaQ3B9NAfM7+mTtDsJ+coDD+FF1RjAENPtPqOGtkdQCjdbSkOVK/L3Uts6hsJm0EdsixTNqyP
	8+mWFRm0LewVDX9zWuKQE3ASNzBmGI31fVIKGx9JHC8JlFAQRV0j2xdaxwcgXc+z4UxxWP+qC/e
	EeiyM390lDu4eIgwac3GqkYsCfVFqXQVUSbw==
X-Received: by 2002:a17:903:1ae6:b0:2bd:7191:5708 with SMTP id d9443c01a7336-2bf20bb8cbbmr23970105ad.29.1780039277783;
        Fri, 29 May 2026 00:21:17 -0700 (PDT)
Received: from lappy ([210.160.217.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239e5c83sm8851695ad.16.2026.05.29.00.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 00:21:17 -0700 (PDT)
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
Subject: [PATCH v11 0/4] Add MSI Claw HID Configuration Driver
Date: Fri, 29 May 2026 00:21:07 -0700
Message-ID: <20260529072111.7565-1-derekjohn.clark@gmail.com>
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
v11:
  - Restore dropped changes from v10.
v10: https://lore.kernel.org/linux-input/20260527222122.10620-1-derekjohn.clark@gmail.com/
  - Remove additional gamepad_registered variable left over after rename
    to gp_registered.
v9: https://lore.kernel.org/linux-input/20260525020543.519082-1-derekjohn.clark@gmail.com/
  - Don't use devm_* functions in cfg_setup_fn, do manual adding
    and cleanup to prevent possible use after free.
  - Use scoped_guard instead of guard in claw_remove.
  - Rename gamepad_registered to gp_registered for brevity.
  - Check for drvdata in rgb_queue_fn to avoid use after free during
    teardown.
  - Ensure rgb_queue work is canceled during suspend.
  - Limit guard usage in cfg_setup_fn to avoid holding a lock during
    registration and add group events.
v8: https://lore.kernel.org/linux-input/20260522015518.1111290-1-derekjohn.clark@gmail.com/
  - Use spinlock when accessing gamepad_registered.
  - Clear state machine on all errors in claw_hw_output_report.
  - Wrap all branches under single cmd_lock guard in claw_raw_event.
  - Reject generic ACK in claw_raw_event if waiting_cmd is for another
    branch.
  - Wrap all branches under single cmd_lock guard in claw_raw_event.
  - Reject generic ACK in claw_raw_event if waiting_cmd is for another
    branch.
  - Don't close hid devices that couldn't have been opened.
  - Ensure led_classdev is unregistered if adding attribute group fails.
  - Reorder remove actions to ensure no use-after free or rearming cleared
    flags.
v7: https://lore.kernel.org/linux-input/20260520013158.3633277-1-derekjohn.clark@gmail.com/
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
 drivers/hid/hid-msi.c | 1998 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 2023 insertions(+)
 create mode 100644 drivers/hid/hid-msi.c

-- 
2.53.0

