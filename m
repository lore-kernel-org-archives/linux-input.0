From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/4] Input: synaptics - do not abuse -1 as return value
Date: Fri, 24 Mar 2017 23:04:08 -0700
Message-ID: <20170325060409.40558-3-dmitry.torokhov@gmail.com>
References: <20170325060409.40558-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33495 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967189AbdCYGES (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 25 Mar 2017 02:04:18 -0400
In-Reply-To: <20170325060409.40558-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Duggan <aduggan@synaptics.com>

Let's stop using -1 as a universal return value and instead propagate
errors from underlying calls up the stack.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/synaptics.c | 71 ++++++++++++++++++++++++++---------------
 1 file changed, 46 insertions(+), 25 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index be2265bc386c..224269c849bb 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -82,12 +82,17 @@
 static int synaptics_mode_cmd(struct psmouse *psmouse, unsigned char mode)
 {
 	unsigned char param[1];
+	int error;
+
+	error = psmouse_sliced_command(psmouse, mode);
+	if (error)
+		return error;
 
-	if (psmouse_sliced_command(psmouse, mode))
-		return -1;
 	param[0] = SYN_PS_SET_MODE2;
-	if (ps2_command(&psmouse->ps2dev, param, PSMOUSE_CMD_SETRATE))
-		return -1;
+	error = ps2_command(&psmouse->ps2dev, param, PSMOUSE_CMD_SETRATE);
+	if (error)
+		return error;
+
 	return 0;
 }
 
@@ -534,16 +539,19 @@ static int synaptics_set_advanced_gesture_mode(struct psmouse *psmouse)
 {
 	static unsigned char param = 0xc8;
 	struct synaptics_data *priv = psmouse->private;
+	int error;
 
 	if (!(SYN_CAP_ADV_GESTURE(priv->info.ext_cap_0c) ||
 	      SYN_CAP_IMAGE_SENSOR(priv->info.ext_cap_0c)))
 		return 0;
 
-	if (psmouse_sliced_command(psmouse, SYN_QUE_MODEL))
-		return -1;
+	error = psmouse_sliced_command(psmouse, SYN_QUE_MODEL);
+	if (error)
+		return error;
 
-	if (ps2_command(&psmouse->ps2dev, &param, PSMOUSE_CMD_SETRATE))
-		return -1;
+	error = ps2_command(&psmouse->ps2dev, &param, PSMOUSE_CMD_SETRATE);
+	if (error)
+		return error;
 
 	/* Advanced gesture mode also sends multi finger data */
 	priv->info.capabilities |= BIT(1);
@@ -554,6 +562,7 @@ static int synaptics_set_advanced_gesture_mode(struct psmouse *psmouse)
 static int synaptics_set_mode(struct psmouse *psmouse)
 {
 	struct synaptics_data *priv = psmouse->private;
+	int error;
 
 	priv->mode = 0;
 	if (priv->absolute_mode)
@@ -565,13 +574,18 @@ static int synaptics_set_mode(struct psmouse *psmouse)
 	if (SYN_CAP_EXTENDED(priv->info.capabilities))
 		priv->mode |= SYN_BIT_W_MODE;
 
-	if (synaptics_mode_cmd(psmouse, priv->mode))
-		return -1;
+	error = synaptics_mode_cmd(psmouse, priv->mode);
+	if (error)
+		return error;
 
-	if (priv->absolute_mode &&
-	    synaptics_set_advanced_gesture_mode(psmouse)) {
-		psmouse_err(psmouse, "Advanced gesture mode init failed.\n");
-		return -1;
+	if (priv->absolute_mode) {
+		error = synaptics_set_advanced_gesture_mode(psmouse);
+		if (error) {
+			psmouse_err(psmouse,
+				    "Advanced gesture mode init failed: %d\n",
+				    error);
+			return error;
+		}
 	}
 
 	return 0;
@@ -598,12 +612,17 @@ static void synaptics_set_rate(struct psmouse *psmouse, unsigned int rate)
 static int synaptics_pt_write(struct serio *serio, unsigned char c)
 {
 	struct psmouse *parent = serio_get_drvdata(serio->parent);
-	char rate_param = SYN_PS_CLIENT_CMD; /* indicates that we want pass-through port */
+	u8 rate_param = SYN_PS_CLIENT_CMD; /* indicates that we want pass-through port */
+	int error;
+
+	error = psmouse_sliced_command(parent, c);
+	if (error)
+		return error;
+
+	error = ps2_command(&parent->ps2dev, &rate_param, PSMOUSE_CMD_SETRATE);
+	if (error)
+		return error;
 
-	if (psmouse_sliced_command(parent, c))
-		return -1;
-	if (ps2_command(&parent->ps2dev, &rate_param, PSMOUSE_CMD_SETRATE))
-		return -1;
 	return 0;
 }
 
@@ -1395,19 +1414,21 @@ static int synaptics_reconnect(struct psmouse *psmouse)
 	} while (error && ++retry < 3);
 
 	if (error)
-		return -1;
+		return error;
 
 	if (retry > 1)
 		psmouse_dbg(psmouse, "reconnected after %d tries\n", retry);
 
-	if (synaptics_query_hardware(psmouse, &info)) {
+	error = synaptics_query_hardware(psmouse, &info);
+	if (error) {
 		psmouse_err(psmouse, "Unable to query device.\n");
-		return -1;
+		return error;
 	}
 
-	if (synaptics_set_mode(psmouse)) {
+	error = synaptics_set_mode(psmouse);
+	if (error) {
 		psmouse_err(psmouse, "Unable to initialize device.\n");
-		return -1;
+		return error;
 	}
 
 	if (info.identity != priv->info.identity ||
@@ -1420,7 +1441,7 @@ static int synaptics_reconnect(struct psmouse *psmouse)
 			    priv->info.model_id, info.model_id,
 			    priv->info.capabilities, info.capabilities,
 			    priv->info.ext_cap, info.ext_cap);
-		return -1;
+		return -ENXIO;
 	}
 
 	return 0;
-- 
2.12.1.578.ge9c3154ca4-goog

