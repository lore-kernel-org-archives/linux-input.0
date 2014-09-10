From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 4/4 v2] HID: wacom - enable LED support for Wireless Intuos5/Pro
Date: Wed, 10 Sep 2014 12:41:31 -0700
Message-ID: <1410378091-14584-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:37933 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbaIJTli (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Sep 2014 15:41:38 -0400
Received: by mail-pa0-f48.google.com with SMTP id hz1so10914358pad.35
        for <linux-input@vger.kernel.org>; Wed, 10 Sep 2014 12:41:37 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: killertofu@gmail.com, linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

And associate all LED/OLED to PAD device

Signed-off-by: Ping Cheng <pingc@wacom.com>
Tested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_sys.c | 52 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index f911f97..91fb3c3 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -17,6 +17,7 @@
 
 #define WAC_MSG_RETRIES		5
 
+#define WAC_CMD_WL_LED_CONTROL	0x03
 #define WAC_CMD_LED_CONTROL	0x20
 #define WAC_CMD_ICON_START	0x21
 #define WAC_CMD_ICON_XFER	0x23
@@ -490,8 +491,14 @@ static int wacom_led_control(struct wacom *wacom)
 {
 	unsigned char *buf;
 	int retval;
+	unsigned char report_id = WAC_CMD_LED_CONTROL;
+	int buf_size = 9;
 
-	buf = kzalloc(9, GFP_KERNEL);
+	if (wacom->wacom_wac.pid) { /* wireless connected */
+		report_id = WAC_CMD_WL_LED_CONTROL;
+		buf_size = 13;
+	}
+	buf = kzalloc(buf_size, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
@@ -505,9 +512,16 @@ static int wacom_led_control(struct wacom *wacom)
 		int ring_led = wacom->led.select[0] & 0x03;
 		int ring_lum = (((wacom->led.llv & 0x60) >> 5) - 1) & 0x03;
 		int crop_lum = 0;
-
-		buf[0] = WAC_CMD_LED_CONTROL;
-		buf[1] = (crop_lum << 4) | (ring_lum << 2) | (ring_led);
+		unsigned char led_bits = (crop_lum << 4) | (ring_lum << 2) | (ring_led);
+
+		buf[0] = report_id;
+		if (wacom->wacom_wac.pid) {
+			wacom_get_report(wacom->hdev, HID_FEATURE_REPORT,
+					 buf, buf_size, WAC_CMD_RETRIES);
+			buf[0] = report_id;
+			buf[4] = led_bits;
+		} else
+			buf[1] = led_bits;
 	}
 	else {
 		int led = wacom->led.select[0] | 0x4;
@@ -516,14 +530,14 @@ static int wacom_led_control(struct wacom *wacom)
 		    wacom->wacom_wac.features.type == WACOM_24HD)
 			led |= (wacom->led.select[1] << 4) | 0x40;
 
-		buf[0] = WAC_CMD_LED_CONTROL;
+		buf[0] = report_id;
 		buf[1] = led;
 		buf[2] = wacom->led.llv;
 		buf[3] = wacom->led.hlv;
 		buf[4] = wacom->led.img_lum;
 	}
 
-	retval = wacom_set_report(wacom->hdev, HID_FEATURE_REPORT, buf, 9,
+	retval = wacom_set_report(wacom->hdev, HID_FEATURE_REPORT, buf, buf_size,
 				  WAC_CMD_RETRIES);
 	kfree(buf);
 
@@ -1036,6 +1050,7 @@ static void wacom_unregister_inputs(struct wacom *wacom)
 		input_unregister_device(wacom->wacom_wac.pad_input);
 	wacom->wacom_wac.input = NULL;
 	wacom->wacom_wac.pad_input = NULL;
+	wacom_destroy_leds(wacom);
 }
 
 static int wacom_register_inputs(struct wacom *wacom)
@@ -1073,10 +1088,17 @@ static int wacom_register_inputs(struct wacom *wacom)
 		error = input_register_device(pad_input_dev);
 		if (error)
 			goto fail3;
+
+		error = wacom_initialize_leds(wacom);
+		if (error)
+			goto fail4;
 	}
 
 	return 0;
 
+fail4:
+	input_unregister_device(pad_input_dev);
+	pad_input_dev = NULL;
 fail3:
 	input_unregister_device(input_dev);
 	input_dev = NULL;
@@ -1151,6 +1173,7 @@ static void wacom_wireless_work(struct work_struct *work)
 			 wacom_wac1->features.name);
 		wacom_wac1->shared->touch_max = wacom_wac1->features.touch_max;
 		wacom_wac1->shared->type = wacom_wac1->features.type;
+		wacom_wac1->pid = wacom_wac->pid;
 		error = wacom_register_inputs(wacom1);
 		if (error)
 			goto fail;
@@ -1171,6 +1194,7 @@ static void wacom_wireless_work(struct work_struct *work)
 					 "%s (WL) Pad",wacom_wac2->features.name);
 			snprintf(wacom_wac2->pad_name, WACOM_NAME_MAX,
 				 "%s (WL) Pad", wacom_wac2->features.name);
+			wacom_wac2->pid = wacom_wac->pid;
 			error = wacom_register_inputs(wacom2);
 			if (error)
 				goto fail;
@@ -1353,21 +1377,17 @@ static int wacom_probe(struct hid_device *hdev,
 			goto fail1;
 	}
 
-	error = wacom_initialize_leds(wacom);
-	if (error)
-		goto fail2;
-
 	if (!(features->quirks & WACOM_QUIRK_MONITOR) &&
 	     (features->quirks & WACOM_QUIRK_BATTERY)) {
 		error = wacom_initialize_battery(wacom);
 		if (error)
-			goto fail3;
+			goto fail2;
 	}
 
 	if (!(features->quirks & WACOM_QUIRK_NO_INPUT)) {
 		error = wacom_register_inputs(wacom);
 		if (error)
-			goto fail4;
+			goto fail3;
 	}
 
 	if (hdev->bus == BUS_BLUETOOTH) {
@@ -1385,7 +1405,7 @@ static int wacom_probe(struct hid_device *hdev,
 	error = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
 	if (error) {
 		hid_err(hdev, "hw start failed\n");
-		goto fail5;
+		goto fail4;
 	}
 
 	if (features->quirks & WACOM_QUIRK_MONITOR)
@@ -1398,11 +1418,10 @@ static int wacom_probe(struct hid_device *hdev,
 
 	return 0;
 
- fail5:	if (hdev->bus == BUS_BLUETOOTH)
+ fail4:	if (hdev->bus == BUS_BLUETOOTH)
 		device_remove_file(&hdev->dev, &dev_attr_speed);
 	wacom_unregister_inputs(wacom);
- fail4:	wacom_destroy_battery(wacom);
- fail3:	wacom_destroy_leds(wacom);
+ fail3:	wacom_destroy_battery(wacom);
  fail2:	wacom_remove_shared_data(wacom_wac);
  fail1:	kfree(wacom);
 	hid_set_drvdata(hdev, NULL);
@@ -1420,7 +1439,6 @@ static void wacom_remove(struct hid_device *hdev)
 	if (hdev->bus == BUS_BLUETOOTH)
 		device_remove_file(&hdev->dev, &dev_attr_speed);
 	wacom_destroy_battery(wacom);
-	wacom_destroy_leds(wacom);
 	wacom_remove_shared_data(&wacom->wacom_wac);
 
 	hid_set_drvdata(hdev, NULL);
-- 
1.9.1

