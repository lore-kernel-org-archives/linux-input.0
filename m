From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 2/2] HID: huion: split the stylus and pad in 2 nodes
Date: Tue, 17 Feb 2015 17:54:13 -0500
Message-ID: <1424213653-5970-3-git-send-email-benjamin.tissoires@redhat.com>
References: <1424213653-5970-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55910 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753076AbbBQWyX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Feb 2015 17:54:23 -0500
In-Reply-To: <1424213653-5970-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>, Jiri Kosina <jkosina@suse.cz>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Libinput expects the pad node to be different from the stylus one.
We can just use HID_QUIRK_MULTI_INPUT to separate the buttons of the
pad than the actual stylus.
We can also remove the unused interfaces.
Last, we append "Pen" or "Pad" suffix to the appropriate input node
to match what the Wacom driver does and be more convenient for the users
to know which one is which.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-huion.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/hid/hid-huion.c b/drivers/hid/hid-huion.c
index 50fbda4..f298f66 100644
--- a/drivers/hid/hid-huion.c
+++ b/drivers/hid/hid-huion.c
@@ -142,6 +142,33 @@ static __u8 *huion_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	return rdesc;
 }
 
+static void huion_input_configured(struct hid_device *hdev,
+		struct hid_input *hi)
+{
+	char *name;
+	const char *suffix = NULL;
+	struct hid_field *field = hi->report->field[0];
+
+	switch (field->application) {
+	case HID_GD_KEYPAD:
+		suffix = "Pad";
+		break;
+	case HID_DG_PEN:
+		suffix = "Pen";
+		break;
+	}
+
+	if (suffix) {
+		name = devm_kzalloc(&hi->input->dev,
+				    strlen(hdev->name) + strlen(suffix) + 2,
+				    GFP_KERNEL);
+		if (name) {
+			sprintf(name, "%s %s", hdev->name, suffix);
+			hi->input->name = name;
+		}
+	}
+}
+
 /**
  * Enable fully-functional tablet mode and determine device parameters.
  *
@@ -282,6 +309,9 @@ static int huion_probe(struct hid_device *hdev, const struct hid_device_id *id)
 				hid_err(hdev, "tablet enabling failed\n");
 				return rc;
 			}
+			hdev->quirks |= HID_QUIRK_MULTI_INPUT;
+		} else {
+			return -ENODEV;
 		}
 		break;
 	}
@@ -335,6 +365,7 @@ static struct hid_driver huion_driver = {
 	.probe = huion_probe,
 	.report_fixup = huion_report_fixup,
 	.raw_event = huion_raw_event,
+	.input_configured = huion_input_configured,
 };
 module_hid_driver(huion_driver);
 
-- 
2.1.0

