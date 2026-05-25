Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDF521771B
	for <linux-input@vger.kernel.org>; Mon, 25 May 2026 02:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779674756; cv=none; b=bZ/Lkya9aaOr/y8S3yUDk5l7LKuSVGW7SOYvrcmSFkar9yOQk9enPqhe7FxsdIgxV2IcJvd/32yH2G5apqveGElSVRfuvJS4jRuKMNvI22mMGgxoJcyX5866OmTTfnzPLboHtVJKRHiHjYKdK1GbnzR8My8MP4/Tp7FKrAZLHqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779674756; c=relaxed/simple;
	bh=OBMMmp+YTMAm7U85146xnrw24q4YjUbI18Q2uM1E0fE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qOp7QBC0iNK/Lhs5ytoOwYz1TduqbBfguS0fwgHDJ6s2VxpZh6ugbdqOKA0HJsIeZng1IMYZKzxc8cA1DKc1XLqHrtwWmVb79kFWQBgHR4QcxJGEOz7PmpoHsR9ZBriw9tSv6XopIY/rF2fL5Wo1LP2FjUiuwYBmjWyNOXTh6y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ed5gPJKu; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ed5gPJKu"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8353ca0f1f1so3942421b3a.1
        for <linux-input@vger.kernel.org>; Sun, 24 May 2026 19:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779674754; x=1780279554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WaPWQoiiTkAlBxuWrZfPdKnM+hMsBzcJp27fLs5FejY=;
        b=ed5gPJKunrNXf1xx9ADjC/otbsr3ysPgDK7JsakIRzEUvCZ0k7Kdz2MATpmilyAR4u
         f37XFf4duaB3j/lCpt8Zc/dcOFKwWODM29EOLwmmT5CGPkq6KfJO7VGGyOFKOhex/s1O
         40Ux1+M5UZytGxlr7sSIa0HKCC02s50uHc/MXBgvPbdtzSDanFqlEFagV0BkK0vDhwOh
         tsknTGY18MEK16nqiz/7E9BdHludLqq0fqGdSUJEXYLVphEie2WYJEJdC+0dkZOLzjxP
         BVg3HL9L5yXV8x8bW31B39dViJmgDJFrDvErhAfnBnAIauBWRdOBrcB+ZrN3AkOzuEgf
         Kd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779674754; x=1780279554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WaPWQoiiTkAlBxuWrZfPdKnM+hMsBzcJp27fLs5FejY=;
        b=g4V5S+bOyfdgr0QSZX/upSdJgMq1KMh4p5B1iJS4OMZr3V3tWTbNwjE2WKDulHRogC
         FT1DA7/voDramvAJZq/6ovs7NJWVI8uj6taKSrgyU4cIn+XzHrITYLtqTFbGZPLdKHkV
         zKyGgHQv4frk3AwXO4rY86xqnlj9ptiOs46vF1ZfOgrQAmKYu2v8jZXbyMNh9xNbA1h/
         z8URVYto0AMFPKE70kicq3fwIy2E8YstjmjgIMwl3szsLJf6Y+2uAtdj80CAELs77gN1
         VyBnmvofw+lG3P/JQ6YwYEMEdikItTgEGa52sRDLAVGfT5qdP5a+O58ZP2XnUy3DAXuu
         Ki1g==
X-Forwarded-Encrypted: i=1; AFNElJ9if1QxazN4+Wp7eQ0wnheiWqDUBe6M1+OJwtjcRBts/0UEByzcavR7Hp3j7MZIP6YjYet7x3lTbyUs5g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Cn8QziSrGOsc/Ze25qV/ytLTaUikStgDs3zSH6tqeMuRD0W2
	WfVRQibfLUYSqfvlbrlhw5ok3sH5Ztr8/ZqBSwsh3gvSYjyvK+Y3sVtF
X-Gm-Gg: Acq92OGD1dnLoLuBuqAzhb4WSbQKgJTH2rHY8OGY8C+4hVgQC4U1Av2Sb6Q0Ip51ngL
	pEfPrxphmvnVdwMdjVcsEKTaj0SJskEIsmwx9IrOS36Bh9I/pWoxN/GOWV2Y+/gpvgiCkYLlNdZ
	JaD5S+qmAbvHKRpsSfqcfheVQ4liHaTEpFWsp7RmrJ56nYWn6ToyYbCWgXJiQWU67mW1Jke1jwv
	AwOTRrg7TCujje71hQomP8x6QB+bfubSbMrT1UKe2h+srfSu+bBr6E9HsG03d9SNCjrtWrEsESQ
	Q9uXM6FglWUaznEKn+plQK1wJ5J7r1/0zX+QZh/z85xj+XXB43WP2dJ0wheFZPvz3QHlMJK+Yg2
	YHn/RjgkkDUtoxdwy5uLMkHSVHDTsXUNbmJ3yVF8izgJMfP0jF7FZKzA3zx7Y3WKfZrkCBA+AjF
	/nuZG+XBQ5p8UQEm74Fiphr+WsUis9bx+xDH3Bcl7CLFu4
X-Received: by 2002:a05:6a00:4c8e:b0:838:1f6b:dcbc with SMTP id d2e1a72fcca58-8414b3e1e7cmr12310242b3a.6.1779674753927;
        Sun, 24 May 2026 19:05:53 -0700 (PDT)
Received: from lappy ([203.105.74.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ac9df3sm9369587b3a.9.2026.05.24.19.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 19:05:53 -0700 (PDT)
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
Subject: [PATCH v9 0/4] Add MSI Claw HID Configuration Driver
Date: Mon, 25 May 2026 02:05:39 +0000
Message-ID: <20260525020543.519082-1-derekjohn.clark@gmail.com>
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
v9:
  - Don't use devm_* functions in cfg_setup_fn, do manual adding
    and cleanup to prevent possible use after free.
  - Use scoped_guard instead of guard in claw_remove.
  - Rename gamepad_registered to gp_registered for brevity.
  - Check for drvdata in rgb_queue_fn to avoid use after free during
    teardown.
  - Ensure rgb_queue work is canceled during suspend.
  - Limit guard usage in cfg_setup_fn to avoid holding a lock during
    registration and add group events.
v8:
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

