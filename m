From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 02/12 v2] HID: wiimote: Register wiimote hid driver stub
Date: Fri, 17 Jun 2011 16:49:12 +0200
Message-ID: <1308322162-13953-2-git-send-email-dh.herrmann@googlemail.com>
References: <1308322162-13953-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62088 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759208Ab1FQOuQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jun 2011 10:50:16 -0400
Received: by fxm17 with SMTP id 17so1796087fxm.19
        for <linux-input@vger.kernel.org>; Fri, 17 Jun 2011 07:50:15 -0700 (PDT)
In-Reply-To: <1308322162-13953-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: padovan@profusion.mobi, jkosina@suse.cz, oliver@neukum.org, dh.herrmann@googlemail.com

The wiimote uses a fake HID protocol. Hence, we need to prevent
HIDINPUT and HIDDEV from parsing wiimote data and instead parse
raw hid events.
Add VID/PID to hid-core so the special driver is loaded on new
wiimotes.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-core.c    |    1 +
 drivers/hid/hid-ids.h     |    3 ++
 drivers/hid/hid-wiimote.c |   62 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 65 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index c957c4b..4482556 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1502,6 +1502,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ZYDACRON, USB_DEVICE_ID_ZYDACRON_REMOTE_CONTROL) },
 
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_PRESENTER_8K_BT) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_NINTENDO, USB_DEVICE_ID_NINTENDO_WIIMOTE) },
 	{ }
 };
 
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 0b374a6..480ce6e 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -491,6 +491,9 @@
 #define USB_VENDOR_ID_NEXTWINDOW	0x1926
 #define USB_DEVICE_ID_NEXTWINDOW_TOUCHSCREEN	0x0003
 
+#define USB_VENDOR_ID_NINTENDO		0x057e
+#define USB_DEVICE_ID_NINTENDO_WIIMOTE	0x0306
+
 #define USB_VENDOR_ID_NTRIG		0x1b96
 #define USB_DEVICE_ID_NTRIG_TOUCH_SCREEN   0x0001
 #define USB_DEVICE_ID_NTRIG_TOUCH_SCREEN_1   0x0003
diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index 8a770e6..ed4fe18 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -10,18 +10,78 @@
  * any later version.
  */
 
+#include <linux/hid.h>
 #include <linux/module.h>
+#include "hid-ids.h"
 
 #define WIIMOTE_VERSION "0.1"
 #define WIIMOTE_NAME "Nintendo Wii Remote"
 
-static int __init wiimote_init(void)
+static int wiimote_hid_event(struct hid_device *hdev, struct hid_report *report,
+							u8 *raw_data, int size)
+{
+	if (size < 1)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int wiimote_hid_probe(struct hid_device *hdev,
+				const struct hid_device_id *id)
 {
+	int ret;
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "HID parse failed\n");
+		return ret;
+	}
+
+	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
+	if (ret) {
+		hid_err(hdev, "HW start failed\n");
+		return ret;
+	}
+
+	hid_info(hdev, "New device registered\n");
 	return 0;
 }
 
+static void wiimote_hid_remove(struct hid_device *hdev)
+{
+	hid_info(hdev, "Device removed\n");
+	hid_hw_stop(hdev);
+}
+
+static const struct hid_device_id wiimote_hid_devices[] = {
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_NINTENDO,
+				USB_DEVICE_ID_NINTENDO_WIIMOTE) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, wiimote_hid_devices);
+
+static struct hid_driver wiimote_hid_driver = {
+	.name = "wiimote",
+	.id_table = wiimote_hid_devices,
+	.probe = wiimote_hid_probe,
+	.remove = wiimote_hid_remove,
+	.raw_event = wiimote_hid_event,
+};
+
+static int __init wiimote_init(void)
+{
+	int ret;
+
+	ret = hid_register_driver(&wiimote_hid_driver);
+	if (ret)
+		pr_err("Can't register wiimote hid driver\n");
+
+	return ret;
+}
+
 static void __exit wiimote_exit(void)
 {
+	hid_unregister_driver(&wiimote_hid_driver);
 }
 
 module_init(wiimote_init);
-- 
1.7.5.2

