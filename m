From: Sebastian Keller <sebastiankeller@fastmail.net>
Subject: [PATCH] drivers: hid: hid-wiimote-modules: fixed code style errors
Date: Wed,  5 Feb 2014 01:45:23 +0100
Message-ID: <1391561123-12194-1-git-send-email-sebastiankeller@fastmail.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:52233 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753801AbaBEApd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Feb 2014 19:45:33 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dh.herrmann@gmail.com
Cc: linux-input@vger.kernel.org, Sebastian Keller <sebastiankeller@fastmail.net>

realigned case statements

Signed-off-by: Sebastian Keller <sebastiankeller@fastmail.net>
---
 drivers/hid/hid-wiimote-modules.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
index 6b61f01..b8306c2 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
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

