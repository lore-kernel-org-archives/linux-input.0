From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v2 3/6] HID: sony: Add Bluetooth output report formatting
Date: Thu, 30 Jan 2014 12:24:05 -0500
Message-ID: <1391102648-19381-4-git-send-email-frank.praznik@oh.rr.com>
References: <1391102648-19381-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:59584 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbaA3RYO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Jan 2014 12:24:14 -0500
In-Reply-To: <1391102648-19381-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, dh.herrmann@gmail.com, Frank Praznik <frank.praznik@oh.rr.com>

Add formatting and reporting for Dualshock 4 output reports on Bluetooth.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>

---
 drivers/hid/hid-sony.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 52162a9..4d12b4e 100644
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
@@ -1482,10 +1493,16 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	else if (sc->quirks & SIXAXIS_CONTROLLER_BT)
 		ret = sixaxis_set_operational_bt(hdev);
 	else if (sc->quirks & DUALSHOCK4_CONTROLLER_USB) {
-		if (hdev->ll_driver->output_report == NULL) {
+		if ((sc->quirks & DUALSHOCK4_CONTROLLER_USB) &&
+		     hdev->ll_driver->output_report == NULL) {
 			hid_err(hdev, "NULL output_report handler\n");
 			ret = -EINVAL;
 			goto err_stop;
+		} else if ((sc->quirks & DUALSHOCK4_CONTROLLER_BT) &&
+			    hdev->ll_driver->raw_request == NULL) {
+			hid_err(hdev, "NULL raw_request handler\n");
+			ret = -EINVAL;
+			goto err_stop;
 		}
 
 		/* The Dualshock 4 touchpad supports 2 touches and has a
-- 
1.8.5.3

