From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v3 1/8] HID: sony: Fix Sixaxis cable state detection
Date: Sat, 15 Mar 2014 09:41:15 -0400
Message-ID: <1394890882-2039-2-git-send-email-frank.praznik@oh.rr.com>
References: <1394890882-2039-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.231]:38466 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756541AbaCONld (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 15 Mar 2014 09:41:33 -0400
In-Reply-To: <1394890882-2039-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

Byte 31 of the Sixaxis report can change depending on whether or not the
controller is rumbling.  Using bit 3 is the only reliable way to detect the
state of the cable regardless of rumble activity.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---
 drivers/hid/hid-sony.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 4884bb5..4c445a0 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -863,7 +863,7 @@ static void sixaxis_parse_report(struct sony_sc *sc, __u8 *rd, int size)
 		battery_capacity = sixaxis_battery_capacity[index];
 		battery_charging = 0;
 	}
-	cable_state = !((rd[31] >> 4) & 0x01);
+	cable_state = !(rd[31] & 0x04);
 
 	spin_lock_irqsave(&sc->lock, flags);
 	sc->cable_state = cable_state;
-- 
1.8.5.3

