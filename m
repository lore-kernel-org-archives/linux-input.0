Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DBC233928
	for <linux-input@vger.kernel.org>; Thu, 11 Jun 2026 22:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781215910; cv=none; b=AEeKj0qzNrhmJDkjPk9kFfPjWX+roKwG/mMAtLZ6ACN0/IQvfAp5PCllUke67Q+TdLaXE0F6KYt0UiFLJZ8Nvt0IEj2bAPK2ASfkL/T5q4PB3wj4N2/tRyjQ712z8c+ikaf5+BtJwIsOouIdusa37r2UiD5Z4t3P8fl2/6yqcHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781215910; c=relaxed/simple;
	bh=PUneajfNH7bz+8vwN4hrzyTeHo8oy0IsRxcMXw3mOP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QGnb8gKz2k0Y380DpiFgzEgNd1/RFtBw96LzlzMU14w2UbLWOm+/lUt6zN9v5suxwGE4zyxanV1vLH9IQ+or23mv96mcE7TfUGky//+m7UMGCcYT8XvHlazRRsweeTpOKGTQ4noTVOvPDG97Wu7sjLloWje5S28pAGWzW1CIcVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uKwbRp4O; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uKwbRp4O"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781215906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gOpuxKJgR5u8vlhqk20Zt54zuncbAaqvsynrY2CMuQE=;
	b=uKwbRp4OixxCJI9ds9eWtWD2ArlTooN7JfRw2IdzLk6YvaDsVusu9h3iS/6A12cbLKYtMG
	Qi7BA0+XDdWLq26+PaYSEwi6DsmB1dQN8mDm0E9ErtnI3CczZy5pPNZal4xh+oyqaZrC/B
	Dk0PRJbLIjWkXajEFT/HWGSydqb41A0=
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Denis Benato" <denis.benato@linux.dev>
Subject: [PATCH] HID: asus: add support for xgm led
Date: Thu, 11 Jun 2026 22:11:41 +0000
Message-ID: <20260611221141.45456-1-denis.benato@linux.dev>
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
 drivers/hid/hid-asus.c | 53 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index d34d74df3dc0..4298a3fe98c7 100644
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
@@ -940,6 +948,19 @@ static int asus_battery_probe(struct hid_device *hdev)
 	return ret;
 }
 
+static void asus_xgm_led_set(struct led_classdev *led_cdev, enum led_brightness value)
+{
+	const u8 buf[ROG_XGM_REPORT_SIZE] = {
+		FEATURE_KBD_LED_REPORT_ID2, 0xC5, (value) ? 0x50 : 0x00
+	};
+	struct asus_xgm_led *xgm = container_of(led_cdev, struct asus_xgm_led, cdev);
+	int ret;
+
+	ret = asus_kbd_set_report(xgm->hdev, buf, ROG_XGM_REPORT_SIZE);
+	if (ret != ROG_XGM_REPORT_SIZE)
+		hid_err(xgm->hdev, "Unable to set XG mobile led state: %d\n", ret);
+}
+
 static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
 {
 	struct input_dev *input = hi->input;
@@ -1183,6 +1204,9 @@ static int __maybe_unused asus_resume(struct hid_device *hdev)
 		}
 	}
 
+	if (drvdata->xgm_led)
+		asus_xgm_led_set(&drvdata->xgm_led->cdev, drvdata->xgm_led->cdev.brightness);
+
 asus_resume_err:
 	return ret;
 }
@@ -1309,6 +1333,32 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
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
+		drvdata->xgm_led->cdev.name = "asus:xgm:led";
+		drvdata->xgm_led->cdev.brightness = 1;
+		drvdata->xgm_led->cdev.max_brightness = 1;
+		drvdata->xgm_led->cdev.brightness_set = asus_xgm_led_set;
+		ret = led_classdev_register(&hdev->dev, &drvdata->xgm_led->cdev);
+		if (ret) {
+			hid_err(hdev, "Asus failed to register xgm led: %d\n", ret);
+			goto err_stop_hw;
+		}
+
+		/*
+		 * Sometimes after a reboot LEDs are ON, sometimes are OFF: set them to
+		 * what the default brightness resets when doing a cold boot.
+		 */
+		asus_xgm_led_set(&drvdata->xgm_led->cdev, drvdata->xgm_led->cdev.brightness);
+	}
+
 	/* Laptops keyboard backlight is always at 0x5a */
 	if (is_vendor && (drvdata->quirks & QUIRK_USE_KBD_BACKLIGHT) &&
 	    (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID)) &&
@@ -1365,6 +1415,9 @@ static void asus_remove(struct hid_device *hdev)
 	if (drvdata->quirks & QUIRK_HID_FN_LOCK)
 		cancel_work_sync(&drvdata->fn_lock_sync_work);
 
+	if (drvdata->xgm_led)
+		led_classdev_unregister(&drvdata->xgm_led->cdev);
+
 	hid_hw_stop(hdev);
 }
 
-- 
2.47.3

