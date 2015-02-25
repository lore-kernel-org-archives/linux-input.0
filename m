From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 4/4] HID: uclogic: name the input nodes based on their tool
Date: Tue, 24 Feb 2015 19:05:30 -0500
Message-ID: <1424822730-14938-5-git-send-email-benjamin.tissoires@redhat.com>
References: <1424822730-14938-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424822730-14938-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>
List-Id: linux-input@vger.kernel.org

We append "Pen", "Pad", "Mouse" or "Keyboard" suffix to the appropriate
input node to match what the Wacom driver does and be more convenient for
the user to know which one is which.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-uclogic.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/hid/hid-uclogic.c b/drivers/hid/hid-uclogic.c
index c03e076..7042238 100644
--- a/drivers/hid/hid-uclogic.c
+++ b/drivers/hid/hid-uclogic.c
@@ -713,6 +713,45 @@ static __u8 *uclogic_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	return rdesc;
 }
 
+static void uclogic_input_configured(struct hid_device *hdev,
+		struct hid_input *hi)
+{
+	char *name;
+	const char *suffix = NULL;
+	struct hid_field *field;
+	size_t len;
+
+	/* no report associated (HID_QUIRK_MULTI_INPUT not set) */
+	if (!hi->report)
+		return;
+
+	field = hi->report->field[0];
+
+	switch (field->application) {
+	case HID_GD_KEYBOARD:
+		suffix = "Keyboard";
+		break;
+	case HID_GD_MOUSE:
+		suffix = "Mouse";
+		break;
+	case HID_GD_KEYPAD:
+		suffix = "Pad";
+		break;
+	case HID_DG_PEN:
+		suffix = "Pen";
+		break;
+	}
+
+	if (suffix) {
+		len = strlen(hdev->name) + 2 + strlen(suffix);
+		name = devm_kzalloc(&hi->input->dev, len, GFP_KERNEL);
+		if (name) {
+			snprintf(name, len, "%s %s", hdev->name, suffix);
+			hi->input->name = name;
+		}
+	}
+}
+
 /**
  * Enable fully-functional tablet mode and determine device parameters.
  *
@@ -906,6 +945,7 @@ static struct hid_driver uclogic_driver = {
 	.probe = uclogic_probe,
 	.report_fixup = uclogic_report_fixup,
 	.raw_event = uclogic_raw_event,
+	.input_configured = uclogic_input_configured,
 };
 module_hid_driver(uclogic_driver);
 
-- 
2.1.0
