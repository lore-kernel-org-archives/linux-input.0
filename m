Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0C13370F3
	for <linux-input@vger.kernel.org>; Fri, 20 Feb 2026 07:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771571176; cv=none; b=o8SaNWuGBO4KgbulF6JZd0ljtYJs+0DzH0iRGV4AW7j/+b1UXg+ZP3L8HOklrMgWQsKYgi6ywSzwiSDreXi6d7OKslYUY7w8/PDhxb6eMDyFbLJPAE+x/Y1deHAiqLcKZWmcmE0qAn9Cyy0zrRqcHBRdOCo1zkfS22+/nKWE3gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771571176; c=relaxed/simple;
	bh=ikfzksm+wLsqocEkArkkEVPF+9NtY6K0g1U6x4qnaHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1XXgB6tSiKmzRM5X4hu7GErT8qRz3J/EVIy+PYAOj8fsK0oHp/EmovRyqc32jxBn5JiJvfV15Jm04LaB6+pljsL/N7p2xegwPn2z9k9J2zUzHiPyqaOsmo/hLxwxt+DY8EJJZLATMgtMLOwED5BzW4nOdvEjGCZedb47dkCMkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLJJEd6h; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLJJEd6h"
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-127423bea4bso1454672c88.0
        for <linux-input@vger.kernel.org>; Thu, 19 Feb 2026 23:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771571172; x=1772175972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22FKswPIkgTaZrxf06G8nEvQoSlteqKZSt+NVe2oBnI=;
        b=CLJJEd6hDYCYeWaLqRFCJU7cYkoy49WLZLWIJReuYWpClBW3fXBDJ6oLK6pL1C550w
         2YzkL+MosoCgMqAGPx6hhyUcHUtyI9j97At4H9ixQ9wGSSScg9LoZog0sdhz02YEARHG
         l33wxJo+41tDkY10JmXWJZtjpWW2ZUDMeqfY/t6QLtqOrIIj0Ht2ZyfZYV6xFpwlm0PC
         XuBdrjrZMOYWFrT509IwjfbBOvsPLbv9znNrZgM+WsZkvHiQ79+LBrDOjBTSnyn97M6v
         raWtkAZWjIlQ7jrL6nt2xHuNj28TTYYBsfG2OfF8DMTtWJqfT5vHfJNNjumVkufN+OW8
         ORlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771571172; x=1772175972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=22FKswPIkgTaZrxf06G8nEvQoSlteqKZSt+NVe2oBnI=;
        b=IcxvBz1j+mwYV+zJ/B1PpoNnbu9FxvPg5WA5WxJVm3NxmoNlVcal6+kvpkkGKeJrLj
         1yl0y3VdHcNFIR+Zc/KSpP6jrlr00runnEEFhbtn0jLmMNVq9BWp8BdkmJA5HXPSldGZ
         LWznIL3fNIgU5OLi6pqPrlXYc4rbQ1445BesDRfBLVEyPfiAOGcyU+QJTA9HYHj3ziCc
         hcBvi9kwK4mr+FqKECB33BX4+z32YvG2SEVPA8sRCgSMeUvSaOrLJZZYNqDUUfl/8hMT
         6rlCX0NJ1hHfg+KQq4fWisprNWbxx8mGKv+bjZNhCieyYFd0emP0J5RpVQNIs112E2aW
         dCOw==
X-Forwarded-Encrypted: i=1; AJvYcCUiFxPzRRWJ8milqghESFcrqPpBG7TDXCaQ5x7yP72vjBsJb1z1gcy/Ha7xiSZWE41NmJPkWWcgVztngQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjnFIrQ/DZHlnvweQIjA8/+xdXJBic3lXVUrXL39soavRqyNuh
	4d/0yaqs4njxkUAOEQOst+7WS5PK5hZCk9SIiGdSVZivi9NTDtX/CB2X
X-Gm-Gg: AZuq6aKf4vWCd4FwG4MEz8S1FjRQioSO5tLPPJB1U27zs2dutfrlOs6GoHgY5ZrQ3+N
	31lf/9Ivg2pQ50KAm+eAulGmZP2A8VbzVH8Rl1zndCG4NbRQT/dnftKkLDrwOKh2HwiouijGisj
	HmRhHidOeck09ljSLbbLI1V6JisZqByxjjXolezKfICc2r6ioBqfz/z20Xi1Ml1Z8bb6TGLou3A
	ByCUNvzYhBdeQSF5pPAfJJUBLA7y3ucpRabKFL3DV4djFKEbO9RpJ1JrK+PTDQXq1BN3RPOwuUU
	puPjGPRSJVhHkTNJ1yp0eLOs2Ri7D0NdjF40R1APtCFC3gsKiA4c0Vr8hllCgLIvAwUykVG+7Dl
	bOCskSgmpEmbCINBEtz4V9LOFkP3xK9SdhgYKZUvGs5AZ1SSXGXBHYPH86Iv8JHwQ5GrU4+iXga
	y5HzzJvwXAwYeNCmi5AOc/5ttfI1flI8T2GsPCG9EX1oB1j1CBfYfXmNUaGZRNeG6ij8tegxvzo
	ZM=
X-Received: by 2002:a05:693c:3013:b0:2ba:a3c5:ccd with SMTP id 5a478bee46e88-2bd733cc98amr260099eec.37.1771571171831;
        Thu, 19 Feb 2026 23:06:11 -0800 (PST)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb669f7dsm22163335eec.23.2026.02.19.23.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 23:06:11 -0800 (PST)
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
Subject: [PATCH v4 16/16] HID: Add documentation for Lenovo Legion Go drivers
Date: Fri, 20 Feb 2026 07:05:29 +0000
Message-ID: <20260220070533.4083667-17-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220070533.4083667-1-derekjohn.clark@gmail.com>
References: <20260220070533.4083667-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds ABI documentation for the hid-lenovo-go-s and hid-lenovo-go
drivers.

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
V3:
 - Remove excess + from every line of patch.
---
 .../ABI/testing/sysfs-driver-hid-lenovo-go    | 724 ++++++++++++++++++
 .../ABI/testing/sysfs-driver-hid-lenovo-go-s  | 304 ++++++++
 MAINTAINERS                                   |   2 +
 3 files changed, 1030 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
 create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
new file mode 100644
index 0000000000000..c8221373ef76a
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
@@ -0,0 +1,724 @@
+What:		/sys/class/leds/go:rgb:joystick_rings/effect
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This controls the display effect of the RGB interface.
+
+		Values are monocolor, breathe, chroma, or rainbow.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/class/leds/go:rgb:joystick_rings/effect_index
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the effect attribute.
+
+		Values are monocolor, breathe, chroma, or rainbow.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/class/leds/go:rgb:joystick_rings/enabled
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This controls enabling or disabling the RGB interface.
+
+		Values are true or false.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/class/leds/go:rgb:joystick_rings/enabled_index
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the enabled attribute.
+
+		Values are true or false.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/class/leds/go:rgb:joystick_rings/mode
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This controls the operating mode of the RGB interface.
+
+		Values are dynamic or custom. Custom allows setting the RGB effect and color.
+    Dynamic is a Windows mode for syncing Lenovo RGB interfaces not currently
+    supported under Linux.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/class/leds/go:rgb:joystick_rings/mode_index
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the mode attribute.
+
+		Values are dynamic or custom.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/class/leds/go:rgb:joystick_rings/profile
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This controls selecting the configured RGB profile.
+
+		Values are 1-3.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/class/leds/go:rgb:joystick_rings/profile_range
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the profile attribute.
+
+		Values are 1-3.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/class/leds/go:rgb:joystick_rings/speed
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This controls the change rate for the breathe, chroma, and rainbow effects.
+
+		Values are 0-100.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/class/leds/go:rgb:joystick_rings/speed_range
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the speed attribute.
+
+		Values are 0-100.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/firmware_version
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the firmware version of the internal MCU.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/fps_mode_dpi
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the DPI of the right handle when the FPS mode switch is on.
+
+		Values are 500, 800, 1200, and 1800.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/fps_mode_dpi_index
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the fps_mode_dpi attribute.
+
+		Values are 500, 800, 1200, and 1800.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/hardware_generation
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the hardware generation of the internal MCU.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/hardware_version
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the hardware version of the internal MCU.
+
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/left_handle/auto_sleep_time
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This controls the sleep timer due to inactivity for the left removable controller.
+
+		Values are 0-255.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/left_handle/auto_sleep_time_range
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the left_handle/auto_sleep_time attribute.
+
+		Values are 0-255.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/left_handle/calibrate_gyro
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This initiates or halts calibration of the left removable controller's IMU.
+
+		Values are start, stop.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/left_handle/calibrate_gyro_index
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the left_handle/calibrate_gyro attribute.
+
+		Values are start, stop.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/left_handle/calibrate_gyro_status
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the result of the last attempted calibration of the left removable controller's IMU.
+
+		Values are unknown, success, failure.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/left_handle/calibrate_joystick
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This initiates or halts calibration of the left removable controller's joystick.
+
+		Values are start, stop.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/left_handle/calibrate_joystick_index
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the left_handle/calibrate_jotstick attribute.
+
+		Values are start, stop.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/left_handle/calibrate_joystick_status
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the result of the last attempted calibration of the left removable controller's joystick.
+
+		Values are unknown, success, failure.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/left_handle/calibrate_tirgger
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This initiates or halts calibration of the left removable controller's trigger.
+
+		Values are start, stop.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/left_handle/calibrate_gyro_trigger
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the left_handle/calibrate_trigger attribute.
+
+		Values are start, stop.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/left_handle/calibrate_trigger_status
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the result of the last attempted calibration of the left removable controller's trigger.
+
+		Values are unknown, success, failure.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/left_handle/firmware_version
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the left removable controller's firmware version.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/left_handle/hardware_generation
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the hardware generation of the left removable controller.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/left_handle/hardware_version
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the hardware version of the left removable controller.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/left_handle/imu_bypass_enabled
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This controls enabling or disabling the IMU bypass function of the left removable controller.
+
+		Values are true or false.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/left_handle/imu_bypass_enabled_index
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the left_handle/imu_bypass_enabled attribute.
+
+		Values are true or false.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/left_handle/imu_enabled
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This controls enabling or disabling the IMU of the left removable controller.
+
+		Values are true or false.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/left_handle/imu_enabled_index
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the left_handle/imu_enabled attribute.
+
+		Values are true or false.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/left_handle/product_version
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the product version of the left removable controller.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/left_handle/protocol_version
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the protocol version of the left removable controller.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/left_handle/reset
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	Resets the left removable controller to factory defaults.
+
+		Writing 1 to this path initiates.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/left_handle/rumble_mode
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This controls setting the response behavior for rumble events for the left removable controller.
+
+		Values are fps, racing, standarg, spg, rpg.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/left_handle/rumble_mode_index
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the left_handle/rumble_mode attribute.
+
+		Values are fps, racing, standarg, spg, rpg.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/left_handle/rumble_notification
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This controls enabling haptic rumble events for the left removable controller.
+
+		Values are true, false.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/left_handle/rumble_notification_index
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the left_handle/rumble_notification attribute.
+
+		Values are true, false.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/mode
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This controls the operating mode of the built-in controller.
+
+		Values are xinput or dinput.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/left_handle/mode_index
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the mode attribute.
+
+		Values are xinput or dinput.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This controls the behavior of built in chord combinations.
+
+		Values are windows or linux.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the os_mode attribute.
+
+		Values are windows or linux.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/product_version
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the product version of the internal MCU.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/right_handle/protocol_version
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the protocol version of the internal MCU.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/reset_mcu
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	Resets the internal MCU to factory defaults.
+
+		Writing 1 to this path initiates.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/right_handle/auto_sleep_time
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This controls the sleep timer due to inactivity for the right removable controller.
+
+		Values are 0-255.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/right_handle/auto_sleep_time_range
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the right_handle/auto_sleep_time attribute.
+
+		Values are 0-255.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/right_handle/calibrate_gyro
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This initiates or halts calibration of the right removable controller's IMU.
+
+		Values are start, stop.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/right_handle/calibrate_gyro_index
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the right_handle/calibrate_gyro attribute.
+
+		Values are start, stop.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/right_handle/calibrate_gyro_status
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the result of the last attempted calibration of the right removable controller's IMU.
+
+		Values are unknown, success, failure.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/right_handle/calibrate_joystick
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This initiates or halts calibration of the right removable controller's joystick.
+
+		Values are start, stop.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/right_handle/calibrate_joystick_index
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the right_handle/calibrate_jotstick attribute.
+
+		Values are start, stop.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/right_handle/calibrate_joystick_status
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the result of the last attempted calibration of the right removable controller's joystick.
+
+		Values are unknown, success, failure.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/right_handle/calibrate_tirgger
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This initiates or halts calibration of the right removable controller's trigger.
+
+		Values are start, stop.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/right_handle/calibrate_gyro_trigger
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the right_handle/calibrate_trigger attribute.
+
+		Values are start, stop.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/right_handle/calibrate_trigger_status
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the result of the last attempted calibration of the right removable controller's trigger.
+
+		Values are unknown, success, failure.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/right_handle/firmware_version
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the right removable controller's firmware version.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/right_handle/hardware_generation
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the hardware generation of the right removable controller.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/right_handle/hardware_version
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the hardware version of the right removable controller.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/right_handle/imu_bypass_enabled
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This controls enabling or disabling the IMU bypass function of the right removable controller.
+
+		Values are true or false.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/right_handle/imu_bypass_enabled_index
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the right_handle/imu_bypass_enabled attribute.
+
+		Values are true or false.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/right_handle/imu_enabled
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This controls enabling or disabling the IMU of the right removable controller.
+
+		Values are true or false.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/right_handle/imu_enabled_index
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the right_handle/imu_enabled attribute.
+
+		Values are true or false.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/right_handle/product_version
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the product version of the right removable controller.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/right_handle/protocol_version
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the protocol version of the right removable controller.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/right_handle/reset
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	Resets the right removable controller to factory defaults.
+
+		Writing 1 to this path initiates.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/right_handle/rumble_mode
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This controls setting the response behavior for rumble events for the right removable controller.
+
+		Values are fps, racing, standarg, spg, rpg.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/right_handle/rumble_mode_index
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the right_handle/rumble_mode attribute.
+
+		Values are fps, racing, standarg, spg, rpg.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/right_handle/rumble_notification
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This controls enabling haptic rumble events for the right removable controller.
+
+		Values are true, false.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/right_handle/rumble_notification_index
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the right_handle/rumble_notification attribute.
+
+		Values are true, false.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/rumble_intensity
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This controls setting the rumble intensity for both removable controllers.
+
+		Values are off, low, medium, high.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/rumble_intensity_index
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the rumble_intensity attribute.
+
+		Values are off, low, medium, high.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This controls enabling or disabling the touchpad.
+
+		Values are true, false.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled_index
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the touchpad/enabled attribute.
+
+		Values are true, false.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/vibration_enabled
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This controls enabling haptic rumble events for the touchpad.
+
+		Values are true, false.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/vibration_enabled_index
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the touchpad/vibration_enabled attribute.
+
+		Values are true, false.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/vibration_intensity
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This controls setting the intensity of the touchpad haptics.
+
+		Values are off, low, medium, high.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/vibration_intensity_index
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the touchpad/vibration_intensity attribute.
+
+		Values are off, low, medium, high.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/tx_dongle/firmware_version
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the firmware version of the internal wireless transmission dongle.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/tx_dongle/hardware_generation
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the hardware generation of the internal wireless transmission dongle.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/tx_dongle/hardware_version
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the hardware version of the internal wireless transmission dongle.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/tx_dongle/product_version
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the product version of the internal wireless transmission dongle.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/tx_dongle/protocol_version
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the protocol version of the internal wireless transmission dongle.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+
diff --git a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
new file mode 100644
index 0000000000000..4d317074bb7e6
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
@@ -0,0 +1,304 @@
+What:		/sys/class/leds/go_s:rgb:joystick_rings/effect
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This controls the display effect of the RGB interface.
+
+		Values are monocolor, breathe, chroma, or rainbow.
+
+		Applies to Lenovo Legion Go S line of handheld devices.
+
+What:		/sys/class/leds/go_s:rgb:joystick_rings/effect_index
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the effect attribute.
+
+		Values are monocolor, breathe, chroma, or rainbow.
+
+		Applies to Lenovo Legion Go S line of handheld devices.
+
+What:		/sys/class/leds/go_s:rgb:joystick_rings/enabled
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This controls enabling or disabling the RGB interface.
+
+		Values are true or false.
+
+		Applies to Lenovo Legion Go S line of handheld devices.
+
+What:		/sys/class/leds/go_s:rgb:joystick_rings/enabled_index
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the enabled attribute.
+
+		Values are true or false.
+
+		Applies to Lenovo Legion Go S line of handheld devices.
+
+What:		/sys/class/leds/go_s:rgb:joystick_rings/mode
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This controls the operating mode of the RGB interface.
+
+		Values are dynamic or custom. Custom allows setting the RGB effect and color.
+    Dynamic is a Windows mode for syncing Lenovo RGB interfaces not currently
+    supported under Linux.
+
+		Applies to Lenovo Legion Go S line of handheld devices.
+
+What:		/sys/class/leds/go_s:rgb:joystick_rings/mode_index
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the mode attribute.
+
+		Values are dynamic or custom.
+
+		Applies to Lenovo Legion Go S line of handheld devices.
+
+What:		/sys/class/leds/go_s:rgb:joystick_rings/profile
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This controls selecting the configured RGB profile.
+
+		Values are 1-3.
+
+		Applies to Lenovo Legion Go S line of handheld devices.
+
+What:		/sys/class/leds/go_s:rgb:joystick_rings/profile_range
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the profile attribute.
+
+		Values are 1-3.
+
+		Applies to Lenovo Legion Go S line of handheld devices.
+
+What:		/sys/class/leds/go_s:rgb:joystick_rings/speed
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This controls the change rate for the breathe, chroma, and rainbow effects.
+
+		Values are 0-100.
+
+		Applies to Lenovo Legion Go S line of handheld devices.
+
+What:		/sys/class/leds/go_s:rgb:joystick_rings/speed_range
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the speed attribute.
+
+		Values are 0-100.
+
+		Applies to Lenovo Legion Go S line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/gamepad/auto_sleep_time
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This controls the sleep timer due to inactivity for the built-in controller.
+
+		Values are 0-255.
+
+		Applies to Lenovo Legion Go S line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/gamepad/auto_sleep_time_range
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the gamepad/auto_sleep_time attribute.
+
+		Values are 0-255.
+
+		Applies to Lenovo Legion Go S line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/gamepad/dpad_mode
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This controls the operating mode of the built-in controllers D-pad.
+
+		Values are 4-way or 8-way.
+
+		Applies to Lenovo Legion Go S line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/gamepad/dpad_mode_index
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the gamepad/dpad_mode attribute.
+
+		Values are 4-way or 8-way.
+
+		Applies to Lenovo Legion Go S line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/gamepad/mode
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This controls the operating mode of the built-in controller.
+
+		Values are xinput or dinput.
+
+		Applies to Lenovo Legion Go S line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/gamepad/mode_index
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the gamepad/mode attribute.
+
+		Values are xinput or dinput.
+
+		Applies to Lenovo Legion Go S line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/gamepad/poll_rate
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This controls the poll rate in Hz of the built-in controller.
+
+		Values are 125, 250, 500, or 1000.
+
+		Applies to Lenovo Legion Go S line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/gamepad/poll_rate_index
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the gamepad/poll_rate attribute.
+
+		Values are 125, 250, 500, or 1000.
+
+		Applies to Lenovo Legion Go S line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/imu/bypass_enabled
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This controls enabling or disabling the IMU bypass function. When enabled the IMU data is directly reported to the OS through
+an HIDRAW interface.
+
+		Values are true or false.
+
+		Applies to Lenovo Legion Go S line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/imu/bypass_enabled_index
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the imu/bypass_enabled attribute.
+
+		Values are true or false.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/imu/manufacturer
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the manufacturer of the intertial measurment unit.
+
+		Values are Bosch or ST.
+
+		Applies to Lenovo Legion Go S line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/imu/sensor_enabled
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This controls enabling or disabling the IMU.
+
+		Values are true, false, or wake-2s.
+
+		Applies to Lenovo Legion Go S line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/imu/sensor_enabled_index
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the imu/sensor_enabled attribute.
+
+		Values are true, false, or wake-2s.
+
+		Applies to Lenovo Legion Go S line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/mcu_id
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the MCU Identification Number
+
+		Applies to Lenovo Legion Go S line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/mouse/step
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This controls which value is used for the mouse sensitivity.
+
+		Values are 1-127.
+
+		Applies to Lenovo Legion Go S line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/mouse/step_range
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the mouse/step attribute.
+
+		Values are 1-127.
+
+		Applies to Lenovo Legion Go S line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This controls which value is used for the touchpads operating mode.
+
+		Values are windows or linux.
+
+		Applies to Lenovo Legion Go S line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the os_mode attribute.
+
+		Values are windows or linux.
+
+		Applies to Lenovo Legion Go S line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This controls enabling or disabling the built-in touchpad.
+
+		Values are true or false.
+
+		Applies to Lenovo Legion Go S line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled_index
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the touchpad/enabled attribute.
+
+		Values are true or false.
+
+		Applies to Lenovo Legion Go S line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/linux_mode
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This controls behavior of the touchpad events when os_mode is set to linux.
+
+		Values are absolute or relative.
+
+		Applies to Lenovo Legion Go S line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/linux_mode_index
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the touchpad/linux_mode attribute.
+
+		Values are absolute or relative.
+
+		Applies to Lenovo Legion Go S line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/windows_mode
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This controls behavior of the touchpad events when os_mode is set to windows.
+
+		Values are absolute or relative.
+
+		Applies to Lenovo Legion Go S line of handheld devices.
+
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/windows_mode_index
+Date:		April 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This displays the available options for the touchpad/windows_mode attribute.
+
+		Values are absolute or relative.
+
+		Applies to Lenovo Legion Go S line of handheld devices.
diff --git a/MAINTAINERS b/MAINTAINERS
index 1d0468906788a..8eea5f231e809 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14318,6 +14318,8 @@ M:	Derek J. Clark <derekjohn.clark@gmail.com>
 M:	Mark Pearson <mpearson-lenovo@squebb.ca>
 L:	linux-input@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
+F:	Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
 F:	drivers/hid/hid-lenovo-go-s.c
 F:	drivers/hid/hid-lenovo-go.c
 F:	drivers/hid/hid-lenovo.c
-- 
2.52.0

