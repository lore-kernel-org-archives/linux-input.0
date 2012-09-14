From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] Input: wacom - Mark Intuos5 pad as in-prox when touching buttons
Date: Fri, 14 Sep 2012 16:30:05 -0700
Message-ID: <1347665405-2078-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50436 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760291Ab2INXaY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Sep 2012 19:30:24 -0400
Received: by pbbrr13 with SMTP id rr13so6335226pbb.19
        for <linux-input@vger.kernel.org>; Fri, 14 Sep 2012 16:30:23 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linuxwacom-devel@lists.sourceforge.net, dmitry.torokhov@gmail.com, pinglinux@gmail.com, chris@cnpbagwell.com
Cc: Jason Gerecke <killertofu@gmail.com>

If the ExpressKeys on the Intuos5 are touched, they currently result
an out-of-prox packet being sent even if the pad is already out of
prox. This can cause some confusion in the X driver. To restore the
expected semantics, we make being touched a sufficient condition to
signal proximity.

https://bugs.freedesktop.org/show_bug.cgi?id=54250

Reported-by: Timo Aaltonen <tjaalton@ubuntu.com>
Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 drivers/input/tablet/wacom_wac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 532d067..9317109 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -606,7 +606,7 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 				input_report_abs(input, ABS_WHEEL, 0);
 			}
 
-			if (data[2] | (data[3] & 0x01) | data[4]) {
+			if (data[2] | (data[3] & 0x01) | data[4] | data[5]) {
 				input_report_key(input, wacom->tool[1], 1);
 				input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
 			} else {
-- 
1.7.12

