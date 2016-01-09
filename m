From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 1/4] HID: wacom - request tool info only when we get general events
Date: Fri,  8 Jan 2016 17:14:54 -0800
Message-ID: <1452302094-5521-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35679 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593AbcAIBPS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Jan 2016 20:15:18 -0500
Received: by mail-pa0-f68.google.com with SMTP id gi1so29468090pac.2
        for <linux-input@vger.kernel.org>; Fri, 08 Jan 2016 17:15:17 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, killertofu@gmail.com, Ping Cheng <pingc@wacom.com>

Move wacom_intuos_schedule_prox_event inside wacom_intuos_general
so we don't call it when general event data isn't ready.

Signed-off-by: Ping Cheng <pingc@wacom.com>
Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index f706604..6449547 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -746,13 +746,6 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 		return 2;
 	}
 
-	/* don't report other events if we don't know the ID */
-	if (!wacom->id[idx]) {
-		/* but reschedule a read of the current tool */
-		wacom_intuos_schedule_prox_event(wacom);
-		return 1;
-	}
-
 	return 0;
 }
 
@@ -893,6 +886,13 @@ static int wacom_intuos_general(struct wacom_wac *wacom)
 		data[0] != WACOM_REPORT_INTUOS_PEN)
 		return 0;
 
+	/* don't report events if we don't know the tool ID */
+	if (!wacom->id[idx]) {
+		/* but reschedule a read of the current tool */
+		wacom_intuos_schedule_prox_event(wacom);
+		return 1;
+	}
+
 	x = (be16_to_cpup((__be16 *)&data[2]) << 1) | ((data[9] >> 1) & 1);
 	y = (be16_to_cpup((__be16 *)&data[4]) << 1) | (data[9] & 1);
 	distance = data[9] >> 2;
-- 
1.9.1

