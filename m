From: Simon Wood <simon@mungewell.org>
Subject: [Patch-V2 6/6] HID: hid-logitech-hidpp: G920 remove deadzones
Date: Thu, 12 Nov 2015 09:25:35 -0700
Message-ID: <1447345535-2912-7-git-send-email-simon@mungewell.org>
References: <1447345535-2912-1-git-send-email-simon@mungewell.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447345535-2912-1-git-send-email-simon@mungewell.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Edwin <Edwin@Velds.nl>, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>, elias vanderstuyft <elias.vds@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>
List-Id: linux-input@vger.kernel.org

Ensure that the G920 is not given the default deadzones.

Signed-off-by: Simon Wood <simon@mungewell.org>
---
 drivers/hid/hid-logitech-hidpp.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 80ebd1c..e235f3d 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -1441,6 +1441,25 @@ static int hidpp_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	return 0;
 }
 
+static int hidpp_input_mapped(struct hid_device *hdev, struct hid_input *hi,
+		struct hid_field *field, struct hid_usage *usage,
+		unsigned long **bit, int *max)
+{
+	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
+
+	/* Ensure that Logitech G920 is not given a default fuzz/flat value */
+	if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
+		if (usage->type == EV_ABS && (usage->code == ABS_X ||
+				usage->code == ABS_Y || usage->code == ABS_Z ||
+				usage->code == ABS_RZ)) {
+			field->application = HID_GD_MULTIAXIS;
+		}
+	}
+
+	return 0;
+}
+
+
 static void hidpp_populate_input(struct hidpp_device *hidpp,
 		struct input_dev *input, bool origin_is_hid_core)
 {
@@ -1875,6 +1894,7 @@ static struct hid_driver hidpp_driver = {
 	.raw_event = hidpp_raw_event,
 	.input_configured = hidpp_input_configured,
 	.input_mapping = hidpp_input_mapping,
+	.input_mapped = hidpp_input_mapped,
 };
 
 module_hid_driver(hidpp_driver);
-- 
2.1.4
