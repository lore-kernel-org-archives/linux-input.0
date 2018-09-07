From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 2/7] HID: logitech-hidpp: make .probe usbhid capable
Date: Fri,  7 Sep 2018 12:34:45 +0200
Message-ID: <20180907103450.13890-3-benjamin.tissoires@redhat.com>
References: <20180907103450.13890-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180907103450.13890-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Simon Wood <simon@mungewell.org>, Olivier Gay <ogay@logitech.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

The current custom solution for the G920 is not the best because
hid_hw_start() is not called at the end of the .probe().
It means that any configuration retrieved after the initial hid_hw_start
would not be exposed to user space without races.

We can simply force hid_hw_start to just enable the transport layer by
not using a connect_mask. This way, we can have a common path between
USB, Unifying and Bluetooth devices.

Tested with a M185 with the non unifying receiver, a T650 and many other
unifying devices, and the T651 over Bluetooth.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-ids.h            |  2 +
 drivers/hid/hid-logitech-hidpp.c | 85 +++++++++++++++++++++-------------------
 2 files changed, 47 insertions(+), 40 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index e254ae802688..537223086d6b 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -741,7 +741,9 @@
 #define USB_DEVICE_ID_LOGITECH_CORDLESS_DESKTOP_LX500	0xc512
 #define USB_DEVICE_ID_MX3000_RECEIVER	0xc513
 #define USB_DEVICE_ID_LOGITECH_UNIFYING_RECEIVER	0xc52b
+#define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER		0xc52f
 #define USB_DEVICE_ID_LOGITECH_UNIFYING_RECEIVER_2	0xc532
+#define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_2		0xc534
 #define USB_DEVICE_ID_SPACETRAVELLER	0xc623
 #define USB_DEVICE_ID_SPACENAVIGATOR	0xc626
 #define USB_DEVICE_ID_DINOVO_DESKTOP	0xc704
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 37abae63bb1a..d635e9685581 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -3268,24 +3268,23 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		hid_warn(hdev, "Cannot allocate sysfs group for %s\n",
 			 hdev->name);
 
-	if (hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT)
-		connect_mask &= ~HID_CONNECT_HIDINPUT;
-
-	if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
-		ret = hid_hw_start(hdev, connect_mask);
-		if (ret) {
-			hid_err(hdev, "hw start failed\n");
-			goto hid_hw_start_fail;
-		}
-		ret = hid_hw_open(hdev);
-		if (ret < 0) {
-			dev_err(&hdev->dev, "%s:hid_hw_open returned error:%d\n",
-				__func__, ret);
-			hid_hw_stop(hdev);
-			goto hid_hw_start_fail;
-		}
+	/*
+	 * Plain USB connections need to actually call start and open
+	 * on the transport driver to allow incoming data.
+	 */
+	ret = hid_hw_start(hdev, 0);
+	if (ret) {
+		hid_err(hdev, "hw start failed\n");
+		goto hid_hw_start_fail;
 	}
 
+	ret = hid_hw_open(hdev);
+	if (ret < 0) {
+		dev_err(&hdev->dev, "%s:hid_hw_open returned error:%d\n",
+			__func__, ret);
+		hid_hw_stop(hdev);
+		goto hid_hw_open_fail;
+	}
 
 	/* Allow incoming packets */
 	hid_device_io_start(hdev);
@@ -3299,7 +3298,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		if (!connected) {
 			ret = -ENODEV;
 			hid_err(hdev, "Device not connected");
-			goto hid_hw_open_failed;
+			goto hid_hw_init_fail;
 		}
 
 		hid_info(hdev, "HID++ %u.%u device connected.\n",
@@ -3311,37 +3310,36 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (connected && (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)) {
 		ret = wtp_get_config(hidpp);
 		if (ret)
-			goto hid_hw_open_failed;
+			goto hid_hw_init_fail;
 	} else if (connected && (hidpp->quirks & HIDPP_QUIRK_CLASS_G920)) {
 		ret = g920_get_config(hidpp);
 		if (ret)
-			goto hid_hw_open_failed;
+			goto hid_hw_init_fail;
 	}
 
-	/* Block incoming packets */
-	hid_device_io_stop(hdev);
+	hidpp_connect_event(hidpp);
 
-	if (!(hidpp->quirks & HIDPP_QUIRK_CLASS_G920)) {
-		ret = hid_hw_start(hdev, connect_mask);
-		if (ret) {
-			hid_err(hdev, "%s:hid_hw_start returned error\n", __func__);
-			goto hid_hw_start_fail;
-		}
-	}
+	/* Reset the HID node state */
+	hid_device_io_stop(hdev);
+	hid_hw_close(hdev);
+	hid_hw_stop(hdev);
 
-	/* Allow incoming packets */
-	hid_device_io_start(hdev);
+	if (hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT)
+		connect_mask &= ~HID_CONNECT_HIDINPUT;
 
-	hidpp_connect_event(hidpp);
+	/* Now export the actual inputs and hidraw nodes to the world */
+	ret = hid_hw_start(hdev, connect_mask);
+	if (ret) {
+		hid_err(hdev, "%s:hid_hw_start returned error\n", __func__);
+		goto hid_hw_start_fail;
+	}
 
 	return ret;
 
-hid_hw_open_failed:
-	hid_device_io_stop(hdev);
-	if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
-		hid_hw_close(hdev);
-		hid_hw_stop(hdev);
-	}
+hid_hw_init_fail:
+	hid_hw_close(hdev);
+hid_hw_open_fail:
+	hid_hw_stop(hdev);
 hid_hw_start_fail:
 	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
 	cancel_work_sync(&hidpp->work);
@@ -3360,10 +3358,9 @@ static void hidpp_remove(struct hid_device *hdev)
 
 	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
 
-	if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
+	if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920)
 		hidpp_ff_deinit(hdev);
-		hid_hw_close(hdev);
-	}
+
 	hid_hw_stop(hdev);
 	cancel_work_sync(&hidpp->work);
 	mutex_destroy(&hidpp->send_mutex);
@@ -3427,6 +3424,14 @@ static const struct hid_device_id hidpp_devices[] = {
 
 	{ LDJ_DEVICE(HID_ANY_ID) },
 
+	{ /* Logitech Nano (non DJ) receiver */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
+			 USB_DEVICE_ID_LOGITECH_NANO_RECEIVER) },
+
+	{ /* Logitech Nano (non DJ) receiver */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
+			 USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_2) },
+
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL),
 		.driver_data = HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_REPORTS},
 	{}
-- 
2.14.3
