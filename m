From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V2 13/14] Input: ALPS - Enable trackstick on Rushmore touchpads
Date: Sun,  3 Feb 2013 15:56:53 -0800
Message-ID: <1359935815-13507-14-git-send-email-cernekee@gmail.com>
References: <1359935815-13507-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:56416 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044Ab3BCX5m (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Feb 2013 18:57:42 -0500
Received: by mail-pb0-f47.google.com with SMTP id rp8so2873071pbb.34
        for <linux-input@vger.kernel.org>; Sun, 03 Feb 2013 15:57:41 -0800 (PST)
In-Reply-To: <1359935815-13507-1-git-send-email-cernekee@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: seth.forshee@canonical.com, emmanuel.thome@inria.fr, dturvene@dahetral.com, vincent.vanackere@gmail.com, bgamari@gmail.com, linux-input@vger.kernel.org

Separate out the common trackstick probe/setup sequences, then call them
from each of the v3 init functions.

Credits: Emmanual Thome furnished the information on the trackstick init
and how it affected the report format.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/input/mouse/alps.c |  185 +++++++++++++++++++++++++++-----------------
 1 file changed, 115 insertions(+), 70 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 801a4dc..3c7bd2f 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -29,6 +29,9 @@
  */
 #define ALPS_CMD_NIBBLE_10	0x01f2
 
+#define ALPS_REG_BASE_RUSHMORE	0xc2c0
+#define ALPS_REG_BASE_PINNACLE	0x0000
+
 static const struct alps_nibble_commands alps_v3_nibble_commands[] = {
 	{ PSMOUSE_CMD_SETPOLL,		0x00 }, /* 0 */
 	{ PSMOUSE_CMD_RESET_DIS,	0x00 }, /* 1 */
@@ -1166,26 +1169,31 @@ static int alps_hw_init_v1_v2(struct psmouse *psmouse)
 }
 
 /*
- * Enable or disable passthrough mode to the trackstick. Must be in
- * command mode when calling this function.
+ * Enable or disable passthrough mode to the trackstick.
  */
-static int alps_passthrough_mode_v3(struct psmouse *psmouse, bool enable)
+static int alps_passthrough_mode_v3(struct psmouse *psmouse,
+				    int reg_base, bool enable)
 {
-	int reg_val;
+	int reg_val, ret = -1;
 
-	reg_val = alps_command_mode_read_reg(psmouse, 0x0008);
-	if (reg_val == -1)
+	if (alps_enter_command_mode(psmouse, NULL))
 		return -1;
 
+	reg_val = alps_command_mode_read_reg(psmouse, reg_base + 0x0008);
+	if (reg_val == -1)
+		goto error;
+
 	if (enable)
 		reg_val |= 0x01;
 	else
 		reg_val &= ~0x01;
 
-	if (__alps_command_mode_write_reg(psmouse, reg_val))
-		return -1;
+	ret = __alps_command_mode_write_reg(psmouse, reg_val);
 
-	return 0;
+error:
+	if (alps_exit_command_mode(psmouse))
+		ret = -1;
+	return ret;
 }
 
 /* Must be in command mode when calling this function */
@@ -1204,69 +1212,102 @@ static int alps_absolute_mode_v3(struct psmouse *psmouse)
 	return 0;
 }
 
-static int alps_hw_init_v3(struct psmouse *psmouse)
+static int alps_probe_trackstick_v3(struct psmouse *psmouse, int reg_base)
 {
-	struct ps2dev *ps2dev = &psmouse->ps2dev;
-	int reg_val;
-	unsigned char param[4];
+	int ret = -EIO, reg_val;
 
 	if (alps_enter_command_mode(psmouse, NULL))
 		goto error;
 
-	/* Check for trackstick */
-	reg_val = alps_command_mode_read_reg(psmouse, 0x0008);
+	reg_val = alps_command_mode_read_reg(psmouse, reg_base + 0x08);
 	if (reg_val == -1)
 		goto error;
-	if (reg_val & 0x80) {
-		if (alps_passthrough_mode_v3(psmouse, true))
-			goto error;
-		if (alps_exit_command_mode(psmouse))
-			goto error;
+
+	/* bit 7: trackstick is present */
+	ret = reg_val & 0x80 ? 0 : -ENODEV;
+
+error:
+	alps_exit_command_mode(psmouse);
+	return ret;
+}
+
+static int alps_setup_trackstick_v3(struct psmouse *psmouse, int reg_base)
+{
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
+	int ret = 0;
+	unsigned char param[4];
+
+	if (alps_passthrough_mode_v3(psmouse, reg_base, true))
+		return -EIO;
+
+	/*
+	 * E7 report for the trackstick
+	 *
+	 * There have been reports of failures to seem to trace back
+	 * to the above trackstick check failing. When these occur
+	 * this E7 report fails, so when that happens we continue
+	 * with the assumption that there isn't a trackstick after
+	 * all.
+	 */
+	if (alps_rpt_cmd(psmouse, 0, PSMOUSE_CMD_SETSCALE21, param)) {
+		psmouse_warn(psmouse, "trackstick E7 report failed\n");
+		ret = -ENODEV;
+	} else {
+		psmouse_dbg(psmouse,
+			    "trackstick E7 report: %2.2x %2.2x %2.2x\n",
+			    param[0], param[1], param[2]);
 
 		/*
-		 * E7 report for the trackstick
-		 *
-		 * There have been reports of failures to seem to trace back
-		 * to the above trackstick check failing. When these occur
-		 * this E7 report fails, so when that happens we continue
-		 * with the assumption that there isn't a trackstick after
-		 * all.
+		 * Not sure what this does, but it is absolutely
+		 * essential. Without it, the touchpad does not
+		 * work at all and the trackstick just emits normal
+		 * PS/2 packets.
 		 */
-		param[0] = 0x64;
-		if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE21) ||
-		    ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE21) ||
-		    ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE21) ||
-		    ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO)) {
-			psmouse_warn(psmouse, "trackstick E7 report failed\n");
-		} else {
-			psmouse_dbg(psmouse,
-				    "trackstick E7 report: %2.2x %2.2x %2.2x\n",
-				    param[0], param[1], param[2]);
-
-			/*
-			 * Not sure what this does, but it is absolutely
-			 * essential. Without it, the touchpad does not
-			 * work at all and the trackstick just emits normal
-			 * PS/2 packets.
-			 */
-			if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE11) ||
-			    ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE11) ||
-			    ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE11) ||
-			    alps_command_mode_send_nibble(psmouse, 0x9) ||
-			    alps_command_mode_send_nibble(psmouse, 0x4)) {
-				psmouse_err(psmouse,
-					    "Error sending magic E6 sequence\n");
-				goto error_passthrough;
-			}
+		if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE11) ||
+		    ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE11) ||
+		    ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE11) ||
+		    alps_command_mode_send_nibble(psmouse, 0x9) ||
+		    alps_command_mode_send_nibble(psmouse, 0x4)) {
+			psmouse_err(psmouse,
+				    "Error sending magic E6 sequence\n");
+			ret = -EIO;
+			goto error;
 		}
 
-		if (alps_enter_command_mode(psmouse, NULL))
-			goto error_passthrough;
-		if (alps_passthrough_mode_v3(psmouse, false))
-			goto error;
+		/*
+		 * This ensures the trackstick packets are in the format
+		 * supported by this driver. If bit 1 isn't set the packet
+		 * format is different.
+		 */
+		if (alps_enter_command_mode(psmouse, NULL) ||
+		    alps_command_mode_write_reg(psmouse,
+						reg_base + 0x08, 0x82) ||
+		    alps_exit_command_mode(psmouse))
+			ret = -EIO;
 	}
 
-	if (alps_absolute_mode_v3(psmouse)) {
+error:
+	if (alps_passthrough_mode_v3(psmouse, reg_base, false))
+		ret = -EIO;
+
+	return ret;
+}
+
+static int alps_hw_init_v3(struct psmouse *psmouse)
+{
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
+	int reg_val;
+	unsigned char param[4];
+
+	reg_val = alps_probe_trackstick_v3(psmouse, ALPS_REG_BASE_PINNACLE);
+	if (reg_val == -EIO)
+		goto error;
+	if (reg_val == 0 &&
+	    alps_setup_trackstick_v3(psmouse, ALPS_REG_BASE_PINNACLE) == -EIO)
+		goto error;
+
+	if (alps_enter_command_mode(psmouse, NULL) ||
+	    alps_absolute_mode_v3(psmouse)) {
 		psmouse_err(psmouse, "Failed to enter absolute mode\n");
 		goto error;
 	}
@@ -1303,14 +1344,6 @@ static int alps_hw_init_v3(struct psmouse *psmouse)
 	if (alps_command_mode_write_reg(psmouse, 0x0162, 0x04))
 		goto error;
 
-	/*
-	 * This ensures the trackstick packets are in the format
-	 * supported by this driver. If bit 1 isn't set the packet
-	 * format is different.
-	 */
-	if (alps_command_mode_write_reg(psmouse, 0x0008, 0x82))
-		goto error;
-
 	alps_exit_command_mode(psmouse);
 
 	/* Set rate and enable data reporting */
@@ -1323,10 +1356,6 @@ static int alps_hw_init_v3(struct psmouse *psmouse)
 
 	return 0;
 
-error_passthrough:
-	/* Something failed while in passthrough mode, so try to get out */
-	if (!alps_enter_command_mode(psmouse, NULL))
-		alps_passthrough_mode_v3(psmouse, false);
 error:
 	/*
 	 * Leaving the touchpad in command mode will essentially render
@@ -1339,9 +1368,19 @@ error:
 
 static int alps_hw_init_rushmore_v3(struct psmouse *psmouse)
 {
+	struct alps_data *priv = psmouse->private;
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	int reg_val, ret = -1;
 
+	if (priv->flags & ALPS_DUALPOINT) {
+		reg_val = alps_setup_trackstick_v3(psmouse,
+						   ALPS_REG_BASE_RUSHMORE);
+		if (reg_val == -EIO)
+			goto error;
+		if (reg_val == -ENODEV)
+			priv->flags &= ~ALPS_DUALPOINT;
+	}
+
 	if (alps_enter_command_mode(psmouse, NULL) ||
 	    alps_command_mode_read_reg(psmouse, 0xc2d9) == -1 ||
 	    alps_command_mode_write_reg(psmouse, 0xc2cb, 0x00))
@@ -1563,6 +1602,12 @@ static int alps_identify(struct psmouse *psmouse, struct alps_data *priv)
 		priv->x_bits = 16;
 		priv->y_bits = 12;
 
+		/* hack to make addr_command, nibble_command available */
+		psmouse->private = priv;
+
+		if (alps_probe_trackstick_v3(psmouse, ALPS_REG_BASE_RUSHMORE))
+			priv->flags &= ~ALPS_DUALPOINT;
+
 		return 0;
 	} else if (ec[0] == 0x88 && ec[1] == 0x07 &&
 		   ec[2] >= 0x90 && ec[2] <= 0x9d) {
-- 
1.7.10.4

