From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH v2] Input: atmel_mxt_ts - Support 12bit resolution
Date: Fri, 08 Apr 2011 14:44:06 +0900
Message-ID: <1302241446-29201-1-git-send-email-jy0922.shim@samsung.com>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:34248 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554Ab1DHFox (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Apr 2011 01:44:53 -0400
Received: from epmmp2 (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LJB00APFJYRPI60@mailout3.samsung.com> for
 linux-input@vger.kernel.org; Fri, 08 Apr 2011 14:44:51 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LJB00B17JYRS8@mmp2.samsung.com> for
 linux-input@vger.kernel.org; Fri, 08 Apr 2011 14:44:51 +0900 (KST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, iiro.valkonen@atmel.com, kyungmin.park@samsung.com

Atmel touchscreen chip can support 12bit resolution and this patch
modifies to get maximum x and y size from platform data.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
v2: Fix absinfo->maximum value of x and y

 drivers/input/touchscreen/atmel_mxt_ts.c |   53 ++++++++++++++++++++++--------
 1 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 4012436..a97905a 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -196,9 +196,12 @@
 #define MXT_PRESS		(1 << 6)
 #define MXT_DETECT		(1 << 7)
 
+/* Touch orient bits */
+#define MXT_XY_SWITCH		(1 << 0)
+#define MXT_X_INVERT		(1 << 1)
+#define MXT_Y_INVERT		(1 << 2)
+
 /* Touchscreen absolute values */
-#define MXT_MAX_XC		0x3ff
-#define MXT_MAX_YC		0x3ff
 #define MXT_MAX_AREA		0xff
 
 #define MXT_MAX_FINGER		10
@@ -246,6 +249,8 @@ struct mxt_data {
 	struct mxt_info info;
 	struct mxt_finger finger[MXT_MAX_FINGER];
 	unsigned int irq;
+	unsigned int max_x;
+	unsigned int max_y;
 };
 
 static bool mxt_object_readable(unsigned int type)
@@ -549,8 +554,13 @@ static void mxt_input_touchevent(struct mxt_data *data,
 	if (!(status & (MXT_PRESS | MXT_MOVE)))
 		return;
 
-	x = (message->message[1] << 2) | ((message->message[3] & ~0x3f) >> 6);
-	y = (message->message[2] << 2) | ((message->message[3] & ~0xf3) >> 2);
+	x = (message->message[1] << 4) | ((message->message[3] >> 4) & 0xf);
+	y = (message->message[2] << 4) | ((message->message[3] & 0xf));
+	if (data->max_x < 1024)
+		x = x >> 2;
+	if (data->max_y < 1024)
+		y = y >> 2;
+
 	area = message->message[4];
 
 	dev_dbg(dev, "[%d] %s x: %d, y: %d, area: %d\n", id,
@@ -845,6 +855,20 @@ static int mxt_initialize(struct mxt_data *data)
 	return 0;
 }
 
+static void mxt_calc_resolution(struct mxt_data *data)
+{
+	unsigned int max_x = data->pdata->x_size - 1;
+	unsigned int max_y = data->pdata->y_size - 1;
+
+	if (data->pdata->orient & MXT_XY_SWITCH) {
+		data->max_x = max_y;
+		data->max_y = max_x;
+	} else {
+		data->max_x = max_x;
+		data->max_y = max_y;
+	}
+}
+
 static ssize_t mxt_object_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
@@ -1052,31 +1076,32 @@ static int __devinit mxt_probe(struct i2c_client *client,
 	input_dev->open = mxt_input_open;
 	input_dev->close = mxt_input_close;
 
+	data->client = client;
+	data->input_dev = input_dev;
+	data->pdata = pdata;
+	data->irq = client->irq;
+
+	mxt_calc_resolution(data);
+
 	__set_bit(EV_ABS, input_dev->evbit);
 	__set_bit(EV_KEY, input_dev->evbit);
 	__set_bit(BTN_TOUCH, input_dev->keybit);
 
 	/* For single touch */
 	input_set_abs_params(input_dev, ABS_X,
-			     0, MXT_MAX_XC, 0, 0);
+			     0, data->max_x, 0, 0);
 	input_set_abs_params(input_dev, ABS_Y,
-			     0, MXT_MAX_YC, 0, 0);
+			     0, data->max_y, 0, 0);
 
 	/* For multi touch */
 	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR,
 			     0, MXT_MAX_AREA, 0, 0);
 	input_set_abs_params(input_dev, ABS_MT_POSITION_X,
-			     0, MXT_MAX_XC, 0, 0);
+			     0, data->max_x, 0, 0);
 	input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
-			     0, MXT_MAX_YC, 0, 0);
+			     0, data->max_y, 0, 0);
 
 	input_set_drvdata(input_dev, data);
-
-	data->client = client;
-	data->input_dev = input_dev;
-	data->pdata = pdata;
-	data->irq = client->irq;
-
 	i2c_set_clientdata(client, data);
 
 	error = mxt_initialize(data);
-- 
1.7.0.4

