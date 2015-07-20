From: Andrew Shadura <andrew.shadura@collabora.co.uk>
Subject: [PATCH] HID: update PenMount USB report descriptor so that only one button is reported
Date: Mon, 20 Jul 2015 14:07:44 +0200
Message-ID: <1437394064-13881-1-git-send-email-andrew.shadura@collabora.co.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:44558 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755632AbbGTMIR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jul 2015 08:08:17 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Input Mailing List <linux-input@vger.kernel.org>

PenMount USB resistive touchscreen reports it has three buttons, while in reality
it doesn't have any and doesn't support active styli, and only generates touch
events.

Signed-off-by: Andrew Shadura <andrew.shadura@collabora.co.uk>
---
 drivers/hid/hid-penmount.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/hid/hid-penmount.c b/drivers/hid/hid-penmount.c
index c11dce8..4e12502 100644
--- a/drivers/hid/hid-penmount.c
+++ b/drivers/hid/hid-penmount.c
@@ -30,6 +30,21 @@ static int penmount_input_mapping(struct hid_device *hdev,
 	return 0;
 }
 
+static __u8 *penmount_report_fixup(struct hid_device *hdev, __u8 *rdesc,
+        unsigned int *rsize)
+{
+	if (*rsize == 76 &&
+		rdesc[2] == 0x09 && rdesc[3] == 0x02 /* mouse */ &&
+		rdesc[22] == 0x05 && rdesc[23] == 0x09 /* button */ &&
+		rdesc[26] == 0x29 && rdesc[27] == 0x03 /* maximum */) {
+		hid_info(hdev,
+			"fixing up PenMount USB touchscreen report descriptor\n");
+
+		rdesc[27] = 0x01; /* just one button */
+	}
+	return rdesc;
+}
+
 static const struct hid_device_id penmount_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_PENMOUNT_6000) },
 	{ }
@@ -39,6 +54,7 @@ MODULE_DEVICE_TABLE(hid, penmount_devices);
 static struct hid_driver penmount_driver = {
 	.name = "hid-penmount",
 	.id_table = penmount_devices,
+	.report_fixup = penmount_report_fixup,
 	.input_mapping = penmount_input_mapping,
 };
 
-- 
2.1.4

