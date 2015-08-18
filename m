From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] HID: wacom: Use tablet-provided touch height/width values for INTUOSHT
Date: Mon, 17 Aug 2015 17:41:53 -0700
Message-ID: <1439858513-10581-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36265 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbbHRAmS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Aug 2015 20:42:18 -0400
Received: by pawq9 with SMTP id q9so21826714paw.3
        for <linux-input@vger.kernel.org>; Mon, 17 Aug 2015 17:42:18 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

The current generation of "Intuos" tablets (i.e. INTUOSHT) report touch
width and height data just like the "Intuos Pro" do. This commit changes
the code to allow these tablets to use the appropriate codepath instead
of the one intended for Intuos5/Bamboo.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index fe164df..3024a3c 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1772,7 +1772,7 @@ static void wacom_bpt3_touch_msg(struct wacom_wac *wacom, unsigned char *data)
 		int y = (data[3] << 4) | (data[4] & 0x0f);
 		int width, height;
 
-		if (features->type >= INTUOSPS && features->type <= INTUOSPL) {
+		if (features->type >= INTUOSPS && features->type <= INTUOSHT) {
 			width  = data[5] * 100;
 			height = data[6] * 100;
 		} else {
-- 
2.5.0

