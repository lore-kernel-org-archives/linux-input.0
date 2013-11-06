From: Simon Wood <simon@mungewell.org>
Subject: [PATCH 5/5] HID:hid-lg4ff: Correct Auto-center strength for wheels other than MOMO and MOMO2
Date: Wed,  6 Nov 2013 12:30:44 -0700
Message-ID: <1383766244-2336-5-git-send-email-simon@mungewell.org>
References: <1383766244-2336-1-git-send-email-simon@mungewell.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1383766244-2336-1-git-send-email-simon@mungewell.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, simon@mungewell.org, Elias Vanderstuyft <elias.vds@gmail.com>, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@prifuk.cz>
List-Id: linux-input@vger.kernel.org

The MOMO and MOMO2 wheels have a slightly different autocenter command,
and accept values in the range 0..F (rather than 0..7 for the other wheels).

This patch uses the product ID to determine how to compute the strength.

Signed-off-by: Simon Wood <simon@mungewell.org>
---
 drivers/hid/hid-lg4ff.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index 5492809..befe0e3 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -234,6 +234,20 @@ static void hid_lg4ff_set_autocenter_default(struct input_dev *dev, u16 magnitud
 	struct hid_report *report = list_entry(report_list->next, struct hid_report, list);
 	__s32 *value = report->field[0]->value;
 	__u32 expand_a, expand_b;
+	struct lg4ff_device_entry *entry;
+	struct lg_drv_data *drv_data;
+
+	drv_data = hid_get_drvdata(hid);
+	if (!drv_data) {
+		hid_err(hid, "Private driver data not found!\n");
+		return;
+	}
+
+	entry = drv_data->device_props;
+	if (!entry) {
+		hid_err(hid, "Device properties not found!\n");
+		return;
+	}
 
 	/* De-activate Auto-Center */
 	if (magnitude == 0) {
@@ -257,6 +271,16 @@ static void hid_lg4ff_set_autocenter_default(struct input_dev *dev, u16 magnitud
 		expand_b = (0x80 * 0xaaaa) + 0xff * (magnitude - 0xaaaa);
 	}
 
+	/* Adjust for non-MOMO wheels */
+	switch (entry->product_id) {
+	case USB_DEVICE_ID_LOGITECH_MOMO_WHEEL:
+	case USB_DEVICE_ID_LOGITECH_MOMO_WHEEL2:
+		break;
+	default:
+		expand_a = expand_a >> 1;
+		break;
+	}
+
 	value[0] = 0xfe;
 	value[1] = 0x0d;
 	value[2] = expand_a / 0xaaaa;
-- 
1.8.1.2
