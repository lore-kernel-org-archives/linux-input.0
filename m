From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: synaptics - set minimum coordinates as reported by
 firmware
Date: Wed, 6 Jul 2011 23:57:05 -0700
Message-ID: <20110707065705.GH7658@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44534 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078Ab1GGG5L (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jul 2011 02:57:11 -0400
Received: by iwn6 with SMTP id 6so590418iwn.19
        for <linux-input@vger.kernel.org>; Wed, 06 Jul 2011 23:57:10 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Input <linux-input@vger.kernel.org>

Newer Synaptics firmware allows to query minimum coordinates reported by
the device, let's use this data.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/synaptics.c |   56 ++++++++++++++++++++++++++-------------
 drivers/input/mouse/synaptics.h |    8 ++++--
 2 files changed, 43 insertions(+), 21 deletions(-)


diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 86bd89a..5538fc6 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -207,27 +207,37 @@ static int synaptics_identify(struct psmouse *psmouse)
 static int synaptics_resolution(struct psmouse *psmouse)
 {
 	struct synaptics_data *priv = psmouse->private;
-	unsigned char res[3];
-	unsigned char max[3];
+	unsigned char resp[3];
 
 	if (SYN_ID_MAJOR(priv->identity) < 4)
 		return 0;
 
-	if (synaptics_send_cmd(psmouse, SYN_QUE_RESOLUTION, res) == 0) {
-		if (res[0] != 0 && (res[1] & 0x80) && res[2] != 0) {
-			priv->x_res = res[0]; /* x resolution in units/mm */
-			priv->y_res = res[2]; /* y resolution in units/mm */
+	if (synaptics_send_cmd(psmouse, SYN_QUE_RESOLUTION, resp) == 0) {
+		if (resp[0] != 0 && (resp[1] & 0x80) && resp[2] != 0) {
+			priv->x_res = resp[0]; /* x resolution in units/mm */
+			priv->y_res = resp[2]; /* y resolution in units/mm */
 		}
 	}
 
 	if (SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 5 &&
 	    SYN_CAP_MAX_DIMENSIONS(priv->ext_cap_0c)) {
-		if (synaptics_send_cmd(psmouse, SYN_QUE_EXT_DIMENSIONS, max)) {
-			printk(KERN_ERR "Synaptics claims to have dimensions query,"
-			       " but I'm not able to read it.\n");
+		if (synaptics_send_cmd(psmouse, SYN_QUE_EXT_MAX_COORDS, resp)) {
+			printk(KERN_ERR "Synaptics claims to have max coordinates"
+			       " query, but I'm not able to read it.\n");
+		} else {
+			priv->x_max = (resp[0] << 5) | ((resp[1] & 0x0f) << 1);
+			priv->y_max = (resp[2] << 5) | ((resp[1] & 0xf0) >> 3);
+		}
+	}
+
+	if (SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 7 &&
+	    SYN_CAP_MIN_DIMENSIONS(priv->ext_cap_0c)) {
+		if (synaptics_send_cmd(psmouse, SYN_QUE_EXT_MIN_COORDS, resp)) {
+			printk(KERN_ERR "Synaptics claims to have min coordinates"
+			       " query, but I'm not able to read it.\n");
 		} else {
-			priv->x_max = (max[0] << 5) | ((max[1] & 0x0f) << 1);
-			priv->y_max = (max[2] << 5) | ((max[1] & 0xf0) >> 3);
+			priv->x_min = (resp[0] << 5) | ((resp[1] & 0x0f) << 1);
+			priv->y_min = (resp[2] << 5) | ((resp[1] & 0xf0) >> 3);
 		}
 	}
 
@@ -693,19 +703,27 @@ static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
 	__set_bit(INPUT_PROP_POINTER, dev->propbit);
 
 	__set_bit(EV_ABS, dev->evbit);
-	input_set_abs_params(dev, ABS_X, XMIN_NOMINAL,
-			     priv->x_max ?: XMAX_NOMINAL, fuzz, 0);
-	input_set_abs_params(dev, ABS_Y, YMIN_NOMINAL,
-			     priv->y_max ?: YMAX_NOMINAL, fuzz, 0);
+	input_set_abs_params(dev, ABS_X,
+			     priv->x_min ?: XMIN_NOMINAL,
+			     priv->x_max ?: XMAX_NOMINAL,
+			     fuzz, 0);
+	input_set_abs_params(dev, ABS_Y,
+			     priv->y_min ?: YMIN_NOMINAL,
+			     priv->y_max ?: YMAX_NOMINAL,
+			     fuzz, 0);
 	input_set_abs_params(dev, ABS_PRESSURE, 0, 255, 0, 0);
 
 	if (SYN_CAP_ADV_GESTURE(priv->ext_cap_0c)) {
 		__set_bit(INPUT_PROP_SEMI_MT, dev->propbit);
 		input_mt_init_slots(dev, 2);
-		input_set_abs_params(dev, ABS_MT_POSITION_X, XMIN_NOMINAL,
-				     priv->x_max ?: XMAX_NOMINAL, fuzz, 0);
-		input_set_abs_params(dev, ABS_MT_POSITION_Y, YMIN_NOMINAL,
-				     priv->y_max ?: YMAX_NOMINAL, fuzz, 0);
+		input_set_abs_params(dev, ABS_MT_POSITION_X,
+				     priv->x_min ?: XMIN_NOMINAL,
+				     priv->x_max ?: XMAX_NOMINAL,
+				     fuzz, 0);
+		input_set_abs_params(dev, ABS_MT_POSITION_Y,
+				     priv->y_min ?: YMIN_NOMINAL,
+				     priv->y_max ?: YMAX_NOMINAL,
+				     fuzz, 0);
 
 		input_abs_set_res(dev, ABS_MT_POSITION_X, priv->x_res);
 		input_abs_set_res(dev, ABS_MT_POSITION_Y, priv->y_res);
diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
index b8025b0..a4394e1 100644
--- a/drivers/input/mouse/synaptics.h
+++ b/drivers/input/mouse/synaptics.h
@@ -19,7 +19,8 @@
 #define SYN_QUE_RESOLUTION		0x08
 #define SYN_QUE_EXT_CAPAB		0x09
 #define SYN_QUE_EXT_CAPAB_0C		0x0c
-#define SYN_QUE_EXT_DIMENSIONS		0x0d
+#define SYN_QUE_EXT_MAX_COORDS		0x0d
+#define SYN_QUE_EXT_MIN_COORDS		0x0f
 
 /* synatics modes */
 #define SYN_BIT_ABSOLUTE_MODE		(1 << 7)
@@ -73,10 +74,12 @@
  * 2	0x04	reduced filtering	firmware does less filtering on
  *					position data, driver should watch
  *					for noise.
+ * 2	0x20	report min		query 0x0f gives min coord reported
  */
 #define SYN_CAP_CLICKPAD(ex0c)		((ex0c) & 0x100000) /* 1-button ClickPad */
 #define SYN_CAP_CLICKPAD2BTN(ex0c)	((ex0c) & 0x000100) /* 2-button ClickPad */
 #define SYN_CAP_MAX_DIMENSIONS(ex0c)	((ex0c) & 0x020000)
+#define SYN_CAP_MIN_DIMENSIONS(ex0c)	((ex0c) & 0x000200)
 #define SYN_CAP_ADV_GESTURE(ex0c)	((ex0c) & 0x080000)
 #define SYN_CAP_REDUCED_FILTERING(ex0c)	((ex0c) & 0x000400)
 
@@ -134,7 +137,8 @@ struct synaptics_data {
 	unsigned long int ext_cap_0c;		/* Ext Caps from 0x0c query */
 	unsigned long int identity;		/* Identification */
 	unsigned int x_res, y_res;		/* X/Y resolution in units/mm */
-	unsigned int x_max, y_max;		/* Max dimensions (from FW) */
+	unsigned int x_max, y_max;		/* Max coordinates (from FW) */
+	unsigned int x_min, y_min;		/* Min coordinates (from FW) */
 
 	unsigned char pkt_type;			/* packet type - old, new, etc */
 	unsigned char mode;			/* current mode byte */
-- 
Dmitry
