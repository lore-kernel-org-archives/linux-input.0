Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC42F70836
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 03:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784517356; cv=none; b=lW+gwu+dR2t4RN/fCVebZScRsRdTzTb/BgV9Tr70JZPxIKSn6+SMUCg7lUc6CH6O5WoOGORtaj+TPrXPfVFpSzjPYNtJlrtCkFYyaxFRjzoQ9vRaMp881J0hnYDvQhBnboWUiHRi/Icx0ylUe6su/OP//jgzUelgeYkv3nfKov0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784517356; c=relaxed/simple;
	bh=xJld+Kqr3E9aGmWW8fwZIGmVJLiOCEscp9QOcRU/Cuo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uKdNQdgzvZFYawQYM2pSBOeVQBWZVJKO0HybZruXl3rss1hK0wnBPsE2lYF5daIbQkrirUv9nq01C4gmgqyHHExPyg+SRsrzPM1iOA3VZ2MPyTco/Yu8toc+t09bIqxJiszA9smDB3a8bTqw1etw0pKmwksz8YmsBp5/peffqq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cyaOUQmJ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyaOUQmJ"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-ca957432c7fso6589460a12.1
        for <linux-input@vger.kernel.org>; Sun, 19 Jul 2026 20:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784517354; x=1785122154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rAn+ZjzZCIWy9NwWys+0erxDJuyw8kVHNqaC7VdPjaI=;
        b=cyaOUQmJHnHaA1dMclmbP4VYvNYZdU2I/OPx9s39F8jirMeATMbw2bJLuUdEQht8p6
         Psi2xOWctW3FVhd2kqhH0OTie45YNTW7P4ftEYP3gpW5eSJKkxDGxweTxQVXF+lU85IU
         OZNG6TQv7S2EVFb2ssh+nhPOr5olXXLSKqExmRa6kiMDwgc9txXQGZYZBgRL6XwoKkCt
         qIjvfksGY5v78gQVcL2ZYSz8zO2KhPnwfIl2uSBDSHc4dPRU1CrNoYZPquCpl+eGD1S0
         d9EWfMcU6nXjB2Pj5w2UpA0t9ik5ytVGgPe/fU4SY8YdwpvNK3y/djP+lCTRlwkF0n5o
         Fl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784517354; x=1785122154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rAn+ZjzZCIWy9NwWys+0erxDJuyw8kVHNqaC7VdPjaI=;
        b=p4MxkJUOzu4go4S7yLfS8s84gszDG6/5RZ76R6lxgrAN8fyeHKpP3hQQMXl+WkwpPP
         V8KKFZwEr4OsKpX3zmV5OHSK+IVplpLFXow1SJW96kVD0UixUuJ5duVQgL8HotoYXwmR
         BxZvLO6co3/h3kMxaisg1V345WMRRvYY3+6OLUb7HHLyEKCMLdNnOywEBgrEucTM8Uql
         0MZAwuxWdTwB7nyhV0HtsYY+170Ax6cFt3tAdgrEc7spfMMmrqvCEPX9Ui4MVIGN4v35
         YlAkHBUNX8JcX5Hm0kgidxChb8d5WUAh3FAYvQo3hgFMvW79G3Jt3pBPPFrK5bNDf5Tg
         KyTg==
X-Forwarded-Encrypted: i=1; AHgh+Rpz+SagO7bzjodY1LTcPhzf+WIZEuBmCdQToeuWPHR+wo7035t8qhjTg02HUSZDA2LE4AVFdCXiRW8ayw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAqcIdMtotjaIF4EW2/aTByAO6+STU34bZ6BFtIYu3J/PoioGr
	gNGNhzjJov+Uxu6Z91IbgZSYHhw29UdEOIBfv853rm+fwK5+vTJ3hv0U
X-Gm-Gg: AfdE7ckg8mtK/tblLQf30M7R1QuAVty3DXRB1UnkYgXl8QAgaVwwDgSBWg+eaGZnH1J
	bio0q70esd++XWxNWgu5b53zJVAJbTFqoVDk/nPWUJwlPZchRqYidQ7rZqzo++dJ1sOPLUpt2Xj
	QxVTwDjdu9yNI8wQ5UoQIT66dVp9VcT1OWnRsLNToI9Y3elQi2SGjQ5ze0I+FG6DgRS3CsOvJKW
	BGBxema0874upEwrEQ2/PH+Go4zJyzA626eGuhfihAZWjQniCmuecJaqZVF/ugkAAuut9Y+bCe5
	a78btcGPtxOr9ak+svB5T6JrUXzE/P5kvA0SglGZAXzSwjXDADmZvN6QZmLSFrLEvLZucEHuI0u
	cvBSbhnpVCHSME4Oy1Rnr0pfmYnlOgtvxLNb5aQaHYCqV0LHQLRzrM0PpAAmU7J/Zj3SUegw95X
	SLL+yJ7jUDBfp6cjEPcoWGnzGf6aqS15OSlkxM5QWO41RtukB8dJgsA1E=
X-Received: by 2002:a05:6a21:7111:b0:3c0:9c19:6586 with SMTP id adf61e73a8af0-3c3ad9a2938mr13291174637.64.1784517354212;
        Sun, 19 Jul 2026 20:15:54 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429fdbd45sm30822694eec.12.2026.07.19.20.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 20:15:52 -0700 (PDT)
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
Subject: [PATCH v13 0/4] Add MSI Claw HID Configuration Driver
Date: Mon, 20 Jul 2026 03:15:45 +0000
Message-ID: <20260720031549.2272658-1-derekjohn.clark@gmail.com>
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
v13:
 - Add pm_ptr() to driver resume pointer.
 - Refactor handling of pending acks with no timeout, avoids collisions
   by arming a completion to wait on the next command, allowing the URB
   to be dropped (so the ACK will fire) while forcing serial events.
v12: https://lore.kernel.org/linux-input/20260714102640.18075-1-derekjohn.clark@gmail.com/
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
 drivers/hid/hid-msi.c | 2054 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 2079 insertions(+)
 create mode 100644 drivers/hid/hid-msi.c

-- 
2.54.0

