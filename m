From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: [PATCH 2/2] hid-mosart: support suspend/resume
Date: Mon, 13 Dec 2010 15:59:13 +0100
Message-ID: <1292252353-3029-3-git-send-email-benjamin.tissoires@enac.fr>
References: <1292252353-3029-1-git-send-email-benjamin.tissoires@enac.fr>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:39627 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758005Ab0LMPJe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Dec 2010 10:09:34 -0500
In-Reply-To: <1292252353-3029-1-git-send-email-benjamin.tissoires@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@enac.fr>

The device has 2 modes. The first one is an emulation of a touchscreen
by sending left and right button, and the second mode is the one used in
dual-touch (sending trackingID, touch and else).

In case of a suspend/resume, the device switch back to the first mode
described above (with left and right buttons).
This adds a hook in .reset_resume for the device to be switched to
the correct mode (I just copied the code in mosart_probe).

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
---
 drivers/hid/hid-mosart.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-mosart.c b/drivers/hid/hid-mosart.c
index acd8a49..15d0381 100644
--- a/drivers/hid/hid-mosart.c
+++ b/drivers/hid/hid-mosart.c
@@ -234,6 +234,19 @@ static int mosart_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	return ret;
 }
 
+#ifdef CONFIG_PM
+static int mosart_reset_resume(struct hid_device *hdev)
+{
+	struct hid_report_enum *re = hdev->report_enum
+						+ HID_FEATURE_REPORT;
+	struct hid_report *r = re->report_id_hash[7];
+
+	r->field[0]->value[0] = 0x02;
+	usbhid_submit_report(hdev, r, USB_DIR_OUT);
+	return 0;
+}
+#endif
+
 static void mosart_remove(struct hid_device *hdev)
 {
 	hid_hw_stop(hdev);
@@ -262,6 +275,9 @@ static struct hid_driver mosart_driver = {
 	.input_mapped = mosart_input_mapped,
 	.usage_table = mosart_grabbed_usages,
 	.event = mosart_event,
+#ifdef CONFIG_PM
+	.reset_resume = mosart_reset_resume,
+#endif
 };
 
 static int __init mosart_init(void)
-- 
1.7.3.2

