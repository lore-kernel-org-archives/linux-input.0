From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: [PATCH v2 3/5] Input: wacom_w8001 - handle touch error case correctly
Date: Thu, 3 Dec 2015 14:21:45 +1000
Message-ID: <20151203042145.GA22439@jelly.redhat.com>
References: <20151201220156.GE3740@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:39365 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757454AbbLCEVz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Dec 2015 23:21:55 -0500
Content-Disposition: inline
In-Reply-To: <20151201220156.GE3740@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>

If a device failed at the pen setup and gets a zero reply from the touch
device, we need to return an error. Otherwise we have a device with
nothing but a name and the EV_KEY and EV_ABS bits.

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
Acked-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
---
Change to v1:
- return -ENXIO if the first byte is empty
- fix return statement to only return an error if both fail

 drivers/input/touchscreen/wacom_w8001.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
index 222006e..9ea5f82 100644
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
@@ -426,13 +426,12 @@ static int w8001_setup(struct w8001 *w8001)
 	}
 
 	/* Touch enabled? */
-	error = w8001_command(w8001, W8001_CMD_TOUCHQUERY, true);
+	err_touch = w8001_command(w8001, W8001_CMD_TOUCHQUERY, true);
 
-	/*
-	 * Some non-touch devices may reply to the touch query. But their
-	 * second byte is empty, which indicates touch is not supported.
-	 */
-	if (!error && w8001->response[1]) {
+	if (!err_touch && !w8001->response[1])
+		err_touch = -ENXIO;
+
+	if (!err_touch) {
 		__set_bit(BTN_TOUCH, dev->keybit);
 		__set_bit(BTN_TOOL_FINGER, dev->keybit);
 
@@ -491,7 +490,7 @@ static int w8001_setup(struct w8001 *w8001)
 
 	strlcat(w8001->name, " Touchscreen", sizeof(w8001->name));
 
-	return 0;
+	return !err_pen || !err_touch ? 0 : -ENXIO;
 }
 
 /*
-- 
2.5.0

