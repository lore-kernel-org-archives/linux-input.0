From: Sebastian Keller <sebastiankeller@fastmail.net>
Subject: [PATCH] drivers: hid: hid-wiimote-modules: fixed code style errors
Date: Wed,  5 Feb 2014 00:54:28 +0100
Message-ID: <1391558068-10715-1-git-send-email-sebastiankeller@fastmail.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:48908 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754862AbaBDXyo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Feb 2014 18:54:44 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dh.herrmann@googlemail.com
Cc: linux-input@vger.kernel.org, Sebastian Keller <sebastiankeller@fastmail.net>

Realigned the switch case blocks
Added a space to an (void *) cast

Signed-off-by: Sebastian Keller <sebastiankeller@fastmail.net>
---
 drivers/hid/hid-wiimote-modules.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
index 6b61f01..1882bce 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -353,7 +353,7 @@ static int wiimod_led_probe(const struct wiimod_ops *ops,
 	if (!led)
 		return -ENOMEM;
 
-	name = (void*)&led[1];
+	name = (void *)&led[1];
 	snprintf(name, namesz, "%s:blue:p%lu", dev_name(dev), ops->arg);
 	led->name = name;
 	led->brightness = 0;
@@ -689,15 +689,15 @@ static int wiimod_ir_change(struct wiimote_data *wdata, __u16 mode)
 
 	/* put IR cam into desired state */
 	switch (mode) {
-		case WIIPROTO_FLAG_IR_FULL:
-			format = 5;
-			break;
-		case WIIPROTO_FLAG_IR_EXT:
-			format = 3;
-			break;
-		case WIIPROTO_FLAG_IR_BASIC:
-			format = 1;
-			break;
+	case WIIPROTO_FLAG_IR_FULL:
+		format = 5;
+		break;
+	case WIIPROTO_FLAG_IR_EXT:
+		format = 3;
+		break;
+	case WIIPROTO_FLAG_IR_BASIC:
+		format = 1;
+		break;
 	}
 	ret = wiimote_cmd_write(wdata, 0xb00033, &format, sizeof(format));
 	if (ret)
-- 
1.8.5.3

