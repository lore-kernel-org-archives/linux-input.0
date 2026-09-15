Received: from mta0.migadu.com (out-67.mta0.migadu.com [91.218.175.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040434BE450
	for <linux-input@vger.kernel.org>; Tue, 15 Sep 2026 18:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789495945; cv=none; b=j7gXMPQOA5d1zpvHpudYykZPkNBabQMiCej8pzQv09Zhy9+mP0aubCupOPTIwvOUBe6h8qNVtg5bk62HFKFrAvZhbgnqmeklPTDLABTp7AbU8UOHWW2no/ETTusD83Q5hJTW0sWyERViE+UWZHef489RkJZkUDCqAIl+py8BYoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789495945; c=relaxed/simple;
	bh=mWSonoI8Rf6kLGtR+hZdBol7nOHVUi5oG8LK3DaGXl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ttUPFjYLMmyyd2vFFcmmzx/4N9xG2Y8boD/Q1lzB4tCsAQgiBHg06NepWWYsNi8T9w1VDPV0nQWuZ7RIUeaac1dBOnlul0rqWEqDjeAXZ2DlqxAHaS5P+bQKujLthoRR9qouYmfsfa9SGfKWMtz7zB0kjBUKOsHKmrDAgrHZ8/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NyFVnitE; arc=none smtp.client-ip=91.218.175.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NyFVnitE"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mWSonoI8Rf6kLGtR+hZdBol7nOHVUi5oG8LK3DaGXl4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789495940; v=1; x=1790100740;
 b=NyFVnitEIgFYzpY04Pn3i2mvuDpaW3qXFJ/vdi4uymMhvCND7dA9BozLKVw2wdnMyNOhD2qW
 kW4L2F6Fl1rhT8vLd4bNiYCcu4io1xWwVM8POquHqmlLhcxB7m0KDR7DXLiiiw2Gfq3d1oX2WwX
 Ue5Jx422uvxv3RoDcOUj7bDw=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 58d4f4e72a68db37;
	Tue, 15 Sep 2026 18:12:20 +0000
X-Mizu-Trace-ID: 58d4f4e72a68db37
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	Denis Benato <denis.benato@linux.dev>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH 3/3] HID: asus: add support for xgm led
Date: Tue, 15 Sep 2026 18:12:00 +0000
Message-ID: <20260915181200.18086-4-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915181200.18086-1-denis.benato@linux.dev>
References: <20260915181200.18086-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XG mobile stations have very bright leds behind the fan that can be
turned either ON or OFF: add a cled interface to allow controlling the
brightness of those red leds.

Let the led core manage the power transitions: the classdev is flagged
with LED_CORE_SUSPENDRESUME, so it is switched off at suspend and its
last brightness is restored at resume. The EC drives its own blinking
pattern during s2idle anyway, so the led state while the machine is
asleep is not meaningful.

Cc: Antheas Kapenekakis <lkml@antheas.dev>
Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/hid-asus.c | 84 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 03150d29eec5..a427e272563d 100644
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
@@ -144,6 +146,11 @@ struct asus_worker {
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
@@ -170,6 +177,7 @@ struct asus_drvdata {
 	unsigned long battery_next_query;
 	struct asus_hid_listener listener;
 	bool fn_lock;
+	struct asus_xgm_led *xgm_led;
 };
 
 static int asus_report_battery(struct asus_drvdata *, u8 *, int);
@@ -1161,6 +1169,26 @@ static int asus_battery_probe(struct hid_device *hdev)
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
@@ -1406,6 +1434,49 @@ static void asus_initialize_reports(struct hid_device *hdev)
 	}
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
+	drvdata->xgm_led->cdev.flags = LED_CORE_SUSPENDRESUME;
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
@@ -1545,6 +1616,16 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (!drvdata->tp)
 		asus_initialize_reports(hdev);
 
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
@@ -1594,6 +1675,9 @@ static void asus_remove(struct hid_device *hdev)
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

