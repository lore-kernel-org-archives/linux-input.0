From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v3 3/6] HID: sony: Add Dualshock 4 Bluetooth output report formatting
Date: Wed,  5 Feb 2014 20:03:46 -0500
Message-ID: <1391648629-3077-4-git-send-email-frank.praznik@oh.rr.com>
References: <1391648629-3077-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:56652 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753036AbaBFBEQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Feb 2014 20:04:16 -0500
In-Reply-To: <1391648629-3077-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, dh.herrmann@gmail.com, Frank Praznik <frank.praznik@oh.rr.com>

Add formating for the Dualshock 4 output report data in Bluetooth mode.

In Bluetooth mode the Dualshock 4 wants output reports sent on the control
channel.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---

 v3 uses the inline hid_hw_raw_request inline function

 drivers/hid/hid-sony.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index e9775a1..59cd9d7 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1268,11 +1268,18 @@ static void dualshock4_state_worker(struct work_struct *work)
 	struct hid_device *hdev = sc->hdev;
 	int offset;
 
-	__u8 buf[32] = { 0 };
+	__u8 buf[78] = { 0 };
 
-	buf[0] = 0x05;
-	buf[1] = 0x03;
-	offset = 4;
+	if (sc->quirks & DUALSHOCK4_CONTROLLER_USB) {
+		buf[0] = 0x05;
+		buf[1] = 0x03;
+		offset = 4;
+	} else {
+		buf[0] = 0x11;
+		buf[1] = 0xB0;
+		buf[3] = 0x0F;
+		offset = 6;
+	}
 
 #ifdef CONFIG_SONY_FF
 	buf[offset++] = sc->right;
@@ -1285,7 +1292,11 @@ static void dualshock4_state_worker(struct work_struct *work)
 	buf[offset++] = sc->led_state[1];
 	buf[offset++] = sc->led_state[2];
 
-	hid_hw_output_report(hdev, buf, sizeof(buf));
+	if (sc->quirks & DUALSHOCK4_CONTROLLER_USB)
+		hid_hw_output_report(hdev, buf, 32);
+	else
+		hid_hw_raw_request(hdev, 0x11, buf, 78,
+				HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
 }
 
 #ifdef CONFIG_SONY_FF
-- 
1.8.5.3

