Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5E636E46E
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784024808; cv=none; b=YB/k8yY92U5rlvmDnwu9ncuXw3t/t23iTOaxjgKwwtKAbPLbh7jJ/swBHHU5mOlGqewDEmDFya3zfey3/vk5tfyv6llxYHfjl50p7LtWki63G/hok2NgfvnVCSWmYCMtpj9F0AiMlS6B+dZnQS+0bGyXhD0yWXru/YzhCHJFfOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784024808; c=relaxed/simple;
	bh=K+QIxVhorfR1MyXp+qy4rn09dpd40JsjX9jkdrYe12A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nNidqSlIcTGiVkj8RBhpdYoWt8EnWUE/Xvtz43DmFjsandni1xUOeBboOZpbpIyjmvupkS5XMCQb9R8WQpI7kc1cka8SILx/KymGv9Xacao/uIkbFGeVATo+u+tW50fgMT70LxW9/k7dclxdby2ZcapDPAbc7LbBKHTnJrCJl48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/iC29Kk; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/iC29Kk"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38101f85591so588625a91.1
        for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 03:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784024806; x=1784629606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=boyQ+mZmVrEZmWolDZaO6rWNxBMWstz63XLu9MpBykk=;
        b=C/iC29Kkt4gJw26FyxAZKmjC1/wKmT+Bgssm8CWWrY3nrvKQ82DZhKd+EPby62TK8p
         NfZJx14mVfb4F42Zh/zZFZQNgD2l0JDkwd/i7+fz+emDTqRb3bxxy9D7sPVdPQGx97E3
         ycv4TZyRB+HLxuGjAz+C9zFHxeAJPz8CYnNV2tyun7KPSh/q+n9ACPYip8uCwNS3PPKa
         +ERTNoQLwBuOTSg2Kgz9wtfx5jUPuljDON4IBGK7hixmmO+92yQu7PhNNaIm41wGZysD
         TsUxEBnipjLMf7I6KmSs0OxlHsvfhyyjjLZno2/OXl3D91kofr0bxq4xcBR4wg3PyExy
         oqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784024806; x=1784629606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=boyQ+mZmVrEZmWolDZaO6rWNxBMWstz63XLu9MpBykk=;
        b=CzKrEH1TGOYvovHEhSDkYFvaeGPiJ2n2hFNbadM6ilXy3wnhexA6/AhUsTn1hXY5B9
         jR9dHLdim1gtPcB5MOAeDzTvexFMIPY/88ID1zACunU3HO52Ku1PH1svIxAkZfGNxQ2O
         ufQy05NoVVm9BcPp5WbAUGp5n0V47/Z8r5Wc3CbZDfniytcC3/Vbhqa39c9IfqeXsUmH
         ZfrFUzEi0SDJIJZKtIrUOzf3QCENKaN8WjlnbwBVgsY9QzSTUYMT76/CqgWHFafZx4KQ
         i3fky8tA1BvLn6iAoOFaaH49aukhWiCB3a7j7kaBTJzlPa+77beUCr2BQ/Fg7Cxo/Mwu
         CxkA==
X-Forwarded-Encrypted: i=1; AHgh+RozDA+ZEdzHX8TmO17gne0DC5+g02jGUGem6cikaO4v5m36Mg0TIF1BKuPN8FocxGk/NI+yKRnq/+E5zg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb/luwOXoGsWgxBO+JqZ0TQUrnaviGCWHT6MtoGP0HmJqZFHUV
	pfOn+KWrrl/2CEmE0WAn0XMUQb5YF2KakNRfiikmyd0zX8KYF5B/WSMQ
X-Gm-Gg: AfdE7cmadv0axh+yvoVbWMADRArR+9/rg95yZXi1k7584ZgobSha+ZGdB3Ans3t587X
	Dw1O3dE0WbMYASyVreg8w15mLMZjgArDJuPyibC+4891UD+ZbQ5MdtDdPp3uvy7p61ASCCC/+PP
	dDS5SD1vvr4vWpBaTk8Lw4rGpn+VtaCzwc2S9ZLUJr+pU5DLeDTEwTt9g8VEF8H0FVFUcdO3QlO
	3Bs+tW54f1vBkOvcz2M0thxFmF8nscZtIF4WTHWS0jDjUBqVPeCuQ/PLG8Eqqn729tFUplelDqT
	tTDtdRwoCrGXyVV7jePDUH30CYK0RtI5+/N/2nvXGiXpgkcT60Jr5vVAGejqeJpsWw1iroQSfcP
	TfKKF69q/TkhHkmgLvUV9v/WD60jqSnEFJJCoeFZXW4vAAWHs/2ptBtYC8P+uK4VYtya58o/Ul3
	J3yT5KIJ5TMGfhfNkypDJa06cxyOYvRoAFdsaDPd5nlKkDIIpfqlHXdNw=
X-Received: by 2002:a17:90b:2646:b0:384:927f:3db9 with SMTP id 98e67ed59e1d1-38dc807217fmr9919822a91.1.1784024805678;
        Tue, 14 Jul 2026 03:26:45 -0700 (PDT)
Received: from lappy (221x252x203x146.ap221.ftth.ucom.ne.jp. [221.252.203.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e172cf625sm1264750a91.7.2026.07.14.03.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 03:26:45 -0700 (PDT)
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
Subject: [PATCH v12 0/4] Add MSI Claw HID Configuration Driver
Date: Tue, 14 Jul 2026 03:26:36 -0700
Message-ID: <20260714102640.18075-1-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.54.0
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
v12:
  - Fix race condition with mode events. Makes claw_hw_output_report() a
    wrapper that holds cfg_mutex and adds __claw_hw_output_report(),
    which has the old functionality but uses lockdep_assert_held(), and
    claw_switch_mode(), which handles cfg_mutex holding and spinlock
    holding for all mode functions, preventing the multiple callers issue.
  - Remove goto based cleanup in __claw_hw_output_report(), adds some
    duplicated code but avoids anti-pattern for cleanup.
  - Use spinlock_irqsave for raw_event-reachable locks since completion
    context isn't guaranteed softirq-only across all HCDs.
  - Add bool to track if the driver is waiting on a sync ack with no
    timeout to prevent those acks from clearing timeout acks.
  - On address mismatch, assume stale message return and keep waiting for
    correct message.
  - On remove, cancel the rgb_queue last to avoid a re-arming, and in
    rgb_queue_fn check rgb_registered to avoid running after the sysfs
    group has been removed.
  - Add note to led_cdev.name to (hopefully) silence sashiko-bot about
    an impossible double device collision.
  - Explicitly check if the current address is less than the rgb_address
    to avoid invalid overflow math.
v11: https://lore.kernel.org/linux-input/20260529072111.7565-1-derekjohn.clark@gmail.com/#r
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
 drivers/hid/hid-msi.c | 2058 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 2083 insertions(+)
 create mode 100644 drivers/hid/hid-msi.c

-- 
2.54.0

