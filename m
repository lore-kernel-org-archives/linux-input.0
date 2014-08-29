From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH] hid: sony: Set the Sixaxis cable state correctly
Date: Fri, 29 Aug 2014 13:11:52 -0400
Message-ID: <1409332312-2414-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.225]:20676 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753268AbaH2RML (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 29 Aug 2014 13:12:11 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

Bit 3 in byte 31 of the Sixaxis report indicates whether the battery is
charging or not charging as opposed to whether or not the cable is plugged in.
As a result, when connected via USB and fully charged, the power_supply status
is wrongly reported as 'Discharging' instead of 'Full'.

Use the battery level value to set the cable state so that the power status
is reported correctly as that seems to be the only reliable way to determine the
cable status on the Sixaxis.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---
 drivers/hid/hid-sony.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index c372368..ecc6616 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -935,12 +935,13 @@ static void sixaxis_parse_report(struct sony_sc *sc, __u8 *rd, int size)
 	if (rd[30] >= 0xee) {
 		battery_capacity = 100;
 		battery_charging = !(rd[30] & 0x01);
+		cable_state = 1;
 	} else {
 		__u8 index = rd[30] <= 5 ? rd[30] : 5;
 		battery_capacity = sixaxis_battery_capacity[index];
 		battery_charging = 0;
+		cable_state = 0;
 	}
-	cable_state = !(rd[31] & 0x04);
 
 	spin_lock_irqsave(&sc->lock, flags);
 	sc->cable_state = cable_state;
-- 
1.9.3

