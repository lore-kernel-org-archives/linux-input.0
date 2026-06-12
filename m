Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4E53845BD
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781274223; cv=none; b=qqd+BmhaGWDvyY66KHYmc6lHKGljYj4HNv45jzZz3V1uG5wXfLfiRrPPaQesMzv8DvxTiaiyVsJ19SHZh+64VDBLuiT2qG2sKs//zY7Ft8e1sks8CWf7Sm7AVhMMR+8i9RnOiWLtSUFHrl5TeEzwaGw/nQz45wvLcRmZeAkR17E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781274223; c=relaxed/simple;
	bh=Rd1GmXFlZWRe+0tXhb9MKbBTxFRzTpcoglqfiJyOOGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SzKRCq60lSvnpr/WWma9aq+dIrcsjLh2mL0SnLc9jHoXnn0o9dmmsGj5KD8NBefqUAgZuW177hZxO1UlysshVQnHZ2KNj7ALpd0n28AyTQ87tiNM446eeV+O3/4YZzT3HJQIcNST+hcJ7s6/X7OPtjRl/XbNXFd5CODeLV4yPy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HOzuOjzl; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HOzuOjzl"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781274220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CXA6OFzAxyfvr5eAb7R/01gcCjjtPkfVx3Brt5REjpo=;
	b=HOzuOjzlnkR3dDwkDi5FsvJxBRxtYNOIfPE6fx5jEkCYbBrO1/g3Jnh5gjhQ0sLEVdEI+B
	7IF3uzml48PX6waOWJdcCbJr414XpNoZplpygXKvA/wL8Up8wDgyltezitzOiwxwODMX83
	+n4UeDztcM1+jZltoRC7pdv1+HDcCZw=
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Denis Benato" <denis.benato@linux.dev>,
	"Antheas Kapenekakis" <lkml@antheas.dev>
Subject: [PATCH v2 3/4] HID: asus: add support for xgm led
Date: Fri, 12 Jun 2026 14:23:25 +0000
Message-ID: <20260612142326.1704858-4-denis.benato@linux.dev>
In-Reply-To: <20260612142326.1704858-1-denis.benato@linux.dev>
References: <20260612142326.1704858-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

XG mobile stations have very bright leds behind the fan that can be
turned either ON or OFF: add a cled interface to allow controlling the
brightness of those red leds.

Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/hid-asus.c | 70 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 323dc0b7f3ff..21c4a60d224e 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -51,6 +51,8 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define FEATURE_KBD_LED_REPORT_ID1 0x5d
 #define FEATURE_KBD_LED_REPORT_ID2 0x5e
 
+#define ROG_XGM_REPORT_SIZE 300
+
 #define ROG_ALLY_REPORT_SIZE 64
 #define ROG_ALLY_X_MIN_MCU 313
 #define ROG_ALLY_MIN_MCU 319
@@ -118,6 +120,11 @@ struct asus_kbd_leds {
 	bool removed;
 };
 
+struct asus_xgm_led {
+	struct led_classdev cdev;
+	struct hid_device *hdev;
+};
+
 struct asus_touchpad_info {
 	int max_x;
 	int max_y;
@@ -143,6 +150,7 @@ struct asus_drvdata {
 	unsigned long battery_next_query;
 	struct work_struct fn_lock_sync_work;
 	bool fn_lock;
+	struct asus_xgm_led *xgm_led;
 };
 
 static int asus_report_battery(struct asus_drvdata *, u8 *, int);
@@ -941,6 +949,23 @@ static int asus_battery_probe(struct hid_device *hdev)
 	return ret;
 }
 
+static int asus_xgm_led_set(struct led_classdev *led_cdev, enum led_brightness value)
+{
+	const u8 buf[ROG_XGM_REPORT_SIZE] = {
+		FEATURE_KBD_LED_REPORT_ID2, 0xC5, (value) ? 0x50 : 0x00
+	};
+	struct asus_xgm_led *xgm = container_of(led_cdev, struct asus_xgm_led, cdev);
+	int ret;
+
+	ret = asus_kbd_set_report(xgm->hdev, buf, ROG_XGM_REPORT_SIZE);
+	if (ret != ROG_XGM_REPORT_SIZE) {
+		hid_err(xgm->hdev, "Unable to set XG mobile led state: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
 {
 	struct input_dev *input = hi->input;
@@ -1184,6 +1209,14 @@ static int __maybe_unused asus_resume(struct hid_device *hdev)
 		}
 	}
 
+	if (drvdata->xgm_led) {
+		ret = asus_xgm_led_set(&drvdata->xgm_led->cdev, drvdata->xgm_led->cdev.brightness);
+		if (ret) {
+			hid_err(hdev, "Asus failed to restore xgm brightness: %d\n", ret);
+			goto asus_resume_err;
+		}
+	}
+
 asus_resume_err:
 	return ret;
 }
@@ -1310,6 +1343,40 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		}
 	}
 
+	if (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID) &&
+	    ((hdev->product == USB_DEVICE_ID_ASUSTEK_XGM_2022) ||
+	     (hdev->product == USB_DEVICE_ID_ASUSTEK_XGM_2023))) {
+		drvdata->xgm_led = devm_kzalloc(&hdev->dev, sizeof(*drvdata->xgm_led), GFP_KERNEL);
+		if (drvdata->xgm_led == NULL) {
+			ret = -ENOMEM;
+			goto err_stop_hw;
+		}
+		drvdata->xgm_led->hdev = hdev;
+		drvdata->xgm_led->cdev.name = devm_kasprintf(&hdev->dev, GFP_KERNEL,
+					"asus:xgm-%s:led",
+					strlen(hdev->uniq) ?
+					hdev->uniq : dev_name(&hdev->dev));
+		drvdata->xgm_led->cdev.brightness = 1;
+		drvdata->xgm_led->cdev.max_brightness = 1;
+		drvdata->xgm_led->cdev.brightness_set_blocking = asus_xgm_led_set;
+
+		/*
+		 * Sometimes after a reboot LEDs are ON, sometimes are OFF: set them to
+		 * what the default brightness resets when doing a cold boot.
+		 */
+		ret = asus_xgm_led_set(&drvdata->xgm_led->cdev, drvdata->xgm_led->cdev.brightness);
+		if (ret) {
+			hid_err(hdev, "Asus failed to set xgm led: %d\n", ret);
+			goto err_stop_hw;
+		}
+
+		ret = led_classdev_register(&hdev->dev, &drvdata->xgm_led->cdev);
+		if (ret) {
+			hid_err(hdev, "Asus failed to register xgm led: %d\n", ret);
+			goto err_stop_hw;
+		}
+	}
+
 	/* Laptops keyboard backlight is always at 0x5a */
 	if (is_vendor && (drvdata->quirks & QUIRK_USE_KBD_BACKLIGHT) &&
 	    (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID)) &&
@@ -1366,6 +1433,9 @@ static void asus_remove(struct hid_device *hdev)
 	if (drvdata->quirks & QUIRK_HID_FN_LOCK)
 		cancel_work_sync(&drvdata->fn_lock_sync_work);
 
+	if (drvdata->xgm_led)
+		led_classdev_unregister(&drvdata->xgm_led->cdev);
+
 	hid_hw_stop(hdev);
 }
 
-- 
2.47.3

