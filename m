From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: [PATCH 1/5] Input: wacom_w8001 - use __set_bit for evbits
Date: Mon, 30 Nov 2015 13:38:12 +1000
Message-ID: <1448854696-32625-1-git-send-email-peter.hutterer@who-t.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:22020 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbbK3Dug (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Nov 2015 22:50:36 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Peter Hutterer <peter.hutterer@who-t.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
Acked-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
---
 drivers/input/touchscreen/wacom_w8001.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
index 2792ca3..d194d57 100644
--- a/drivers/input/touchscreen/wacom_w8001.c
+++ b/drivers/input/touchscreen/wacom_w8001.c
@@ -393,7 +393,8 @@ static int w8001_setup(struct w8001 *w8001)
 
 	msleep(250);	/* wait 250ms before querying the device */
 
-	dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+	__set_bit(EV_KEY, dev->evbit);
+	__set_bit(EV_ABS, dev->evbit);
 	strlcat(w8001->name, "Wacom Serial", sizeof(w8001->name));
 
 	__set_bit(INPUT_PROP_DIRECT, dev->propbit);
-- 
2.5.0

