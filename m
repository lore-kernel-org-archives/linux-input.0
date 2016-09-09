From: Simon Wood <gitsend@mungewell.org>
Subject: [PATCH 2/5] HID:hid-logitech: Add combined pedal support Logitech wheels
Date: Fri,  9 Sep 2016 16:50:46 -0600
Message-ID: <1473461449-8060-2-git-send-email-simon@mungewell.org>
References: <1473461449-8060-1-git-send-email-simon@mungewell.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473461449-8060-1-git-send-email-simon@mungewell.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Edwin Velds <edwin@velds.nl>, Elias Vanderstuyft <elias.vds@gmail.com>, Michal Maly <madcatxster@gmail.com>, Simon Wood <simon@mungewell.org>
List-Id: linux-input@vger.kernel.org

Add support for reporting a combined accelerator/brake axis for wheels
which contain combined data in their HID stream.

This includes DF, MOMO, MOMO2 and DFP.

Signed-off-by: Simon Wood <simon@mungewell.org>
---
 drivers/hid/hid-lg.c    | 12 ++++++++++++
 drivers/hid/hid-lg4ff.c | 32 ++++++++++++++++++++++++++++++++
 drivers/hid/hid-lg4ff.h |  4 ++++
 3 files changed, 48 insertions(+)

diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index feb2be7..06f8a5e 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -657,6 +657,17 @@ static int lg_event(struct hid_device *hdev, struct hid_field *field,
 	return 0;
 }
 
+static int lg_raw_event(struct hid_device *hdev, struct hid_report *report,
+		u8 *rd, int size)
+{
+	struct lg_drv_data *drv_data = hid_get_drvdata(hdev);
+
+	if (drv_data->quirks & LG_FF4)
+		return lg4ff_raw_event(hdev, report, rd, size, drv_data);
+
+	return 0;
+}
+
 static int lg_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	struct usb_interface *iface = to_usb_interface(hdev->dev.parent);
@@ -830,6 +841,7 @@ static struct hid_driver lg_driver = {
 	.input_mapping = lg_input_mapping,
 	.input_mapped = lg_input_mapped,
 	.event = lg_event,
+	.raw_event = lg_raw_event,
 	.probe = lg_probe,
 	.remove = lg_remove,
 };
diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index ca31ce4..79d34c2 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -329,6 +329,38 @@ int lg4ff_adjust_input_event(struct hid_device *hid, struct hid_field *field,
 	}
 }
 
+int lg4ff_raw_event(struct hid_device *hdev, struct hid_report *report,
+		u8 *rd, int size, struct lg_drv_data *drv_data)
+{
+	struct lg4ff_device_entry *entry = drv_data->device_props;
+
+	if (!entry)
+		return 0;
+
+	/* adjust HID report present combined pedals data */
+	if (entry->wdata.combine) {
+		switch (entry->wdata.product_id) {
+		case USB_DEVICE_ID_LOGITECH_WHEEL:
+			rd[5] = rd[3];
+			rd[6] = 0x7F;
+			return 1;
+		case USB_DEVICE_ID_LOGITECH_MOMO_WHEEL:
+		case USB_DEVICE_ID_LOGITECH_MOMO_WHEEL2:
+			rd[4] = rd[3];
+			rd[5] = 0x7F;
+			return 1;
+		case USB_DEVICE_ID_LOGITECH_DFP_WHEEL:
+			rd[5] = rd[4];
+			rd[6] = 0x7F;
+			return 1;
+		default:
+			return 0;
+		}
+	}
+
+	return 0;
+}
+
 static void lg4ff_init_wheel_data(struct lg4ff_wheel_data * const wdata, const struct lg4ff_wheel *wheel,
 				  const struct lg4ff_multimode_wheel *mmode_wheel,
 				  const u16 real_product_id)
diff --git a/drivers/hid/hid-lg4ff.h b/drivers/hid/hid-lg4ff.h
index 66201af..de1f350 100644
--- a/drivers/hid/hid-lg4ff.h
+++ b/drivers/hid/hid-lg4ff.h
@@ -6,11 +6,15 @@ extern int lg4ff_no_autoswitch; /* From hid-lg.c */
 
 int lg4ff_adjust_input_event(struct hid_device *hid, struct hid_field *field,
 			     struct hid_usage *usage, s32 value, struct lg_drv_data *drv_data);
+int lg4ff_raw_event(struct hid_device *hdev, struct hid_report *report,
+		u8 *rd, int size, struct lg_drv_data *drv_data);
 int lg4ff_init(struct hid_device *hdev);
 int lg4ff_deinit(struct hid_device *hdev);
 #else
 static inline int lg4ff_adjust_input_event(struct hid_device *hid, struct hid_field *field,
 					   struct hid_usage *usage, s32 value, struct lg_drv_data *drv_data) { return 0; }
+static inline int lg4ff_raw_event(struct hid_device *hdev, struct hid_report *report,
+		u8 *rd, int size, struct lg_drv_data *drv_data) { return 0; }
 static inline int lg4ff_init(struct hid_device *hdev) { return -1; }
 static inline int lg4ff_deinit(struct hid_device *hdev) { return -1; }
 #endif
-- 
2.7.4
