Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8D037BE64
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781364649; cv=none; b=UuH8rdlMxuJVyLV2PEMkaEwOGZuWF1trCr8kXhzDgJ92jMesJsHMeXwYeOLC6KbKqFUtVbiHXTlCAHk/VG2HXY3OCPbTCyP5iw5gu1EevzE1RmjCJL/E9leCE86lFWZ6FszPTrMKt9sQatesm6LUSjCcbwWRer+R4fttOM27agE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781364649; c=relaxed/simple;
	bh=A9OPBayvSKJ+jp6Eaq/xjIYdRxdiXKxCYB8wFAm2fd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LrMBbiHG7yaY454M6HZ9AcZC4weeO4cAj/j/VB6Lag79kJzVQPNrsKR0z9Sa++TfvhVl/EOEISeh6rGQYSV8fh3xSkZR+HnzfTQn5HsMyZLdRFfHzAAF/wCJK08pG+SbgZh7s4Q53Sstmr6UAH3fMr0bQkRuu1iYTRWNp0jSCFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Nw1Y4Iiv; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Nw1Y4Iiv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781364636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7h5w3+qH/FO4M18bupJw7+SJTaTNAr4SBWoNeLiG3Og=;
	b=Nw1Y4IivoPWJVvlqg5hPFGCtpp21JAAsvuQjcEe31R49aTkiWPFelFvdArkZrh+mhzuxXF
	ARzrUIf7cGL45Qx5ZvzqMN7HQwD+jycUBMFlaLI7k57WNVhAOtU5xJdNXZy2xOlI88KCYT
	vUBW/GWtIRbY1ML71Ai26Qy+TIJHcO8=
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Denis Benato" <denis.benato@linux.dev>,
	"Antheas Kapenekakis" <lkml@antheas.dev>,
	"Connor Belli" <connorbelli2003@gmail.com>
Subject: [PATCH v3 3/8] HID: asus: add support for xgm led
Date: Sat, 13 Jun 2026 15:30:24 +0000
Message-ID: <20260613153029.2559774-4-denis.benato@linux.dev>
In-Reply-To: <20260613153029.2559774-1-denis.benato@linux.dev>
References: <20260613153029.2559774-1-denis.benato@linux.dev>
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

Reviewed by: Antheas Kapenekakis <lkml@antheas.dev>
Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/hid-asus.c | 91 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 323dc0b7f3ff..0a6c97155549 100644
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
@@ -1169,6 +1194,51 @@ static int asus_start_multitouch(struct hid_device *hdev)
 	return 0;
 }
 
+static int asus_xgm_init(struct hid_device *hdev, struct asus_drvdata *drvdata)
+{
+	const char *name;
+	int ret;
+
+	drvdata->xgm_led = devm_kzalloc(&hdev->dev, sizeof(*drvdata->xgm_led), GFP_KERNEL);
+	if (drvdata->xgm_led == NULL)
+		return -ENOMEM;
+
+	name = devm_kasprintf(&hdev->dev, GFP_KERNEL, "asus:xgm-%s:led",
+			      strlen(hdev->uniq) ? hdev->uniq : dev_name(&hdev->dev));
+
+	if (name == NULL) {
+		ret = -ENOMEM;
+		goto asus_xgm_init_err;
+	}
+
+	drvdata->xgm_led->hdev = hdev;
+	drvdata->xgm_led->cdev.name = name;
+	drvdata->xgm_led->cdev.brightness = 1;
+	drvdata->xgm_led->cdev.max_brightness = 1;
+	drvdata->xgm_led->cdev.brightness_set_blocking = asus_xgm_led_set;
+
+	/* LED state is arbitrary on boot, set a default */
+	ret = asus_xgm_led_set(&drvdata->xgm_led->cdev, drvdata->xgm_led->cdev.brightness);
+	if (ret) {
+		hid_err(hdev, "Asus failed to set xgm led: %d\n", ret);
+		goto asus_xgm_init_led_err;
+	}
+
+	ret = led_classdev_register(&hdev->dev, &drvdata->xgm_led->cdev);
+	if (ret) {
+		hid_err(hdev, "Asus failed to register xgm led: %d\n", ret);
+		goto asus_xgm_init_led_err;
+	}
+
+	return 0;
+asus_xgm_init_led_err:
+	devm_kfree(&hdev->dev, name);
+asus_xgm_init_err:
+	devm_kfree(&hdev->dev, drvdata->xgm_led);
+	drvdata->xgm_led = NULL;
+	return ret;
+}
+
 static int __maybe_unused asus_resume(struct hid_device *hdev)
 {
 	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
@@ -1184,6 +1254,14 @@ static int __maybe_unused asus_resume(struct hid_device *hdev)
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
@@ -1310,6 +1388,16 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		}
 	}
 
+	if (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID) &&
+	    ((hdev->product == USB_DEVICE_ID_ASUSTEK_XGM_2022) ||
+	     (hdev->product == USB_DEVICE_ID_ASUSTEK_XGM_2023))) {
+		ret = asus_xgm_init(hdev, drvdata);
+		if (ret) {
+			hid_err(hdev, "Failed to initialize xg mobile: %d\n", ret);
+			goto err_stop_hw;
+		}
+	}
+
 	/* Laptops keyboard backlight is always at 0x5a */
 	if (is_vendor && (drvdata->quirks & QUIRK_USE_KBD_BACKLIGHT) &&
 	    (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID)) &&
@@ -1366,6 +1454,9 @@ static void asus_remove(struct hid_device *hdev)
 	if (drvdata->quirks & QUIRK_HID_FN_LOCK)
 		cancel_work_sync(&drvdata->fn_lock_sync_work);
 
+	if (drvdata->xgm_led)
+		led_classdev_unregister(&drvdata->xgm_led->cdev);
+
 	hid_hw_stop(hdev);
 }
 
-- 
2.47.3

