From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 08/27] HID: wacom: put the managed resources in a group
Date: Tue,  5 Jul 2016 16:39:04 +0200
Message-ID: <1467729563-23318-9-git-send-email-benjamin.tissoires@redhat.com>
References: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44020 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933002AbcGEOjt (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 5 Jul 2016 10:39:49 -0400
In-Reply-To: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

We currently have a complex clean_inputs() function while this can be
handled all by devres. Set a group that we can destroy in wireless_work().

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom.h     |  1 +
 drivers/hid/wacom_sys.c | 69 +++++++++++++++++++++----------------------------
 drivers/hid/wacom_wac.c |  2 +-
 drivers/hid/wacom_wac.h |  3 ---
 4 files changed, 32 insertions(+), 43 deletions(-)

diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index a968fbb..6f5555f 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -131,6 +131,7 @@ struct wacom {
 	struct power_supply_desc ac_desc;
 	struct kobject *remote_dir;
 	struct attribute_group remote_group[5];
+	bool resources;
 };
 
 static inline void wacom_schedule_work(struct wacom_wac *wacom_wac,
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index da2fccf..08f6d1f 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1394,34 +1394,6 @@ static struct input_dev *wacom_allocate_input(struct wacom *wacom)
 	return input_dev;
 }
 
-static void wacom_clean_inputs(struct wacom *wacom)
-{
-	if (wacom->wacom_wac.pen_input) {
-		if (wacom->wacom_wac.pen_registered)
-			input_unregister_device(wacom->wacom_wac.pen_input);
-		else
-			input_free_device(wacom->wacom_wac.pen_input);
-	}
-	if (wacom->wacom_wac.touch_input) {
-		if (wacom->wacom_wac.touch_registered)
-			input_unregister_device(wacom->wacom_wac.touch_input);
-		else
-			input_free_device(wacom->wacom_wac.touch_input);
-	}
-	if (wacom->wacom_wac.pad_input) {
-		if (wacom->wacom_wac.pad_registered)
-			input_unregister_device(wacom->wacom_wac.pad_input);
-		else
-			input_free_device(wacom->wacom_wac.pad_input);
-	}
-	wacom->wacom_wac.pen_input = NULL;
-	wacom->wacom_wac.touch_input = NULL;
-	wacom->wacom_wac.pad_input = NULL;
-	wacom->wacom_wac.pen_registered = false;
-	wacom->wacom_wac.touch_registered = false;
-	wacom->wacom_wac.pad_registered = false;
-}
-
 static int wacom_allocate_inputs(struct wacom *wacom)
 {
 	struct wacom_wac *wacom_wac = &(wacom->wacom_wac);
@@ -1464,7 +1436,6 @@ static int wacom_register_inputs(struct wacom *wacom)
 		error = input_register_device(pen_input_dev);
 		if (error)
 			goto fail;
-		wacom_wac->pen_registered = true;
 	}
 
 	error = wacom_setup_touch_input_capabilities(touch_input_dev, wacom_wac);
@@ -1477,7 +1448,6 @@ static int wacom_register_inputs(struct wacom *wacom)
 		error = input_register_device(touch_input_dev);
 		if (error)
 			goto fail;
-		wacom_wac->touch_registered = true;
 	}
 
 	error = wacom_setup_pad_input_capabilities(pad_input_dev, wacom_wac);
@@ -1490,18 +1460,14 @@ static int wacom_register_inputs(struct wacom *wacom)
 		error = input_register_device(pad_input_dev);
 		if (error)
 			goto fail;
-		wacom_wac->pad_registered = true;
 	}
 
 	return 0;
 
 fail:
 	wacom_wac->pad_input = NULL;
-	wacom_wac->pad_registered = false;
 	wacom_wac->touch_input = NULL;
-	wacom_wac->touch_registered = false;
 	wacom_wac->pen_input = NULL;
-	wacom_wac->pen_registered = false;
 	return error;
 }
 
@@ -1612,6 +1578,22 @@ static void wacom_update_name(struct wacom *wacom, const char *suffix)
 		"%s%s Pad", name, suffix);
 }
 
+static void wacom_release_resources(struct wacom *wacom)
+{
+	struct hid_device *hdev = wacom->hdev;
+
+	if (!wacom->resources)
+		return;
+
+	devres_release_group(&hdev->dev, wacom);
+
+	wacom->resources = false;
+
+	wacom->wacom_wac.pen_input = NULL;
+	wacom->wacom_wac.touch_input = NULL;
+	wacom->wacom_wac.pad_input = NULL;
+}
+
 static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 {
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
@@ -1624,9 +1606,14 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 	if (features->pktlen > WACOM_PKGLEN_MAX)
 		return -EINVAL;
 
+	if (!devres_open_group(&hdev->dev, wacom, GFP_KERNEL))
+		return -ENOMEM;
+
+	wacom->resources = true;
+
 	error = wacom_allocate_inputs(wacom);
 	if (error)
-		return error;
+		goto fail_open_group;
 
 	/*
 	 * Bamboo Pad has a generic hid handling for the Pen, and we switch it
@@ -1733,6 +1720,8 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 		wacom_wac->shared->touch_input = wacom_wac->touch_input;
 	}
 
+	devres_close_group(&hdev->dev, wacom);
+
 	return 0;
 
 fail_quirks:
@@ -1748,6 +1737,8 @@ fail_battery:
 fail_shared_data:
 fail_parsed:
 fail_allocate_inputs:
+fail_open_group:
+	wacom_release_resources(wacom);
 	return error;
 }
 
@@ -1773,14 +1764,14 @@ static void wacom_wireless_work(struct work_struct *work)
 	wacom1 = hid_get_drvdata(hdev1);
 	wacom_wac1 = &(wacom1->wacom_wac);
 	wacom_destroy_leds(wacom1);
-	wacom_clean_inputs(wacom1);
+	wacom_release_resources(wacom1);
 
 	/* Touch interface */
 	hdev2 = usb_get_intfdata(usbdev->config->interface[2]);
 	wacom2 = hid_get_drvdata(hdev2);
 	wacom_wac2 = &(wacom2->wacom_wac);
 	wacom_destroy_leds(wacom2);
-	wacom_clean_inputs(wacom2);
+	wacom_release_resources(wacom2);
 
 	if (wacom_wac->pid == 0) {
 		hid_info(wacom->hdev, "wireless tablet disconnected\n");
@@ -1835,9 +1826,9 @@ static void wacom_wireless_work(struct work_struct *work)
 
 fail:
 	wacom_destroy_leds(wacom1);
-	wacom_clean_inputs(wacom1);
+	wacom_release_resources(wacom1);
 	wacom_destroy_leds(wacom2);
-	wacom_clean_inputs(wacom2);
+	wacom_release_resources(wacom2);
 	return;
 }
 
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index c7707b2..3e2c903 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1941,7 +1941,7 @@ static int wacom_bpt3_touch(struct wacom_wac *wacom)
 	}
 
 	/* only update touch if we actually have a touchpad and touch data changed */
-	if (wacom->touch_registered && touch_changed) {
+	if (wacom->touch_input && touch_changed) {
 		input_mt_sync_frame(wacom->touch_input);
 		wacom->shared->touch_down = wacom_wac_finger_count_touches(wacom);
 	}
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 53d1653..d5b973d 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -234,9 +234,6 @@ struct wacom_wac {
 	struct input_dev *pen_input;
 	struct input_dev *touch_input;
 	struct input_dev *pad_input;
-	bool pen_registered;
-	bool touch_registered;
-	bool pad_registered;
 	int pid;
 	int battery_capacity;
 	int num_contacts_left;
-- 
2.5.5

