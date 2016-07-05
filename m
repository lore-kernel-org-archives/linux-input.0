From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 07/27] HID: wacom: switch inputs to devres
Date: Tue,  5 Jul 2016 16:39:03 +0200
Message-ID: <1467729563-23318-8-git-send-email-benjamin.tissoires@redhat.com>
References: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Simplifying the error code paths.
We need to keep wacom_clean_inputs() around for now as the wireless
module is using it to dynamically remove the inputs on disconnect.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_sys.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 61dcb87e..da2fccf 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -91,7 +91,12 @@ static void wacom_close(struct input_dev *dev)
 {
 	struct wacom *wacom = input_get_drvdata(dev);
 
-	hid_hw_close(wacom->hdev);
+	/*
+	 * wacom->hdev should never be null, but surprisingly, I had the case
+	 * once while unplugging the Wacom Wireless Receiver.
+	 */
+	if (wacom->hdev)
+		hid_hw_close(wacom->hdev);
 }
 
 /*
@@ -1370,7 +1375,7 @@ static struct input_dev *wacom_allocate_input(struct wacom *wacom)
 	struct hid_device *hdev = wacom->hdev;
 	struct wacom_wac *wacom_wac = &(wacom->wacom_wac);
 
-	input_dev = input_allocate_device();
+	input_dev = devm_input_allocate_device(&hdev->dev);
 	if (!input_dev)
 		return NULL;
 
@@ -1424,10 +1429,10 @@ static int wacom_allocate_inputs(struct wacom *wacom)
 	wacom_wac->pen_input = wacom_allocate_input(wacom);
 	wacom_wac->touch_input = wacom_allocate_input(wacom);
 	wacom_wac->pad_input = wacom_allocate_input(wacom);
-	if (!wacom_wac->pen_input || !wacom_wac->touch_input || !wacom_wac->pad_input) {
-		wacom_clean_inputs(wacom);
+	if (!wacom_wac->pen_input ||
+	    !wacom_wac->touch_input ||
+	    !wacom_wac->pad_input)
 		return -ENOMEM;
-	}
 
 	wacom_wac->pen_input->name = wacom_wac->pen_name;
 	wacom_wac->touch_input->name = wacom_wac->touch_name;
@@ -1458,7 +1463,7 @@ static int wacom_register_inputs(struct wacom *wacom)
 	} else {
 		error = input_register_device(pen_input_dev);
 		if (error)
-			goto fail_register_pen_input;
+			goto fail;
 		wacom_wac->pen_registered = true;
 	}
 
@@ -1471,7 +1476,7 @@ static int wacom_register_inputs(struct wacom *wacom)
 	} else {
 		error = input_register_device(touch_input_dev);
 		if (error)
-			goto fail_register_touch_input;
+			goto fail;
 		wacom_wac->touch_registered = true;
 	}
 
@@ -1484,23 +1489,19 @@ static int wacom_register_inputs(struct wacom *wacom)
 	} else {
 		error = input_register_device(pad_input_dev);
 		if (error)
-			goto fail_register_pad_input;
+			goto fail;
 		wacom_wac->pad_registered = true;
 	}
 
 	return 0;
 
-fail_register_pad_input:
-	if (touch_input_dev)
-		input_unregister_device(touch_input_dev);
+fail:
+	wacom_wac->pad_input = NULL;
+	wacom_wac->pad_registered = false;
 	wacom_wac->touch_input = NULL;
 	wacom_wac->touch_registered = false;
-fail_register_touch_input:
-	if (pen_input_dev)
-		input_unregister_device(pen_input_dev);
 	wacom_wac->pen_input = NULL;
 	wacom_wac->pen_registered = false;
-fail_register_pen_input:
 	return error;
 }
 
@@ -1741,14 +1742,12 @@ fail_hw_start:
 fail_remote:
 	wacom_destroy_leds(wacom);
 fail_leds:
-	wacom_clean_inputs(wacom);
 fail_register_inputs:
 fail_battery:
 	wacom_remove_shared_data(wacom);
 fail_shared_data:
 fail_parsed:
 fail_allocate_inputs:
-	wacom_clean_inputs(wacom);
 	return error;
 }
 
@@ -1928,7 +1927,6 @@ static void wacom_remove(struct hid_device *hdev)
 	cancel_work_sync(&wacom->battery_work);
 	kobject_put(wacom->remote_dir);
 	wacom_destroy_leds(wacom);
-	wacom_clean_inputs(wacom);
 	if (hdev->bus == BUS_BLUETOOTH)
 		device_remove_file(&hdev->dev, &dev_attr_speed);
 	wacom_remove_shared_data(wacom);
-- 
2.5.5
