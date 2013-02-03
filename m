From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V2 05/14] Input: ALPS - Rework detection sequence
Date: Sun,  3 Feb 2013 15:56:45 -0800
Message-ID: <1359935815-13507-6-git-send-email-cernekee@gmail.com>
References: <1359935815-13507-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:49809 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753883Ab3BCX5Z (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Feb 2013 18:57:25 -0500
Received: by mail-pa0-f45.google.com with SMTP id kl14so331793pab.4
        for <linux-input@vger.kernel.org>; Sun, 03 Feb 2013 15:57:25 -0800 (PST)
In-Reply-To: <1359935815-13507-1-git-send-email-cernekee@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: seth.forshee@canonical.com, emmanuel.thome@inria.fr, dturvene@dahetral.com, vincent.vanackere@gmail.com, bgamari@gmail.com, linux-input@vger.kernel.org

If the E6 report test passes, get the E7 and EC reports right away and
then try to match an entry in the table.

Pass in the alps_data struct, so that the detection code will be able to
set operating parameters based on information found during detection.

Change the version (psmouse->model) to report the protocol version only,
in preparation for supporting models that do not show up in the ID table.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/input/mouse/alps.c |  123 +++++++++++++++++++-------------------------
 drivers/input/mouse/alps.h |    8 +--
 2 files changed, 56 insertions(+), 75 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 1ca854b..fb39fda 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1451,86 +1451,77 @@ static int alps_hw_init(struct psmouse *psmouse)
 	return ret;
 }
 
-static const struct alps_model_info *alps_get_model(struct psmouse *psmouse, int *version)
+static int alps_match_table(struct psmouse *psmouse, struct alps_data *priv,
+			    unsigned char *e7, unsigned char *ec)
 {
-	static const unsigned char rates[] = { 0, 10, 20, 40, 60, 80, 100, 200 };
-	unsigned char param[4];
 	const struct alps_model_info *model = NULL;
 	int i;
 
+	for (i = 0; ; i++) {
+		if (i == ARRAY_SIZE(alps_model_data))
+			return -EINVAL;
+
+		model = &alps_model_data[i];
+		if (!memcmp(e7, model->signature, sizeof(model->signature))) {
+			if (!model->command_mode_resp ||
+			    model->command_mode_resp == ec[2])
+				break;
+		}
+	}
+
+	priv->proto_version = model->proto_version;
+	priv->flags = model->flags;
+	priv->byte0 = model->byte0;
+	priv->mask0 = model->mask0;
+
+	return 0;
+}
+
+static int alps_identify(struct psmouse *psmouse, struct alps_data *priv)
+{
+	unsigned char e6[4], e7[4], ec[4];
+
 	/*
 	 * First try "E6 report".
 	 * ALPS should return 0,0,10 or 0,0,100 if no buttons are pressed.
 	 * The bits 0-2 of the first byte will be 1s if some buttons are
 	 * pressed.
 	 */
-	if (alps_rpt_cmd(psmouse, PSMOUSE_CMD_SETRES, PSMOUSE_CMD_SETSCALE11,
-			 param))
-		return NULL;
+	if (alps_rpt_cmd(psmouse, PSMOUSE_CMD_SETRES,
+			 PSMOUSE_CMD_SETSCALE11, e6))
+		return -EIO;
 
-	if ((param[0] & 0xf8) != 0 || param[1] != 0 ||
-	    (param[2] != 10 && param[2] != 100))
-		return NULL;
+	if ((e6[0] & 0xf8) != 0 || e6[1] != 0 || (e6[2] != 10 && e6[2] != 100))
+		return -EINVAL;
 
 	/*
-	 * Now try "E7 report". Allowed responses are in
-	 * alps_model_data[].signature
+	 * Now get the "E7" and "EC" reports.  These will uniquely identify
+	 * most ALPS touchpads.
 	 */
-	if (alps_rpt_cmd(psmouse, PSMOUSE_CMD_SETRES, PSMOUSE_CMD_SETSCALE21,
-			 param))
-		return NULL;
-
-	if (version) {
-		for (i = 0; i < ARRAY_SIZE(rates) && param[2] != rates[i]; i++)
-			/* empty */;
-		*version = (param[0] << 8) | (param[1] << 4) | i;
-	}
+	if (alps_rpt_cmd(psmouse, PSMOUSE_CMD_SETRES,
+			 PSMOUSE_CMD_SETSCALE21, e7) ||
+	    alps_rpt_cmd(psmouse, PSMOUSE_CMD_SETRES,
+			 PSMOUSE_CMD_RESET_WRAP, ec) ||
+	    alps_exit_command_mode(psmouse))
+		return -EIO;
 
-	for (i = 0; i < ARRAY_SIZE(alps_model_data); i++) {
-		if (!memcmp(param, alps_model_data[i].signature,
-			    sizeof(alps_model_data[i].signature))) {
-			model = alps_model_data + i;
-			break;
-		}
-	}
+	if (alps_match_table(psmouse, priv, e7, ec) == 0)
+		return 0;
 
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
+	psmouse_info(psmouse,
+		"Unknown ALPS touchpad: E7=%2.2x %2.2x %2.2x, EC=%2.2x %2.2x %2.2x\n",
+		e7[0], e7[1], e7[2], ec[0], ec[1], ec[2]);
 
-			if (!model)
-				psmouse_dbg(psmouse,
-					    "Unknown command mode response %2.2x\n",
-					    param[0]);
-		}
-	}
-
-	return model;
+	return -EINVAL;
 }
 
 static int alps_reconnect(struct psmouse *psmouse)
 {
-	const struct alps_model_info *model;
+	struct alps_data *priv = psmouse->private;
 
 	psmouse_reset(psmouse);
 
-	model = alps_get_model(psmouse, NULL);
-	if (!model)
+	if (alps_identify(psmouse, priv) < 0)
 		return -1;
 
 	return alps_hw_init(psmouse);
@@ -1549,9 +1540,7 @@ static void alps_disconnect(struct psmouse *psmouse)
 int alps_init(struct psmouse *psmouse)
 {
 	struct alps_data *priv;
-	const struct alps_model_info *model;
 	struct input_dev *dev1 = psmouse->dev, *dev2;
-	int version;
 
 	priv = kzalloc(sizeof(struct alps_data), GFP_KERNEL);
 	dev2 = input_allocate_device();
@@ -1565,15 +1554,9 @@ int alps_init(struct psmouse *psmouse)
 
 	psmouse_reset(psmouse);
 
-	model = alps_get_model(psmouse, &version);
-	if (!model)
+	if (alps_identify(psmouse, priv) < 0)
 		goto init_fail;
 
-	priv->proto_version = model->proto_version;
-	priv->byte0 = model->byte0;
-	priv->mask0 = model->mask0;
-	priv->flags = model->flags;
-
 	if (alps_hw_init(psmouse))
 		goto init_fail;
 
@@ -1678,18 +1661,16 @@ init_fail:
 
 int alps_detect(struct psmouse *psmouse, bool set_properties)
 {
-	int version;
-	const struct alps_model_info *model;
+	struct alps_data dummy;
 
-	model = alps_get_model(psmouse, &version);
-	if (!model)
+	if (alps_identify(psmouse, &dummy) < 0)
 		return -1;
 
 	if (set_properties) {
 		psmouse->vendor = "ALPS";
-		psmouse->name = model->flags & ALPS_DUALPOINT ?
+		psmouse->name = dummy.flags & ALPS_DUALPOINT ?
 				"DualPoint TouchPad" : "GlidePoint";
-		psmouse->model = version;
+		psmouse->model = dummy.proto_version << 8;
 	}
 	return 0;
 }
diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
index efd0eea..a81b318 100644
--- a/drivers/input/mouse/alps.h
+++ b/drivers/input/mouse/alps.h
@@ -12,10 +12,10 @@
 #ifndef _ALPS_H
 #define _ALPS_H
 
-#define ALPS_PROTO_V1	0
-#define ALPS_PROTO_V2	1
-#define ALPS_PROTO_V3	2
-#define ALPS_PROTO_V4	3
+#define ALPS_PROTO_V1	1
+#define ALPS_PROTO_V2	2
+#define ALPS_PROTO_V3	3
+#define ALPS_PROTO_V4	4
 
 /**
  * struct alps_model_info - touchpad ID table
-- 
1.7.10.4

