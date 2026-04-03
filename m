Received: from mx5.mail-out.lima-city.de (mx5.mail-out.lima-city.de [91.216.248.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7A21B4223
	for <linux-input@vger.kernel.org>; Fri,  3 Apr 2026 13:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.248.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775222090; cv=none; b=a2ZQicc173uIcdOfN6rzzqRh+7SgSewWxHaXHN7PAqy6zAuLNHqhrL9hHiDH80MXeBoW0A0pIqFLXmC14GbO6UXD3w7SYRm/18UERltTTfnpJcdsDUvuMUWbGE++gpbH1UxndePqklhKBuKFWg7WXwvFcfexO4REkYHqvCJ5pLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775222090; c=relaxed/simple;
	bh=OdqK73G+iT0SRYUFpl7l1nyz3ddaGPJzQKOl2baT+ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5alxavcdy7uSkNXv70jEMVunbU0LwEPsQdC4/qSJ4Ef7sB0+RnLFQdVGvsZgWAwr+rIrIzRnGtCbj333mvywOt1d5nm5KO7N/sB9C7LiEX4A89IPxnEfmJ7rNjv5GwTeA69/PoJZc1Tr+it9NhgcLjru+G8dlcm159WgcoW/8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=negmaster.com; spf=none smtp.mailfrom=negmaster.com; dkim=pass (2048-bit key) header.d=negmaster.com header.i=@negmaster.com header.b=V2WESrg7; arc=none smtp.client-ip=91.216.248.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=negmaster.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=negmaster.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=negmaster.com header.i=@negmaster.com header.b="V2WESrg7"
From: deqrocks <andre@negmaster.com>
X-Lima-ML-UUID: 4a6c06ec-b381-455b-878e-88e07d5ab6f6
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=negmaster.com;
	s=securedbylima-20200315; t=1775221713;
	bh=OdqK73G+iT0SRYUFpl7l1nyz3ddaGPJzQKOl2baT+ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V2WESrg7Ictu8bGe4g94kpu1K4viTdGTW/moGmYjRkUBBueOCYV/7F7txK2gqDAXW
	 Miyj9FGpkktPvZW1Ld1A9qP2KiDdiO083N/+89pc57Hwxt7/g/kHRK1VHM31K7NyB+
	 0D10fXdpOUbhktmFZjFUCZ/YDek/0HeMM9uIwkI8dHGJcv1xTkxn9ZedUb6YfgrmxB
	 1e7fny2kwGMj/ujlfLdR/amA79VY7utHPA3DnWbOYItBQHxE5TTDb7wl0hLnRcphJH
	 VwGYqB67Onj8/dv79R8wqQ18x6TqyTUF1HtizNsWM667IV8YeYpNXf1oZMSgZtL7G4
	 14Ch47dVdTndA==
To: jikos@kernel.org,
	benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org
Subject: [PATCH 3/3] Add Touch Bar and backlight reprobe support
Date: Fri,  3 Apr 2026 15:06:20 +0200
Message-ID: <20260403130620.91999-4-andre@negmaster.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403130620.91999-1-andre@negmaster.com>
References: <20260403130620.91999-1-andre@negmaster.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop stale device state across suspend and let the Touch Bar\nrelated drivers tear down and reinitialize through reprobe after\nresume.

Signed-off-by: deqrocks <andre@negmaster.com>
---
 hid-apple.c       |  50 +++++++++++++++++++--
 hid-appletb-bl.c  |  44 ++++++++++++++++++-
 hid-appletb-kbd.c | 109 ++++++++++++++++++++++++++++++++++++----------
 3 files changed, 174 insertions(+), 29 deletions(-)

diff --git a/hid-apple.c b/hid-apple.c
index c620890..dc9d244 100644
--- a/hid-apple.c
+++ b/hid-apple.c
@@ -114,6 +114,15 @@ struct apple_magic_backlight {
 	u16 saved_brightness;
 };
 
+static u16 apple_saved_kbd_backlight_brightness;
+
+static u16 apple_initial_kbd_backlight_brightness(u16 max_brightness)
+{
+	if (apple_saved_kbd_backlight_brightness)
+		return apple_saved_kbd_backlight_brightness;
+	return max_t(u16, max_brightness / 2, 1);
+}
+
 struct apple_sc {
 	struct hid_device *hdev;
 	unsigned long quirks;
@@ -123,6 +132,7 @@ struct apple_sc {
 	struct timer_list battery_timer;
 	struct apple_sc_backlight *backlight;
 	struct apple_magic_backlight *magic_backlight;
+	bool suspend_preparing_remove;
 };
 
 struct apple_key_translation {
@@ -833,8 +843,10 @@ static int apple_backlight_led_set(struct led_classdev *led_cdev,
 	int ret;
 
 	ret = apple_backlight_set(backlight->hdev, brightness, 0);
-	if (!ret)
+	if (!ret) {
 		backlight->current_brightness = brightness;
+		apple_saved_kbd_backlight_brightness = brightness;
+	}
 	return ret;
 }
 
@@ -878,12 +890,19 @@ static int apple_backlight_init(struct hid_device *hdev)
 	asc->backlight->cdev.brightness_set_blocking = apple_backlight_led_set;
 	asc->backlight->current_brightness = 0;
 	asc->backlight->saved_brightness = 0;
+	asc->backlight->cdev.brightness = 0;
+
+	asc->backlight->cdev.brightness =
+		apple_initial_kbd_backlight_brightness(rep->backlight_on_max);
 
-	ret = apple_backlight_set(hdev, 0, 0);
+	ret = apple_backlight_set(hdev, asc->backlight->cdev.brightness, 0);
 	if (ret < 0) {
 		hid_err(hdev, "backlight set request failed: %d\n", ret);
 		goto cleanup_and_exit;
 	}
+	asc->backlight->current_brightness = asc->backlight->cdev.brightness;
+	asc->backlight->saved_brightness = asc->backlight->current_brightness;
+	apple_saved_kbd_backlight_brightness = asc->backlight->current_brightness;
 
 	ret = devm_led_classdev_register(&hdev->dev, &asc->backlight->cdev);
 
@@ -917,6 +936,7 @@ static int apple_magic_backlight_led_set(struct led_classdev *led_cdev,
 
 	apple_magic_backlight_set(backlight, brightness, 1);
 	backlight->current_brightness = brightness;
+	apple_saved_kbd_backlight_brightness = brightness;
 	return 0;
 }
 
@@ -950,9 +970,16 @@ static int apple_magic_backlight_init(struct hid_device *hdev)
 	backlight->cdev.brightness_set_blocking = apple_magic_backlight_led_set;
 	backlight->current_brightness = 0;
 	backlight->saved_brightness = 0;
+	backlight->cdev.brightness = 0;
 	asc->magic_backlight = backlight;
 
-	apple_magic_backlight_set(backlight, 0, 0);
+	backlight->cdev.brightness =
+		apple_initial_kbd_backlight_brightness(backlight->cdev.max_brightness);
+	backlight->current_brightness = backlight->cdev.brightness;
+	backlight->saved_brightness = backlight->current_brightness;
+	apple_saved_kbd_backlight_brightness = backlight->current_brightness;
+
+	apple_magic_backlight_set(backlight, backlight->current_brightness, 0);
 
 	return devm_led_classdev_register(&hdev->dev, &backlight->cdev);
 
@@ -1028,6 +1055,17 @@ static void apple_remove(struct hid_device *hdev)
 	if (asc->quirks & APPLE_RDESC_BATTERY)
 		timer_delete_sync(&asc->battery_timer);
 
+	/* Only tear down LEDs on suspend-driven remove. */
+	if (asc->suspend_preparing_remove && asc->backlight) {
+		devm_led_classdev_unregister(&hdev->dev, &asc->backlight->cdev);
+		asc->backlight = NULL;
+	}
+
+	if (asc->suspend_preparing_remove && asc->magic_backlight) {
+		devm_led_classdev_unregister(&hdev->dev, &asc->magic_backlight->cdev);
+		asc->magic_backlight = NULL;
+	}
+
 	hid_hw_stop(hdev);
 }
 
@@ -1036,14 +1074,18 @@ static int apple_suspend(struct hid_device *hdev, pm_message_t msg)
 {
 	struct apple_sc *asc = hid_get_drvdata(hdev);
 
+	asc->suspend_preparing_remove = true;
+
 	if (asc->backlight) {
 		asc->backlight->saved_brightness = asc->backlight->current_brightness;
+		apple_saved_kbd_backlight_brightness = asc->backlight->current_brightness;
 		apple_backlight_set(hdev, 0, 0);
 		asc->backlight->current_brightness = 0;
 	}
 
 	if (asc->magic_backlight) {
 		asc->magic_backlight->saved_brightness = asc->magic_backlight->current_brightness;
+		apple_saved_kbd_backlight_brightness = asc->magic_backlight->current_brightness;
 		apple_magic_backlight_set(asc->magic_backlight, 0, 0);
 		asc->magic_backlight->current_brightness = 0;
 	}
@@ -1056,6 +1098,8 @@ static int apple_resume(struct hid_device *hdev)
 	struct apple_sc *asc = hid_get_drvdata(hdev);
 	int ret = 0;
 
+	asc->suspend_preparing_remove = false;
+
 	if (asc->backlight && asc->backlight->saved_brightness) {
 		ret = apple_backlight_set(hdev, asc->backlight->saved_brightness, 0);
 		if (!ret)
diff --git a/hid-appletb-bl.c b/hid-appletb-bl.c
index bad2aea..5fc5a00 100644
--- a/hid-appletb-bl.c
+++ b/hid-appletb-bl.c
@@ -36,6 +36,7 @@ struct appletb_bl {
 	struct backlight_device *bdev;
 
 	bool full_on;
+	bool suspend_preparing_remove;
 };
 
 static const u8 appletb_bl_brightness_map[] = {
@@ -44,6 +45,15 @@ static const u8 appletb_bl_brightness_map[] = {
 	APPLETB_BL_ON,
 };
 
+static int appletb_bl_default_brightness_index(void)
+{
+	if (appletb_bl_def_brightness < 0)
+		return 0;
+	if (appletb_bl_def_brightness >= ARRAY_SIZE(appletb_bl_brightness_map))
+		return ARRAY_SIZE(appletb_bl_brightness_map) - 1;
+	return appletb_bl_def_brightness;
+}
+
 static int appletb_bl_set_brightness(struct appletb_bl *bl, u8 brightness)
 {
 	struct hid_report *report = bl->brightness_field->report;
@@ -142,7 +152,7 @@ static int appletb_bl_probe(struct hid_device *hdev, const struct hid_device_id
 	bl->brightness_field = brightness_field;
 
 	ret = appletb_bl_set_brightness(bl,
-		appletb_bl_brightness_map[(appletb_bl_def_brightness > 2) ? 2 : appletb_bl_def_brightness]);
+		appletb_bl_brightness_map[appletb_bl_default_brightness_index()]);
 
 	if (ret) {
 		dev_err_probe(dev, ret, "Failed to set default touch bar brightness to %d\n",
@@ -177,12 +187,39 @@ static void appletb_bl_remove(struct hid_device *hdev)
 {
 	struct appletb_bl *bl = hid_get_drvdata(hdev);
 
-	appletb_bl_set_brightness(bl, APPLETB_BL_OFF);
+	/* Only tear down the backlight on suspend-driven remove. */
+	if (bl && bl->suspend_preparing_remove)
+		appletb_bl_set_brightness(bl, APPLETB_BL_OFF);
+
+	if (bl && bl->suspend_preparing_remove && bl->bdev) {
+		devm_backlight_device_unregister(&hdev->dev, bl->bdev);
+		bl->bdev = NULL;
+	}
 
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
 }
 
+static int appletb_bl_suspend(struct hid_device *hdev, pm_message_t msg)
+{
+	struct appletb_bl *bl = hid_get_drvdata(hdev);
+
+	if (bl)
+		bl->suspend_preparing_remove = true;
+
+	return 0;
+}
+
+static int appletb_bl_resume(struct hid_device *hdev)
+{
+	struct appletb_bl *bl = hid_get_drvdata(hdev);
+
+	if (bl)
+		bl->suspend_preparing_remove = false;
+
+	return 0;
+}
+
 static const struct hid_device_id appletb_bl_hid_ids[] = {
 	/* MacBook Pro's 2018, 2019, with T2 chip: iBridge DFR Brightness */
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_TOUCHBAR_BACKLIGHT) },
@@ -195,6 +232,9 @@ static struct hid_driver appletb_bl_hid_driver = {
 	.id_table = appletb_bl_hid_ids,
 	.probe = appletb_bl_probe,
 	.remove = appletb_bl_remove,
+	.suspend = pm_ptr(appletb_bl_suspend),
+	.resume = pm_ptr(appletb_bl_resume),
+	.reset_resume = pm_ptr(appletb_bl_resume),
 };
 module_hid_driver(appletb_bl_hid_driver);
 
diff --git a/hid-appletb-kbd.c b/hid-appletb-kbd.c
index 0fdc096..63238ab 100644
--- a/hid-appletb-kbd.c
+++ b/hid-appletb-kbd.c
@@ -65,10 +65,25 @@ struct appletb_kbd {
 	struct timer_list inactivity_timer;
 	bool has_dimmed;
 	bool has_turned_off;
+	bool suspend_preparing_remove;
+	bool fn_down;
+	unsigned long last_mode_jiffies;
 	u8 saved_mode;
 	u8 current_mode;
 };
 
+#define APPLETB_MODE_SUBMIT_INTERVAL_MS 50
+
+static void appletb_kbd_reset_state(struct appletb_kbd *kbd)
+{
+	kbd->saved_mode = APPLETB_KBD_MODE_OFF;
+	kbd->current_mode = APPLETB_KBD_MODE_OFF;
+	kbd->has_dimmed = false;
+	kbd->has_turned_off = false;
+	kbd->fn_down = false;
+	kbd->last_mode_jiffies = 0;
+}
+
 static const struct key_entry appletb_kbd_keymap[] = {
 	{ KE_KEY, KEY_ESC, { KEY_ESC } },
 	{ KE_KEY, KEY_F1,  { KEY_BRIGHTNESSDOWN } },
@@ -92,6 +107,18 @@ static int appletb_kbd_set_mode(struct appletb_kbd *kbd, u8 mode)
 	struct hid_device *hdev = report->device;
 	int ret;
 
+	if (kbd->suspend_preparing_remove && mode != APPLETB_KBD_MODE_OFF)
+		return -EBUSY;
+
+	if (kbd->current_mode == mode)
+		return 0;
+
+	if (kbd->last_mode_jiffies &&
+	    time_before(jiffies, kbd->last_mode_jiffies +
+				msecs_to_jiffies(APPLETB_MODE_SUBMIT_INTERVAL_MS))) {
+		return -EAGAIN;
+	}
+
 	ret = hid_hw_power(hdev, PM_HINT_FULLON);
 	if (ret) {
 		hid_err(hdev, "Device didn't resume (%pe)\n", ERR_PTR(ret));
@@ -105,8 +132,8 @@ static int appletb_kbd_set_mode(struct appletb_kbd *kbd, u8 mode)
 	}
 
 	hid_hw_request(hdev, report, HID_REQ_SET_REPORT);
-
 	kbd->current_mode = mode;
+	kbd->last_mode_jiffies = jiffies;
 
 power_normal:
 	hid_hw_power(hdev, PM_HINT_NORMAL);
@@ -114,6 +141,22 @@ power_normal:
 	return ret;
 }
 
+static void appletb_kbd_teardown(struct hid_device *hdev, struct appletb_kbd *kbd,
+				 bool send_mode_off)
+{
+	if (send_mode_off)
+		appletb_kbd_set_mode(kbd, APPLETB_KBD_MODE_OFF);
+
+	input_unregister_handler(&kbd->inp_handler);
+	if (kbd->backlight_dev) {
+		put_device(&kbd->backlight_dev->dev);
+		kbd->backlight_dev = NULL;
+		timer_delete_sync(&kbd->inactivity_timer);
+	}
+
+	appletb_kbd_reset_state(kbd);
+}
+
 static ssize_t mode_show(struct device *dev,
 			 struct device_attribute *attr, char *buf)
 {
@@ -238,18 +281,35 @@ static void appletb_kbd_inp_event(struct input_handle *handle, unsigned int type
 
 	reset_inactivity_timer(kbd);
 
-	if (type == EV_KEY && code == KEY_FN && appletb_tb_fn_toggle &&
-		(kbd->current_mode == APPLETB_KBD_MODE_SPCL ||
-		 kbd->current_mode == APPLETB_KBD_MODE_FN)) {
-		if (value == 1) {
-			kbd->saved_mode = kbd->current_mode;
-			appletb_kbd_set_mode(kbd, kbd->current_mode == APPLETB_KBD_MODE_SPCL
-						? APPLETB_KBD_MODE_FN : APPLETB_KBD_MODE_SPCL);
-		} else if (value == 0) {
-			if (kbd->saved_mode != kbd->current_mode)
-				appletb_kbd_set_mode(kbd, kbd->saved_mode);
-		}
+	if (type != EV_KEY || code != KEY_FN || !appletb_tb_fn_toggle)
+		return;
+
+	if (kbd->current_mode != APPLETB_KBD_MODE_SPCL &&
+	    kbd->current_mode != APPLETB_KBD_MODE_FN)
+		return;
+
+	if (value == 2)
+		return;
+
+	if (value == 1) {
+		if (kbd->fn_down)
+			return;
+
+		kbd->fn_down = true;
+		kbd->saved_mode = kbd->current_mode;
+		appletb_kbd_set_mode(kbd,
+				     kbd->current_mode == APPLETB_KBD_MODE_SPCL
+				     ? APPLETB_KBD_MODE_FN
+				     : APPLETB_KBD_MODE_SPCL);
+		return;
 	}
+
+	if (value != 0 || !kbd->fn_down)
+		return;
+
+	kbd->fn_down = false;
+	if (kbd->saved_mode != kbd->current_mode)
+		appletb_kbd_set_mode(kbd, kbd->saved_mode);
 }
 
 static int appletb_kbd_inp_connect(struct input_handler *handler,
@@ -392,6 +452,8 @@ static int appletb_kbd_probe(struct hid_device *hdev, const struct hid_device_id
 		return -ENOMEM;
 
 	kbd->mode_field = mode_field;
+	kbd->suspend_preparing_remove = false;
+	appletb_kbd_reset_state(kbd);
 
 	ret = hid_hw_start(hdev, HID_CONNECT_HIDINPUT);
 	if (ret)
@@ -405,7 +467,9 @@ static int appletb_kbd_probe(struct hid_device *hdev, const struct hid_device_id
 
 	kbd->backlight_dev = backlight_device_get_by_name("appletb_backlight");
 	if (!kbd->backlight_dev) {
-		dev_err_probe(dev, -ENODEV, "Failed to get backlight device\n");
+		ret = dev_err_probe(dev, -EPROBE_DEFER,
+				    "Backlight device not ready, deferring probe\n");
+		goto close_hw;
 	} else {
 		backlight_device_set_brightness(kbd->backlight_dev, 2);
 		timer_setup(&kbd->inactivity_timer, appletb_inactivity_timer, 0);
@@ -453,14 +517,14 @@ stop_hw:
 static void appletb_kbd_remove(struct hid_device *hdev)
 {
 	struct appletb_kbd *kbd = hid_get_drvdata(hdev);
+	bool send_mode_off = false;
 
-	appletb_kbd_set_mode(kbd, APPLETB_KBD_MODE_OFF);
+	/* Only force MODE_OFF on suspend-driven remove. */
+	if (kbd)
+		send_mode_off = kbd->suspend_preparing_remove &&
+				kbd->current_mode != APPLETB_KBD_MODE_OFF;
 
-	input_unregister_handler(&kbd->inp_handler);
-	if (kbd->backlight_dev) {
-		put_device(&kbd->backlight_dev->dev);
-		timer_delete_sync(&kbd->inactivity_timer);
-	}
+	appletb_kbd_teardown(hdev, kbd, send_mode_off);
 
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
@@ -470,9 +534,7 @@ static int appletb_kbd_suspend(struct hid_device *hdev, pm_message_t msg)
 {
 	struct appletb_kbd *kbd = hid_get_drvdata(hdev);
 
-	kbd->saved_mode = kbd->current_mode;
-	appletb_kbd_set_mode(kbd, APPLETB_KBD_MODE_OFF);
-
+	kbd->suspend_preparing_remove = true;
 	return 0;
 }
 
@@ -480,8 +542,7 @@ static int appletb_kbd_resume(struct hid_device *hdev)
 {
 	struct appletb_kbd *kbd = hid_get_drvdata(hdev);
 
-	appletb_kbd_set_mode(kbd, kbd->saved_mode);
-
+	kbd->suspend_preparing_remove = false;
 	return 0;
 }
 
-- 
2.53.0

