From: Jiri Slaby <jirislaby@gmail.com>
Subject: [RFC 8/8] test
Date: Fri,  4 Apr 2008 22:35:57 +0200
Message-ID: <1207341357-17792-9-git-send-email-jirislaby@gmail.com>
References: <1207341357-17792-1-git-send-email-jirislaby@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.wellnetcz.com ([212.24.148.102]:33498 "EHLO WNmonitoring"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751333AbYDDU7a (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 4 Apr 2008 16:59:30 -0400
In-Reply-To: <1207341357-17792-1-git-send-email-jirislaby@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, marcel@holtmann.org, dmitry.torokhov@gmail.com, Jiri Slaby <jirislaby@gmail.com>

Just demonstrative example.

---
 drivers/hid/Makefile   |    2 +-
 drivers/hid/hid-core.c |    1 +
 drivers/hid/test.c     |   62 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 1 deletions(-)
 create mode 100644 drivers/hid/test.c

diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 8a5cbbe..e607b7b 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -3,7 +3,7 @@
 #
 hid-objs			:= hid-core.o hid-input.o hid-input-quirks.o
 
-obj-$(CONFIG_HID)		+= hid.o
+obj-$(CONFIG_HID)		+= hid.o test.o
 
 hid-$(CONFIG_HID_DEBUG)		+= hid-debug.o
 hid-$(CONFIG_HIDRAW)		+= hidraw.o
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index e1b17e7..aff61c6 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1155,6 +1155,7 @@ static const struct hid_device_id hid_usb_blacklist[] = {
 	{ HID_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY) },
 	{ HID_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY) },
 	{ HID_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_JIS) },
+	{ HID_DEVICE(0x045e, 0x00f0) },
 	{ }
 };
 
diff --git a/drivers/hid/test.c b/drivers/hid/test.c
new file mode 100644
index 0000000..3633199
--- /dev/null
+++ b/drivers/hid/test.c
@@ -0,0 +1,62 @@
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/module.h>
+
+static const struct hid_report_id t_report_table[] = {
+	{ HID_REPORT_ID(0) },
+	{ HID_TERMINATOR }
+};
+
+static int t_raw_event(struct hid_device *hdev, struct hid_report *report,
+		u8 *data, int size)
+{
+/*	printk(KERN_DEBUG "report: %u, %u, %d, %.8x\n",
+			report->id, report->type,
+			size, __swab32(*((u32 *)data)));*/
+
+	return -ENODEV;
+}
+
+static const struct hid_usage_id t_usage_table[] = {
+	{ HID_USAGE_ID(HID_ANY_ID, 8) },
+	{ HID_TERMINATOR }
+};
+
+static int t_event(struct hid_device *hdev, struct hid_field *field,
+		struct hid_usage *usage, __s32 value)
+{
+/*	printk(KERN_DEBUG "usage: %u %u %u %d\n",
+			usage->hid, usage->code, usage->type, value);*/
+
+	return -ENODEV;
+}
+
+static const struct hid_device_id t_devices[] = {
+	{ HID_DEVICE(0x045e, 0x00f0) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, t_devices);
+
+static struct hid_driver t_driver = {
+	.name = "test-usb",
+	.bus_type = BUS_USB,
+	.id_table = t_devices,
+	.usage_table = t_usage_table,
+	.event = t_event,
+	.report_table = t_report_table,
+	.raw_event = t_raw_event,
+};
+
+static int t_init(void)
+{
+	return hid_register_driver(&t_driver);
+}
+
+static void t_exit(void)
+{
+	hid_unregister_driver(&t_driver);
+}
+
+module_init(t_init);
+module_exit(t_exit);
+MODULE_LICENSE("GPL");
-- 
1.5.4.4

