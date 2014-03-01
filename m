From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH 1/6] HID: sony: Fix Sixaxis cable state detection
Date: Fri, 28 Feb 2014 22:58:56 -0500
Message-ID: <1393646341-16947-2-git-send-email-frank.praznik@oh.rr.com>
References: <1393646341-16947-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:39036 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791AbaCAD7Z (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Feb 2014 22:59:25 -0500
In-Reply-To: <1393646341-16947-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, dh.herrmann@gmail.com, Frank Praznik <frank.praznik@oh.rr.com>

Byte 31 of the Sixaxis report can change depending on whether or not the
controller is rumbling.  Using bit 3 is the only reliable way to detect the
state of the cable regardless of rumble activity.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---
 drivers/hid/hid-sony.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index b1aa6f0..31ba01a 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -864,7 +864,7 @@ static void sixaxis_parse_report(struct sony_sc *sc, __u8 *rd, int size)
 		battery_capacity = sixaxis_battery_capacity[index];
 		battery_charging = 0;
 	}
-	cable_state = !((rd[31] >> 4) & 0x01);
+	cable_state = !(rd[31] & 0x04);
 
 	spin_lock_irqsave(&sc->lock, flags);
 	sc->cable_state = cable_state;
-- 
1.8.5.3

