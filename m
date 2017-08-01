From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] HID: Use per-transport helpers instead of hid_is_using_ll_driver
Date: Tue,  1 Aug 2017 14:45:46 -0700
Message-ID: <20170801214546.12258-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37807 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752218AbdHAVrB (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 1 Aug 2017 17:47:01 -0400
Received: by mail-qt0-f193.google.com with SMTP id d10so2922198qtb.4
        for <linux-input@vger.kernel.org>; Tue, 01 Aug 2017 14:47:00 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

Users of the hid_is_using_ll_driver function introduced in fc2237a724 gain
a dependency on whatever transport(s) they need to check against, which can
lead to build errors if those dependencies are not properly dealt with. To
make this process less error-prone, replace the generic function with per-
transport helpers that transparently handle the dependencies.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
Jiri: Commit 9d14201c74 can be reverted if this proposal is acceptable.

 drivers/hid/i2c-hid/i2c-hid.c | 10 ++++++++--
 drivers/hid/uhid.c            |  9 +++++++--
 drivers/hid/usbhid/hid-core.c |  9 +++++++--
 drivers/hid/wacom_sys.c       |  2 +-
 include/linux/hid.h           | 40 +++++++++++++++++++++++++++++++++-------
 net/bluetooth/hidp/core.c     |  9 +++++++--
 6 files changed, 63 insertions(+), 16 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 77396145d2d0..e81aabd5b019 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -780,7 +780,7 @@ static int i2c_hid_power(struct hid_device *hid, int lvl)
 	return 0;
 }
 
-struct hid_ll_driver i2c_hid_ll_driver = {
+static struct hid_ll_driver i2c_hid_ll_driver = {
 	.parse = i2c_hid_parse,
 	.start = i2c_hid_start,
 	.stop = i2c_hid_stop,
@@ -790,7 +790,13 @@ struct hid_ll_driver i2c_hid_ll_driver = {
 	.output_report = i2c_hid_output_report,
 	.raw_request = i2c_hid_raw_request,
 };
-EXPORT_SYMBOL_GPL(i2c_hid_ll_driver);
+
+bool hid_is_using_i2c_driver(struct hid_device *hdev)
+{
+	return hdev->ll_driver == &i2c_hid_ll_driver;
+}
+EXPORT_SYMBOL_GPL(hid_is_using_i2c_driver);
+
 
 static int i2c_hid_init_irq(struct i2c_client *client)
 {
diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 6f819f144cb4..983b574f7f7b 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -369,7 +369,7 @@ static int uhid_hid_output_report(struct hid_device *hid, __u8 *buf,
 	return uhid_hid_output_raw(hid, buf, count, HID_OUTPUT_REPORT);
 }
 
-struct hid_ll_driver uhid_hid_driver = {
+static struct hid_ll_driver uhid_hid_driver = {
 	.start = uhid_hid_start,
 	.stop = uhid_hid_stop,
 	.open = uhid_hid_open,
@@ -378,7 +378,12 @@ struct hid_ll_driver uhid_hid_driver = {
 	.raw_request = uhid_hid_raw_request,
 	.output_report = uhid_hid_output_report,
 };
-EXPORT_SYMBOL_GPL(uhid_hid_driver);
+
+bool hid_is_using_uhid_driver(struct hid_device *hdev)
+{
+	return hdev->ll_driver == &uhid_hid_driver;
+}
+EXPORT_SYMBOL_GPL(hid_is_using_uhid_driver);
 
 #ifdef CONFIG_COMPAT
 
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index e1047ad0d59b..1a33d3db6658 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1261,7 +1261,7 @@ static int usbhid_idle(struct hid_device *hid, int report, int idle,
 	return hid_set_idle(dev, ifnum, report, idle);
 }
 
-struct hid_ll_driver usb_hid_driver = {
+static struct hid_ll_driver usb_hid_driver = {
 	.parse = usbhid_parse,
 	.start = usbhid_start,
 	.stop = usbhid_stop,
@@ -1274,7 +1274,12 @@ struct hid_ll_driver usb_hid_driver = {
 	.output_report = usbhid_output_report,
 	.idle = usbhid_idle,
 };
-EXPORT_SYMBOL_GPL(usb_hid_driver);
+
+bool hid_is_using_usb_driver(struct hid_device *hdev)
+{
+	return hdev->ll_driver == &usb_hid_driver;
+}
+EXPORT_SYMBOL_GPL(hid_is_using_usb_driver);
 
 static int usbhid_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index e82a696a1d07..87f50bbfcb2f 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2027,7 +2027,7 @@ static void wacom_update_name(struct wacom *wacom, const char *suffix)
 	if ((features->type == HID_GENERIC) && !strcmp("Wacom HID", features->name)) {
 		char *product_name = wacom->hdev->name;
 
-		if (hid_is_using_ll_driver(wacom->hdev, &usb_hid_driver)) {
+		if (hid_is_using_usb_driver(wacom->hdev)) {
 			struct usb_interface *intf = to_usb_interface(wacom->hdev->dev.parent);
 			struct usb_device *dev = interface_to_usbdev(intf);
 			product_name = dev->product;
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 3853408daf7f..178983df1096 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -777,16 +777,42 @@ struct hid_ll_driver {
 	int (*idle)(struct hid_device *hdev, int report, int idle, int reqtype);
 };
 
-extern struct hid_ll_driver i2c_hid_ll_driver;
-extern struct hid_ll_driver hidp_hid_driver;
-extern struct hid_ll_driver uhid_hid_driver;
-extern struct hid_ll_driver usb_hid_driver;
+#if IS_ENABLED(CONFIG_I2C_HID)
+extern bool hid_is_using_i2c_driver(struct hid_device *hdev);
+#else
+static inline bool hid_is_using_i2c_driver(struct hid_device *hdev)
+{
+	return false;
+}
+#endif
 
-static inline bool hid_is_using_ll_driver(struct hid_device *hdev,
-		struct hid_ll_driver *driver)
+#if IS_ENABLED(CONFIG_BT_HIDP)
+extern bool hid_is_using_hidp_driver(struct hid_device *hdev);
+#else
+static inline bool hid_is_using_hidp_driver(struct hid_device *hdev)
 {
-	return hdev->ll_driver == driver;
+	return false;
 }
+#endif
+
+#if IS_ENABLED(CONFIG_UHID)
+extern bool hid_is_using_uhid_driver(struct hid_device *hdev);
+#else
+static inline bool hid_is_using_uhid_driver(struct hid_device *hdev)
+{
+	return false;
+}
+#endif
+
+#if IS_ENABLED(CONFIG_USB_HID)
+extern bool hid_is_using_usb_driver(struct hid_device *hdev);
+#else
+static inline bool hid_is_using_usb_driver(struct hid_device *hdev)
+{
+	return false;
+}
+#endif
+
 
 #define	PM_HINT_FULLON	1<<5
 #define PM_HINT_NORMAL	1<<1
diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 8112893037bd..c18e4b835ce9 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -734,7 +734,7 @@ static void hidp_stop(struct hid_device *hid)
 	hid->claimed = 0;
 }
 
-struct hid_ll_driver hidp_hid_driver = {
+static struct hid_ll_driver hidp_hid_driver = {
 	.parse = hidp_parse,
 	.start = hidp_start,
 	.stop = hidp_stop,
@@ -743,7 +743,12 @@ struct hid_ll_driver hidp_hid_driver = {
 	.raw_request = hidp_raw_request,
 	.output_report = hidp_output_report,
 };
-EXPORT_SYMBOL_GPL(hidp_hid_driver);
+
+bool hid_is_using_hidp_driver(struct hid_device *hdev)
+{
+	return hdev->ll_driver == &hidp_hid_driver;
+}
+EXPORT_SYMBOL_GPL(hid_is_using_hidp_driver);
 
 /* This function sets up the hid device. It does not add it
    to the HID system. That is done in hidp_add_connection(). */
-- 
2.13.3

