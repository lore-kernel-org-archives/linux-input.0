From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 4/5] HID: sony: Send ds4 output reports on output end-point
Date: Tue,  4 Oct 2016 19:58:57 -0700
Message-ID: <1475636338-3779-5-git-send-email-roderick@gaikai.com>
References: <1475636338-3779-1-git-send-email-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:35487 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754476AbcJEDA3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 4 Oct 2016 23:00:29 -0400
Received: by mail-it0-f41.google.com with SMTP id r192so164666887ita.0
        for <linux-input@vger.kernel.org>; Tue, 04 Oct 2016 20:00:28 -0700 (PDT)
In-Reply-To: <1475636338-3779-1-git-send-email-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

Add a CRC value to each output report. This removes the need for the
'no output reports on interrupt end-point' quirk.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 drivers/hid/hid-sony.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 34988ce..24f7d19 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1895,7 +1895,7 @@ static void dualshock4_send_output_report(struct sony_sc *sc)
 	} else {
 		memset(buf, 0, DS4_OUTPUT_REPORT_0x11_SIZE);
 		buf[0] = 0x11;
-		buf[1] = 0x80;
+		buf[1] = 0xC0; /* HID + CRC */
 		buf[3] = 0x0F;
 		offset = 6;
 	}
@@ -1922,9 +1922,16 @@ static void dualshock4_send_output_report(struct sony_sc *sc)
 
 	if (sc->quirks & DUALSHOCK4_CONTROLLER_USB)
 		hid_hw_output_report(hdev, buf, DS4_OUTPUT_REPORT_0x05_SIZE);
-	else
-		hid_hw_raw_request(hdev, 0x11, buf, DS4_OUTPUT_REPORT_0x11_SIZE,
-				HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
+	else {
+		/* CRC generation */
+		u8 bthdr = 0xA2;
+		u32 crc;
+
+		crc = crc32_le(0xFFFFFFFF, &bthdr, 1);
+		crc = ~crc32_le(crc, buf, DS4_OUTPUT_REPORT_0x11_SIZE-4);
+		put_unaligned_le32(crc, &buf[74]);
+		hid_hw_output_report(hdev, buf, DS4_OUTPUT_REPORT_0x11_SIZE);
+	}
 }
 
 static void motion_send_output_report(struct sony_sc *sc)
@@ -2378,11 +2385,6 @@ static int sony_input_configured(struct hid_device *hdev,
 		sony_init_output_report(sc, sixaxis_send_output_report);
 	} else if (sc->quirks & DUALSHOCK4_CONTROLLER) {
 		if (sc->quirks & DUALSHOCK4_CONTROLLER_BT) {
-			/*
-			 * The DualShock 4 wants output reports sent on the ctrl
-			 * endpoint when connected via Bluetooth.
-			 */
-			hdev->quirks |= HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP;
 			ret = dualshock4_set_operational_bt(hdev);
 			if (ret < 0) {
 				hid_err(hdev, "failed to set the Dualshock 4 operational mode\n");
-- 
2.7.4

