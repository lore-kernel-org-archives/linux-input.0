From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 4/4] HID: wacom - Add quirks for INTUOSHT2 in range events
Date: Fri,  8 Jan 2016 17:16:25 -0800
Message-ID: <1452302185-5641-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34740 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281AbcAIBQc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Jan 2016 20:16:32 -0500
Received: by mail-pf0-f193.google.com with SMTP id 65so1311175pfd.1
        for <linux-input@vger.kernel.org>; Fri, 08 Jan 2016 17:16:32 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, killertofu@gmail.com, Ping Cheng <pingc@wacom.com>

INTUOSHT2 in range event is not used to indicate in proximity state.
INTUOSHT2 only has one stylus.

Signed-off-by: Ping Cheng <pingc@wacom.com>
Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 4 +++++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index af9ecf4..8ea2465 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -609,6 +609,7 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 		case 0x885: /* Intuos3 Marker Pen */
 		case 0x802: /* Intuos4/5 13HD/24HD General Pen */
 		case 0x804: /* Intuos4/5 13HD/24HD Marker Pen */
+		case 0x8e2: /* IntuosHT2 pen */
 		case 0x022:
 		case 0x100804: /* Intuos4/5 13HD/24HD Art Pen */
 		case 0x140802: /* Intuos4/5 13HD/24HD Classic Pen */
@@ -676,7 +677,8 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 
 	/* in Range */
 	if ((data[1] & 0xfe) == 0x20) {
-		wacom->shared->stylus_in_proximity = true;
+		if (features->type != INTUOSHT2)
+			wacom->shared->stylus_in_proximity = true;
 
 		/* in Range while exiting */
 		if (wacom->reporting_data) {
-- 
1.9.1

