From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 3/6] HID: wacom: move down wireless_work()
Date: Fri, 12 Feb 2016 17:27:42 +0100
Message-ID: <1455294465-13694-4-git-send-email-benjamin.tissoires@redhat.com>
References: <1455294465-13694-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455294465-13694-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org
Cc: Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

If wireless_work() wants to reuse parse_and_register(), we need to have
it declared after this function.

No functional changes.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_sys.c | 234 ++++++++++++++++++++++++------------------------
 1 file changed, 117 insertions(+), 117 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 92a2c81..78e9e25 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1494,123 +1494,6 @@ static void wacom_calculate_res(struct wacom_features *features)
 						    features->unitExpo);
 }
 
-static void wacom_wireless_work(struct work_struct *work)
-{
-	struct wacom *wacom = container_of(work, struct wacom, work);
-	struct usb_device *usbdev = wacom->usbdev;
-	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
-	struct hid_device *hdev1, *hdev2;
-	struct wacom *wacom1, *wacom2;
-	struct wacom_wac *wacom_wac1, *wacom_wac2;
-	int error;
-
-	/*
-	 * Regardless if this is a disconnect or a new tablet,
-	 * remove any existing input and battery devices.
-	 */
-
-	wacom_destroy_battery(wacom);
-
-	/* Stylus interface */
-	hdev1 = usb_get_intfdata(usbdev->config->interface[1]);
-	wacom1 = hid_get_drvdata(hdev1);
-	wacom_wac1 = &(wacom1->wacom_wac);
-	wacom_clean_inputs(wacom1);
-
-	/* Touch interface */
-	hdev2 = usb_get_intfdata(usbdev->config->interface[2]);
-	wacom2 = hid_get_drvdata(hdev2);
-	wacom_wac2 = &(wacom2->wacom_wac);
-	wacom_clean_inputs(wacom2);
-
-	if (wacom_wac->pid == 0) {
-		hid_info(wacom->hdev, "wireless tablet disconnected\n");
-		wacom_wac1->shared->type = 0;
-	} else {
-		const struct hid_device_id *id = wacom_ids;
-
-		hid_info(wacom->hdev, "wireless tablet connected with PID %x\n",
-			 wacom_wac->pid);
-
-		while (id->bus) {
-			if (id->vendor == USB_VENDOR_ID_WACOM &&
-			    id->product == wacom_wac->pid)
-				break;
-			id++;
-		}
-
-		if (!id->bus) {
-			hid_info(wacom->hdev, "ignoring unknown PID.\n");
-			return;
-		}
-
-		/* Stylus interface */
-		wacom_wac1->features =
-			*((struct wacom_features *)id->driver_data);
-		wacom_wac1->features.device_type |= WACOM_DEVICETYPE_PEN;
-		wacom_set_default_phy(&wacom_wac1->features);
-		wacom_calculate_res(&wacom_wac1->features);
-		snprintf(wacom_wac1->pen_name, WACOM_NAME_MAX, "%s (WL) Pen",
-			 wacom_wac1->features.name);
-		if (wacom_wac1->features.type < BAMBOO_PEN ||
-		    wacom_wac1->features.type > BAMBOO_PT) {
-			snprintf(wacom_wac1->pad_name, WACOM_NAME_MAX, "%s (WL) Pad",
-				 wacom_wac1->features.name);
-			wacom_wac1->features.device_type |= WACOM_DEVICETYPE_PAD;
-		}
-		wacom_wac1->shared->touch_max = wacom_wac1->features.touch_max;
-		wacom_wac1->shared->type = wacom_wac1->features.type;
-		wacom_wac1->pid = wacom_wac->pid;
-		error = wacom_allocate_inputs(wacom1) ||
-			wacom_register_inputs(wacom1);
-		if (error)
-			goto fail;
-
-		/* Touch interface */
-		if (wacom_wac1->features.touch_max ||
-		    (wacom_wac1->features.type >= INTUOSHT &&
-		    wacom_wac1->features.type <= BAMBOO_PT)) {
-			wacom_wac2->features =
-				*((struct wacom_features *)id->driver_data);
-			wacom_wac2->features.pktlen = WACOM_PKGLEN_BBTOUCH3;
-			wacom_set_default_phy(&wacom_wac2->features);
-			wacom_wac2->features.x_max = wacom_wac2->features.y_max = 4096;
-			wacom_calculate_res(&wacom_wac2->features);
-			snprintf(wacom_wac2->touch_name, WACOM_NAME_MAX,
-				 "%s (WL) Finger",wacom_wac2->features.name);
-			if (wacom_wac1->features.touch_max)
-				wacom_wac2->features.device_type |= WACOM_DEVICETYPE_TOUCH;
-			if (wacom_wac1->features.type >= INTUOSHT &&
-			    wacom_wac1->features.type <= BAMBOO_PT) {
-				snprintf(wacom_wac2->pad_name, WACOM_NAME_MAX,
-					 "%s (WL) Pad",wacom_wac2->features.name);
-				wacom_wac2->features.device_type |= WACOM_DEVICETYPE_PAD;
-			}
-			wacom_wac2->pid = wacom_wac->pid;
-			error = wacom_allocate_inputs(wacom2) ||
-				wacom_register_inputs(wacom2);
-			if (error)
-				goto fail;
-
-			if ((wacom_wac1->features.type == INTUOSHT ||
-			    wacom_wac1->features.type == INTUOSHT2) &&
-			    wacom_wac1->features.touch_max)
-				wacom_wac->shared->touch_input = wacom_wac2->touch_input;
-		}
-
-		error = wacom_initialize_battery(wacom);
-		if (error)
-			goto fail;
-	}
-
-	return;
-
-fail:
-	wacom_clean_inputs(wacom1);
-	wacom_clean_inputs(wacom2);
-	return;
-}
-
 void wacom_battery_work(struct work_struct *work)
 {
 	struct wacom *wacom = container_of(work, struct wacom, work);
@@ -1809,6 +1692,123 @@ fail_allocate_inputs:
 	return error;
 }
 
+static void wacom_wireless_work(struct work_struct *work)
+{
+	struct wacom *wacom = container_of(work, struct wacom, work);
+	struct usb_device *usbdev = wacom->usbdev;
+	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+	struct hid_device *hdev1, *hdev2;
+	struct wacom *wacom1, *wacom2;
+	struct wacom_wac *wacom_wac1, *wacom_wac2;
+	int error;
+
+	/*
+	 * Regardless if this is a disconnect or a new tablet,
+	 * remove any existing input and battery devices.
+	 */
+
+	wacom_destroy_battery(wacom);
+
+	/* Stylus interface */
+	hdev1 = usb_get_intfdata(usbdev->config->interface[1]);
+	wacom1 = hid_get_drvdata(hdev1);
+	wacom_wac1 = &(wacom1->wacom_wac);
+	wacom_clean_inputs(wacom1);
+
+	/* Touch interface */
+	hdev2 = usb_get_intfdata(usbdev->config->interface[2]);
+	wacom2 = hid_get_drvdata(hdev2);
+	wacom_wac2 = &(wacom2->wacom_wac);
+	wacom_clean_inputs(wacom2);
+
+	if (wacom_wac->pid == 0) {
+		hid_info(wacom->hdev, "wireless tablet disconnected\n");
+		wacom_wac1->shared->type = 0;
+	} else {
+		const struct hid_device_id *id = wacom_ids;
+
+		hid_info(wacom->hdev, "wireless tablet connected with PID %x\n",
+			 wacom_wac->pid);
+
+		while (id->bus) {
+			if (id->vendor == USB_VENDOR_ID_WACOM &&
+			    id->product == wacom_wac->pid)
+				break;
+			id++;
+		}
+
+		if (!id->bus) {
+			hid_info(wacom->hdev, "ignoring unknown PID.\n");
+			return;
+		}
+
+		/* Stylus interface */
+		wacom_wac1->features =
+			*((struct wacom_features *)id->driver_data);
+		wacom_wac1->features.device_type |= WACOM_DEVICETYPE_PEN;
+		wacom_set_default_phy(&wacom_wac1->features);
+		wacom_calculate_res(&wacom_wac1->features);
+		snprintf(wacom_wac1->pen_name, WACOM_NAME_MAX, "%s (WL) Pen",
+			 wacom_wac1->features.name);
+		if (wacom_wac1->features.type < BAMBOO_PEN ||
+		    wacom_wac1->features.type > BAMBOO_PT) {
+			snprintf(wacom_wac1->pad_name, WACOM_NAME_MAX,
+				 "%s (WL) Pad", wacom_wac1->features.name);
+			wacom_wac1->features.device_type |= WACOM_DEVICETYPE_PAD;
+		}
+		wacom_wac1->shared->touch_max = wacom_wac1->features.touch_max;
+		wacom_wac1->shared->type = wacom_wac1->features.type;
+		wacom_wac1->pid = wacom_wac->pid;
+		error = wacom_allocate_inputs(wacom1) ||
+			wacom_register_inputs(wacom1);
+		if (error)
+			goto fail;
+
+		/* Touch interface */
+		if (wacom_wac1->features.touch_max ||
+		    (wacom_wac1->features.type >= INTUOSHT &&
+		    wacom_wac1->features.type <= BAMBOO_PT)) {
+			wacom_wac2->features =
+				*((struct wacom_features *)id->driver_data);
+			wacom_wac2->features.pktlen = WACOM_PKGLEN_BBTOUCH3;
+			wacom_set_default_phy(&wacom_wac2->features);
+			wacom_wac2->features.x_max = wacom_wac2->features.y_max = 4096;
+			wacom_calculate_res(&wacom_wac2->features);
+			snprintf(wacom_wac2->touch_name, WACOM_NAME_MAX,
+				 "%s (WL) Finger", wacom_wac2->features.name);
+			if (wacom_wac1->features.touch_max)
+				wacom_wac2->features.device_type |= WACOM_DEVICETYPE_TOUCH;
+			if (wacom_wac1->features.type >= INTUOSHT &&
+			    wacom_wac1->features.type <= BAMBOO_PT) {
+				snprintf(wacom_wac2->pad_name, WACOM_NAME_MAX,
+					 "%s (WL) Pad", wacom_wac2->features.name);
+				wacom_wac2->features.device_type |= WACOM_DEVICETYPE_PAD;
+			}
+			wacom_wac2->pid = wacom_wac->pid;
+			error = wacom_allocate_inputs(wacom2) ||
+				wacom_register_inputs(wacom2);
+			if (error)
+				goto fail;
+
+			if ((wacom_wac1->features.type == INTUOSHT ||
+			    wacom_wac1->features.type == INTUOSHT2) &&
+			    wacom_wac1->features.touch_max)
+				wacom_wac->shared->touch_input = wacom_wac2->touch_input;
+		}
+
+		error = wacom_initialize_battery(wacom);
+		if (error)
+			goto fail;
+	}
+
+	return;
+
+fail:
+	wacom_clean_inputs(wacom1);
+	wacom_clean_inputs(wacom2);
+	return;
+}
+
 static int wacom_probe(struct hid_device *hdev,
 		const struct hid_device_id *id)
 {
-- 
2.5.0
