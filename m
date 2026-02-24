Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9C819F11B
	for <linux-input@vger.kernel.org>; Tue, 24 Feb 2026 01:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771896743; cv=none; b=sJWAfMyntnAojoVbhgH26JQhaaZ8jx9IClYammhYJKpT//wTtUpgqg5U6y9QOVSQ5pklAq9qE5xklExyxNEyEXycAq8Yb4AKB3aTr8NCxg4xdUDMCqvNBErngILPk6ylxasuK5rC5yCHCh6ok7NaiG0VrdSpqTvdDEXDhtuzKVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771896743; c=relaxed/simple;
	bh=9QaSUsadgBZ0pAu9idxerD48WBsC80kGYrLKHo0YnDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=St5HgCpr10IyalLAf/rz8tWqaJfVnb/QYWG2qgGvNK2/23KrWWwPw2kHlpR1IdRirGDYYFU0HXSasvEHGtuA44JfxhXMmPrudF8BUdDmQ0RvlzSVnWV1hE+OkAqQEO9/doV5XltBWTChGdzATL2AF0Mg6hUOVirQkPxFcuiP68c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZE+4X23N; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZE+4X23N"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2bd8097c709so1261021eec.0
        for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 17:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771896742; x=1772501542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xf7FXImFkqV/ywRrjo8KhjWY1MLZz5tqMEQ4Yc9Qlu4=;
        b=ZE+4X23NAsWx65R8M+YM+dRNGOspi5FY7gu5aL6TsfNGHFPaJFxXLrfgC1lNYJPV5E
         CyJrV2yEO6QPjGJ+xz8XR7W5qrstITIZtbHd/c/1wMPKnoIhtSZMQoKkjZbpUpg2xXSm
         AkLTtf/M7j/e3gmg747/R7VKDHXly0//IlV2hmJak91aEsdOmIeDO9UIYPVNYEA13vva
         ll6RfbHpkm+0XtM9rOcJsTXoTCXslwaMlyX6ZLX9oTsBRLQx/ticShCl6ACWh3OAyTKh
         JUqVQh1KwONqDYZAmMKOcHvdHiHJaAbd1ZJkp0PYd9IYL6+SaxnxRfWhlHB4+SEd1nk4
         t5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771896742; x=1772501542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xf7FXImFkqV/ywRrjo8KhjWY1MLZz5tqMEQ4Yc9Qlu4=;
        b=u8gAmDwFYYCTKDHW1O9W3vDOcWblINwJT5wrEeiSoZEljG/QyzJDQCBkondebyALwW
         UXd3D2hPwSkDkvBbZ8lOXA2Fjb+3i+Q6yF6CCzCt72V+00aWE1yI0qR8AMICsuAr0oEK
         aexcoO6n62K04gyhbqJuO3jCRSwF2Whk4bvvhrO1EUciMrmSXOHtIpCvwAKTjuaJS559
         OGORqlLAo5/fDl13sVGZiDXmMPpqm/inQ8U+Tq2sRghGsBWUFj15mzwf5tDAVidDtcSM
         /bNe85Dl7WgIaPufib0SE1vPwSuTT8z9XL62EHwZLHeKc1k2hyos0BWJ19dJgnOTFxIv
         HL6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+l+KTNpFHyKSTzK/ag8IMdSxvWvcb0S67+enCzCnBfnElQ8UlwU+eZzj8U9eGvDMAdc1UDTaYYi7+XA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWiijoJlzEWCEG8cAHd2CBu/cxaOwHSW2Jq//C518hpI6GDGbt
	sTq+iF+3qEL4i7DvNAvKDUQ7wRSH3yWfvzJbqD13CgYjmvMENg7RiUex
X-Gm-Gg: ATEYQzx1bZkaJy7QTZ23hYJq/qiY+cxzIGLnGHaOkQq8QqQPO3+/RIXq1I05kBU03ej
	7k0mT6yonpbIiEkmBhA5K8lmysDPGzR6nbjxswNw8OmqzAnA8TnP/JdiGkeMJt0AYi8+Y6sJKZu
	qf9/UnCZY6arlU9v8sOlHqLA1kMly+n/DEW7yvJDjnxaQk3AIX2zX7uHEwfbBmAHHLiX4A+PbiJ
	K9GP+jLzZOxjxB+QTH9eDWnheCjrq2N9N6+3/bnk9I3qYP8JU7mIDHHoI21qNg+akurpyPRVbFC
	OI7RJLoBRJqXfvi6HjY9z+2jXggg3EKn7XboUBGM7RPENjy9MOihPnfgikmCuIaET3C9Ft/ZdqA
	8bOF/ThB77/XimuI5xtheHPshEGMI+mjH64IE4eGSdSotRyu3thPUDB301KzM+aujnJv83AbOUO
	uUdcIpcU3STOpUWamcoBKrBIwU4ouQK5B9ju14ghPz4/9QcQBN0ZFPAIqi2dli9KUTlCDRFAlli
	os=
X-Received: by 2002:a05:693c:40cf:b0:2bd:a7a4:6fc with SMTP id 5a478bee46e88-2bda7a421b7mr580631eec.24.1771896741649;
        Mon, 23 Feb 2026 17:32:21 -0800 (PST)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7daa027fsm6485015eec.9.2026.02.23.17.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 17:32:21 -0800 (PST)
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
Subject: [PATCH v5 00/16] HID: Add Legion Go and Go S Drivers
Date: Tue, 24 Feb 2026 01:32:01 +0000
Message-ID: <20260224013217.1363996-1-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.52.0
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
v5:
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
 drivers/hid/hid-lenovo-go-s.c                 | 1509 ++++++++++
 drivers/hid/hid-lenovo-go.c                   | 2497 +++++++++++++++++
 include/linux/device.h                        |   46 +
 include/linux/hid.h                           |    1 +
 11 files changed, 5130 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
 create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
 create mode 100644 drivers/hid/hid-lenovo-go-s.c
 create mode 100644 drivers/hid/hid-lenovo-go.c

-- 
2.52.0

