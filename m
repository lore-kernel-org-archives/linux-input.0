From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: [PATCH 3/5] Input: wacom_w8001 - handle touch error case correctly
Date: Mon, 30 Nov 2015 13:38:14 +1000
Message-ID: <1448854696-32625-3-git-send-email-peter.hutterer@who-t.net>
References: <1448854696-32625-1-git-send-email-peter.hutterer@who-t.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:22020 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbbK3Dui (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Nov 2015 22:50:38 -0500
In-Reply-To: <1448854696-32625-1-git-send-email-peter.hutterer@who-t.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Peter Hutterer <peter.hutterer@who-t.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>

If a device failed at the pen setup and gets a zero reply from the touch
device, we need to return an error. Otherwise we have a device with
nothing but a name and the EV_KEY and EV_ABS bits.

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
Acked-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
---
 drivers/input/touchscreen/wacom_w8001.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
index 222006e..cdebf8e 100644
--- a/drivers/input/touchscreen/wacom_w8001.c
+++ b/drivers/input/touchscreen/wacom_w8001.c
@@ -385,7 +385,7 @@ static int w8001_setup(struct w8001 *w8001)
 	struct input_dev *dev = w8001->dev;
 	struct w8001_coord coord;
 	struct w8001_touch_query touch;
-	int error;
+	int error, err_pen, err_touch;
 
 	error = w8001_command(w8001, W8001_CMD_STOP, false);
 	if (error)
@@ -400,8 +400,8 @@ static int w8001_setup(struct w8001 *w8001)
 	__set_bit(INPUT_PROP_DIRECT, dev->propbit);
 
 	/* penabled? */
-	error = w8001_command(w8001, W8001_CMD_QUERY, true);
-	if (!error) {
+	err_pen = w8001_command(w8001, W8001_CMD_QUERY, true);
+	if (!err_pen) {
 		__set_bit(BTN_TOUCH, dev->keybit);
 		__set_bit(BTN_TOOL_PEN, dev->keybit);
 		__set_bit(BTN_TOOL_RUBBER, dev->keybit);
@@ -426,13 +426,15 @@ static int w8001_setup(struct w8001 *w8001)
 	}
 
 	/* Touch enabled? */
-	error = w8001_command(w8001, W8001_CMD_TOUCHQUERY, true);
+	err_touch = w8001_command(w8001, W8001_CMD_TOUCHQUERY, true);
 
 	/*
 	 * Some non-touch devices may reply to the touch query. But their
 	 * second byte is empty, which indicates touch is not supported.
 	 */
-	if (!error && w8001->response[1]) {
+	if (!err_touch && w8001->response[1]) {
+		err_touch = 1;
+
 		__set_bit(BTN_TOUCH, dev->keybit);
 		__set_bit(BTN_TOOL_FINGER, dev->keybit);
 
@@ -491,7 +493,7 @@ static int w8001_setup(struct w8001 *w8001)
 
 	strlcat(w8001->name, " Touchscreen", sizeof(w8001->name));
 
-	return 0;
+	return !err_pen || !err_touch;
 }
 
 /*
-- 
2.5.0

