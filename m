Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFBA426D2C
	for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773127801; cv=none; b=Ih0825tF4T8kmQlN22s0EO/vU9aLdykdWR2aMem6VNKgfeMT0rUq/rlI1m/l27KffOA9WhymmunHO0326CHBLrW6+KfIRQ6SjTLik56B63rO3eUBvEJ3laSF3KJuvkFqMCm7x60dv4Udoo/Z0nQezqnGo3bLhApvsvUUUgM6Iug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773127801; c=relaxed/simple;
	bh=c22LblRWXjws9JqV8QtHpdMVhhVeTCZ/5RjS9c20Tqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=arb+O53MiSAipxosrhpwo5bBYlm8D62MoS/aIqPw6QosWkF8Ovmbdvzyvq64fO4FjcYed+7KW/JiQ474BVFekYAD1jVzCHvHe/lqc18k3+VQbC7qqGl9Li1tR68YbJAI70RmiIyBZ6NXWjif4MMnlYFb8oSZ/vv5axiW55ugomY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJWlut4K; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJWlut4K"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2be06c02f66so78368eec.1
        for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 00:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773127797; x=1773732597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0wb1J3eA0vOa0cYpTZKoMEDGrUwNLfSmRN+V4sggzQ=;
        b=FJWlut4K8mGvd0EubLk697LhtK7K+RKPBihmKU3HiqA0Pf8n9ZcuSBtWgILZk5bWZK
         RGr0/JqVGIe1QYIk1W/6AH/2fOXPnHBHsU7s9VThZQPH1ifJKwT6ArO7s8I++SvgspB8
         wUNPEKRGkiAzRO9CqPbF7FYkP4A/BzNKyNBlHc0W7Thdzk7Lu6+lOYR+KtbuJpsImcKr
         cP3y167D/SZEFst7oMd3C5GVJySF6z141lKAaSnEt6ITxTSQfKTFqlvaRluYdQKONXT7
         BOvQfz/6LMcg56yOVTjsOwfJabAbcp4QlnfJaMnUTr2JpO0vLzJg4/t7QA6FmOaZu7x8
         uuyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773127797; x=1773732597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q0wb1J3eA0vOa0cYpTZKoMEDGrUwNLfSmRN+V4sggzQ=;
        b=J5rgYvuYAMN5HR4p77ekaJibuTF/BycafwT8mgncmt3FpMKvm2wbxpxQwsVDErSWx/
         D7fHMNZ/ooKwRkq+3vP2kFsxe7I8zPQ54y4nq6D3f4i+ZROZGe72uRXLoMNHbIppyT6c
         lo+/NOeZEa40BzXecT7i4iNDXY4Q4PjeWSP1/OZhywlW9jS2gjzDnvgYu6Q3dPkRY/xJ
         AbRFqPgHk76VgTmVvA7c8szyt9Js5qDNFvEPMr/X7FPGYHkZiy6NDjvcghsXCn9XCSF2
         ZLFokprxgLETcbSknVQm5ZxFYEwxbBQlDUardZWWMVVFtU9StmGUpinlm+uYI4i5nYb5
         IUzg==
X-Forwarded-Encrypted: i=1; AJvYcCWF/rr+DozWaB6v517/t4xT1fL21ijkCyrSkIfzE/TnmwsCiNW5+pTqyk7DnF1IVvPITsEu4kbhNoWmXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYS+wNRD87vc1JJr892QlHJK4y9hb4nPbspmyk/ng8RO1r86ZM
	qsY7bkozp9opHh4kHNr5LaFCjfU3lBpO2sfBNFUSEVIFoCDDjxEm4b86
X-Gm-Gg: ATEYQzyw93jQFCfIobmpCvi23XokMji33zu/XecCfc7Bh2hkUcVVrIMGhnQLFeq7e5H
	punXWdM89xb9xb3kRM3crybH+aTgcs1cwLfcXP3MRb6SXGssstvVv9WblipPm4Bsfb0RAWGAVfy
	IXYz+zG8dVqz32EAzlThmqatoNZZcUdecRL05Z4oZYeKdFWgSZe+OAsFqO6qS/ZqNdMZ8d2wqki
	xGlQKxwTreZIqJpkkDus3RYSQyOwmW9PUwGbtx0fmZrA5dEGDFP9IBW72uYw5QInNBmvgRW+Z/Q
	Y4GyOzEdI9829zAWP8Z2h+YibozespZMYX/3V+1+Fj+MlU2IGviGnOrTnlv1GC5Lv6Yv6etJDb3
	RVGU/BnMvjp+nSfjzGIYtJPHbs8vD4EXrWt7yEN3PeYPkDsyfO+CckE0WEqv18dhHhwrwHRbioC
	lx4dQ7CNLPy9GTOSvxmLY7Mzxc1P4XOUVSvh0iujFhMC7wOdGwu7aFjViy+JyjkZfP+TYNICLrn
	vNK
X-Received: by 2002:a05:7300:6da6:b0:2be:2bc5:b9f3 with SMTP id 5a478bee46e88-2be4dfdf27bmr6143973eec.16.1773127796312;
        Tue, 10 Mar 2026 00:29:56 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be81209142sm721925eec.12.2026.03.10.00.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 00:29:56 -0700 (PDT)
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
Subject: [PATCH v6 16/19] HID: Add documentation for Lenovo Legion Go drivers
Date: Tue, 10 Mar 2026 07:29:34 +0000
Message-ID: <20260310072937.3295875-17-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310072937.3295875-1-derekjohn.clark@gmail.com>
References: <20260310072937.3295875-1-derekjohn.clark@gmail.com>
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
v3:
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
index 000000000000..c8221373ef76
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
index 000000000000..4d317074bb7e
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
index c81f10292ff7..146159a8b2e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14420,6 +14420,8 @@ M:	Derek J. Clark <derekjohn.clark@gmail.com>
 M:	Mark Pearson <mpearson-lenovo@squebb.ca>
 L:	linux-input@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
+F:	Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
 F:	drivers/hid/hid-lenovo-go-s.c
 F:	drivers/hid/hid-lenovo-go.c
 F:	drivers/hid/hid-lenovo.c
-- 
2.53.0

