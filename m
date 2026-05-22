Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D871E5B9A
	for <linux-input@vger.kernel.org>; Fri, 22 May 2026 01:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779414924; cv=none; b=SR14G2OQRaC+TSWJbQbaGuA4la4iJjLbHz9P1mbanL/pnsIgJ2g4Ak9AzAfkGjTyVbVHbLRJih1pj0xZWwNvUaOaIRWISbOKUPhgZpITSIOA4yghr/7Er9wrm/RpjUdssCTCGJVPaRQsazdT5+1hFSE4qpnJiVh7PZd5wOaqvaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779414924; c=relaxed/simple;
	bh=a14LELKGdLlGxA0JWTIiQ34/q0XwuK+lSqKCrSUw+/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nPSbt4cp7sgPcJ0Auia+7nx75OxgtU4FHUgzYX5kZmlYr4y8ybpRC+bRdhTgcitXSMPB8jy8UJxr4OsDinbBtGGtIzhh+VNmCly8HWkvqshsl/qaGM8YTaPcJXZzYAqhiQKCHve9PTiO19HjEeWGcyiX4rFtbzpthenC14FUD1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1Hjg4XU; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1Hjg4XU"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3044857f09aso921477eec.1
        for <linux-input@vger.kernel.org>; Thu, 21 May 2026 18:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779414922; x=1780019722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ta6Rkgj0W41964n7L0CI/4UtxHQLT/GRoNfsIIac3I=;
        b=j1Hjg4XUVji4f3RmPknjpV4FVgzFGVBQv7c1U5LhIAKbUTydX18kuadT/JZNNhMqVG
         +cCLw0bQ5c5FkIVbNhpLmwGPzJ5n+oSpYgnul7xz6Hoi8UFF5oEWzmhp6+TqAPmczfQt
         rSTJo45ee0CA2NdX56wwg84y9hjMRBDE34MLhS3JmlJSkQg++Mo0cTtbvFVHwhDErttd
         MGLwmBvq3RpkOokublOVZLXoOFETw1ATUospk14BzH6J6zyzs174ZPWa8RbYWriFxk4x
         FtoAd0OrDDGkGPftlajn53/TLf80HiRgXk3j3bWa1FItuzgw5Q3sJ1RyuABJvsJLkZ2j
         rwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779414922; x=1780019722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Ta6Rkgj0W41964n7L0CI/4UtxHQLT/GRoNfsIIac3I=;
        b=kRhy7/XZUYUd4kmRVmuTtQV6HhsDoUbjBy1bBX1YzS2jNIgV/6/oGnS2lofyNPsT3e
         orAkejs78ZlVPz/J175gE2xVe8xQ8kr7JORoxTkL9Fyj0FFX57zCkF1ASDFTYhmh9Oow
         3ruSCL/d/wgyvNKFrP+ESVGdEmrrheyV0Odi8hyjdOAYUaVeLkSx1exstFkC4EhedkvC
         aIafsmn803wSpDHE0Ox+jRymebb/MlTHeBYwlpvI6cUXeu+Mxrj5oiBU48wEiJk7JZxy
         I9uReWlARPcMBomBCoPgSARKAIg9zxqywjipAEgPqDUaCDU/z5EVoUaSEEDrCpBbV2/n
         vfLw==
X-Forwarded-Encrypted: i=1; AFNElJ/GYJThieIN2RCoL1EADy6zSHYWitaRJ7i/WfrFkrX9gWi6rERZxj4WAiPE2N/zKR3ek08aQED6omq+DA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDt0CHNyv0v/O9VIWDYR0UBmtxPMnHfHdmMBLaYemcbnKu8/wI
	cJ/njqLToAWbRrOBkRf9g2U2tUIJq3khUMMNuylU5K2/fDj0D1UptSHa
X-Gm-Gg: Acq92OGn1HD5pQW+ClVU2rBNzsyg7vQOGwgQLcp4SY74i4AJi3Fom7tgg0TqN0PzK2s
	uWf0C0T5Y3j1TMZxbbRudiiYchEYJfyNG+fYQJyAEEJuGoQs/wugamo4W4DNAD9gvxoeFt0Kmre
	86zcD4HiUOkWBi7gxQT2DPlVpev5j429mVCcn2jxWS90MfnU1nKnY/ldE9rWrmcIyZZisuzfRz8
	OkPktJ5TuTKP+2nwS9DH1tTbs5bF75aWDPdC8aY5HVOJ1VrHhGUIZTVZCX8AlrLjSo38/xv4M59
	86hZ3pjmfpF27zQo9flq7YC/QCfvjj41RhJMI5EkQlWpL+5BgBqmQ/nfkmVrz8wrZwjGGBfxKgC
	opOM79aGRoctrMc/H1fepdKcTCF+nKH6Mg/ddEw2nzB6efAsxYxZMPYwOiMpyCfmIzwtTg2aA8Q
	mlKhVJbrNnKrMy4nlgjhXkc6Y9HOp+lydj+Aup5Cbc7apFBE8eO1VtkLQNUyrDBkDCrXBOYxjoY
	vEy
X-Received: by 2002:a05:7300:324b:b0:2d2:96e8:1bf5 with SMTP id 5a478bee46e88-30448f3084cmr1071594eec.3.1779414921662;
        Thu, 21 May 2026 18:55:21 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3044b9123f7sm1027744eec.19.2026.05.21.18.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 18:55:21 -0700 (PDT)
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
Subject: [PATCH v8 0/4] Add MSI Claw HID Configuration Driver
Date: Fri, 22 May 2026 01:55:14 +0000
Message-ID: <20260522015518.1111290-1-derekjohn.clark@gmail.com>
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
 drivers/hid/hid-msi.c | 1980 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 2005 insertions(+)
 create mode 100644 drivers/hid/hid-msi.c

-- 
2.53.0

