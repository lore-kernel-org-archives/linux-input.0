Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F983F9FB
	for <linux-input@vger.kernel.org>; Fri, 19 Jun 2026 00:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781827909; cv=none; b=EBeQQFRIMmu0YU9sc5wLhecICfUsTX6f37jheOviqPh/wFMB98pR9rMlr6E2ziBVbrcOGOjqd2kunxa/A7cyeg7LrOTnCP8bKQ/dA48FqSo6jPPxcKFxlKytueMNklXmzs+mAK7m/pw/tbE4wvIuQTBRoOhnlDRjk0Q2FC4WHZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781827909; c=relaxed/simple;
	bh=fv8eVYDEdTJ4bSlZ7Z5PXK20r36Z6QBmCVvlvRXM6dM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQf7X2fuJAMljRulq17/jKQMooJNrRd9RcXDKDZqmkdo2+jZsuH/tFDN9U4u/1dCetn2fBtvO/665EE++1SqP/RF5JFK8wLVx0MMYK8NcCRUvNwDE1L+Yc6w6ATfeBMnJuQOMBmTuDT53HOKnX+vI07SoMlx2T0TrASLEK7R5fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QbdQ9+bm; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QbdQ9+bm"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781827906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H5HzgCS9QOoo0BJb+qoFlJS4q7sq6FVZ75P2HP0fhtg=;
	b=QbdQ9+bmj0++X4NQn3IN7hjYCOVyLaA7cSmcGNVRc8p4Q1rhltf6DQH0dCc1ucawPe12WZ
	uZEqVgFzRHy2dwyi7a3hJLaCHlFzyNfb0PE99SiRZdBukYC43aLHl+NuGPGY3XZTgoIUOt
	tnf7OiNX356HcwBoSFDUCunwNlhUwCU=
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
Subject: [PATCH v5 4/5] HID: asus: add support for xgm led
Date: Fri, 19 Jun 2026 00:11:02 +0000
Message-ID: <20260619001103.1189200-5-denis.benato@linux.dev>
In-Reply-To: <20260619001103.1189200-1-denis.benato@linux.dev>
References: <20260619001103.1189200-1-denis.benato@linux.dev>
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

Reviewed-by: Antheas Kapenekakis <lkml@antheas.dev>
Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/hid-asus.c | 94 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 0fb8cd6437b7..06e4888f090c 100644
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
@@ -143,6 +145,11 @@ struct asus_worker {
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
@@ -169,6 +176,7 @@ struct asus_drvdata {
 	unsigned long battery_next_query;
 	struct asus_hid_listener listener;
 	bool fn_lock;
+	struct asus_xgm_led *xgm_led;
 };
 
 static int asus_report_battery(struct asus_drvdata *, u8 *, int);
@@ -1125,6 +1133,26 @@ static int asus_battery_probe(struct hid_device *hdev)
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
+	if (ret < 0) {
+		hid_err(xgm->hdev, "Unable to set XG mobile led state: %d\n", ret);
+		return ret;
+	} else if (ret != ROG_XGM_REPORT_SIZE) {
+		hid_err(xgm->hdev, "Unexpected partial transfer to XG mobile: %d\n", ret);
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
 {
 	struct input_dev *input = hi->input;
@@ -1349,9 +1377,52 @@ static int asus_start_multitouch(struct hid_device *hdev)
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
+		goto asus_xgm_init_err;
+	}
+
+	ret = devm_led_classdev_register(&hdev->dev, &drvdata->xgm_led->cdev);
+	if (ret) {
+		hid_err(hdev, "Asus failed to register xgm led: %d\n", ret);
+		goto asus_xgm_init_err;
+	}
+
+	return 0;
+asus_xgm_init_err:
+	drvdata->xgm_led = NULL;
+	return ret;
+}
+
 static int __maybe_unused asus_resume(struct hid_device *hdev)
 {
 	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	int ret;
 
 	/*
 	 * If we have a backlight listener registered, restore the previous state,
@@ -1361,7 +1432,17 @@ static int __maybe_unused asus_resume(struct hid_device *hdev)
 	if (drvdata->listener.brightness_set)
 		asus_kbd_backlight_set(&drvdata->listener, drvdata->kbd_backlight_brightness);
 
+	if (drvdata->xgm_led) {
+		ret = asus_xgm_led_set(&drvdata->xgm_led->cdev, drvdata->xgm_led->cdev.brightness);
+		if (ret) {
+			hid_err(hdev, "Asus failed to restore xgm brightness: %d\n", ret);
+			goto asus_resume_err;
+		}
+	}
+
 	return 0;
+asus_resume_err:
+	return ret;
 }
 
 static int __maybe_unused asus_reset_resume(struct hid_device *hdev)
@@ -1491,6 +1572,16 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
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
@@ -1540,6 +1631,9 @@ static void asus_remove(struct hid_device *hdev)
 	if (drvdata->listener.brightness_set)
 		asus_hid_unregister_listener(&drvdata->listener);
 
+	if (drvdata->xgm_led)
+		devm_led_classdev_unregister(&hdev->dev, &drvdata->xgm_led->cdev);
+
 	asus_worker_stop(drvdata->worker);
 	hid_hw_stop(hdev);
 }
-- 
2.47.3

