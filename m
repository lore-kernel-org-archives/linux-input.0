From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 1/3] Input: ALPS - Remove unused argument to alps_enter_command_mode()
Date: Sat, 16 Feb 2013 22:40:03 -0800
Message-ID: <1361083206-5094-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:39097 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752411Ab3BQGkV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Feb 2013 01:40:21 -0500
Received: by mail-pa0-f52.google.com with SMTP id fb1so2292647pad.25
        for <linux-input@vger.kernel.org>; Sat, 16 Feb 2013 22:40:20 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: seth.forshee@canonical.com, emmanuel.thome@inria.fr, dturvene@dahetral.com, vincent.vanackere@gmail.com, bgamari@gmail.com, jacmet@sunsite.dk, linux-input@vger.kernel.org

Now that alps_identify() explicitly issues an EC report using
alps_rpt_cmd(), we no longer need to look at the magic numbers returned
by alps_enter_command_mode().

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/input/mouse/alps.c |   18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)


Baseline for this series:
git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next


diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 7b99fc7..9c97531 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -994,8 +994,7 @@ static int alps_rpt_cmd(struct psmouse *psmouse, int init_command,
 	return 0;
 }
 
-static int alps_enter_command_mode(struct psmouse *psmouse,
-				   unsigned char *resp)
+static int alps_enter_command_mode(struct psmouse *psmouse)
 {
 	unsigned char param[4];
 
@@ -1009,9 +1008,6 @@ static int alps_enter_command_mode(struct psmouse *psmouse,
 			    "unknown response while entering command mode\n");
 		return -1;
 	}
-
-	if (resp)
-		*resp = param[2];
 	return 0;
 }
 
@@ -1176,7 +1172,7 @@ static int alps_passthrough_mode_v3(struct psmouse *psmouse,
 {
 	int reg_val, ret = -1;
 
-	if (alps_enter_command_mode(psmouse, NULL))
+	if (alps_enter_command_mode(psmouse))
 		return -1;
 
 	reg_val = alps_command_mode_read_reg(psmouse, reg_base + 0x0008);
@@ -1216,7 +1212,7 @@ static int alps_probe_trackstick_v3(struct psmouse *psmouse, int reg_base)
 {
 	int ret = -EIO, reg_val;
 
-	if (alps_enter_command_mode(psmouse, NULL))
+	if (alps_enter_command_mode(psmouse))
 		goto error;
 
 	reg_val = alps_command_mode_read_reg(psmouse, reg_base + 0x08);
@@ -1279,7 +1275,7 @@ static int alps_setup_trackstick_v3(struct psmouse *psmouse, int reg_base)
 		 * supported by this driver. If bit 1 isn't set the packet
 		 * format is different.
 		 */
-		if (alps_enter_command_mode(psmouse, NULL) ||
+		if (alps_enter_command_mode(psmouse) ||
 		    alps_command_mode_write_reg(psmouse,
 						reg_base + 0x08, 0x82) ||
 		    alps_exit_command_mode(psmouse))
@@ -1306,7 +1302,7 @@ static int alps_hw_init_v3(struct psmouse *psmouse)
 	    alps_setup_trackstick_v3(psmouse, ALPS_REG_BASE_PINNACLE) == -EIO)
 		goto error;
 
-	if (alps_enter_command_mode(psmouse, NULL) ||
+	if (alps_enter_command_mode(psmouse) ||
 	    alps_absolute_mode_v3(psmouse)) {
 		psmouse_err(psmouse, "Failed to enter absolute mode\n");
 		goto error;
@@ -1381,7 +1377,7 @@ static int alps_hw_init_rushmore_v3(struct psmouse *psmouse)
 			priv->flags &= ~ALPS_DUALPOINT;
 	}
 
-	if (alps_enter_command_mode(psmouse, NULL) ||
+	if (alps_enter_command_mode(psmouse) ||
 	    alps_command_mode_read_reg(psmouse, 0xc2d9) == -1 ||
 	    alps_command_mode_write_reg(psmouse, 0xc2cb, 0x00))
 		goto error;
@@ -1431,7 +1427,7 @@ static int alps_hw_init_v4(struct psmouse *psmouse)
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	unsigned char param[4];
 
-	if (alps_enter_command_mode(psmouse, NULL))
+	if (alps_enter_command_mode(psmouse))
 		goto error;
 
 	if (alps_absolute_mode_v4(psmouse)) {
-- 
1.7.10.4

