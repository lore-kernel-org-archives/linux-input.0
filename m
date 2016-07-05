From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 03/27] HID: wacom: remove cleanup of wacom->remote_dir from wacom_clean_inputs()
Date: Tue,  5 Jul 2016 16:38:59 +0200
Message-ID: <1467729563-23318-4-git-send-email-benjamin.tissoires@redhat.com>
References: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

wacom->remote_dir has nothing to do with inputs, so better not magically
removing it when cleaning inputs.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_sys.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 9e283aa..5dd2640 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1397,7 +1397,6 @@ static void wacom_clean_inputs(struct wacom *wacom)
 		else
 			input_free_device(wacom->wacom_wac.pad_input);
 	}
-	kobject_put(wacom->remote_dir);
 	wacom->wacom_wac.pen_input = NULL;
 	wacom->wacom_wac.touch_input = NULL;
 	wacom->wacom_wac.pad_input = NULL;
@@ -1480,16 +1479,10 @@ static int wacom_register_inputs(struct wacom *wacom)
 		error = wacom_initialize_leds(wacom);
 		if (error)
 			goto fail_leds;
-
-		error = wacom_initialize_remote(wacom);
-		if (error)
-			goto fail_remote;
 	}
 
 	return 0;
 
-fail_remote:
-	wacom_destroy_leds(wacom);
 fail_leds:
 	input_unregister_device(pad_input_dev);
 	pad_input_dev = NULL;
@@ -1686,6 +1679,12 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 	if (error)
 		goto fail_register_inputs;
 
+	if (wacom->wacom_wac.features.device_type & WACOM_DEVICETYPE_PAD) {
+		error = wacom_initialize_remote(wacom);
+		if (error)
+			goto fail_remote;
+	}
+
 	if (features->type == HID_GENERIC)
 		connect_mask |= HID_CONNECT_DRIVER;
 
@@ -1705,7 +1704,7 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 	if ((features->type == BAMBOO_TOUCH) &&
 	    (features->device_type & WACOM_DEVICETYPE_PEN)) {
 		error = -ENODEV;
-		goto fail_hw_start;
+		goto fail_quirks;
 	}
 
 	/* pen only Bamboo neither support touch nor pad */
@@ -1713,7 +1712,7 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 	    ((features->device_type & WACOM_DEVICETYPE_TOUCH) ||
 	    (features->device_type & WACOM_DEVICETYPE_PAD))) {
 		error = -ENODEV;
-		goto fail_hw_start;
+		goto fail_quirks;
 	}
 
 	if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR)
@@ -1728,10 +1727,13 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 
 	return 0;
 
-fail_hw_start:
+fail_quirks:
 	hid_hw_stop(hdev);
-fail_register_inputs:
+fail_hw_start:
+	kobject_put(wacom->remote_dir);
+fail_remote:
 	wacom_clean_inputs(wacom);
+fail_register_inputs:
 	wacom_destroy_battery(wacom);
 fail_battery:
 	wacom_remove_shared_data(wacom);
@@ -1910,6 +1912,7 @@ static void wacom_remove(struct hid_device *hdev)
 	hid_hw_stop(hdev);
 
 	cancel_work_sync(&wacom->work);
+	kobject_put(wacom->remote_dir);
 	wacom_clean_inputs(wacom);
 	if (hdev->bus == BUS_BLUETOOTH)
 		device_remove_file(&hdev->dev, &dev_attr_speed);
-- 
2.5.5
