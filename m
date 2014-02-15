From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH] HID: sony: Correct Sixaxis battery reporting
Date: Sat, 15 Feb 2014 13:35:42 -0500
Message-ID: <1392489342-5401-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:62122 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753480AbaBOSgB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 15 Feb 2014 13:36:01 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

The battery_charging and cable_state flags were backwards on the Sixaxis.
The low bit of report byte 30 is 0 when charging and 1 when not.
Bit 5 of byte 31 is 0 when a USB cable is connected and 1 when not.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---
 drivers/hid/hid-sony.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 8eac6a6..283b2a3 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -850,12 +850,12 @@ static void sixaxis_parse_report(struct sony_sc *sc, __u8 *rd, int size)
 	 */
 	if (rd[30] >= 0xee) {
 		battery_capacity = 100;
-		battery_charging = rd[30] & 0x01;
+		battery_charging = !(rd[30] & 0x01);
 	} else {
 		battery_capacity = sixaxis_battery_capacity[rd[30]];
 		battery_charging = 0;
 	}
-	cable_state = (rd[31] >> 4) & 0x01;
+	cable_state = !((rd[31] >> 4) & 0x01);
 
 	spin_lock_irqsave(&sc->lock, flags);
 	sc->cable_state = cable_state;
-- 
1.8.5.3

