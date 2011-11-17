From: JJ Ding <jj_ding@emc.com.tw>
Subject: [PATCH 1/2] Input: elantech - add support for elantech fast command
Date: Thu, 17 Nov 2011 18:16:33 +0800
Message-ID: <1321524994-5513-2-git-send-email-jj_ding@emc.com.tw>
References: <1321524994-5513-1-git-send-email-jj_ding@emc.com.tw>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:34046 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756506Ab1KQKSp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Nov 2011 05:18:45 -0500
In-Reply-To: <1321524994-5513-1-git-send-email-jj_ding@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, =?UTF-8?q?=C3=89ric=20Piel?= <E.A.B.Piel@tudelft.nl>
Cc: linux-input@vger.kernel.org, JJ Ding <jj_ding@emc.com.tw>

Starting with v3 hardware, the firmware supports this shorter
elantech_send_cmd. Teach the driver to use it.

Signed-off-by: JJ Ding <jj_ding@emc.com.tw>
---
 drivers/input/mouse/elantech.c |   38 ++++++++++++++++++++++++++++++--------
 drivers/input/mouse/elantech.h |    1 +
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index b562392..dae020c 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -43,6 +43,24 @@ static int synaptics_send_cmd(struct psmouse *psmouse, unsigned char c,
 }
 
 /*
+ * V3 and later support this fast command
+ */
+static int elantech_send_cmd(struct psmouse *psmouse, unsigned char c,
+				unsigned char *param)
+{
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
+
+	if (ps2_command(ps2dev, NULL, ETP_PS2_CUSTOM_COMMAND) ||
+	    ps2_command(ps2dev, NULL, c) ||
+	    ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO)) {
+		psmouse_err(psmouse, "%s query 0x%02x failed.\n", __func__, c);
+		return -1;
+	}
+
+	return 0;
+}
+
+/*
  * A retrying version of ps2_command
  */
 static int elantech_ps2_command(struct psmouse *psmouse,
@@ -863,13 +881,13 @@ static int elantech_set_range(struct psmouse *psmouse,
 			i = (etd->fw_version > 0x020800 &&
 			     etd->fw_version < 0x020900) ? 1 : 2;
 
-			if (synaptics_send_cmd(psmouse, ETP_FW_ID_QUERY, param))
+			if (etd->send_cmd(psmouse, ETP_FW_ID_QUERY, param))
 				return -1;
 
 			fixed_dpi = param[1] & 0x10;
 
 			if (((etd->fw_version >> 16) == 0x14) && fixed_dpi) {
-				if (synaptics_send_cmd(psmouse, ETP_SAMPLE_QUERY, param))
+				if (etd->send_cmd(psmouse, ETP_SAMPLE_QUERY, param))
 					return -1;
 
 				*x_max = (etd->capabilities[1] - i) * param[1] / 2;
@@ -888,7 +906,7 @@ static int elantech_set_range(struct psmouse *psmouse,
 		break;
 
 	case 3:
-		if (synaptics_send_cmd(psmouse, ETP_FW_ID_QUERY, param))
+		if (etd->send_cmd(psmouse, ETP_FW_ID_QUERY, param))
 			return -1;
 
 		*x_max = (0x0f & param[0]) << 8 | param[1];
@@ -896,7 +914,7 @@ static int elantech_set_range(struct psmouse *psmouse,
 		break;
 
 	case 4:
-		if (synaptics_send_cmd(psmouse, ETP_FW_ID_QUERY, param))
+		if (etd->send_cmd(psmouse, ETP_FW_ID_QUERY, param))
 			return -1;
 
 		*x_max = (0x0f & param[0]) << 8 | param[1];
@@ -1220,9 +1238,13 @@ static int elantech_set_properties(struct elantech_data *etd)
 	else
 		return -1;
 
-	/*
-	 * Turn on packet checking by default.
-	 */
+	/* decide which send_cmd we're gonna use early */
+	if (etd->hw_version > 2)
+		etd->send_cmd = elantech_send_cmd;
+	else
+		etd->send_cmd = synaptics_send_cmd;
+
+	/* Turn on packet checking by default */
 	etd->paritycheck = 1;
 
 	/*
@@ -1278,7 +1300,7 @@ int elantech_init(struct psmouse *psmouse)
 		     "assuming hardware version %d (with firmware version 0x%02x%02x%02x)\n",
 		     etd->hw_version, param[0], param[1], param[2]);
 
-	if (synaptics_send_cmd(psmouse, ETP_CAPABILITIES_QUERY,
+	if (etd->send_cmd(psmouse, ETP_CAPABILITIES_QUERY,
 	    etd->capabilities)) {
 		psmouse_err(psmouse, "failed to query capabilities.\n");
 		goto init_fail;
diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elantech.h
index 9e5f1aa..08d00bd 100644
--- a/drivers/input/mouse/elantech.h
+++ b/drivers/input/mouse/elantech.h
@@ -135,6 +135,7 @@ struct elantech_data {
 	unsigned int width;
 	struct finger_pos mt[ETP_MAX_FINGERS];
 	unsigned char parity[256];
+	int (*send_cmd)(struct psmouse *psmouse, unsigned char c, unsigned char *param);
 };
 
 #ifdef CONFIG_MOUSE_PS2_ELANTECH
-- 
1.7.8-rc2

