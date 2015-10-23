From: Simon Wood <simon@mungewell.org>
Subject: [RFC 3/5] HID: hid-logitech-hidpp: Add basic support for Logitech G920
Date: Fri, 23 Oct 2015 11:27:25 -0600
Message-ID: <1445621247-18806-3-git-send-email-simon@mungewell.org>
References: <1445621247-18806-1-git-send-email-simon@mungewell.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445621247-18806-1-git-send-email-simon@mungewell.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Edwin <Edwin@Velds.nl>, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>, elias vanderstuyft <elias.vds@gmail.com>, Simon Wood <simon@mungewell.org>
List-Id: linux-input@vger.kernel.org

This patch adds basic support for the Logitech G920 wheel when in HID
mode. This wheel 'speaks' the HID++ protocol, and therefor is driven
with hid-logitech-hidpp.

At this stage the driver only shows that it can communicate with the
wheel by outputting the name discovered over HID++.

The normal HID functions work to give input functionality using
joystick/event interface.
---
 drivers/hid/hid-core.c           |  1 +
 drivers/hid/hid-ids.h            |  1 +
 drivers/hid/hid-logitech-hidpp.c | 69 +++++++++++++++++++++++++++++++---------
 3 files changed, 56 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 70a11ac..fe53b0a 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1896,6 +1896,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_RUMBLEPAD_CORD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_RUMBLEPAD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_RUMBLEPAD2_2) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WINGMAN_F3D) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WINGMAN_FFG ) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_FORCE3D_PRO) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index f769208..d3500c4 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -614,6 +614,7 @@
 #define USB_DEVICE_ID_LOGITECH_RUMBLEPAD2	0xc218
 #define USB_DEVICE_ID_LOGITECH_RUMBLEPAD2_2	0xc219
 #define USB_DEVICE_ID_LOGITECH_G29_WHEEL	0xc24f
+#define USB_DEVICE_ID_LOGITECH_G920_WHEEL	0xc262
 #define USB_DEVICE_ID_LOGITECH_WINGMAN_F3D	0xc283
 #define USB_DEVICE_ID_LOGITECH_FORCE3D_PRO	0xc286
 #define USB_DEVICE_ID_LOGITECH_FLIGHT_SYSTEM_G940	0xc287
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index c343b23..76d7267 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -43,10 +43,12 @@ MODULE_PARM_DESC(disable_raw_mode,
 
 #define HIDPP_QUIRK_CLASS_WTP			BIT(0)
 #define HIDPP_QUIRK_CLASS_M560			BIT(1)
+#define HIDPP_QUIRK_CLASS_G920			BIT(2)
 
 /* bits 2..20 are reserved for classes */
 #define HIDPP_QUIRK_DELAYED_INIT		BIT(21)
 #define HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS	BIT(22)
+#define HIDPP_QUIRK_FORCE_OUTPUT_REPORTS	BIT(23)
 
 /*
  * There are two hidpp protocols in use, the first version hidpp10 is known
@@ -136,8 +138,11 @@ static void hidpp_connect_event(struct hidpp_device *hidpp_dev);
 static int __hidpp_send_report(struct hid_device *hdev,
 				struct hidpp_report *hidpp_report)
 {
+	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
 	int fields_count, ret;
 
+	hidpp = hid_get_drvdata(hdev);
+
 	switch (hidpp_report->report_id) {
 	case REPORT_ID_HIDPP_SHORT:
 		fields_count = HIDPP_REPORT_SHORT_LENGTH;
@@ -158,9 +163,13 @@ static int __hidpp_send_report(struct hid_device *hdev,
 	 */
 	hidpp_report->device_index = 0xff;
 
-	ret = hid_hw_raw_request(hdev, hidpp_report->report_id,
-		(u8 *)hidpp_report, fields_count, HID_OUTPUT_REPORT,
-		HID_REQ_SET_REPORT);
+	if (hidpp->quirks & HIDPP_QUIRK_FORCE_OUTPUT_REPORTS) {
+		ret = hid_hw_output_report(hdev, (u8 *)hidpp_report, fields_count);
+	} else {
+		ret = hid_hw_raw_request(hdev, hidpp_report->report_id,
+			(u8 *)hidpp_report, fields_count, HID_OUTPUT_REPORT,
+			HID_REQ_SET_REPORT);
+	}
 
 	return ret == fields_count ? 0 : -1;
 }
@@ -1305,8 +1314,10 @@ static void hidpp_overwrite_name(struct hid_device *hdev, bool use_unifying)
 
 	if (!name)
 		hid_err(hdev, "unable to retrieve the name of the device");
-	else
+	else {
+		dbg_hid("HID++: Got name: %s\n", name);
 		snprintf(hdev->name, sizeof(hdev->name), "%s", name);
+	}
 
 	kfree(name);
 }
@@ -1457,6 +1468,25 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto hid_parse_fail;
 	}
 
+	if (hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT)
+		connect_mask &= ~HID_CONNECT_HIDINPUT;
+
+	if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
+		ret = hid_hw_start(hdev, connect_mask);
+		if (ret) {
+			hid_err(hdev, "hw start failed\n");
+			goto hid_hw_start_fail;
+		}
+		ret = hid_hw_open(hdev);
+		if (ret < 0) {
+			dev_err(&hdev->dev, "%s:hid_hw_open returned error:%d\n",
+				__func__, ret);
+			hid_hw_stop(hdev);
+			goto hid_hw_start_fail;
+		}
+	}
+
+
 	/* Allow incoming packets */
 	hid_device_io_start(hdev);
 
@@ -1465,8 +1495,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		if (!connected) {
 			ret = -ENODEV;
 			hid_err(hdev, "Device not connected");
-			hid_device_io_stop(hdev);
-			goto hid_parse_fail;
+			goto hid_hw_open_failed;
 		}
 
 		hid_info(hdev, "HID++ %u.%u device connected.\n",
@@ -1479,19 +1508,18 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (connected && (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)) {
 		ret = wtp_get_config(hidpp);
 		if (ret)
-			goto hid_parse_fail;
+			goto hid_hw_open_failed;
 	}
 
 	/* Block incoming packets */
 	hid_device_io_stop(hdev);
 
-	if (hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT)
-		connect_mask &= ~HID_CONNECT_HIDINPUT;
-
-	ret = hid_hw_start(hdev, connect_mask);
-	if (ret) {
-		hid_err(hdev, "%s:hid_hw_start returned error\n", __func__);
-		goto hid_hw_start_fail;
+	if (!(hidpp->quirks & HIDPP_QUIRK_CLASS_G920)) {
+		ret = hid_hw_start(hdev, connect_mask);
+		if (ret) {
+			hid_err(hdev, "%s:hid_hw_start returned error\n", __func__);
+			goto hid_hw_start_fail;
+		}
 	}
 
 	if (hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT) {
@@ -1503,6 +1531,12 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	return ret;
 
+hid_hw_open_failed:
+	hid_device_io_stop(hdev);
+	if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
+		hid_hw_close(hdev);
+		hid_hw_stop(hdev);
+	}
 hid_hw_start_fail:
 hid_parse_fail:
 	cancel_work_sync(&hidpp->work);
@@ -1516,9 +1550,11 @@ static void hidpp_remove(struct hid_device *hdev)
 {
 	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
 
+	if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920)
+		hid_hw_close(hdev);
+	hid_hw_stop(hdev);
 	cancel_work_sync(&hidpp->work);
 	mutex_destroy(&hidpp->send_mutex);
-	hid_hw_stop(hdev);
 }
 
 static const struct hid_device_id hidpp_devices[] = {
@@ -1542,6 +1578,9 @@ static const struct hid_device_id hidpp_devices[] = {
 
 	{ HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
 		USB_VENDOR_ID_LOGITECH, HID_ANY_ID)},
+
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL),
+		.driver_data = HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_REPORTS},
 	{}
 };
 
-- 
2.1.4
