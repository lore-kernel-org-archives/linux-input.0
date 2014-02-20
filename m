From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v2 3/5] HID: sony: Perform a boundry check on the sixaxis battery level index.
Date: Thu, 20 Feb 2014 11:36:02 -0500
Message-ID: <1392914164-31899-4-git-send-email-frank.praznik@oh.rr.com>
References: <1392914164-31899-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:53948 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755382AbaBTQgN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Feb 2014 11:36:13 -0500
In-Reply-To: <1392914164-31899-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dh.herrmann@gmail.com, jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

Make sure that an out-of-bounds read doesn't occur in the Sixaxis battery level
lookup table in the event that the controller sends an invalid battery status
value in the report.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---
 drivers/hid/hid-sony.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index a51a9c0..b39e3ab 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -854,7 +854,8 @@ static void sixaxis_parse_report(struct sony_sc *sc, __u8 *rd, int size)
 		battery_capacity = 100;
 		battery_charging = !(rd[30] & 0x01);
 	} else {
-		battery_capacity = sixaxis_battery_capacity[rd[30]];
+		__u8 index = rd[30] <= 5 ? rd[30] : 5;
+		battery_capacity = sixaxis_battery_capacity[index];
 		battery_charging = 0;
 	}
 	cable_state = !((rd[31] >> 4) & 0x01);
-- 
1.8.5.3

