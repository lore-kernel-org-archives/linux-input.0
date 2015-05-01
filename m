From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: lenovo: add support for Lenovo ThinkPad Keyboard Pro unit
Date: Fri,  1 May 2015 16:22:45 -0400
Message-ID: <1430511765-28209-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Jonathan Oppenheim <lejono@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This dock is used with the Thinkpad Helix 2 but suffers from an error
in the report descriptor where an usage max is 65535.

Add a report fixup for it and make the keyboard working.

Tested-by: Jonathan Oppenheim <lejono@gmail.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

Jonathan,

Compared to the patch I sent you last week, the only difference is that
I removed a remnant debug line :)

Cheers,
Benjamin

 drivers/hid/hid-core.c   |  1 +
 drivers/hid/hid-ids.h    |  1 +
 drivers/hid/hid-lenovo.c | 31 +++++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 722a925..c2baf8c 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1851,6 +1851,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_TPKBD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_CUSBKBD) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_CBTKBD) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_TPPRODOCK) },
 #endif
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_MX3000_RECEIVER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_S510_RECEIVER) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index b24caf8..e5b86e0 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -585,6 +585,7 @@
 #define USB_DEVICE_ID_LENOVO_TPKBD	0x6009
 #define USB_DEVICE_ID_LENOVO_CUSBKBD	0x6047
 #define USB_DEVICE_ID_LENOVO_CBTKBD	0x6048
+#define USB_DEVICE_ID_LENOVO_TPPRODOCK	0x6067
 
 #define USB_VENDOR_ID_LG		0x1fd2
 #define USB_DEVICE_ID_LG_MULTITOUCH	0x0064
diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 78608d6..4e291d5 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -43,6 +43,35 @@ struct lenovo_drvdata_cptkbd {
 
 #define map_key_clear(c) hid_map_usage_clear(hi, usage, bit, max, EV_KEY, (c))
 
+static const __u8 lenovo_pro_dock_need_fixup_collection[] = {
+	0x05, 0x88,		/* Usage Page (Vendor Usage Page 0x88)	*/
+	0x09, 0x01,		/* Usage (Vendor Usage 0x01)		*/
+	0xa1, 0x01,		/* Collection (Application)		*/
+	0x85, 0x04,		/*  Report ID (4)			*/
+	0x19, 0x00,		/*  Usage Minimum (0)			*/
+	0x2a, 0xff, 0xff,	/*  Usage Maximum (65535)		*/
+};
+
+static __u8 *lenovo_report_fixup(struct hid_device *hdev, __u8 *rdesc,
+		unsigned int *rsize)
+{
+	switch (hdev->product) {
+	case USB_DEVICE_ID_LENOVO_TPPRODOCK:
+		/* the fixups that need to be done:
+		 *   - get a reasonable usage max for the vendor collection
+		 *     0x8801 from the report ID 4
+		 */
+		if (*rsize >= 153 &&
+		    memcmp(&rdesc[140], lenovo_pro_dock_need_fixup_collection,
+			  sizeof(lenovo_pro_dock_need_fixup_collection)) == 0) {
+			rdesc[151] = 0x01;
+			rdesc[152] = 0x00;
+		}
+		break;
+	}
+	return rdesc;
+}
+
 static int lenovo_input_mapping_tpkbd(struct hid_device *hdev,
 		struct hid_input *hi, struct hid_field *field,
 		struct hid_usage *usage, unsigned long **bit, int *max)
@@ -784,6 +813,7 @@ static const struct hid_device_id lenovo_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_TPKBD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_CUSBKBD) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_CBTKBD) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_TPPRODOCK) },
 	{ }
 };
 
@@ -797,6 +827,7 @@ static struct hid_driver lenovo_driver = {
 	.probe = lenovo_probe,
 	.remove = lenovo_remove,
 	.raw_event = lenovo_raw_event,
+	.report_fixup = lenovo_report_fixup,
 };
 module_hid_driver(lenovo_driver);
 
-- 
2.3.6
