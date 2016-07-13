From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 04/30] HID: wacom: untie leds from inputs
Date: Wed, 13 Jul 2016 18:05:51 +0200
Message-ID: <1468425977-4819-5-git-send-email-benjamin.tissoires@redhat.com>
References: <1468425977-4819-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1468425977-4819-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Like remotes, LEDs should be handled by themself, not magically behind
the inputs as they have a complete different life.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

No changes in v2
---
 drivers/hid/wacom_sys.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 5dd2640..af2801d 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1403,7 +1403,6 @@ static void wacom_clean_inputs(struct wacom *wacom)
 	wacom->wacom_wac.pen_registered = false;
 	wacom->wacom_wac.touch_registered = false;
 	wacom->wacom_wac.pad_registered = false;
-	wacom_destroy_leds(wacom);
 }
 
 static int wacom_allocate_inputs(struct wacom *wacom)
@@ -1475,18 +1474,10 @@ static int wacom_register_inputs(struct wacom *wacom)
 		if (error)
 			goto fail_register_pad_input;
 		wacom_wac->pad_registered = true;
-
-		error = wacom_initialize_leds(wacom);
-		if (error)
-			goto fail_leds;
 	}
 
 	return 0;
 
-fail_leds:
-	input_unregister_device(pad_input_dev);
-	pad_input_dev = NULL;
-	wacom_wac->pad_registered = false;
 fail_register_pad_input:
 	if (touch_input_dev)
 		input_unregister_device(touch_input_dev);
@@ -1680,6 +1671,10 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 		goto fail_register_inputs;
 
 	if (wacom->wacom_wac.features.device_type & WACOM_DEVICETYPE_PAD) {
+		error = wacom_initialize_leds(wacom);
+		if (error)
+			goto fail_leds;
+
 		error = wacom_initialize_remote(wacom);
 		if (error)
 			goto fail_remote;
@@ -1732,6 +1727,8 @@ fail_quirks:
 fail_hw_start:
 	kobject_put(wacom->remote_dir);
 fail_remote:
+	wacom_destroy_leds(wacom);
+fail_leds:
 	wacom_clean_inputs(wacom);
 fail_register_inputs:
 	wacom_destroy_battery(wacom);
@@ -1765,12 +1762,14 @@ static void wacom_wireless_work(struct work_struct *work)
 	hdev1 = usb_get_intfdata(usbdev->config->interface[1]);
 	wacom1 = hid_get_drvdata(hdev1);
 	wacom_wac1 = &(wacom1->wacom_wac);
+	wacom_destroy_leds(wacom1);
 	wacom_clean_inputs(wacom1);
 
 	/* Touch interface */
 	hdev2 = usb_get_intfdata(usbdev->config->interface[2]);
 	wacom2 = hid_get_drvdata(hdev2);
 	wacom_wac2 = &(wacom2->wacom_wac);
+	wacom_destroy_leds(wacom2);
 	wacom_clean_inputs(wacom2);
 
 	if (wacom_wac->pid == 0) {
@@ -1825,7 +1824,9 @@ static void wacom_wireless_work(struct work_struct *work)
 	return;
 
 fail:
+	wacom_destroy_leds(wacom1);
 	wacom_clean_inputs(wacom1);
+	wacom_destroy_leds(wacom2);
 	wacom_clean_inputs(wacom2);
 	return;
 }
@@ -1913,6 +1914,7 @@ static void wacom_remove(struct hid_device *hdev)
 
 	cancel_work_sync(&wacom->work);
 	kobject_put(wacom->remote_dir);
+	wacom_destroy_leds(wacom);
 	wacom_clean_inputs(wacom);
 	if (hdev->bus == BUS_BLUETOOTH)
 		device_remove_file(&hdev->dev, &dev_attr_speed);
-- 
2.5.5
