From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH 3/7] HID: sony: Add Bluetooth output report formatting for the Dualshock 4
Date: Wed, 29 Jan 2014 12:33:13 -0500
Message-ID: <1391016797-12842-4-git-send-email-frank.praznik@oh.rr.com>
References: <1391016797-12842-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:40514 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603AbaA2Rdv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jan 2014 12:33:51 -0500
In-Reply-To: <1391016797-12842-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

When connected via Bluetooth the Dualshock 4 wants rumble and LED data sent in
report 17, which is 77 bytes.

The format of the rumble and LED data is identical to running over USB, but the
starting offset is at 6 bytes instead of 4.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>

---
 drivers/hid/hid-sony.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 8e82073f..b35535e 100644
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
 
-	hdev->ll_driver->output_report(hdev, buf, sizeof(buf));
+	if (sc->quirks & DUALSHOCK4_CONTROLLER_USB)
+		hdev->ll_driver->output_report(hdev, buf, 32);
+	else
+		hdev->ll_driver->raw_request(hdev, 0x11, buf, 78,
+				HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
 }
 
 #ifdef CONFIG_SONY_FF
-- 
1.8.5.3

