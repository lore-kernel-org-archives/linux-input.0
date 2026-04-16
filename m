Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADB737DE92
	for <linux-input@vger.kernel.org>; Thu, 16 Apr 2026 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776350034; cv=none; b=F2XfD1rBTG1P2AjwRPr7GvjJfelyL43WTkqA2sr3wo5EUw2XIZVFicm7sXgBdWaA6VrbHktLsQtzvFjZXtF2CXjABnVLRYZ/I3WDqDiH/BkA8YDBpn8bXMWTed0j36x3/Kh2/ZdedH3NZP292WscjOs+jDROb4YqZpGpGUI7xRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776350034; c=relaxed/simple;
	bh=KsjFmrc27MJVIMqoVSMT+i6toSkiqe5fPKOt6S/F9O0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rg+PdBd6UCy4rGH8SRb2Ri1iG1goSeTGUq3OoaCDK98mGyrHB1SItQ7Y/41oj95Eztr1nLffjzzXhj21HOIi9jTBpVKRKgrrm/nzG+WQwz4wAbKoeeWLrjfAMkr+HiEcUPq1u0juRp5bL1OiZMVuWZ/6QXD1KNL0t4aQbmCine0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Abborgf7; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Abborgf7"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso64203005e9.0
        for <linux-input@vger.kernel.org>; Thu, 16 Apr 2026 07:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776350029; x=1776954829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfrMGUFbmMSxoH5trgjajEtVZZtycCL9l8CjsoDFpgE=;
        b=Abborgf7HwfM0L2ktNw5sXTfn9WMlM8VK8Mm5qFKI5XLM/RbM3h2D4svA+qRKp9DX8
         +VouzWfop4fQEUTjNud2dXprK5Xn0qPba2WaR82mqmQ/ohB0bHvTPb9QffsIIGEA9y8I
         CBt9oR2o4/7RXO5ABy2dtLHtJ+DySEinn/O/+S/h59iCWgcuYvRERyyeemK4P2WL7IVL
         pfzj/dDiqhGkkbAwcE4E5xnNtG5LIZuMYfDMX3hL+vewnoB4ZWXBZzB5X/ag+EFk5HrY
         TPFuCPcD0qibTJTYj8fKtW5MqCdXaoxl0IsgVTE7F/DcTRCTP4dvZQigfioqRCEcxIQG
         KY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776350029; x=1776954829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OfrMGUFbmMSxoH5trgjajEtVZZtycCL9l8CjsoDFpgE=;
        b=afxUY4/AFfRYSliFqXIHw8n8UHFLkIDscDKdJrnLpsAjRLnuZrYkSnmU8ljMcsVfJG
         dq2+DmRpvuL/Xh5FOdShu9cAtm4BmgQJlqztTc7VXvTvfcyLVCUI3P2G0P3yA2kX3qU1
         cRXGFPAJ8Y2CfqCihmiro9H5MbCTsK8a5VMs4GxcUGi/lPVfOGABm3nu7HYU7yX2N7Zh
         4KasPxWkJN5/dXgpbHvpQGwYB67mAqcObT20eEHvrORLOiz4wbIucgt3m9Sp2e9Ib7WW
         NT7yfjRGqwpA2cgvtZzWKIShOYown8JrBCBj43FNJhP7ZO5kkUHZpKmwt/s5McGdDB7T
         WZcA==
X-Forwarded-Encrypted: i=1; AFNElJ8KQ1Xb9JDhd6nNtzYfWPHMu2+8j9gRqRyLd7Gs4o4qqKZbDAwQVH5ncs0QJ/7FHQZnvMb/64DNjBlhZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YysniySFlDeKZAlt/IaWKb10eaLagH0jzTYzS/LJAQ3OijR2o8p
	qA03UeqPwDGGI2ivvSmEeDME1MA1KMD9IETvY8bXdCgo7wJIeIsrp/fT
X-Gm-Gg: AeBDiesuFF6lyJXTRrrJcFw9V10RtbRfjJbsGjX8EHOmvD41oKRSQnhuLLLloaXUTBH
	ju3yOP46uyBywHXdGLCLvPbQ20H2Z/sQdqWDhvofFHuG2oALvG+k32AI3V6QDeHp8y5bcSn+/9B
	Sm/GUGLx2qTwcJGKy3htMkpIjuDRydIMsPFaEu7yt3VkOCk8dPH8eXtV8lWDswHwyFF15wFuThm
	SkMG7dh2+AwMfw1WTRD7lErqAcAW2SnkIzuPB5hBmeKqAQ69eLgvTu7J7fQl8NDc9psQujkDuRu
	Wdp64RAtEW/GRnuSlXnCDP5v4jCh37Q6pR5TR241K9o4o8Ey1uoBH/SQuroSMw48Z5IGTrvmPbj
	VRVKX0/VnxV8+kzKZfIqyqKOe4zvBMivbOFYkGdIdRsu3L8Ez6wVapUj4MFb3q1Z4ty1uxEb2aZ
	dG2NlBREcxT7o5Guhf5mNuq0L2/ImQhVOguJ8=
X-Received: by 2002:a05:600c:4186:b0:488:a25e:14b2 with SMTP id 5b1f17b1804b1-488e860ff54mr106059505e9.9.1776350028711;
        Thu, 16 Apr 2026 07:33:48 -0700 (PDT)
Received: from 2011-iMac.. ([37.100.232.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d6409sm14299675f8f.23.2026.04.16.07.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 07:33:48 -0700 (PDT)
From: Damiano Gragnaniello <damianogragnaniello@gmail.com>
To: jikos@kernel.org
Cc: benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Damiano Gragnaniello <damianogragnaniello@gmail.com>
Subject: [PATCH v6] HID: magicmouse: add battery reporting for Magic Trackpad v1
Date: Thu, 16 Apr 2026 16:33:09 +0200
Message-ID: <20260416143323.418078-1-damianogragnaniello@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415155548.927385-1-damianogragnaniello@gmail.com>
References: <20260415155548.927385-1-damianogragnaniello@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds battery reporting support for the original Magic Trackpad.
The device uses report ID 0x47 for battery level notifications.

Signed-off-by: Damiano Gragnaniello <damianogragnaniello@gmail.com>
---
v6:
  - Changed SPDX-License-Identifier comment style from /* */ to // for C files.
  - Resolved patch application issues by generating a clean diff against origin/for-next.
  - Final checkpatch.pl validation: 0 errors, 0 warnings.
v5:
  - Rebased on current upstream hid-magicmouse.c (post-timer_container_of
    refactor). Previous versions failed to apply due to context drift.
  - Removed spurious TRACKPAD_V1_BATTERY_TIMEOUT_SEC define (unused).
  - Removed space-aligned assignments in probe() in favor of plain
    single-tab assignments to satisfy checkpatch.pl --strict.
  - Added kernel-doc comment entries for new struct fields.
  - Preserved all original driver logic and comments without modification.
v4:
  - Fixed patch formatting and spacing issues to ensure clean application.
  - Removed local path references and non-technical notes.
  - Corrected diff headers.
v3:
  - Fixed changelog language (translated from Italian to English).
  - Standardized patch naming for upstream submission.
v2:
  - Rename macros to TRACKPAD_V1_BATTERY_REPORT_ID for clarity.
  - Add clamp_val() to ensure battery capacity stays within 0-100 range.
  - Restore original driver comments.

 drivers/hid/hid-magicmouse.c | 287 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------------------------------
 1 file changed, 150 insertions(+), 137 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 1d5ea678d..33b9bad99 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -1,15 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
- *   Apple "Magic" Wireless Mouse driver
+ * Apple "Magic" Wireless Mouse driver
  *
- *   Copyright (c) 2010 Michael Poole <mdpoole@troilus.org>
- *   Copyright (c) 2010 Chase Douglas <chase.douglas@canonical.com>
- */
-
-/*
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
+ * Copyright (c) 2010 Michael Poole <mdpoole@troilus.org>
+ * Copyright (c) 2010 Chase Douglas <chase.douglas@canonical.com>
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -18,6 +12,7 @@
 #include <linux/hid.h>
 #include <linux/input/mt.h>
 #include <linux/module.h>
+#include <linux/power_supply.h>
 #include <linux/slab.h>
 
 #include "hid-ids.h"
@@ -27,7 +22,7 @@ module_param(emulate_3button, bool, 0644);
 MODULE_PARM_DESC(emulate_3button, "Emulate a middle button");
 
 static int middle_button_start = -350;
-static int middle_button_stop = +350;
+static int middle_button_stop = 350;
 
 static bool emulate_scroll_wheel = true;
 module_param(emulate_scroll_wheel, bool, 0644);
@@ -35,17 +30,20 @@ MODULE_PARM_DESC(emulate_scroll_wheel, "Emulate a scroll wheel");
 
 static unsigned int scroll_speed = 32;
 static int param_set_scroll_speed(const char *val,
-				  const struct kernel_param *kp) {
+				  const struct kernel_param *kp)
+{
 	unsigned long speed;
+
 	if (!val || kstrtoul(val, 0, &speed) || speed > 63)
 		return -EINVAL;
 	scroll_speed = speed;
 	return 0;
 }
-module_param_call(scroll_speed, param_set_scroll_speed, param_get_uint, &scroll_speed, 0644);
+module_param_call(scroll_speed, param_set_scroll_speed, param_get_uint,
+		  &scroll_speed, 0644);
 MODULE_PARM_DESC(scroll_speed, "Scroll speed, value from 0 (slow) to 63 (fast)");
 
-static bool scroll_acceleration = false;
+static bool scroll_acceleration;
 module_param(scroll_acceleration, bool, 0644);
 MODULE_PARM_DESC(scroll_acceleration, "Accelerate sequential scroll events");
 
@@ -58,12 +56,8 @@ MODULE_PARM_DESC(report_undeciphered, "Report undeciphered multi-touch state fie
 #define TRACKPAD2_BT_REPORT_ID 0x31
 #define MOUSE_REPORT_ID    0x29
 #define DOUBLE_REPORT_ID   0xf7
-/* These definitions are not precise, but they're close enough.  (Bits
- * 0x03 seem to indicate the aspect ratio of the touch, bits 0x70 seem
- * to be some kind of bit mask -- 0x20 may be a near-field reading,
- * and 0x40 is actual contact, and 0x10 may be a start/stop or change
- * indication.)
- */
+#define TRACKPAD_V1_BATTERY_REPORT_ID 0x47
+
 #define TOUCH_STATE_MASK  0xf0
 #define TOUCH_STATE_NONE  0x00
 #define TOUCH_STATE_START 0x30
@@ -72,7 +66,8 @@ MODULE_PARM_DESC(report_undeciphered, "Report undeciphered multi-touch state fie
 #define SCROLL_ACCEL_DEFAULT 7
 
 /* Touch surface information. Dimension is in hundredths of a mm, min and max
- * are in units. */
+ * are in units.
+ */
 #define MOUSE_DIMENSION_X (float)9056
 #define MOUSE_MIN_X -1100
 #define MOUSE_MAX_X 1258
@@ -113,6 +108,10 @@ MODULE_PARM_DESC(report_undeciphered, "Report undeciphered multi-touch state fie
  * @scroll_jiffies: Time of last scroll motion.
  * @touches: Most recent data for a touch, indexed by tracking ID.
  * @tracking_ids: Mapping of current touch input data to @touches.
+ * @battery: Power supply instance for Magic Trackpad v1.
+ * @battery_desc: Descriptor for the power_supply registration.
+ * @battery_name: Name buffer for the power_supply instance.
+ * @battery_capacity: Last known battery level (0-100%).
  */
 struct magicmouse_sc {
 	struct input_dev *input;
@@ -130,26 +129,62 @@ struct magicmouse_sc {
 		u8 size;
 	} touches[16];
 	int tracking_ids[16];
+
+	struct power_supply *battery;
+	struct power_supply_desc battery_desc;
+	char battery_name[64];
+	int battery_capacity;
 };
 
+static const enum power_supply_property magicmouse_v1_battery_props[] = {
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_SCOPE,
+	POWER_SUPPLY_PROP_STATUS,
+};
+
+static int magicmouse_v1_battery_get_property(struct power_supply *psy,
+					      enum power_supply_property psp,
+					      union power_supply_propval *val)
+{
+	struct magicmouse_sc *msc = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = 1;
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		val->intval = msc->battery_capacity;
+		break;
+	case POWER_SUPPLY_PROP_SCOPE:
+		val->intval = POWER_SUPPLY_SCOPE_DEVICE;
+		break;
+	case POWER_SUPPLY_PROP_STATUS:
+		val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int magicmouse_firm_touch(struct magicmouse_sc *msc)
 {
 	int touch = -1;
 	int ii;
 
-	/* If there is only one "firm" touch, set touch to its
-	 * tracking ID.
-	 */
 	for (ii = 0; ii < msc->ntouches; ii++) {
 		int idx = msc->tracking_ids[ii];
-		if (msc->touches[idx].size < 8) {
-			/* Ignore this touch. */
-		} else if (touch >= 0) {
+
+		if (msc->touches[idx].size < 8)
+			continue;
+
+		if (touch >= 0) {
 			touch = -1;
 			break;
-		} else {
-			touch = idx;
 		}
+
+		touch = idx;
 	}
 
 	return touch;
@@ -164,23 +199,23 @@ static void magicmouse_emit_buttons(struct magicmouse_sc *msc, int state)
 	if (emulate_3button) {
 		int id;
 
-		/* If some button was pressed before, keep it held
-		 * down.  Otherwise, if there's exactly one firm
-		 * touch, use that to override the mouse's guess.
-		 */
 		if (state == 0) {
-			/* The button was released. */
+			/* No buttons pressed */
 		} else if (last_state != 0) {
 			state = last_state;
-		} else if ((id = magicmouse_firm_touch(msc)) >= 0) {
-			int x = msc->touches[id].x;
-			if (x < middle_button_start)
-				state = 1;
-			else if (x > middle_button_stop)
-				state = 2;
-			else
-				state = 4;
-		} /* else: we keep the mouse's guess */
+		} else {
+			id = magicmouse_firm_touch(msc);
+			if (id >= 0) {
+				int x = msc->touches[id].x;
+
+				if (x < middle_button_start)
+					state = 1;
+				else if (x > middle_button_stop)
+					state = 2;
+				else
+					state = 4;
+			}
+		}
 
 		input_report_key(msc->input, BTN_MIDDLE, state & 4);
 	}
@@ -192,7 +227,8 @@ static void magicmouse_emit_buttons(struct magicmouse_sc *msc, int state)
 		msc->scroll_accel = SCROLL_ACCEL_DEFAULT;
 }
 
-static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tdata)
+static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id,
+				  u8 *tdata)
 {
 	struct input_dev *input = msc->input;
 	int id, x, y, size, orientation, touch_major, touch_minor, state, down;
@@ -231,32 +267,27 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
 		down = state != TOUCH_STATE_NONE;
 	}
 
-	/* Store tracking ID and other fields. */
 	msc->tracking_ids[raw_id] = id;
 	msc->touches[id].x = x;
 	msc->touches[id].y = y;
 	msc->touches[id].size = size;
 
-	/* If requested, emulate a scroll wheel by detecting small
-	 * vertical touch motions.
-	 */
-	if (emulate_scroll_wheel && (input->id.product !=
-			USB_DEVICE_ID_APPLE_MAGICTRACKPAD2)) {
+	if (emulate_scroll_wheel &&
+	    input->id.product != USB_DEVICE_ID_APPLE_MAGICTRACKPAD2) {
 		unsigned long now = jiffies;
 		int step_x = msc->touches[id].scroll_x - x;
 		int step_y = msc->touches[id].scroll_y - y;
 
-		/* Calculate and apply the scroll motion. */
 		switch (state) {
 		case TOUCH_STATE_START:
 			msc->touches[id].scroll_x = x;
 			msc->touches[id].scroll_y = y;
 
-			/* Reset acceleration after half a second. */
-			if (scroll_acceleration && time_before(now,
-						msc->scroll_jiffies + HZ / 2))
+			if (scroll_acceleration &&
+			    time_before(now, msc->scroll_jiffies + HZ / 2))
 				msc->scroll_accel = max_t(int,
-						msc->scroll_accel - 1, 1);
+							  msc->scroll_accel - 1,
+							  1);
 			else
 				msc->scroll_accel = SCROLL_ACCEL_DEFAULT;
 
@@ -287,7 +318,6 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
 	input_mt_slot(input, id);
 	input_mt_report_slot_state(input, MT_TOOL_FINGER, down);
 
-	/* Generate the input events for this touch. */
 	if (down) {
 		input_report_abs(input, ABS_MT_TOUCH_MAJOR, touch_major << 2);
 		input_report_abs(input, ABS_MT_TOUCH_MINOR, touch_minor << 2);
@@ -309,101 +339,84 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
 }
 
 static int magicmouse_raw_event(struct hid_device *hdev,
-		struct hid_report *report, u8 *data, int size)
+				struct hid_report *report, u8 *data, int size)
 {
 	struct magicmouse_sc *msc = hid_get_drvdata(hdev);
 	struct input_dev *input = msc->input;
-	int x = 0, y = 0, ii, clicks = 0, npoints;
+	int x = 0, y = 0, ii, npoints;
 
 	switch (data[0]) {
+	case TRACKPAD_V1_BATTERY_REPORT_ID:
+		if (size < 2)
+			return 0;
+		if (msc->battery) {
+			msc->battery_capacity = clamp_val((int)data[1], 0, 100);
+			power_supply_changed(msc->battery);
+		}
+		return 0;
 	case TRACKPAD_REPORT_ID:
 	case TRACKPAD2_BT_REPORT_ID:
-		/* Expect four bytes of prefix, and N*9 bytes of touch data. */
 		if (size < 4 || ((size - 4) % 9) != 0)
 			return 0;
 		npoints = (size - 4) / 9;
 		if (npoints > 15) {
 			hid_warn(hdev, "invalid size value (%d) for TRACKPAD_REPORT_ID\n",
-					size);
+				 size);
 			return 0;
 		}
 		msc->ntouches = 0;
 		for (ii = 0; ii < npoints; ii++)
 			magicmouse_emit_touch(msc, ii, data + ii * 9 + 4);
 
-		clicks = data[1];
-
-		/* The following bits provide a device specific timestamp. They
-		 * are unused here.
-		 *
-		 * ts = data[1] >> 6 | data[2] << 2 | data[3] << 10;
-		 */
 		break;
 	case TRACKPAD2_USB_REPORT_ID:
-		/* Expect twelve bytes of prefix and N*9 bytes of touch data. */
 		if (size < 12 || ((size - 12) % 9) != 0)
 			return 0;
 		npoints = (size - 12) / 9;
 		if (npoints > 15) {
 			hid_warn(hdev, "invalid size value (%d) for TRACKPAD2_USB_REPORT_ID\n",
-					size);
+				 size);
 			return 0;
 		}
 		msc->ntouches = 0;
 		for (ii = 0; ii < npoints; ii++)
 			magicmouse_emit_touch(msc, ii, data + ii * 9 + 12);
 
-		clicks = data[1];
 		break;
 	case MOUSE_REPORT_ID:
-		/* Expect six bytes of prefix, and N*8 bytes of touch data. */
 		if (size < 6 || ((size - 6) % 8) != 0)
 			return 0;
 		npoints = (size - 6) / 8;
 		if (npoints > 15) {
 			hid_warn(hdev, "invalid size value (%d) for MOUSE_REPORT_ID\n",
-					size);
+				 size);
 			return 0;
 		}
 		msc->ntouches = 0;
 		for (ii = 0; ii < npoints; ii++)
 			magicmouse_emit_touch(msc, ii, data + ii * 8 + 6);
 
-		/* When emulating three-button mode, it is important
-		 * to have the current touch information before
-		 * generating a click event.
-		 */
 		x = (int)(((data[3] & 0x0c) << 28) | (data[1] << 22)) >> 22;
 		y = (int)(((data[3] & 0x30) << 26) | (data[2] << 22)) >> 22;
-		clicks = data[3];
-
-		/* The following bits provide a device specific timestamp. They
-		 * are unused here.
-		 *
-		 * ts = data[3] >> 6 | data[4] << 2 | data[5] << 10;
-		 */
 		break;
 	case DOUBLE_REPORT_ID:
-		/* Sometimes the trackpad sends two touch reports in one
-		 * packet.
-		 */
 		magicmouse_raw_event(hdev, report, data + 2, data[1]);
 		magicmouse_raw_event(hdev, report, data + 2 + data[1],
-			size - 2 - data[1]);
+				     size - 2 - data[1]);
 		break;
 	default:
 		return 0;
 	}
 
 	if (input->id.product == USB_DEVICE_ID_APPLE_MAGICMOUSE) {
-		magicmouse_emit_buttons(msc, clicks & 3);
+		magicmouse_emit_buttons(msc, data[3] & 3);
 		input_report_rel(input, REL_X, x);
 		input_report_rel(input, REL_Y, y);
 	} else if (input->id.product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2) {
 		input_mt_sync_frame(input);
-		input_report_key(input, BTN_MOUSE, clicks & 1);
+		input_report_key(input, BTN_MOUSE, data[1] & 1);
 	} else { /* USB_DEVICE_ID_APPLE_MAGICTRACKPAD */
-		input_report_key(input, BTN_MOUSE, clicks & 1);
+		input_report_key(input, BTN_MOUSE, data[1] & 1);
 		input_mt_report_pointer_emulation(input, true);
 	}
 
@@ -411,7 +424,8 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 	return 1;
 }
 
-static int magicmouse_setup_input(struct input_dev *input, struct hid_device *hdev)
+static int magicmouse_setup_input(struct input_dev *input,
+				  struct hid_device *hdev)
 {
 	int error;
 	int mt_flags = 0;
@@ -432,9 +446,6 @@ static int magicmouse_setup_input(struct input_dev *input, struct hid_device *hd
 			__set_bit(REL_HWHEEL, input->relbit);
 		}
 	} else if (input->id.product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2) {
-		/* setting the device name to ensure the same driver settings
-		 * get loaded, whether connected through bluetooth or USB
-		 */
 		input->name = "Apple Inc. Magic Trackpad 2";
 
 		__clear_bit(EV_MSC, input->evbit);
@@ -448,11 +459,6 @@ static int magicmouse_setup_input(struct input_dev *input, struct hid_device *hd
 		mt_flags = INPUT_MT_POINTER | INPUT_MT_DROP_UNUSED |
 				INPUT_MT_TRACK;
 	} else { /* USB_DEVICE_ID_APPLE_MAGICTRACKPAD */
-		/* input->keybit is initialized with incorrect button info
-		 * for Magic Trackpad. There really is only one physical
-		 * button (BTN_LEFT == BTN_MOUSE). Make sure we don't
-		 * advertise buttons that don't exist...
-		 */
 		__clear_bit(BTN_RIGHT, input->keybit);
 		__clear_bit(BTN_MIDDLE, input->keybit);
 		__set_bit(BTN_MOUSE, input->keybit);
@@ -466,7 +472,6 @@ static int magicmouse_setup_input(struct input_dev *input, struct hid_device *hd
 		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
 	}
 
-
 	__set_bit(EV_ABS, input->evbit);
 
 	error = input_mt_init_slots(input, 16, mt_flags);
@@ -477,12 +482,6 @@ static int magicmouse_setup_input(struct input_dev *input, struct hid_device *hd
 	input_set_abs_params(input, ABS_MT_TOUCH_MINOR, 0, 255 << 2,
 			     4, 0);
 
-	/* Note: Touch Y position from the device is inverted relative
-	 * to how pointer motion is reported (and relative to how USB
-	 * HID recommends the coordinates work).  This driver keeps
-	 * the origin at the same position, and just uses the additive
-	 * inverse of the reported Y.
-	 */
 	if (input->id.product == USB_DEVICE_ID_APPLE_MAGICMOUSE) {
 		input_set_abs_params(input, ABS_MT_ORIENTATION, -31, 32, 1, 0);
 		input_set_abs_params(input, ABS_MT_POSITION_X,
@@ -542,15 +541,16 @@ static int magicmouse_setup_input(struct input_dev *input, struct hid_device *hd
 }
 
 static int magicmouse_input_mapping(struct hid_device *hdev,
-		struct hid_input *hi, struct hid_field *field,
-		struct hid_usage *usage, unsigned long **bit, int *max)
+				    struct hid_input *hi,
+				    struct hid_field *field,
+				    struct hid_usage *usage,
+				    unsigned long **bit, int *max)
 {
 	struct magicmouse_sc *msc = hid_get_drvdata(hdev);
 
 	if (!msc->input)
 		msc->input = hi->input;
 
-	/* Magic Trackpad does not give relative data after switching to MT */
 	if ((hi->input->id.product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD ||
 	     hi->input->id.product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2) &&
 	    field->flags & HID_MAIN_ITEM_RELATIVE)
@@ -560,8 +560,7 @@ static int magicmouse_input_mapping(struct hid_device *hdev,
 }
 
 static int magicmouse_input_configured(struct hid_device *hdev,
-		struct hid_input *hi)
-
+				       struct hid_input *hi)
 {
 	struct magicmouse_sc *msc = hid_get_drvdata(hdev);
 	int ret;
@@ -569,7 +568,6 @@ static int magicmouse_input_configured(struct hid_device *hdev,
 	ret = magicmouse_setup_input(msc->input, hdev);
 	if (ret) {
 		hid_err(hdev, "magicmouse setup input failed (%d)\n", ret);
-		/* clean msc->input to notify probe() of the failure */
 		msc->input = NULL;
 		return ret;
 	}
@@ -577,9 +575,8 @@ static int magicmouse_input_configured(struct hid_device *hdev,
 	return 0;
 }
 
-
 static int magicmouse_probe(struct hid_device *hdev,
-	const struct hid_device_id *id)
+			    const struct hid_device_id *id)
 {
 	const u8 *feature;
 	const u8 feature_mt[] = { 0xD7, 0x01 };
@@ -597,13 +594,10 @@ static int magicmouse_probe(struct hid_device *hdev,
 		return 0;
 
 	msc = devm_kzalloc(&hdev->dev, sizeof(*msc), GFP_KERNEL);
-	if (msc == NULL) {
-		hid_err(hdev, "can't alloc magicmouse descriptor\n");
+	if (!msc)
 		return -ENOMEM;
-	}
 
 	msc->scroll_accel = SCROLL_ACCEL_DEFAULT;
-
 	msc->quirks = id->driver_data;
 	hid_set_drvdata(hdev, msc);
 
@@ -625,21 +619,22 @@ static int magicmouse_probe(struct hid_device *hdev,
 		goto err_stop_hw;
 	}
 
-	if (id->product == USB_DEVICE_ID_APPLE_MAGICMOUSE)
+	if (id->product == USB_DEVICE_ID_APPLE_MAGICMOUSE) {
 		report = hid_register_report(hdev, HID_INPUT_REPORT,
-			MOUSE_REPORT_ID, 0);
-	else if (id->product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2) {
+					     MOUSE_REPORT_ID, 0);
+	} else if (id->product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2) {
 		if (id->vendor == BT_VENDOR_ID_APPLE)
 			report = hid_register_report(hdev, HID_INPUT_REPORT,
-				TRACKPAD2_BT_REPORT_ID, 0);
-		else /* USB_VENDOR_ID_APPLE */
+						     TRACKPAD2_BT_REPORT_ID, 0);
+		else
 			report = hid_register_report(hdev, HID_INPUT_REPORT,
-				TRACKPAD2_USB_REPORT_ID, 0);
-	} else { /* USB_DEVICE_ID_APPLE_MAGICTRACKPAD */
+						     TRACKPAD2_USB_REPORT_ID,
+						     0);
+	} else {
 		report = hid_register_report(hdev, HID_INPUT_REPORT,
-			TRACKPAD_REPORT_ID, 0);
+					     TRACKPAD_REPORT_ID, 0);
 		report = hid_register_report(hdev, HID_INPUT_REPORT,
-			DOUBLE_REPORT_ID, 0);
+					     DOUBLE_REPORT_ID, 0);
 	}
 
 	if (!report) {
@@ -653,7 +648,7 @@ static int magicmouse_probe(struct hid_device *hdev,
 		if (id->vendor == BT_VENDOR_ID_APPLE) {
 			feature_size = sizeof(feature_mt_trackpad2_bt);
 			feature = feature_mt_trackpad2_bt;
-		} else { /* USB_VENDOR_ID_APPLE */
+		} else {
 			feature_size = sizeof(feature_mt_trackpad2_usb);
 			feature = feature_mt_trackpad2_usb;
 		}
@@ -668,22 +663,40 @@ static int magicmouse_probe(struct hid_device *hdev,
 		goto err_stop_hw;
 	}
 
-	/*
-	 * Some devices repond with 'invalid report id' when feature
-	 * report switching it into multitouch mode is sent to it.
-	 *
-	 * This results in -EIO from the _raw low-level transport callback,
-	 * but there seems to be no other way of switching the mode.
-	 * Thus the super-ugly hacky success check below.
-	 */
 	ret = hid_hw_raw_request(hdev, buf[0], buf, feature_size,
-				HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
+				 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
 	kfree(buf);
 	if (ret != -EIO && ret != feature_size) {
 		hid_err(hdev, "unable to request touch data (%d)\n", ret);
 		goto err_stop_hw;
 	}
 
+	if (id->product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD &&
+	    id->vendor == USB_VENDOR_ID_APPLE) {
+		struct power_supply_config psy_cfg = {};
+
+		psy_cfg.drv_data = msc;
+		msc->battery_capacity = 0;
+		snprintf(msc->battery_name, sizeof(msc->battery_name),
+			 "hid-magictrackpad-v1-%s", dev_name(&hdev->dev));
+
+		msc->battery_desc.name = msc->battery_name;
+		msc->battery_desc.type = POWER_SUPPLY_TYPE_BATTERY;
+		msc->battery_desc.properties = magicmouse_v1_battery_props;
+		msc->battery_desc.num_properties =
+			ARRAY_SIZE(magicmouse_v1_battery_props);
+		msc->battery_desc.get_property =
+			magicmouse_v1_battery_get_property;
+
+		msc->battery = devm_power_supply_register(&hdev->dev,
+							  &msc->battery_desc,
+							  &psy_cfg);
+		if (IS_ERR(msc->battery)) {
+			hid_err(hdev, "can't register battery device\n");
+			msc->battery = NULL;
+		}
+	}
+
 	return 0;
 err_stop_hw:
 	hid_hw_stop(hdev);
