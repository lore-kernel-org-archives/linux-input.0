From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [RFC/RFT] Synaptics -
Date: Tue, 20 Apr 2010 23:11:17 -0700
Message-ID: <20100421061116.GF4364@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:32940 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820Ab0DUGLW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Apr 2010 02:11:22 -0400
Received: by gyg13 with SMTP id 13so3643806gyg.19
        for <linux-input@vger.kernel.org>; Tue, 20 Apr 2010 23:11:22 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Christopher Heiny <cheiny@synaptics.com>, linux-input@vger.kernel.org

Newer Synaptics firmware allows to quesry maximim dimensions reported by
device, let's use this data.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

Takashi,

I would appreciate if you could give this patch a try.


Christofer,

Does this look about right?

Thank you!

 drivers/input/mouse/synaptics.c |   28 ++++++++++++++++++++--------
 drivers/input/mouse/synaptics.h |    3 +++
 2 files changed, 23 insertions(+), 8 deletions(-)


diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index ebd7a99..df608c5 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -201,16 +201,26 @@ static int synaptics_resolution(struct psmouse *psmouse)
 {
 	struct synaptics_data *priv = psmouse->private;
 	unsigned char res[3];
+	unsigned char max[3];
 
 	if (SYN_ID_MAJOR(priv->identity) < 4)
-		return 0;
 
-	if (synaptics_send_cmd(psmouse, SYN_QUE_RESOLUTION, res))
-		return 0;
+	if (synaptics_send_cmd(psmouse, SYN_QUE_RESOLUTION, res) == 0) {
+		if (res[0] != 0 && (res[1] & 0x80) && res[2] != 0) {
+			priv->x_res = res[0]; /* x resolution in units/mm */
+			priv->y_res = res[2]; /* y resolution in units/mm */
+		}
+	}
 
-	if ((res[0] != 0) && (res[1] & 0x80) && (res[2] != 0)) {
-		priv->x_res = res[0]; /* x resolution in units/mm */
-		priv->y_res = res[2]; /* y resolution in units/mm */
+	if (SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 5 &&
+	    SYN_CAP_MAX_DIMENSIONS(priv->ext_cap_0c)) {
+		if (synaptics_send_cmd(psmouse, SYN_QUE_EXT_DIMENSIONS, max)) {
+			printk(KERN_ERR "Synaptics claims to have dimensions query,"
+			       " but I'm not able to read it.\n");
+		} else {
+			priv->max_x = (max[0] << 5) | ((max[1] & 0x0f) << 1);
+			priv->max_y = (max[2] << 5) | ((max[1] & 0xf0) >> 3);
+		}
 	}
 
 	return 0;
@@ -578,8 +588,10 @@ static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
 	int i;
 
 	__set_bit(EV_ABS, dev->evbit);
-	input_set_abs_params(dev, ABS_X, XMIN_NOMINAL, XMAX_NOMINAL, 0, 0);
-	input_set_abs_params(dev, ABS_Y, YMIN_NOMINAL, YMAX_NOMINAL, 0, 0);
+	input_set_abs_params(dev, ABS_X,
+			     XMIN_NOMINAL, priv->max_x ?: XMAX_NOMINAL, 0, 0);
+	input_set_abs_params(dev, ABS_Y,
+			     YMIN_NOMINAL, priv->max_y ?: YMAX_NOMINAL, 0, 0);
 	input_set_abs_params(dev, ABS_PRESSURE, 0, 255, 0, 0);
 	__set_bit(ABS_TOOL_WIDTH, dev->absbit);
 
diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
index ae37c5d..6705c43 100644
--- a/drivers/input/mouse/synaptics.h
+++ b/drivers/input/mouse/synaptics.h
@@ -19,6 +19,7 @@
 #define SYN_QUE_RESOLUTION		0x08
 #define SYN_QUE_EXT_CAPAB		0x09
 #define SYN_QUE_EXT_CAPAB_0C		0x0c
+#define SYN_QUE_EXT_DIMENSIONS		0x0d
 
 /* synatics modes */
 #define SYN_BIT_ABSOLUTE_MODE		(1 << 7)
@@ -51,6 +52,7 @@
 #define SYN_CAP_MULTI_BUTTON_NO(ec)	(((ec) & 0x00f000) >> 12)
 #define SYN_CAP_PRODUCT_ID(ec)		(((ec) & 0xff0000) >> 16)
 #define SYN_CAP_CLICKPAD(ex0c)		((ex0c) & 0x100100)
+#define SYN_CAP_MAX_DIMENSIONS(ex0c)	((ex0c) & 0x02)
 
 /* synaptics modes query bits */
 #define SYN_MODE_ABSOLUTE(m)		((m) & (1 << 7))
@@ -100,6 +102,7 @@ struct synaptics_data {
 	unsigned long int capabilities;		/* Capabilities */
 	unsigned long int ext_cap;		/* Extended Capabilities */
 	unsigned long int ext_cap_0c;		/* Ext Caps from 0x0c query */
+	unsigned int max_x, max_y;		/* Max dimensions (from FW) */
 	unsigned long int identity;		/* Identification */
 	int x_res;				/* X resolution in units/mm */
 	int y_res;				/* Y resolution in units/mm */
-- 
Dmitry
