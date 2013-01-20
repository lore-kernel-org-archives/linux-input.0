From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 1/3] Input: ALPS - Introduce helper function for repeated
 commands
Date: Sun, 20 Jan 2013 01:31:14 -0800
Message-ID: <10bf6ea5c8f86eca66cd39498ca38d58@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [69.28.251.93] ([69.28.251.93]:45591 "EHLO b32.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751687Ab3ATJnc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Jan 2013 04:43:32 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: seth.forshee@canonical.com, linux-input@vger.kernel.org

Several ALPS driver init sequences repeat a command three times, then
issue PSMOUSE_CMD_GETINFO to read the result.  Move this into a helper
function to simplify the code.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/input/mouse/alps.c |   50 +++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index e229fa3..bb99923 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -967,16 +967,31 @@ static int alps_command_mode_write_reg(struct psmouse *psmouse, int addr,
 	return __alps_command_mode_write_reg(psmouse, value);
 }
 
+static int alps_rpt_cmd(struct ps2dev *ps2dev, int init_command,
+			int repeated_command, unsigned char *param)
+{
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
+	return 0;
+}
+
 static int alps_enter_command_mode(struct psmouse *psmouse,
 				   unsigned char *resp)
 {
 	unsigned char param[4];
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
 
-	if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_RESET_WRAP) ||
-	    ps2_command(ps2dev, NULL, PSMOUSE_CMD_RESET_WRAP) ||
-	    ps2_command(ps2dev, NULL, PSMOUSE_CMD_RESET_WRAP) ||
-	    ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO)) {
+	if (alps_rpt_cmd(ps2dev, 0, PSMOUSE_CMD_RESET_WRAP, param)) {
 		psmouse_err(psmouse, "failed to enter command mode\n");
 		return -1;
 	}
@@ -1015,15 +1030,8 @@ static const struct alps_model_info *alps_get_model(struct psmouse *psmouse, int
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
+	if (alps_rpt_cmd(ps2dev, PSMOUSE_CMD_SETRES, PSMOUSE_CMD_SETSCALE11,
+			 param))
 		return NULL;
 
 	psmouse_dbg(psmouse, "E6 report: %2.2x %2.2x %2.2x",
@@ -1037,15 +1045,8 @@ static const struct alps_model_info *alps_get_model(struct psmouse *psmouse, int
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
+	if (alps_rpt_cmd(ps2dev, PSMOUSE_CMD_SETRES, PSMOUSE_CMD_SETSCALE21,
+			 param))
 		return NULL;
 
 	psmouse_dbg(psmouse, "E7 report: %2.2x %2.2x %2.2x",
@@ -1140,10 +1141,7 @@ static int alps_get_status(struct psmouse *psmouse, char *param)
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
 
 	/* Get status: 0xF5 0xF5 0xF5 0xE9 */
-	if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_DISABLE) ||
-	    ps2_command(ps2dev, NULL, PSMOUSE_CMD_DISABLE) ||
-	    ps2_command(ps2dev, NULL, PSMOUSE_CMD_DISABLE) ||
-	    ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
+	if (alps_rpt_cmd(ps2dev, 0, PSMOUSE_CMD_DISABLE, param))
 		return -1;
 
 	psmouse_dbg(psmouse, "Status: %2.2x %2.2x %2.2x",
-- 
1.7.10.4

