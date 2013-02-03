From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V2 04/14] Input: ALPS - Introduce helper function for repeated commands
Date: Sun,  3 Feb 2013 15:56:44 -0800
Message-ID: <1359935815-13507-5-git-send-email-cernekee@gmail.com>
References: <1359935815-13507-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:38456 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753883Ab3BCX5X (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Feb 2013 18:57:23 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so2384630dak.19
        for <linux-input@vger.kernel.org>; Sun, 03 Feb 2013 15:57:22 -0800 (PST)
In-Reply-To: <1359935815-13507-1-git-send-email-cernekee@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: seth.forshee@canonical.com, emmanuel.thome@inria.fr, dturvene@dahetral.com, vincent.vanackere@gmail.com, bgamari@gmail.com, linux-input@vger.kernel.org

Several ALPS driver init sequences repeat a command three times, then
issue PSMOUSE_CMD_GETINFO to read the result.  Move this into a helper
function to simplify the code.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/input/mouse/alps.c |   71 +++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 41 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index c473549..1ca854b 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -964,24 +964,42 @@ static int alps_command_mode_write_reg(struct psmouse *psmouse, int addr,
 	return __alps_command_mode_write_reg(psmouse, value);
 }
 
+static int alps_rpt_cmd(struct psmouse *psmouse, int init_command,
+			int repeated_command, unsigned char *param)
+{
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
+
+	param[0] = 0;
+	if (init_command && ps2_command(ps2dev, param, init_command))
+		return -EIO;
+
+	if (ps2_command(ps2dev,  NULL, repeated_command) ||
+	    ps2_command(ps2dev,  NULL, repeated_command) ||
+	    ps2_command(ps2dev,  NULL, repeated_command))
+		return -EIO;
+
+	param[0] = param[1] = param[2] = 0xff;
+	if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
+		return -EIO;
+
+	psmouse_dbg(psmouse, "%2.2X report: %2.2x %2.2x %2.2x\n",
+		    repeated_command, param[0], param[1], param[2]);
+	return 0;
+}
+
 static int alps_enter_command_mode(struct psmouse *psmouse,
 				   unsigned char *resp)
 {
 	unsigned char param[4];
-	struct ps2dev *ps2dev = &psmouse->ps2dev;
 
-	if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_RESET_WRAP) ||
-	    ps2_command(ps2dev, NULL, PSMOUSE_CMD_RESET_WRAP) ||
-	    ps2_command(ps2dev, NULL, PSMOUSE_CMD_RESET_WRAP) ||
-	    ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO)) {
+	if (alps_rpt_cmd(psmouse, 0, PSMOUSE_CMD_RESET_WRAP, param)) {
 		psmouse_err(psmouse, "failed to enter command mode\n");
 		return -1;
 	}
 
 	if (param[0] != 0x88 && param[1] != 0x07) {
 		psmouse_dbg(psmouse,
-			    "unknown response while entering command mode: %2.2x %2.2x %2.2x\n",
-			    param[0], param[1], param[2]);
+			    "unknown response while entering command mode\n");
 		return -1;
 	}
 
@@ -1041,18 +1059,10 @@ static int alps_absolute_mode_v1_v2(struct psmouse *psmouse)
 
 static int alps_get_status(struct psmouse *psmouse, char *param)
 {
-	struct ps2dev *ps2dev = &psmouse->ps2dev;
-
 	/* Get status: 0xF5 0xF5 0xF5 0xE9 */
-	if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_DISABLE) ||
-	    ps2_command(ps2dev, NULL, PSMOUSE_CMD_DISABLE) ||
-	    ps2_command(ps2dev, NULL, PSMOUSE_CMD_DISABLE) ||
-	    ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
+	if (alps_rpt_cmd(psmouse, 0, PSMOUSE_CMD_DISABLE, param))
 		return -1;
 
-	psmouse_dbg(psmouse, "Status: %2.2x %2.2x %2.2x",
-		    param[0], param[1], param[2]);
-
 	return 0;
 }
 
@@ -1443,7 +1453,6 @@ static int alps_hw_init(struct psmouse *psmouse)
 
 static const struct alps_model_info *alps_get_model(struct psmouse *psmouse, int *version)
 {
-	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	static const unsigned char rates[] = { 0, 10, 20, 40, 60, 80, 100, 200 };
 	unsigned char param[4];
 	const struct alps_model_info *model = NULL;
@@ -1455,20 +1464,10 @@ static const struct alps_model_info *alps_get_model(struct psmouse *psmouse, int
 	 * The bits 0-2 of the first byte will be 1s if some buttons are
 	 * pressed.
 	 */
-	param[0] = 0;
-	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES) ||
-	    ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE11) ||
-	    ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE11) ||
-	    ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE11))
-		return NULL;
-
-	param[0] = param[1] = param[2] = 0xff;
-	if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
+	if (alps_rpt_cmd(psmouse, PSMOUSE_CMD_SETRES, PSMOUSE_CMD_SETSCALE11,
+			 param))
 		return NULL;
 
-	psmouse_dbg(psmouse, "E6 report: %2.2x %2.2x %2.2x",
-		    param[0], param[1], param[2]);
-
 	if ((param[0] & 0xf8) != 0 || param[1] != 0 ||
 	    (param[2] != 10 && param[2] != 100))
 		return NULL;
@@ -1477,20 +1476,10 @@ static const struct alps_model_info *alps_get_model(struct psmouse *psmouse, int
 	 * Now try "E7 report". Allowed responses are in
 	 * alps_model_data[].signature
 	 */
-	param[0] = 0;
-	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES) ||
-	    ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE21) ||
-	    ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE21) ||
-	    ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE21))
-		return NULL;
-
-	param[0] = param[1] = param[2] = 0xff;
-	if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
+	if (alps_rpt_cmd(psmouse, PSMOUSE_CMD_SETRES, PSMOUSE_CMD_SETSCALE21,
+			 param))
 		return NULL;
 
-	psmouse_dbg(psmouse, "E7 report: %2.2x %2.2x %2.2x",
-		    param[0], param[1], param[2]);
-
 	if (version) {
 		for (i = 0; i < ARRAY_SIZE(rates) && param[2] != rates[i]; i++)
 			/* empty */;
-- 
1.7.10.4

