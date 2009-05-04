From: Tero Saarni <tero.saarni@gmail.com>
Subject: [PATCH] Input: synaptics - add support for reporting x/y resolution
Date: Mon, 04 May 2009 21:19:05 +0300
Message-ID: <1241461145.29685.13.camel@hp>
References: <1241460369.29685.6.camel@hp>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f174.google.com ([209.85.218.174]:52097 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbZEDSTJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 May 2009 14:19:09 -0400
Received: by bwz22 with SMTP id 22so626693bwz.37
        for <linux-input@vger.kernel.org>; Mon, 04 May 2009 11:19:07 -0700 (PDT)
In-Reply-To: <1241460369.29685.6.camel@hp>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

Synaptics uses anisotropic coordinate system.  On wide touchpads
vertical coordinate resolution can be twice as high as horizontal
leading to unequal sensitivity.  Make x and y coordinate resolution
available so that differences can be compensated.

Signed-off-by: Tero Saarni <tero.saarni@gmail.com>

---

I'm reposting this to fix the line wrapping problems, sorry!

 drivers/input/mouse/synaptics.c |   27 +++++++++++++++++++++++++++
 drivers/input/mouse/synaptics.h |    2 ++
 include/linux/input.h           |    2 ++
 3 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index f3e4f7b..9363953 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -180,6 +180,29 @@ static int synaptics_identify(struct psmouse *psmouse)
 	return -1;
 }
 
+/*
+ * Read touchpad resolution
+ * Resolution is left zero if touchpad does not support the query
+ */
+static int synaptics_resolution(struct psmouse *psmouse)
+{
+	struct synaptics_data *priv = psmouse->private;
+	unsigned char res[3];
+
+	if (SYN_ID_MAJOR(priv->identity) < 4)
+		return 0;
+
+	if (synaptics_send_cmd(psmouse, SYN_QUE_RESOLUTION, res))
+		return 0;
+
+	if (res[1] == 0x80) {
+		priv->x_res = res[0];
+		priv->y_res = res[2];
+	}
+
+	return 0;
+}
+
 static int synaptics_query_hardware(struct psmouse *psmouse)
 {
 	if (synaptics_identify(psmouse))
@@ -188,6 +211,8 @@ static int synaptics_query_hardware(struct psmouse *psmouse)
 		return -1;
 	if (synaptics_capability(psmouse))
 		return -1;
+	if (synaptics_resolution(psmouse))
+		return -1;
 
 	return 0;
 }
@@ -534,6 +559,8 @@ static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
 	set_bit(EV_ABS, dev->evbit);
 	input_set_abs_params(dev, ABS_X, XMIN_NOMINAL, XMAX_NOMINAL, 0, 0);
 	input_set_abs_params(dev, ABS_Y, YMIN_NOMINAL, YMAX_NOMINAL, 0, 0);
+	input_set_abs_params(dev, ABS_RESX, 0, priv->x_res, 0, 0);
+	input_set_abs_params(dev, ABS_RESY, 0, priv->y_res, 0, 0);
 	input_set_abs_params(dev, ABS_PRESSURE, 0, 255, 0, 0);
 	set_bit(ABS_TOOL_WIDTH, dev->absbit);
 
diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
index 02aa4cf..e9a69c9 100644
--- a/drivers/input/mouse/synaptics.h
+++ b/drivers/input/mouse/synaptics.h
@@ -101,6 +101,8 @@ struct synaptics_data {
 	unsigned char pkt_type;			/* packet type - old, new, etc */
 	unsigned char mode;			/* current mode byte */
 	int scroll;
+	int x_res;                              /* x resolution in units/mm */
+	int y_res;                              /* y resolution in units/mm */
 };
 
 int synaptics_detect(struct psmouse *psmouse, int set_properties);
diff --git a/include/linux/input.h b/include/linux/input.h
index 0e6ff5d..53db780 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -645,6 +645,8 @@ struct input_absinfo {
 #define ABS_TILT_Y		0x1b
 #define ABS_TOOL_WIDTH		0x1c
 #define ABS_VOLUME		0x20
+#define ABS_RESX                0x26
+#define ABS_RESY                0x27
 #define ABS_MISC		0x28
 
 #define ABS_MT_TOUCH_MAJOR	0x30	/* Major axis of touching ellipse */
-- 
1.6.0.4



