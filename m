Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A8739891E
	for <linux-input@vger.kernel.org>; Wed, 27 May 2026 22:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779920490; cv=none; b=jH/+omWBG6PZh70ZHmWlSOjV67C61Amj3lGWHyJUR4UTigzP4u2DhoV+YdEZ49eBMj6J4qUz7e+2Y8JDoMOuGsdj+jbvMeFw0CHvpzpELXxx14BUua5FSlI2dfK5QXH3DvjPr5H7x2AtQsLNXTmnXl/JKtxjkvi5BazVlbt/kEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779920490; c=relaxed/simple;
	bh=amt/aSnfCD4mRO9WuKpNVAVi2K/iazes122xLYFRuvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=miJ0gq/lZHHjn9pfZ4BOWo+Q0BfpXVzYMSTGZae3PVXHN+TcmTQQ/nKEdsbTusSKxkLDU839+o8frhh+l6D3SnW89lgP8oOTaWPm2kY34eqc0vInAMSn1MmZp+5TB/L6LjBKc9e5GaV/ZL/1qGMxU0atgU0OjnBvylbjxZp7QmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOJ2/KbG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOJ2/KbG"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b458ca2296so91788955ad.0
        for <linux-input@vger.kernel.org>; Wed, 27 May 2026 15:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779920488; x=1780525288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OnV3huOIWH5ncFFvV2J1TuRo9vrXrPmzDdrWQuCOI4A=;
        b=NOJ2/KbGDQejytdXXdnL5YGRO7gfx0g2ZJNKuqFPJbQwB24q/TTJ979Tf0QlriunD0
         cCWz5wFzctw2QPLvS7LYdfKdew0L29HaH0uo8iB1QRnr+LDVf3qvG/FPqSND9WyoNu91
         XwlKAP8ssewCgxsHf00zrqipul6pjS0erYF8GSN0UZe/VIDTraNOK0zzti07+9aPAdmS
         qhrROI8h/ikaNmmmfyyRLxV2SQ3lThfhakgm+x7ty7QW2r5IDteGvoh/E9CiPVHuW0GI
         892jehtIwMxjWdr6edK7Wfh4LcUw7pCMd9At4Dxz0ZeLqpDAgJG8rOdznGovcgfTeLBv
         +bGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779920488; x=1780525288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnV3huOIWH5ncFFvV2J1TuRo9vrXrPmzDdrWQuCOI4A=;
        b=oMsQLMSXtMFAzLlIpxzxP5Hfm76WPosQZK0Nl+UTHcXEc2BYT8VO6oq+fpughomZVf
         b2QWnsxvHVSrlTuJqXH1enRv+x7csM5y9qqJMzyFogY7grzG5n8kSf6wI3przSbr7Cec
         RlzzDv3cKReNxtsfcgUKM7G9DlYaJVcANyXvKcrsQ9Kl++4AxAkIIxL12P3byFWZ575t
         slxcNFkcZwqvZ3fekdnI9aFCgkwKKs6iLPIN4yUSbFBws12jhaDBSEq/6xbQkMQDTlBM
         kECU/M2xURxPyUndHgDyfWCNr8IFLgPDXVEszV+0BaCQJFFJU8ZO6TpHxtmpPr79DJtf
         Hbiw==
X-Forwarded-Encrypted: i=1; AFNElJ8lRmi6RtPgpo9IcooGiTun02gfCkX9fOWs6pXizjJcWqEJAArzpNCUNxeM8aRytt6DXccauAFgKGFBDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2gt6ygVLy0k1858wMDrDOE2Hlm7sKI2wB8m+xgDaR5YVOxqw5
	E7Dj3bgE/+TmCXPbdRWI/DFB/AX/8ikJ3cRA9kxmyOSIVv9IRVlYCoxc
X-Gm-Gg: Acq92OH45Rw5R+Oojla+qLOy5YR3LkeZU81lbXlDyrmj32Ukto1UUN4TbdnlnzJ6lTD
	2/FYWhFEn3wAFS06mkPuMPhOnCpuM8JWJbz8M8BP+eVyeaZVNWNjiOn5Rw2L+8VdEkafQvOj8Iz
	Yxg3rJR4fJxYFaT30MRkhWSqwfc8V4pVYAARuj7eQme4XnWcGcHl3CZZubTY34ywUhgxt8JNa7+
	OvRQcTI5sfzE+wo9EPpD3UFy5x2EqRaj95RUPjwT1AjXWzWIPeL/eD2yTLNEw8g19h5t96FkWl7
	V5anvJmg23Cfh1DUMUEunyBoquKXdtwcRe2lMCvtc/aNPP7U0TX+J9eoutD6zHGN57Pa4sT+oB2
	4NbAdGXihQyLbsZF1SAeyqx4Ae/pqQH3OtGOtMWnB43gTzKzNI0HugimoKlYgZiCI96E51ZqziB
	ffTu3Qt4AoJfIbE2+S2YDzRYfl8j3RL7rtHlhVCpCEAlqgYplV5IgFMyk=
X-Received: by 2002:a17:903:390d:b0:2b4:5e0f:c239 with SMTP id d9443c01a7336-2beb03776bcmr248815745ad.10.1779920487731;
        Wed, 27 May 2026 15:21:27 -0700 (PDT)
Received: from lappy ([203.105.74.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58fd888sm167783445ad.73.2026.05.27.15.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 15:21:27 -0700 (PDT)
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
Subject: [PATCH v10 0/4] Add MSI Claw HID Configuration Driver
Date: Wed, 27 May 2026 22:21:18 +0000
Message-ID: <20260527222122.10620-1-derekjohn.clark@gmail.com>
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
v10:
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
 drivers/hid/hid-msi.c | 1813 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 1838 insertions(+)
 create mode 100644 drivers/hid/hid-msi.c

-- 
2.53.0

