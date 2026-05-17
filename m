Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91993016E7
	for <linux-input@vger.kernel.org>; Sun, 17 May 2026 01:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778981970; cv=none; b=A22REm7ZeXDdw5loB7iiA6Nj/qnYoQ+7N7rRWsuTxZg1qDS2F32e4UQVu/x+QyRF1VhJxW/V3qLMWESpaItaehU1GVx/J9AIFcfbb4pOWB+v3+nprZs4Ejkj49V3hK40cF6nCIA7efj47G2ZnFZZV80eUm5Ikrq83oEiDm4o6U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778981970; c=relaxed/simple;
	bh=pPbH/0fAZCTMfBo2AlodrAijJ5me0bk98Uy/Q8uG59M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b+XeRBFaq/u/uCaKZJQGViYI9IAuScVcvxg3G0N3HNao1dFTiD3BrHfcQRQtsuCFejdowvoo77KX0oOkFp9eCeOjRhP+u6KvrPG27Z24hyJspFMWRcAo7aSXLRktKvUYQ+LncI6b+u6mKLrFIIx1mQVeyBWESLsHVbi7l5tyhSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8INou/b; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8INou/b"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2f7020a928eso1480701eec.1
        for <linux-input@vger.kernel.org>; Sat, 16 May 2026 18:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778981968; x=1779586768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2NlxtySzo01FfuK8dPO1udm7bJRoM/LnmyF6z8QWTE0=;
        b=L8INou/bMHnoNRiPlCv18iM5cbNVECiVzp+WTfP3K3SsbieJYsuNOdeJDMdoYW0Ya6
         BaRq71ieFP9PHEs2q2XswQxNPdzL+wkPt5FLvCD9IBs2s6lRqWuzZ3TvJUdU3kGM7cFj
         2HGm+OILWeUByFbDNAGoMHB5XxHJtdCg2D28dhAOT9l5c1NEezuz2KFydpphNLZNxGOL
         G3AkDZOHMkCpIZGRg573CWQ3fJ3eXMkykN6oFgcZl74J2xfEqapwQoAAxkA8vr2uME+x
         7xgG7bexlsNRO+4WQOgchlsRr+jRwCWCmdeRfQXR5VPPy5lM3Xyp5Q8WLP9mYUCx0m5u
         Z5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778981968; x=1779586768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NlxtySzo01FfuK8dPO1udm7bJRoM/LnmyF6z8QWTE0=;
        b=UaSxYx3RLQhJZgGdRS4pQfvpXIMpHDkSgZy+e79ipTyC8riHzOrjutLcx52AhQISts
         eUR8qVlL/M8iv/Mq2/iyDv2Tq52IrW4PTA1sTlx8SfaqM7OPLBcIlbyWKa71HaWgMvq6
         tdcOuS5kPPPkUt0upzSCGMgHPd2BKh00Ul+oKFRXz/o35tMq2Hb5KNyin8gasAdsCUsq
         TKFJ2kzRNPXyXocgZ4Iy8ddoPTnPBU448qYoJTJP6IhS47Gw4IeXcLR7L2JALWIou92o
         coYalhO/7dHoGbbIBFP/S+ZyRl1YtD88RFbO2WQTCp9Yn/vhklau4xT2EXrLRe+HzGMv
         YiDA==
X-Forwarded-Encrypted: i=1; AFNElJ+9mi4B0uiW1OpN/RKEIacgSsDeYWUt1oaCl4zy0hJhpJDv9JQuFFbcM5pbCUfq5AqKQQAR6bT2Q9ucyw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfh8MnQ/aX5nnMGD7+yR6fwNemzFwMUVaX7KqQ83t0CAPrzUam
	H7BUILcbZAYDrnflW7BrFqRVJkIGdAWJW3ob0luRlFL5IzrWYAD1e4iU
X-Gm-Gg: Acq92OEOWvvneCYWIVqCiBn/V3+QMxg6wK3canHvzmMNqYI7WqldOQO48WBQQQ4HALI
	+YKqUdJ7MUeERyrJMNo92KvSnss5RLEK56hvCtW22vH+wyyqJmR317722dDmTe9Bmm1lYSCfU/1
	DLEuKpPsIhQQ2CQmFOxj1q1yaRoIcHlvzlNaBCEUkpjywR6hE0w93Pl1JL/tbhzDOeR4vBq368Z
	LG/nNW26/OoGS1ymfunoTcgLRdjJPVNGz2GnkTHn+1pKZRjRGrtXO0DAS1ql1KEjL54dpMiX1BU
	dWLxEpLTsYcw1E7JTs6OPeQjTkeohVw/Hk0Nsy5Durlt8OWrQGz1o9lntln/l437SZ9GkR8t3TV
	lOg8DRVA2HvTdjGvuZMIXRdWM/8K05O8sLifLj9ml/Uag5s+3jYnNfET2AmRln8bs7ZjlE0i7mo
	SfT+z++wteP4wOo4uR0SUZsJNn/odoZ9vC5I/3nAThCG1LpwGPnM0gD4oWq09n9JPu3kpw1yVn0
	Iyy
X-Received: by 2002:a05:7022:4193:b0:12d:de3f:d84e with SMTP id a92af1059eb24-1350494d102mr3763558c88.39.1778981967817;
        Sat, 16 May 2026 18:39:27 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cb5b3c20sm15898086c88.0.2026.05.16.18.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 18:39:27 -0700 (PDT)
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
Subject: [PATCH v5 0/4] Add MSI Claw HID Configuration Driver
Date: Sun, 17 May 2026 01:39:21 +0000
Message-ID: <20260517013925.3120314-1-derekjohn.clark@gmail.com>
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
v5:
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
 drivers/hid/Kconfig   |   12 +
 drivers/hid/Makefile  |    1 +
 drivers/hid/hid-ids.h |    6 +
 drivers/hid/hid-msi.c | 1728 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 1753 insertions(+)
 create mode 100644 drivers/hid/hid-msi.c

-- 
2.53.0

