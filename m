From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH] hid: sony: Drop invalid Sixaxis input reports
Date: Thu, 23 Jul 2015 19:01:16 -0400
Message-ID: <1437692476-12557-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.229]:65088 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753682AbbGWXEf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jul 2015 19:04:35 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: simon@mungewell.org, jkosina@suse.cz, virtuousfox@gmail.com, Frank Praznik <frank.praznik@oh.rr.com>

When connected via Bluetooth the sixaxis periodically sends reports with
an ID of 1, the second byte 0xff and the rest zeroed.  These reports are
not related to the controller state and must be dropped to avoid generating
false input events.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---
 drivers/hid/hid-sony.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index ed2f008..beb2b02 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1270,6 +1270,17 @@ static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
 	 * has to be BYTE_SWAPPED before passing up to joystick interface
 	 */
 	if ((sc->quirks & SIXAXIS_CONTROLLER) && rd[0] == 0x01 && size == 49) {
+		/*
+		 * When connected via Bluetooth the Sixaxis occasionally sends
+		 * a report with the second byte 0xff and the rest zeroed.
+		 *
+		 * This report does not reflect the actual state of the
+		 * controller must be ignored to avoid generating false input
+		 * events.
+		 */
+		if (rd[1] == 0xff)
+			return -EINVAL;
+
 		swap(rd[41], rd[42]);
 		swap(rd[43], rd[44]);
 		swap(rd[45], rd[46]);
-- 
2.4.3

