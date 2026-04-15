Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8F1225397
	for <linux-input@vger.kernel.org>; Wed, 15 Apr 2026 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776268570; cv=none; b=QnSx/hXGGTuySj+G4oNHN5RgelFiNMGTvfcrKnZIjTgjGOZ2nC6IJaquCfvWSX+DXKBNkOLJZuLR/rdPUKKht7xm9/7Rg+5gWJ7vO4+KhkkrUjS/aFPdD9ZSfyebHgINSHxtt/mpQHThQ3a+ugYo9dLpEn3ot9vA4vDlXMBYuSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776268570; c=relaxed/simple;
	bh=akCOoJWNTyCe7iqdrTEkEmCnqRyqizW4RivLjGdDDTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rAceUBW5I4AohPkYSiV0S9AttCBJABb+UlwpYQDLJA/CgnqHimju/hzytvZDsrmrqn+w7wlL8dTH8DSTRSvjaubqf7YzqJsy6Ujvlq1NPkR/IAKHqRygyxGZv4Y2oGgtVwOUasy+mgpL4bVSirYab0YUbTKQzjz8EOZVsQRbse0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qTBCmhMP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTBCmhMP"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48374014a77so93126735e9.3
        for <linux-input@vger.kernel.org>; Wed, 15 Apr 2026 08:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776268568; x=1776873368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G6Mkim16BUUaoJYPhon4NBZrR5e8we9AfJnvcaJ2pRc=;
        b=qTBCmhMPjh7LzILfxNTXFBYqoQm12w8zPla3pZ+UOESS6cqXojqmzCA2nLZMsr3PKa
         xQb+cG6bLEser6q/5R2QyZtWT3c+KlOOblQm5cAsiqCB6OCeE+dzq9r953/YiqGWX5tm
         mrQiZsnfQKJUEdOJrIa9Uc3I/5ZjRPl+bTyQFjD07dt3L9zzM9YZQiQaXEBwAdqT16mI
         uzjD4xHFq9P17Ap16Lt3InhYUP3e2FlgPsLLjXSC0LDm9gxoSIpfqgXHFOeSdP+UOJnW
         e3N4cXhJZ69klZ2T3pgHz4nD4XS2+yF0EyCFgyXlP0TGfMQGFw5+lVvfwOwK9i4vryhf
         jdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776268568; x=1776873368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6Mkim16BUUaoJYPhon4NBZrR5e8we9AfJnvcaJ2pRc=;
        b=kJ+YXrf87tvn6ZzaS/I+f5RnU7wIWOqwQyPkp1DGIs8rXY0P1fts13NXX2cw5keby8
         fZlQ0PIp5n+czffB0OD5V3E/vGY0HGTtLvORX5grr/HhjjuEyDYZZtuR8oSnavNs0FZz
         N277AteSoJPqoxZYJTayuuB5nki1MZLmYQ7d1Rxol747HpfTdeR3P4ZMgrYZHumJf2Sf
         cPysunZ91YAQq2ZVqvKpYJ7EUzWWmUKVIfPpOkiBNeoZAnJodzxTBNwC/UoTj+BuXC3u
         ke1/+sB0TJFIpw7HtE4fs0ffhw1BYeDP0lKKYBnvnHqdE/G1hNhvbjJwgy5IAjWIR0oN
         zRng==
X-Gm-Message-State: AOJu0YxA7kjH77ZG03RDQP5pewBwXPdzJ3jzilpz6D2nykSFnYV6zcnD
	S4S9osmLgqhxq8qwJ0rgA7O9HwuFm1Z2FM7Wl5RMgInxImlDwAyv/NF2
X-Gm-Gg: AeBDievx+Wt7DNkfkm+DMARZVmM3t0KZn8f8sqTMyBTHlXKoRJubbeOHRECyGdT+0+m
	xO0szQ4pJawDEbyRiTe9jcRfiP7ooAuht39Tu+6RFUE7MNn0X6Oo/EMsS5ZxtDsZOglBN9pfWAX
	LpgAWDnxD1HfAvxAbIsrxp9t62nojinIjDlJp7cCL+zQLG0rbw9r53sfnHbm4UUikFKBDpERO8s
	0kllsdQZ0D9VXK06YMmqs7laX8i3dqFpuq0u7v/Y4JFOCra8ipbfLJPu+ZyP4MqnSfnKcRNp6zw
	gaxpWWCwgPaurJSoyN1bjwpcs7no88BA0abRQaAIQET5TDuXOM8ebN/C2rUg+WNhpWbLK+O5r7X
	9YuHM7HF+SYM/p5Qbs1Sdg8zr7AVcOjHF04vjQxTbkSCuY3J05HI8oAM0PuFhP0jPGZOwOYMzkQ
	Th0S+y/UrNSIwAw751T5eqIRTIc4NXgbodo4j9
X-Received: by 2002:a05:600c:30d2:b0:488:e192:6fb5 with SMTP id 5b1f17b1804b1-488e19270cbmr166568205e9.24.1776268567501;
        Wed, 15 Apr 2026 08:56:07 -0700 (PDT)
Received: from 2011-iMac.. ([37.100.201.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1df12sm315334375e9.4.2026.04.15.08.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:56:07 -0700 (PDT)
From: Damiano Gragnaniello <damianogragnaniello@gmail.com>
To: Jiri Kosina <jkosina@suse.cz>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Damiano Gragnaniello <damianogragnaniello@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: magicmouse: add battery reporting for Magic Trackpad v1
Date: Wed, 15 Apr 2026 17:55:48 +0200
Message-ID: <20260415155548.927385-1-damianogragnaniello@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Magic Trackpad v1 (USB_DEVICE_ID_APPLE_MAGICTRACKPAD, 0x030e)
connects over Bluetooth and uses two AA batteries. When the device
sends Report ID 0x47, byte 1 carries the battery level as a
percentage (0-100) already expressed in firmware units.

This patch:
  - Registers a power_supply instance via devm_power_supply_register()
    during probe() for the v1 trackpad only (BT, vendor 0x05ac).
  - Parses Report ID 0x47 in magicmouse_raw_event() and calls
    power_supply_changed() to propagate the value to userspace.
  - Exposes PRESENT, CAPACITY, SCOPE and STATUS properties, consistent
    with how hid-sony and hid-logitech-hidpp expose battery data.
  - Registration failure is treated as non-fatal so the input device
    continues to work even if power_supply cannot be allocated.

Tested on Linux Mint / kernel 6.17 with an Apple Magic Trackpad A1339
(first generation, AA cells, firmware 0x0291).

Note: Technical analysis and initial boilerplate structure were assisted by 
Claude (Anthropic AI). The logic has been manually verified against hardware 
descriptors (rdesc) and tested on physical A1339 hardware.

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Damiano Gragnaniello <damianogragnaniello@gmail.com>
---
--- /home/claude/hid-patch/hid-magicmouse.c.orig	2026-04-15 13:34:50.358612695 +0000
+++ /home/claude/hid-patch/hid-magicmouse.c	2026-04-15 13:35:39.402309524 +0000
@@ -15,6 +15,7 @@
 #include <linux/hid.h>
 #include <linux/input/mt.h>
 #include <linux/module.h>
+#include <linux/power_supply.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 
@@ -60,6 +61,7 @@
 #define MOUSE_REPORT_ID    0x29
 #define MOUSE2_REPORT_ID   0x12
 #define DOUBLE_REPORT_ID   0xf7
+#define TRACKPAD_V1_BATTERY_REPORT_ID 0x47
 #define USB_BATTERY_TIMEOUT_SEC 60
 
 /* These definitions are not precise, but they're close enough.  (Bits
@@ -124,6 +126,10 @@
  * @hdev: Pointer to the underlying HID device.
  * @work: Workqueue to handle initialization retry for quirky devices.
  * @battery_timer: Timer for obtaining battery level information.
+ * @battery: Power supply instance for Magic Trackpad v1 AA battery reporting.
+ * @battery_desc: Descriptor for the power_supply registration.
+ * @battery_name: Name buffer for the power_supply instance.
+ * @battery_capacity: Last known battery level (0-100%) for Magic Trackpad v1.
  */
 struct magicmouse_sc {
 	struct input_dev *input;
@@ -149,8 +155,46 @@
 	struct hid_device *hdev;
 	struct delayed_work work;
 	struct timer_list battery_timer;
+
+	/* Magic Trackpad v1 (AA battery) power_supply support */
+	struct power_supply		*battery;
+	struct power_supply_desc	 battery_desc;
+	char				 battery_name[64];
+	int				 battery_capacity;
+};
+
+static const enum power_supply_property magicmouse_v1_battery_props[] = {
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_SCOPE,
+	POWER_SUPPLY_PROP_STATUS,
 };
 
+static int magicmouse_v1_battery_get_property(struct power_supply *psy,
+					       enum power_supply_property psp,
+					       union power_supply_propval *val)
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
@@ -391,6 +435,19 @@
 	int x = 0, y = 0, ii, clicks = 0, npoints;
 
 	switch (data[0]) {
+	case TRACKPAD_V1_BATTERY_REPORT_ID:
+		/*
+		 * Magic Trackpad v1 (AA battery, 0x030e) sends battery level
+		 * in byte 1, already expressed as a percentage (0-100).
+		 * Clamp defensively and notify the power_supply framework.
+		 */
+		if (size < 2)
+			return 0;
+		if (msc->battery) {
+			msc->battery_capacity = clamp_val((int)data[1], 0, 100);
+			power_supply_changed(msc->battery);
+		}
+		return 0;
 	case TRACKPAD_REPORT_ID:
 	case TRACKPAD2_BT_REPORT_ID:
 		/* Expect four bytes of prefix, and N*9 bytes of touch data. */
@@ -890,6 +947,38 @@
 		magicmouse_fetch_battery(hdev);
 	}
 
+	/* Register power_supply for Magic Trackpad v1 (AA battery, BT only) */
+	if (id->product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD &&
+	    id->vendor == USB_VENDOR_ID_APPLE) {
+		struct power_supply_config psy_cfg = {};
+
+		msc->battery_capacity = 0;
+		snprintf(msc->battery_name, sizeof(msc->battery_name),
+			 "hid-magictrackpad-v1-%s", dev_name(&hdev->dev));
+
+		msc->battery_desc.name           = msc->battery_name;
+		msc->battery_desc.type           = POWER_SUPPLY_TYPE_BATTERY;
+		msc->battery_desc.properties     = magicmouse_v1_battery_props;
+		msc->battery_desc.num_properties =
+			ARRAY_SIZE(magicmouse_v1_battery_props);
+		msc->battery_desc.get_property   =
+			magicmouse_v1_battery_get_property;
+
+		psy_cfg.drv_data = msc;
+
+		msc->battery = devm_power_supply_register(&hdev->dev,
+							  &msc->battery_desc,
+							  &psy_cfg);
+		if (IS_ERR(msc->battery)) {
+			ret = PTR_ERR(msc->battery);
+			hid_err(hdev,
+				"unable to register trackpad v1 battery: %d\n",
+				ret);
+			msc->battery = NULL;
+			/* Non-fatal: continue without battery reporting */
+		}
+	}
+
 	if (is_usb_magicmouse2(id->vendor, id->product) ||
 	    (is_usb_magictrackpad2(id->vendor, id->product) &&
 	     hdev->type != HID_TYPE_USBMOUSE))
