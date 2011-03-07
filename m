From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH 2/4] Input: atmel_mxt_ts - Support 12bit resolution
Date: Mon, 07 Mar 2011 17:42:14 +0900
Message-ID: <1299487335-24139-2-git-send-email-jy0922.shim@samsung.com>
References: <1299487335-24139-1-git-send-email-jy0922.shim@samsung.com>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:50812 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469Ab1CGImI (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Mar 2011 03:42:08 -0500
Received: from epmmp1 (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LHO00746IS6VJ90@mailout4.samsung.com> for
 linux-input@vger.kernel.org; Mon, 07 Mar 2011 17:40:54 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LHO00I3DIS6T0@mmp1.samsung.com> for
 linux-input@vger.kernel.org; Mon, 07 Mar 2011 17:40:54 +0900 (KST)
In-reply-to: <1299487335-24139-1-git-send-email-jy0922.shim@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, iiro.valkonen@atmel.com, kyungmin.park@samsung.com

Atmel touchscreen chip can support 12bit resolution and this patch
modifies to get maximum x and y size from platform data.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |   50 +++++++++++++++++++++--------
 1 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 0986fa4..0ed0b1f 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -192,9 +192,12 @@
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
@@ -242,6 +245,8 @@ struct mxt_data {
 	struct mxt_info info;
 	struct mxt_finger finger[MXT_MAX_FINGER];
 	unsigned int irq;
+	unsigned int x_size;
+	unsigned int y_size;
 };
 
 static bool mxt_object_readable(unsigned int type)
@@ -541,8 +546,13 @@ static void mxt_input_touchevent(struct mxt_data *data,
 	if (!(status & (MXT_PRESS | MXT_MOVE)))
 		return;
 
-	x = (message->message[1] << 2) | ((message->message[3] & ~0x3f) >> 6);
-	y = (message->message[2] << 2) | ((message->message[3] & ~0xf3) >> 2);
+	x = (message->message[1] << 4) | ((message->message[3] >> 4) & 0xf);
+	y = (message->message[2] << 4) | ((message->message[3] & 0xf));
+	if (data->x_size - 1 < 1024)
+		x = x >> 2;
+	if (data->y_size - 1 < 1024)
+		y = y >> 2;
+
 	area = message->message[4];
 
 	dev_dbg(dev, "[%d] %s x: %d, y: %d, area: %d\n", id,
@@ -837,6 +847,17 @@ static int mxt_initialize(struct mxt_data *data)
 	return 0;
 }
 
+static void mxt_calc_resolution(struct mxt_data *data)
+{
+	if (data->pdata->orient & MXT_XY_SWITCH) {
+		data->x_size = data->pdata->y_size;
+		data->y_size = data->pdata->x_size;
+	} else {
+		data->x_size = data->pdata->x_size;
+		data->y_size = data->pdata->y_size;
+	}
+}
+
 static ssize_t mxt_object_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
@@ -1044,31 +1065,32 @@ static int __devinit mxt_probe(struct i2c_client *client,
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
+			     0, data->x_size, 0, 0);
 	input_set_abs_params(input_dev, ABS_Y,
-			     0, MXT_MAX_YC, 0, 0);
+			     0, data->y_size, 0, 0);
 
 	/* For multi touch */
 	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR,
 			     0, MXT_MAX_AREA, 0, 0);
 	input_set_abs_params(input_dev, ABS_MT_POSITION_X,
-			     0, MXT_MAX_XC, 0, 0);
+			     0, data->x_size, 0, 0);
 	input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
-			     0, MXT_MAX_YC, 0, 0);
+			     0, data->y_size, 0, 0);
 
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

