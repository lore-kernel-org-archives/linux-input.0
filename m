From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] HID: wacom: Apply lowres quirk to BAMBOO_TOUCH devices
Date: Fri,  4 Dec 2015 14:45:27 -0800
Message-ID: <1449269127-23508-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34697 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755162AbbLDWpj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Dec 2015 17:45:39 -0500
Received: by pfbg73 with SMTP id g73so33375621pfb.1
        for <linux-input@vger.kernel.org>; Fri, 04 Dec 2015 14:45:39 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

When splitting the touch-only "BAMBOO_TOUCH" type out of the existing
"BAMBOO_PT" type in 3b164a00, the lowres quirk was not updated so that
it would continue to apply to these devices (effectively only the 0xD0).
The absence of this quirk does not significantly impact usability, but
is a correctness issue nonetheless.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 3953416..bec2300 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2421,7 +2421,7 @@ void wacom_setup_device_quirks(struct wacom *wacom)
 		features->quirks |= WACOM_QUIRK_BATTERY;
 
 	/* quirk for bamboo touch with 2 low res touches */
-	if (features->type == BAMBOO_PT &&
+	if ((features->type == BAMBOO_PT || features->type == BAMBOO_TOUCH) &&
 	    features->pktlen == WACOM_PKGLEN_BBTOUCH) {
 		features->x_max <<= 5;
 		features->y_max <<= 5;
-- 
2.6.2

