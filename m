From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V2 07/14] Input: ALPS - Move {addr,nibble}_command settings into alps_set_defaults()
Date: Sun,  3 Feb 2013 15:56:47 -0800
Message-ID: <1359935815-13507-8-git-send-email-cernekee@gmail.com>
References: <1359935815-13507-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:63429 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753994Ab3BCX53 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Feb 2013 18:57:29 -0500
Received: by mail-pa0-f43.google.com with SMTP id bh2so743323pad.2
        for <linux-input@vger.kernel.org>; Sun, 03 Feb 2013 15:57:29 -0800 (PST)
In-Reply-To: <1359935815-13507-1-git-send-email-cernekee@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: seth.forshee@canonical.com, emmanuel.thome@inria.fr, dturvene@dahetral.com, vincent.vanackere@gmail.com, bgamari@gmail.com, linux-input@vger.kernel.org

This allows alps_identify() to override these settings based on the
device characteristics, if it is ever necessary.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/input/mouse/alps.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index ffe0fad..6b0b2b9 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1190,14 +1190,10 @@ static int alps_absolute_mode_v3(struct psmouse *psmouse)
 
 static int alps_hw_init_v3(struct psmouse *psmouse)
 {
-	struct alps_data *priv = psmouse->private;
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	int reg_val;
 	unsigned char param[4];
 
-	priv->nibble_commands = alps_v3_nibble_commands;
-	priv->addr_command = PSMOUSE_CMD_RESET_WRAP;
-
 	if (alps_enter_command_mode(psmouse, NULL))
 		goto error;
 
@@ -1343,13 +1339,9 @@ static int alps_absolute_mode_v4(struct psmouse *psmouse)
 
 static int alps_hw_init_v4(struct psmouse *psmouse)
 {
-	struct alps_data *priv = psmouse->private;
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	unsigned char param[4];
 
-	priv->nibble_commands = alps_v4_nibble_commands;
-	priv->addr_command = PSMOUSE_CMD_DISABLE;
-
 	if (alps_enter_command_mode(psmouse, NULL))
 		goto error;
 
@@ -1431,11 +1423,15 @@ static void alps_set_defaults(struct alps_data *priv)
 		priv->hw_init = alps_hw_init_v3;
 		priv->process_packet = alps_process_packet_v3;
 		priv->set_abs_params = alps_set_abs_params_mt;
+		priv->nibble_commands = alps_v3_nibble_commands;
+		priv->addr_command = PSMOUSE_CMD_RESET_WRAP;
 		break;
 	case ALPS_PROTO_V4:
 		priv->hw_init = alps_hw_init_v4;
 		priv->process_packet = alps_process_packet_v4;
 		priv->set_abs_params = alps_set_abs_params_mt;
+		priv->nibble_commands = alps_v4_nibble_commands;
+		priv->addr_command = PSMOUSE_CMD_DISABLE;
 		break;
 	}
 }
-- 
1.7.10.4

