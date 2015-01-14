From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4/6] Input: ALPS - consolidate setting protocol parameters
Date: Wed, 14 Jan 2015 14:55:52 -0800
Message-ID: <1421276154-8689-5-git-send-email-dmitry.torokhov@gmail.com>
References: <1421276154-8689-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:36923 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754166AbbANW4P (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Jan 2015 17:56:15 -0500
Received: by mail-ie0-f174.google.com with SMTP id at20so11791431iec.5
        for <linux-input@vger.kernel.org>; Wed, 14 Jan 2015 14:56:14 -0800 (PST)
In-Reply-To: <1421276154-8689-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Yunkang Tang <yunkang.tang@cn.alps.com>, Hans de Goede <hdegoede@redhat.com>

Move setting of all protocol properties into alps_set_protocol (former
alps_set_defaults) instead of having it split between several functions.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/alps.c | 131 +++++++++++++++++++++++----------------------
 1 file changed, 67 insertions(+), 64 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 1de0345..cabb267 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -130,6 +130,22 @@ static const struct alps_model_info alps_model_data[] = {
 	{ { 0x73, 0x02, 0x64 }, 0x8a, { ALPS_PROTO_V4, 0x8f, 0x8f, 0 } },
 };
 
+static const struct alps_protocol_info alps_v3_protocol_data = {
+	ALPS_PROTO_V3, 0x8f, 0x8f, ALPS_DUALPOINT
+};
+
+static const struct alps_protocol_info alps_v3_rushmore_data = {
+	ALPS_PROTO_V3, 0x8f, 0x8f, ALPS_DUALPOINT
+};
+
+static const struct alps_protocol_info alps_v5_protocol_data = {
+	ALPS_PROTO_V5, 0xc8, 0xd8, 0
+};
+
+static const struct alps_protocol_info alps_v7_protocol_data = {
+	ALPS_PROTO_V7, 0x48, 0x48, ALPS_DUALPOINT
+};
+
 static void alps_set_abs_params_st(struct alps_data *priv,
 				   struct input_dev *dev1);
 static void alps_set_abs_params_mt(struct alps_data *priv,
@@ -2161,11 +2177,18 @@ error:
 	return ret;
 }
 
-static void alps_set_defaults(struct alps_data *priv)
+static int alps_set_protocol(struct psmouse *psmouse,
+			     struct alps_data *priv,
+			     const struct alps_protocol_info *protocol)
 {
-	priv->byte0 = 0x8f;
-	priv->mask0 = 0x8f;
-	priv->flags = ALPS_DUALPOINT;
+	psmouse->private = priv;
+
+	setup_timer(&priv->timer, alps_flush_packet, (unsigned long)psmouse);
+
+	priv->proto_version = protocol->version;
+	priv->byte0 = protocol->byte0;
+	priv->mask0 = protocol->mask0;
+	priv->flags = protocol->flags;
 
 	priv->x_max = 2000;
 	priv->y_max = 1400;
@@ -2200,6 +2223,11 @@ static void alps_set_defaults(struct alps_data *priv)
 		priv->addr_command = PSMOUSE_CMD_RESET_WRAP;
 		priv->x_bits = 16;
 		priv->y_bits = 12;
+
+		if (alps_probe_trackstick_v3(psmouse,
+					     ALPS_REG_BASE_RUSHMORE) < 0)
+			priv->flags &= ~ALPS_DUALPOINT;
+
 		break;
 
 	case ALPS_PROTO_V4:
@@ -2209,6 +2237,7 @@ static void alps_set_defaults(struct alps_data *priv)
 		priv->nibble_commands = alps_v4_nibble_commands;
 		priv->addr_command = PSMOUSE_CMD_DISABLE;
 		break;
+
 	case ALPS_PROTO_V5:
 		priv->hw_init = alps_hw_init_dolphin_v1;
 		priv->process_packet = alps_process_touchpad_packet_v3_v5;
@@ -2216,14 +2245,12 @@ static void alps_set_defaults(struct alps_data *priv)
 		priv->set_abs_params = alps_set_abs_params_mt;
 		priv->nibble_commands = alps_v3_nibble_commands;
 		priv->addr_command = PSMOUSE_CMD_RESET_WRAP;
-		priv->byte0 = 0xc8;
-		priv->mask0 = 0xd8;
-		priv->flags = 0;
 		priv->x_max = 1360;
 		priv->y_max = 660;
 		priv->x_bits = 23;
 		priv->y_bits = 12;
 		break;
+
 	case ALPS_PROTO_V6:
 		priv->hw_init = alps_hw_init_v6;
 		priv->process_packet = alps_process_packet_v6;
@@ -2232,6 +2259,7 @@ static void alps_set_defaults(struct alps_data *priv)
 		priv->x_max = 2047;
 		priv->y_max = 1535;
 		break;
+
 	case ALPS_PROTO_V7:
 		priv->hw_init = alps_hw_init_v7;
 		priv->process_packet = alps_process_packet_v7;
@@ -2239,19 +2267,21 @@ static void alps_set_defaults(struct alps_data *priv)
 		priv->set_abs_params = alps_set_abs_params_mt;
 		priv->nibble_commands = alps_v3_nibble_commands;
 		priv->addr_command = PSMOUSE_CMD_RESET_WRAP;
-		priv->x_max = 0xfff;
-		priv->y_max = 0x7ff;
-		priv->byte0 = 0x48;
-		priv->mask0 = 0x48;
+
+		if (alps_dolphin_get_device_area(psmouse, priv))
+			return -EIO;
 
 		if (priv->fw_ver[1] != 0xba)
 			priv->flags |= ALPS_BUTTONPAD;
+
 		break;
 	}
+
+	return 0;
 }
 
-static int alps_match_table(struct psmouse *psmouse, struct alps_data *priv,
-			    unsigned char *e7, unsigned char *ec)
+static const struct alps_protocol_info *alps_match_table(unsigned char *e7,
+							 unsigned char *ec)
 {
 	const struct alps_model_info *model;
 	int i;
@@ -2263,22 +2293,16 @@ static int alps_match_table(struct psmouse *psmouse, struct alps_data *priv,
 		    (!model->command_mode_resp ||
 		     model->command_mode_resp == ec[2])) {
 
-			priv->proto_version = model->protocol_info.version;
-			alps_set_defaults(priv);
-
-			priv->flags = model->protocol_info.flags;
-			priv->byte0 = model->protocol_info.byte0;
-			priv->mask0 = model->protocol_info.mask0;
-
-			return 0;
+			return &model->protocol_info;
 		}
 	}
 
-	return -EINVAL;
+	return NULL;
 }
 
 static int alps_identify(struct psmouse *psmouse, struct alps_data *priv)
 {
+	const struct alps_protocol_info *protocol;
 	unsigned char e6[4], e7[4], ec[4];
 
 	/*
@@ -2305,48 +2329,30 @@ static int alps_identify(struct psmouse *psmouse, struct alps_data *priv)
 	    alps_exit_command_mode(psmouse))
 		return -EIO;
 
-	/* Save the Firmware version */
-	memcpy(priv->fw_ver, ec, 3);
-
-	if (alps_match_table(psmouse, priv, e7, ec) == 0) {
-		return 0;
-	} else if (e7[0] == 0x73 && e7[1] == 0x03 && e7[2] == 0x50 &&
-		   ec[0] == 0x73 && (ec[1] == 0x01 || ec[1] == 0x02)) {
-		priv->proto_version = ALPS_PROTO_V5;
-		alps_set_defaults(priv);
-		if (alps_dolphin_get_device_area(psmouse, priv))
-			return -EIO;
-		else
-			return 0;
-	} else if (ec[0] == 0x88 &&
-		   ((ec[1] & 0xf0) == 0xb0 || (ec[1] & 0xf0) == 0xc0)) {
-		priv->proto_version = ALPS_PROTO_V7;
-		alps_set_defaults(priv);
-
-		return 0;
-	} else if (ec[0] == 0x88 && ec[1] == 0x08) {
-		priv->proto_version = ALPS_PROTO_V3_RUSHMORE;
-		alps_set_defaults(priv);
-
-		/* hack to make addr_command, nibble_command available */
-		psmouse->private = priv;
-
-		if (alps_probe_trackstick_v3(psmouse, ALPS_REG_BASE_RUSHMORE))
-			priv->flags &= ~ALPS_DUALPOINT;
-
-		return 0;
-	} else if (ec[0] == 0x88 && ec[1] == 0x07 &&
-		   ec[2] >= 0x90 && ec[2] <= 0x9d) {
-		priv->proto_version = ALPS_PROTO_V3;
-		alps_set_defaults(priv);
-
-		return 0;
+	protocol = alps_match_table(e7, ec);
+	if (!protocol) {
+		if (e7[0] == 0x73 && e7[1] == 0x03 && e7[2] == 0x50 &&
+			   ec[0] == 0x73 && (ec[1] == 0x01 || ec[1] == 0x02)) {
+			protocol = &alps_v5_protocol_data;
+		} else if (ec[0] == 0x88 &&
+			   ((ec[1] & 0xf0) == 0xb0 || (ec[1] & 0xf0) == 0xc0)) {
+			protocol = &alps_v7_protocol_data;
+		} else if (ec[0] == 0x88 && ec[1] == 0x08) {
+			protocol = &alps_v3_rushmore_data;
+		} else if (ec[0] == 0x88 && ec[1] == 0x07 &&
+			   ec[2] >= 0x90 && ec[2] <= 0x9d) {
+			protocol = &alps_v3_protocol_data;
+		} else {
+			psmouse_dbg(psmouse,
+				    "Likely not an ALPS touchpad: E7=%3ph, EC=%3ph\n", e7, ec);
+			return -EINVAL;
+		}
 	}
 
-	psmouse_dbg(psmouse,
-		    "Likely not an ALPS touchpad: E7=%3ph, EC=%3ph\n", e7, ec);
+	/* Save the Firmware version */
+	memcpy(priv->fw_ver, ec, 3);
 
-	return -EINVAL;
+	return alps_set_protocol(psmouse, priv, protocol);
 }
 
 static int alps_reconnect(struct psmouse *psmouse)
@@ -2409,9 +2415,6 @@ int alps_init(struct psmouse *psmouse)
 		goto init_fail;
 
 	priv->dev2 = dev2;
-	setup_timer(&priv->timer, alps_flush_packet, (unsigned long)psmouse);
-
-	psmouse->private = priv;
 
 	psmouse_reset(psmouse);
 
-- 
2.2.0.rc0.207.ga3a616c

