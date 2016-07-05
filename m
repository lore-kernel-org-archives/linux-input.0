From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 16/27] HID: wacom: rework fail path in probe() and parse_and_register()
Date: Tue,  5 Jul 2016 16:39:12 +0200
Message-ID: <1467729563-23318-17-git-send-email-benjamin.tissoires@redhat.com>
References: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Thanks to devres management, we don't need to remember a lot of failure
path. One or two is enough.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_sys.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 64acb71..241acee 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1713,7 +1713,7 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 
 	error = wacom_allocate_inputs(wacom);
 	if (error)
-		goto fail_open_group;
+		goto fail;
 
 	/*
 	 * Bamboo Pad has a generic hid handling for the Pen, and we switch it
@@ -1726,7 +1726,7 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 		} else if ((features->pktlen != WACOM_PKGLEN_BPAD_TOUCH) &&
 			   (features->pktlen != WACOM_PKGLEN_BPAD_TOUCH_USB)) {
 			error = -ENODEV;
-			goto fail_allocate_inputs;
+			goto fail;
 		}
 	}
 
@@ -1746,7 +1746,7 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 			 error ? "Ignoring" : "Assuming pen");
 
 		if (error)
-			goto fail_parsed;
+			goto fail;
 
 		features->device_type |= WACOM_DEVICETYPE_PEN;
 	}
@@ -1757,27 +1757,27 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 
 	error = wacom_add_shared_data(hdev);
 	if (error)
-		goto fail_shared_data;
+		goto fail;
 
 	if (!(features->device_type & WACOM_DEVICETYPE_WL_MONITOR) &&
 	     (features->quirks & WACOM_QUIRK_BATTERY)) {
 		error = wacom_initialize_battery(wacom);
 		if (error)
-			goto fail_battery;
+			goto fail;
 	}
 
 	error = wacom_register_inputs(wacom);
 	if (error)
-		goto fail_register_inputs;
+		goto fail;
 
 	if (wacom->wacom_wac.features.device_type & WACOM_DEVICETYPE_PAD) {
 		error = wacom_initialize_leds(wacom);
 		if (error)
-			goto fail_leds;
+			goto fail;
 
 		error = wacom_initialize_remotes(wacom);
 		if (error)
-			goto fail_remote;
+			goto fail;
 	}
 
 	if (features->type == HID_GENERIC)
@@ -1787,7 +1787,7 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 	error = hid_hw_start(hdev, connect_mask);
 	if (error) {
 		hid_err(hdev, "hw start failed\n");
-		goto fail_hw_start;
+		goto fail;
 	}
 
 	if (!wireless) {
@@ -1826,15 +1826,7 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 
 fail_quirks:
 	hid_hw_stop(hdev);
-fail_hw_start:
-fail_remote:
-fail_leds:
-fail_register_inputs:
-fail_battery:
-fail_shared_data:
-fail_parsed:
-fail_allocate_inputs:
-fail_open_group:
+fail:
 	wacom_release_resources(wacom);
 	return error;
 }
@@ -2014,7 +2006,7 @@ static int wacom_probe(struct hid_device *hdev,
 
 	if (features->check_for_hid_type && features->hid_type != hdev->type) {
 		error = -ENODEV;
-		goto fail_type;
+		goto fail;
 	}
 
 	wacom_wac->hid_data.inputmode = -1;
@@ -2031,12 +2023,12 @@ static int wacom_probe(struct hid_device *hdev,
 	error = hid_parse(hdev);
 	if (error) {
 		hid_err(hdev, "parse failed\n");
-		goto fail_parse;
+		goto fail;
 	}
 
 	error = wacom_parse_and_register(wacom, false);
 	if (error)
-		goto fail_parse;
+		goto fail;
 
 	if (hdev->bus == BUS_BLUETOOTH) {
 		error = device_create_file(&hdev->dev, &dev_attr_speed);
@@ -2048,8 +2040,7 @@ static int wacom_probe(struct hid_device *hdev,
 
 	return 0;
 
-fail_parse:
-fail_type:
+fail:
 	hid_set_drvdata(hdev, NULL);
 	return error;
 }
-- 
2.5.5
