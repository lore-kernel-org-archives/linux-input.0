From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: multitouch: fix LG Melfas touchscreen
Date: Mon, 30 Jan 2017 10:48:06 +0100
Message-ID: <20170130094806.7515-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The LG Melfas touchscreen has a bad firmware where it declares the
Contact ID field as constant while it shouldn't. This messes up the
autodetection and the reporting of the events by hid-multitouch given
that hid-input ignores constant fields.

The autodetection is simply worked around by manually adding the device
to hid_have_special_driver.

The processing of the events requires either a report fixup, either some
specific case handling. Given that the report fixup would require to
basically rewrite all the report descriptor, I went for the programatic
way of fixing that after the report descriptors are loaded.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1416181
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-core.c       |  1 +
 drivers/hid/hid-ids.h        |  1 +
 drivers/hid/hid-multitouch.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 390dfe0..538ff69 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1930,6 +1930,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_CBTKBD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_TPPRODOCK) },
 #endif
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LG, USB_DEVICE_ID_LG_MELFAS_MT) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_MX3000_RECEIVER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_S510_RECEIVER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_S510_RECEIVER_2) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index e348865..cefc9b9 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -632,6 +632,7 @@
 
 #define USB_VENDOR_ID_LG		0x1fd2
 #define USB_DEVICE_ID_LG_MULTITOUCH	0x0064
+#define USB_DEVICE_ID_LG_MELFAS_MT	0x6007
 
 #define USB_VENDOR_ID_LOGITECH		0x046d
 #define USB_DEVICE_ID_LOGITECH_AUDIOHUB 0x0a0e
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 6dca668..6926474 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -68,6 +68,7 @@ MODULE_LICENSE("GPL");
 #define MT_QUIRK_HOVERING		(1 << 11)
 #define MT_QUIRK_CONTACT_CNT_ACCURATE	(1 << 12)
 #define MT_QUIRK_FORCE_GET_FEATURE	(1 << 13)
+#define MT_QUIRK_FIX_CONST_CONTACT_ID	(1 << 14)
 
 #define MT_INPUTMODE_TOUCHSCREEN	0x02
 #define MT_INPUTMODE_TOUCHPAD		0x03
@@ -157,6 +158,7 @@ static void mt_post_parse(struct mt_device *td);
 #define MT_CLS_FLATFROG				0x0107
 #define MT_CLS_GENERALTOUCH_TWOFINGERS		0x0108
 #define MT_CLS_GENERALTOUCH_PWT_TENFINGERS	0x0109
+#define MT_CLS_LG				0x010a
 #define MT_CLS_VTL				0x0110
 
 #define MT_DEFAULT_MAXCONTACT	10
@@ -263,6 +265,12 @@ static struct mt_class mt_classes[] = {
 		.sn_move = 2048,
 		.maxcontacts = 40,
 	},
+	{ .name = MT_CLS_LG,
+		.quirks = MT_QUIRK_ALWAYS_VALID |
+			MT_QUIRK_FIX_CONST_CONTACT_ID |
+			MT_QUIRK_IGNORE_DUPLICATES |
+			MT_QUIRK_HOVERING |
+			MT_QUIRK_CONTACT_CNT_ACCURATE },
 	{ .name = MT_CLS_VTL,
 		.quirks = MT_QUIRK_ALWAYS_VALID |
 			MT_QUIRK_CONTACT_CNT_ACCURATE |
@@ -1078,6 +1086,34 @@ static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
 	return 0;
 }
 
+static void mt_fix_const_field(struct hid_field *field, unsigned int usage)
+{
+	if (field->usage[0].hid != usage ||
+	    !(field->flags & HID_MAIN_ITEM_CONSTANT))
+		return;
+
+	field->flags &= ~HID_MAIN_ITEM_CONSTANT;
+	field->flags |= HID_MAIN_ITEM_VARIABLE;
+}
+
+static void mt_fix_const_fields(struct hid_device *hdev, unsigned int usage)
+{
+	struct hid_report *report;
+	int i;
+
+	list_for_each_entry(report,
+			    &hdev->report_enum[HID_INPUT_REPORT].report_list,
+			    list) {
+
+		if (!report->maxfield)
+			continue;
+
+		for (i = 0; i < report->maxfield; i++)
+			if (report->field[i]->maxusage >= 1)
+				mt_fix_const_field(report->field[i], usage);
+	}
+}
+
 static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	int ret, i;
@@ -1151,6 +1187,9 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (ret != 0)
 		return ret;
 
+	if (mtclass->quirks & MT_QUIRK_FIX_CONST_CONTACT_ID)
+		mt_fix_const_fields(hdev, HID_DG_CONTACTID);
+
 	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 	if (ret)
 		return ret;
@@ -1398,6 +1437,11 @@ static const struct hid_device_id mt_devices[] = {
 		MT_USB_DEVICE(USB_VENDOR_ID_ILITEK,
 			USB_DEVICE_ID_ILITEK_MULTITOUCH) },
 
+	/* LG Melfas panel */
+	{ .driver_data = MT_CLS_LG,
+		HID_USB_DEVICE(USB_VENDOR_ID_LG,
+			USB_DEVICE_ID_LG_MELFAS_MT) },
+
 	/* MosArt panels */
 	{ .driver_data = MT_CLS_CONFIDENCE_MINUS_ONE,
 		MT_USB_DEVICE(USB_VENDOR_ID_ASUS,
-- 
2.9.3
