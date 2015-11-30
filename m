From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: [PATCH 2/5] Input: wacom_w8001 - set BTN_TOOL_DOUBLETAP if we have 2fg support
Date: Mon, 30 Nov 2015 13:38:13 +1000
Message-ID: <1448854696-32625-2-git-send-email-peter.hutterer@who-t.net>
References: <1448854696-32625-1-git-send-email-peter.hutterer@who-t.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:22020 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073AbbK3Duh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Nov 2015 22:50:37 -0500
In-Reply-To: <1448854696-32625-1-git-send-email-peter.hutterer@who-t.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Peter Hutterer <peter.hutterer@who-t.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
Acked-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
---
 drivers/input/touchscreen/wacom_w8001.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
index d194d57..222006e 100644
--- a/drivers/input/touchscreen/wacom_w8001.c
+++ b/drivers/input/touchscreen/wacom_w8001.c
@@ -471,6 +471,7 @@ static int w8001_setup(struct w8001 *w8001)
 		case 5:
 			w8001->pktlen = W8001_PKTLEN_TOUCH2FG;
 
+			__set_bit(BTN_TOOL_DOUBLETAP, dev->keybit);
 			input_mt_init_slots(dev, 2, 0);
 			input_set_abs_params(dev, ABS_MT_POSITION_X,
 						0, touch.x, 0, 0);
-- 
2.5.0

