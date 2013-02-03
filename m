From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V2 03/14] Input: ALPS - Move alps_get_model() down below hw_init code
Date: Sun,  3 Feb 2013 15:56:43 -0800
Message-ID: <1359935815-13507-4-git-send-email-cernekee@gmail.com>
References: <1359935815-13507-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:45755 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753883Ab3BCX5V (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Feb 2013 18:57:21 -0500
Received: by mail-pb0-f45.google.com with SMTP id rq13so2871189pbb.4
        for <linux-input@vger.kernel.org>; Sun, 03 Feb 2013 15:57:20 -0800 (PST)
In-Reply-To: <1359935815-13507-1-git-send-email-cernekee@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: seth.forshee@canonical.com, emmanuel.thome@inria.fr, dturvene@dahetral.com, vincent.vanackere@gmail.com, bgamari@gmail.com, linux-input@vger.kernel.org

This will minimize the number of forward declarations needed when
alps_get_model() starts assigning function pointers.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/input/mouse/alps.c |  186 ++++++++++++++++++++++----------------------
 1 file changed, 93 insertions(+), 93 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 33ee6e0..c473549 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -998,99 +998,6 @@ static inline int alps_exit_command_mode(struct psmouse *psmouse)
 	return 0;
 }
 
-static const struct alps_model_info *alps_get_model(struct psmouse *psmouse, int *version)
-{
-	struct ps2dev *ps2dev = &psmouse->ps2dev;
-	static const unsigned char rates[] = { 0, 10, 20, 40, 60, 80, 100, 200 };
-	unsigned char param[4];
-	const struct alps_model_info *model = NULL;
-	int i;
-
-	/*
-	 * First try "E6 report".
-	 * ALPS should return 0,0,10 or 0,0,100 if no buttons are pressed.
-	 * The bits 0-2 of the first byte will be 1s if some buttons are
-	 * pressed.
-	 */
-	param[0] = 0;
-	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES) ||
-	    ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE11) ||
-	    ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE11) ||
-	    ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE11))
-		return NULL;
-
-	param[0] = param[1] = param[2] = 0xff;
-	if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
-		return NULL;
-
-	psmouse_dbg(psmouse, "E6 report: %2.2x %2.2x %2.2x",
-		    param[0], param[1], param[2]);
-
-	if ((param[0] & 0xf8) != 0 || param[1] != 0 ||
-	    (param[2] != 10 && param[2] != 100))
-		return NULL;
-
-	/*
-	 * Now try "E7 report". Allowed responses are in
-	 * alps_model_data[].signature
-	 */
-	param[0] = 0;
-	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES) ||
-	    ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE21) ||
-	    ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE21) ||
-	    ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE21))
-		return NULL;
-
-	param[0] = param[1] = param[2] = 0xff;
-	if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
-		return NULL;
-
-	psmouse_dbg(psmouse, "E7 report: %2.2x %2.2x %2.2x",
-		    param[0], param[1], param[2]);
-
-	if (version) {
-		for (i = 0; i < ARRAY_SIZE(rates) && param[2] != rates[i]; i++)
-			/* empty */;
-		*version = (param[0] << 8) | (param[1] << 4) | i;
-	}
-
-	for (i = 0; i < ARRAY_SIZE(alps_model_data); i++) {
-		if (!memcmp(param, alps_model_data[i].signature,
-			    sizeof(alps_model_data[i].signature))) {
-			model = alps_model_data + i;
-			break;
-		}
-	}
-
-	if (model && model->proto_version > ALPS_PROTO_V2) {
-		/*
-		 * Need to check command mode response to identify
-		 * model
-		 */
-		model = NULL;
-		if (alps_enter_command_mode(psmouse, param)) {
-			psmouse_warn(psmouse,
-				     "touchpad failed to enter command mode\n");
-		} else {
-			for (i = 0; i < ARRAY_SIZE(alps_model_data); i++) {
-				if (alps_model_data[i].proto_version > ALPS_PROTO_V2 &&
-				    alps_model_data[i].command_mode_resp == param[0]) {
-					model = alps_model_data + i;
-					break;
-				}
-			}
-			alps_exit_command_mode(psmouse);
-
-			if (!model)
-				psmouse_dbg(psmouse,
-					    "Unknown command mode response %2.2x\n",
-					    param[0]);
-		}
-	}
-
-	return model;
-}
-
 /*
  * For DualPoint devices select the device that should respond to
  * subsequent commands. It looks like glidepad is behind stickpointer,
@@ -1534,6 +1441,99 @@ static int alps_hw_init(struct psmouse *psmouse)
 	return ret;
 }
 
+static const struct alps_model_info *alps_get_model(struct psmouse *psmouse, int *version)
+{
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
+	static const unsigned char rates[] = { 0, 10, 20, 40, 60, 80, 100, 200 };
+	unsigned char param[4];
+	const struct alps_model_info *model = NULL;
+	int i;
+
+	/*
+	 * First try "E6 report".
+	 * ALPS should return 0,0,10 or 0,0,100 if no buttons are pressed.
+	 * The bits 0-2 of the first byte will be 1s if some buttons are
+	 * pressed.
+	 */
+	param[0] = 0;
+	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES) ||
+	    ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE11) ||
+	    ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE11) ||
+	    ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE11))
+		return NULL;
+
+	param[0] = param[1] = param[2] = 0xff;
+	if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
+		return NULL;
+
+	psmouse_dbg(psmouse, "E6 report: %2.2x %2.2x %2.2x",
+		    param[0], param[1], param[2]);
+
+	if ((param[0] & 0xf8) != 0 || param[1] != 0 ||
+	    (param[2] != 10 && param[2] != 100))
+		return NULL;
+
+	/*
+	 * Now try "E7 report". Allowed responses are in
+	 * alps_model_data[].signature
+	 */
+	param[0] = 0;
+	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES) ||
+	    ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE21) ||
+	    ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE21) ||
+	    ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE21))
+		return NULL;
+
+	param[0] = param[1] = param[2] = 0xff;
+	if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
+		return NULL;
+
+	psmouse_dbg(psmouse, "E7 report: %2.2x %2.2x %2.2x",
+		    param[0], param[1], param[2]);
+
+	if (version) {
+		for (i = 0; i < ARRAY_SIZE(rates) && param[2] != rates[i]; i++)
+			/* empty */;
+		*version = (param[0] << 8) | (param[1] << 4) | i;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(alps_model_data); i++) {
+		if (!memcmp(param, alps_model_data[i].signature,
+			    sizeof(alps_model_data[i].signature))) {
+			model = alps_model_data + i;
+			break;
+		}
+	}
+
+	if (model && model->proto_version > ALPS_PROTO_V2) {
+		/*
+		 * Need to check command mode response to identify
+		 * model
+		 */
+		model = NULL;
+		if (alps_enter_command_mode(psmouse, param)) {
+			psmouse_warn(psmouse,
+				     "touchpad failed to enter command mode\n");
+		} else {
+			for (i = 0; i < ARRAY_SIZE(alps_model_data); i++) {
+				if (alps_model_data[i].proto_version > ALPS_PROTO_V2 &&
+				    alps_model_data[i].command_mode_resp == param[0]) {
+					model = alps_model_data + i;
+					break;
+				}
+			}
+			alps_exit_command_mode(psmouse);
+
+			if (!model)
+				psmouse_dbg(psmouse,
+					    "Unknown command mode response %2.2x\n",
+					    param[0]);
+		}
+	}
+
+	return model;
+}
+
 static int alps_reconnect(struct psmouse *psmouse)
 {
 	const struct alps_model_info *model;
-- 
1.7.10.4

