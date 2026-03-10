Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629A83E8C5B
	for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 07:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773127783; cv=none; b=Qaxmn2QMdO2WeBTHkLMn8s/+AKfDE7e+brpRkO/Sk4V+ZCoFQJg5fNRagOLdmz3d+HjVQTOXmpyNghKU77L5s3PwvddpaJ3VX/Udf58OnXvm76WY2Uu2YDFLY+MPoy4wt5uhGNMGuzpPraUEY9As1e0RpkgiTmblmU/lgXvT9/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773127783; c=relaxed/simple;
	bh=b+DOz3vZdL+D98QLf9xPAO77+3xK09W3fKXvmW7+8Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hqZ1Vbfn90bRcnk/zUFNgGg9OFyKLmSET8dKB3zR3pCdd3glBl73L/hRGWHkEvbedu7CQVjAslJCYsAakgPTn5Ga4PCKKDgbqcvjDp+8pM+A12XF3LRQIlHEG9rn4FKdsyNKT8CrT1V1r1n4D9l0dGeGksYKyu1Lui7Ax3iGiKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4J54rft; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4J54rft"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so10758531eec.1
        for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 00:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773127780; x=1773732580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ungc3nKaebEzF/mNg2XGVfrnqyJR5bO1BbUSyVSIAiQ=;
        b=S4J54rft75ETzVGwMBjrz25CEczSvnHpZgV3kdRJmJ0X7zRcZtXKiWrbTRKkxrw0oK
         oTlMw2BJSUkG2vxyl8w0yh47FVmzA7DjPHUN+fihq9k38hQ0lk7MXG3+nhl/ZePviKmz
         vbC5ZBM70gcWAYMv/IOU0YmfGkNuzt8Z7ZEwKxiKTF9hbAFSoSU+Jh83xC7S6s7rirs4
         7SdOD4tZaS5dpAWNp+/CKFL3EjoFZN/LAAfPP1TnHINntsF5Y+MfCHd974hBlIORFOHB
         SLWgOAmQawPOFe0X/wdZO4cMLRQdR+fZ2ZEKuWizsJiQEwY7Eh6daK5Hm+Lv3BGeDEJR
         8QZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773127780; x=1773732580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ungc3nKaebEzF/mNg2XGVfrnqyJR5bO1BbUSyVSIAiQ=;
        b=V9/jYM955JxkH88jLafHkHZvZUBLEJRYiuMErjrEAZ8iYoNFjQLTfc+Uo2fgCB62L8
         pH//431Kijc2Ks1UBov9OWMK7ibo3hM2cfu1JvQL9FsvR1BkcG8xfPMqZdxRZDFmk3tq
         n7kdfSp0aZPKbRWZzoDiUP+6N1f/RC6C1WDm3P7XiQkTqDbyCIQdZjiub/BQK8DeHbgr
         VdOdw2SO6K0vn24bWi2KN6BrTVT7vAba6xFF+ea3krJ+oq3Scei2H7J5tPj1V+92nVxJ
         IGRX6KTKpyZkqotyY2s6az5UfT9lh+jwGlVNwHuyzRXDIEWzEaWDWkBWGPPEDo4vOR3W
         GHjA==
X-Forwarded-Encrypted: i=1; AJvYcCWxM7DyYX94E9N318WhlGc4TQayrdPifTnmi1L2m6N8vbHd9iCUrB0HiYNmezNm4YQblEKUtXSXBzf9gQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxVg6LDGkdZko7W95Dh+xUiTCDW6TyCTybAR+Mlo+NbAuGpscR
	qIA2/3samLrfD2Hq3HP4AMRHofyA65XbT3F7WBcvESvu+7lqegofTmYG
X-Gm-Gg: ATEYQzxeh4DvpBOHwVxnk9kn/sdTv7plvun7dp3/KwuUQ0uP1HYTRI9M2BSnDgVkYw/
	qrkL61zjEknJtmBJgeJFZwlEHIJsSZcAb7k/oAVCofIGFSYxeFZdntvnIOkYb7coTejyXRmk+2t
	ahfdny907OKWBhhNH0Ge6fV0z2k5GsNOPgZvfVxab/SsuuciDiNd+elUjGuNbVh0O7rrziOgK3z
	N5iM5OXO2ienYxheKQCbIRpJLnKutC8p0FN3iOf10A6o6Oyc6P6HqS0WrRFG2JJEiGEY9EoTdo6
	4BtALEkx/b6mCE9wGddZjKA4ZP2odvJCAbD79fmglEXZIzrUYPb13rYxxiEq3ti6SWO/hWB75iU
	Harf9tnALroJE+Up8Wtg15UTWxAZNd0ZVs0DaEi8dFkEdJlmwSW8xeqt3H5C5qGzDFIipDkviSp
	hyZdqbnCJrDsx639Mop6m90ZQqQh6vEQm6wiDVnmepjt92fVR0b4epGhq4DIMrTeZZ8eidvSZRQ
	HKhdr43J5sUReo=
X-Received: by 2002:a05:7301:1286:b0:2ba:6a79:f04c with SMTP id 5a478bee46e88-2be4e055dc5mr5269084eec.18.1773127780326;
        Tue, 10 Mar 2026 00:29:40 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be81209142sm721925eec.12.2026.03.10.00.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 00:29:39 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Richard Hughes <hughsient@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Zhixin Zhang <zhangzx36@lenovo.com>,
	Mia Shao <shaohz1@lenovo.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 00/19] HID: Add Legion Go and Go S Drivers
Date: Tue, 10 Mar 2026 07:29:18 +0000
Message-ID: <20260310072937.3295875-1-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds configuration driver support for the Legion Go S,
Legion Go, and Legion Go 2 built-in controller HID interfaces. This
allows for configuring hardware specific attributes such as the auso
sleep timeout, rumble intensity, etc. non-configuration reports are
forwarded to the HID subsystem to ensure no loss of functionality in
userspace. Basic gamepad functionality is provided through xpad, while
advanced features are currently only implemented in userspace daemons
such as InputPlumber[1]. I plan to move this functionality into the
kernel in a later patch series.

Three new device.h macros are added that solve a fairly specific
problem. Many of the attributes need to have the same name as other
attributes when they are in separate attribute subdirectories. The
previous version of this series, along with the upcoming his-asus-ally
driver[2] use this macro to simplify the sysfs by removing redundancy.
An upcoming out of tree driver for the Zotac Zone [3] also found this
macro to be useful. This greatly reduces the path length and term
redundancy of file paths in the sysfs, while also allowing for cleaner
subdirectories that are grouped by functionality. Rather than carry the
same macro in four drivers, it seems beneficial to me that we include the
macro with the other device macros.

A new HID uevent property is also added, HID_FIRMWARE_VERSION, so as to
permit fwupd to read the firmware version of the Go S HID interface without
detaching the kernel driver.

Finally, there are some checkpatch warnings that will need to be supressed:
WARNING: ENOSYS means 'invalid syscall nr' and nothing else
1292: FILE: drivers/hid/lenovo-legos-hid/lenovo-legos-hid-config.c:1085:
+       case -ENOSYS: /* during rmmod -ENOSYS is expected */

This error handling case was added as it is experienced in the real world
when the driver is rmmod. The LED subsystem produces this error code in
its legacy code and this is not a new novel use of -ENOSYS, we are simply
catching the case to avoid spurious errors in dmesg when the drivers are
removed.

[1]: https://github.com/ShadowBlip/InputPlumber/tree/main/src/drivers/lego
[2]: https://lore.kernel.org/all/20240806081212.56860-1-luke@ljones.dev/
[3]: https://github.com/flukejones/linux/tree/wip/zotac-zone-6.15/drivers/hid/zotac-zone-hid

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
Change Log
v6:
  - Include multiple bug fixes from Ethan Tidmore.
  - Make all local attributes static.
  - Invert the rgb_speed logic for the go driver. On the Go this
    attribute sets a delay, so flip the logic to match Go S where the
    larger number means faster so userspace can target this consistently.
  - Include 3 new patches that fix formatting issues with v5 authored by
    additional developers.
v5: https://lore.kernel.org/linux-input/20260224013217.1363996-1-derekjohn.clark@gmail.com/
  - Make all RO attributes cache the data during probe using delayed
    work for both drivers. All RW attributes are read in realtime to
    ensure they match the device current state in the event of firmware
    reset or a userspace application.
  - Fix endianness of version strings and print as hex for Go driver.
  - Remove reset__esume function. It was not being hit as the MCU of
    both devices disconnects of suspend, forcing a reinit of the driver.
    Udev or userpsace will need to set the OS Mode upon resume.
v4: https://lore.kernel.org/linux-input/20260220070533.4083667-1-derekjohn.clark@gmail.com/
  - Use dmabuf allocated per request for both drivers instead of a devm
    preallocated buffer that is reused. This solves a bug where some
    attributes couldn't be restored without manual writing after resume.
  - Reduce the number of quirks and flags in the Go S init to only those
    necessary. Previously they were duplicated from the Go driver but
    everything except HID_CONNECT_HIDRAW was found to be unnessary
    during operational testing.
  - Clean up formatting for debug prints in Go S driver.
  - Fix bugs in RGB driver for Go that caused the effect to switch to
    solid when the speed or brightness was changed.
  - Remove extraneous setting of os_mode member of drvdata when setting
    os_mode. It will be read from the hardware in _show.
v3: https://lore.kernel.org/linux-input/20260124014907.991265-1-derekjohn.clark@gmail.com/
  - Fix Documentation formatting by removing extra + characters.
  - Fix bugs in hid-lenovo-go-s IMU & TP RO attributes being tied to the
    wrong _show function.
  - Rename enume os_mode_index to os_mode_types_index to fix collision
    with os_mode_index attribute.
  - Remove accidental rename for enabled->enable attributes in patch 4
  - Add SOB for Mario in patch 10 as Co-Developer.
v2: https://lore.kernel.org/linux-input/20251229031753.581664-1-derekjohn.clark@gmail.com/
  - Break up adding the Go S driver into feature specific patches.
  - Rename Go S driver from lenovo-legos-hid to hid-lenovo-go-s and move
    it out of a subdirectory.
  - Drop the arbitrary uevent properties patch.
  - Add Go series driver.
  - Move DEVICE_ATTR_NAMED macros to device.h.
v1: https://lore.kernel.org/linux-input/20250703004943.515919-1-derekjohn.clark@gmail.com/

Chen Ni (2):
  HID: hid-lenovo-go-s: Remove unneeded semicolon
  HID: hid-lenovo-go: Remove unneeded semicolon

Colin Ian King (1):
  HID: hid-lenovo-go-s: Fix spelling mistake "configuratiion" ->
    "configuration"

Derek J. Clark (15):
  include: device.h: Add named device attributes
  HID: hid-lenovo-go: Add Lenovo Legion Go Series HID Driver
  HID: hid-lenovo-go: Add Feature Status Attributes
  HID: hid-lenovo-go: Add Rumble and Haptic Settings
  HID: hid-lenovo-go: Add FPS Mode DPI settings
  HID: hid-lenovo-go: Add RGB LED control interface
  HID: hid-lenovo-go: Add Calibration Settings
  HID: hid-lenovo-go: Add OS Mode Toggle
  HID: hid-lenovo-go-s: Add Lenovo Legion Go S Series HID Driver
  HID: hid-lenovo-go-s: Add MCU ID Attribute
  HID: hid-lenovo-go-s: Add Feature Status Attributes
  HID: hid-lenovo-go-s: Add Touchpad Mode Attributes
  HID: hid-lenovo-go-s: Add RGB LED control interface
  HID: hid-lenovo-go-s: Add IMU and Touchpad RO Attributes
  HID: Add documentation for Lenovo Legion Go drivers

Mario Limonciello (1):
  HID: Include firmware version in the uevent

 .../ABI/testing/sysfs-driver-hid-lenovo-go    |  724 +++++
 .../ABI/testing/sysfs-driver-hid-lenovo-go-s  |  304 ++
 MAINTAINERS                                   |   11 +
 drivers/hid/Kconfig                           |   24 +
 drivers/hid/Makefile                          |    2 +
 drivers/hid/hid-core.c                        |    5 +
 drivers/hid/hid-ids.h                         |    7 +
 drivers/hid/hid-lenovo-go-s.c                 | 1506 ++++++++++
 drivers/hid/hid-lenovo-go.c                   | 2502 +++++++++++++++++
 include/linux/device.h                        |   46 +
 include/linux/hid.h                           |    1 +
 11 files changed, 5132 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
 create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
 create mode 100644 drivers/hid/hid-lenovo-go-s.c
 create mode 100644 drivers/hid/hid-lenovo-go.c

-- 
2.53.0

