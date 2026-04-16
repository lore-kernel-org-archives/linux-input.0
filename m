Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9022848A7
	for <linux-input@vger.kernel.org>; Thu, 16 Apr 2026 12:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776344022; cv=none; b=mBzKRuE0ztCxyGsjnp8nLEojUjq0dq1BeQ2STZpb8SLl7LgRJqSSKJ7BNMJkjlPM0DCeCCBxi7uWeZJYgX1yiNXPijedGPMGWWlaAWDw7gMxpFkf2MwldQXBtMNve9hkuPMVqXxuwai0zHboLFkaaEzotcjSaYDXZmIPdIBWHDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776344022; c=relaxed/simple;
	bh=ZBzZJW+7Uhq59Nu90ZzmWYWVYek9o3QeKFGaXs4ZAL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZs2yKt1OSsYsuODR+CXdUKzH2B4WkLS/9ytFDSjpIvwRzjzyz2Z5ERHK7N6c4ZVucHhGeHu7dg6F748GzFnFErTXVyl763RKqKxdA/NEbSPnnQpRADA/1XzxXGre40h7NwEHhStVoGgMLyyqMLOPqxk9LqYGzDgFDTtQ02szf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7uWk7/e; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7uWk7/e"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488ad135063so77022105e9.0
        for <linux-input@vger.kernel.org>; Thu, 16 Apr 2026 05:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776344019; x=1776948819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Hn/3xSqHZ1rBoVkDvjl+PdVa1vSA5BTYQuFCf+BwMQ=;
        b=O7uWk7/eg35EykGiGKlrRrfXbQbJyMuxtcdHdlE55bWq7dAMv1Qv3z3K/UWEGrictA
         etsoBuecWWolYwGSWyKnXKZ/eTvaD2GnIMyrMzhyTj7LZYT67wbe1Y0eBZnndSUFLcFn
         mG/WK7EBeMmW1gddMb9TUQhMsCoaA8XkTNO0lwR/JsKBnctN/t8JWqVUudAkGfFdf+XY
         7jVfkBCvcfDqT4DlX3fM6jydOB/UvXL522jvD3+h5xxiKExvdaRFpY4UXLz33/nkdeNs
         nJjTPD4qtSaBGjRg36OKpOeMl11s0oB2NKB08XYzVIpXv4XLDFilqJLdDXSc5+XA8ttI
         bufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776344019; x=1776948819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/Hn/3xSqHZ1rBoVkDvjl+PdVa1vSA5BTYQuFCf+BwMQ=;
        b=mcWVafWT8gnvSmUsoMWPkqCZEkEU24ul9vdF7d4RKsAYvqPoG7CKv9i2/2ZwQb1qIK
         gTeDUQsJkDHRejLKYlBCnliZTFVeJXvr+VFlx9l5yQ9z4pfMdMCQteAONnmCuqzfUpwp
         9R9pocXkRSXNEeiFYfZYb8KAAsyEFjSmWjmRGZxPgAXTg/tviyyF0JbB4tHaR5CrmYzd
         ylQIO0Gfv36GujsI0pUSG26VFpHpneH7TzKnox8Of/p70+T+SpfjeeBKRMYnuEx51ASb
         Fk6uiS48Y4/BRJv/wvfHiHIKk8yRh6onPzvpOywga3SI0sb+butnKn9C/KMgFhq9Lpex
         b5fw==
X-Forwarded-Encrypted: i=1; AFNElJ9E0hX3z9v53tSKInew6zH3ja839JEQuA47S6OKcQkt9a/e+EEvTJp5VebN3eB5WIbOiwlAYbflv50GEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUD5kJ3BwCyMmhGzKNKaua2nFuMHpJME4LLVY1gO/Ji41qtQyb
	kySKAD1pwy0ghS0dJnVettvAaPPEc0AvpA9Yr1Hlcu+OBlT3zA0IIb/7
X-Gm-Gg: AeBDievx1wPGhNO9m4mw8anBjWxGXjW59t9JXYhaZMBCndorLgzKoZRrLulbdOkoADF
	xypoFfPDE23mjweVuETHRvMKIRbO8y7vFnQwUtHENcuV96sQDtFmcA9OGo96K8SZH70klPWyVNX
	N12zcpL3YpJaxjhIg+zAuWgklFG6eg/jHqy2Kbc+1et+4T312vT4N3aYqaflMGfvRz/dPvPGu5F
	9m6G1LG9sLeLIfJiDHIlWs+gXhfsptbUZ7AkWpVPMJatHKS3L88KrTO/ud57DC3PIuYGgtlfM5Y
	zUbBe2aD+skmfWTz/K7eFmTHGbyp6qS99EyWBSm92NDyergyEhYJ9LzfbaR3/XzesnI5R9GOQh6
	3DcsunT+cCtwNEscZmrEC1aFIG+FzMaVjzb6e17r2DqVvPyNJg/9rUOq8pAUrD7XXjLs5IJts9o
	gmjnkj8aZVX1YA5BTpgk5UtP5FhAxbavvBctU=
X-Received: by 2002:a05:600c:5306:b0:487:59c:2bb8 with SMTP id 5b1f17b1804b1-488d68c3385mr345517055e9.27.1776344018644;
        Thu, 16 Apr 2026 05:53:38 -0700 (PDT)
Received: from 2011-iMac.. ([37.100.232.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f582048bsm51420545e9.7.2026.04.16.05.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 05:53:38 -0700 (PDT)
From: Damiano Gragnaniello <damianogragnaniello@gmail.com>
To: jikos@kernel.org
Cc: bentiss@kernel.org,
	linux-input@vger.kernel.org,
	Damiano Gragnaniello <damianogragnaniello@gmail.com>
Subject: [PATCH v5] HID: magicmouse: add battery reporting for Magic Trackpad v1
Date: Thu, 16 Apr 2026 14:53:15 +0200
Message-ID: <20260416125317.172576-1-damianogragnaniello@gmail.com>
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

The Magic Trackpad v1 (A1339) reports battery level via Bluetooth using
Report ID 0x47. This patch adds support for parsing this report and
registering a power_supply interface so that userspace (upower) can
correctly display the battery percentage for this legacy device.

Signed-off-by: Damiano Gragnaniello <damianogragnaniello@gmail.com>
---
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

 drivers/hid/hid-magicmouse.c | 82 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
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
+	struct power_supply *battery;
+	struct power_supply_desc battery_desc;
+	char battery_name[64];
+	int battery_capacity;
+};
+
+static const enum power_supply_property magicmouse_v1_battery_props[] = {
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_SCOPE,
+	POWER_SUPPLY_PROP_STATUS,
+};
+
+static int magicmouse_v1_battery_get_property(struct power_supply *psy,
+					   enum power_supply_property psp,
+					   union power_supply_propval *val)
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
 }
 
 static int magicmouse_firm_touch(struct magicmouse_sc *msc)
@@ -391,6 +435,19 @@
 	int x = 0, y = 0, ii, clicks = 0, npoints;
 
 	switch (data[0]) {
+	case TRACKPAD_V1_BATTERY_REPORT_ID:
+		/*
+		 * Magic Trackpad v1 (A1339, BT) sends battery level in byte 1,
+		 * already expressed as a percentage (0-100) by the firmware.
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
@@ -890,6 +947,31 @@
 		magicmouse_fetch_battery(hdev);
 	}
 
+	/* Register power_supply for Magic Trackpad v1 (AA battery, BT only) */
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
+		msc->battery_desc.num_properties = ARRAY_SIZE(magicmouse_v1_battery_props);
+		msc->battery_desc.get_property = magicmouse_v1_battery_get_property;
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
 	if (is_usb_magicmouse2(id->vendor, id->product) ||
 	    (is_usb_magictrackpad2(id->vendor, id->product) &&
 	     hdev->type != HID_TYPE_USBMOUSE))
