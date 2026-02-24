Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB072ED866
	for <linux-input@vger.kernel.org>; Tue, 24 Feb 2026 01:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771896762; cv=none; b=inyeHTVH0lwbgCqBkhpowJustfMamaCp6vemK1oWy6D6t4EvqMmqrIJjqJjJYL/rugCVVPXU9tQ9rE44JsG6ad4UWrN1p1KXAnB7rbiK4jq4zCfStDyJqXtQ4W2WuwGp1yKRPWMtOdNu6zl7Za4+AHIZlwMBL2D1GtXuIwSYv2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771896762; c=relaxed/simple;
	bh=ikfzksm+wLsqocEkArkkEVPF+9NtY6K0g1U6x4qnaHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W3MfiFHgxlGQEj3+whTnrMcQ8a4rBEcty7px1eGBjJ7YvLuY/inrxZVEYZeOfGfE+mOyPm8cUwfJdfHb87m1ngoFlmFX8GIdxC+cDNHabjwF2iewhzFD8fL314GUg66WibNOIcL6dyibCfg0G6ujBvVJsvvERPDcGPr91hJju7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEyvKQ5V; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEyvKQ5V"
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2bdac83a6a1so285634eec.1
        for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 17:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771896756; x=1772501556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22FKswPIkgTaZrxf06G8nEvQoSlteqKZSt+NVe2oBnI=;
        b=JEyvKQ5VQPJckjhpJXQb8S9MIfsIuDoKbXecAfxhrzoBCZyzUP/43RTBEPjxTwlQf9
         j6EWjQ/bsC8WOenCY1dlz9D7+YiJYbmVQeYpv+SbCAsXjs+ulOQpRoPQxAdJvR2mtcnB
         MMdECyw60vtcmkIQgoZlgIdb+UedpmIhU3uuGPbobbZ+btHuWWHnmasZs90NfjRnX0sk
         Z80ZTDNCAC1dQ2s6fjwbIOcpCwJkoMvjPhG287g/CLSkBXTl1Tj288Yy2v4fRWsFXGvn
         AiyzPnmPKkg39QyHR3dCSs8jYspDEj0el3tBRRKPxe6OD+Ra5LNPa0vOf7zaZWD6eDrl
         gHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771896756; x=1772501556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=22FKswPIkgTaZrxf06G8nEvQoSlteqKZSt+NVe2oBnI=;
        b=Y5T7ygksyGyebcEHV1NI7EI+Wk/nIYOVwKhaQRdSkJwijl8p6+0DYZZnUrYsM6IpQh
         dCiy0m3xxA0rdQjWj32buxbCMGMK+wBlOzyAuhbUeADfyD28AP1BfVyEsAIrA4A8cOn6
         /zyYEp1ErjQGpRVbo0nEJpU93TT4Hbj825u5M1oI7SeUlUPl95koOO8dqoos6CcZgKKZ
         wNl8DNP31MNZfK8LDAvJLRNDIs/vlz65LgBmeG6+oY9zFjaF2tG7zufkiX4R4AumJqks
         5IzFinTAvuYjs+uTSYeUl2IcMOW4juiVNfuOBgjGCPLJSC4pwfY+x+usSavZxfoGZHZL
         wGqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVExYtzE7U7ekn7vZlxVNWZqcIBlaNrKwrjcNTArCIF2IpGD7lMW4rK8T/aKiSzcedbirBdxhnf6ZmUbw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwT/EytwzFtyJfc/l3HY4M0LuH/lJRnXwsBkC3vN7AQywvGP6h
	2qAA4ApWaA5xvPBJJjOLBhJq6wbAPwWHSR6n6ZHHU5LhKVVy+La11SPj
X-Gm-Gg: ATEYQzx4NKXpN8PSbCU+H7/Y4tAJUhEBul5QvvAmDa8mipBV/dlaf+LpzdjYdgf7/lU
	LLrZcHk/vX8os34cqaLYV11vAwHaQJ2K3onTRoEQfW/s+2284FrDBkx8UOG44WgZbVXC+WIP4R8
	zIDqxkVKuEqC61VFwfgriSczUdFsE81Lut2Vbq3w/LobIorTAhyAVQUKb84x2UtLXScescqCug7
	0zb4wmAFQC8QFeRuviCrIL7CCg96SkIuxkrN0m5AcNQLOz8k/uToLGT6YthEXd52cujwxZ1QyxB
	MHCl8VHL/QAIIOTHISA1+oVVXqOKoDVENSG5EIubO/P67B3Wf5GILYGyxIG18OUku+2nOy4WRyT
	hiNEvBdA9ahAedmaEzD96Fvdadficx0EgOSTyS4Pede88rr8az11mwPasbYGEKYK6Sp9pAb9nvV
	38QfbLw25H0KyQgsP9reVh8PnnoDsOOMk3CZRtchtb07cl2LMg5kptqghM60rs22IhtF4CyHC6S
	jA=
X-Received: by 2002:a05:7301:3e09:b0:2ba:933d:d5c7 with SMTP id 5a478bee46e88-2bd7bd11307mr3975343eec.32.1771896755884;
        Mon, 23 Feb 2026 17:32:35 -0800 (PST)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7daa027fsm6485015eec.9.2026.02.23.17.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 17:32:35 -0800 (PST)
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
Subject: [PATCH v5 16/16] HID: Add documentation for Lenovo Legion Go drivers
Date: Tue, 24 Feb 2026 01:32:17 +0000
Message-ID: <20260224013217.1363996-17-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260224013217.1363996-1-derekjohn.clark@gmail.com>
References: <20260224013217.1363996-1-derekjohn.clark@gmail.com>
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

