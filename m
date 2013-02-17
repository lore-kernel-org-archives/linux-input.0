From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 2/3] Input: ALPS - Add "Dolphin V1" touchpad support
Date: Sat, 16 Feb 2013 22:40:04 -0800
Message-ID: <1361083206-5094-2-git-send-email-cernekee@gmail.com>
References: <1361083206-5094-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:51668 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512Ab3BQGkY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Feb 2013 01:40:24 -0500
Received: by mail-pa0-f46.google.com with SMTP id kp14so2283548pab.19
        for <linux-input@vger.kernel.org>; Sat, 16 Feb 2013 22:40:24 -0800 (PST)
In-Reply-To: <1361083206-5094-1-git-send-email-cernekee@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: seth.forshee@canonical.com, emmanuel.thome@inria.fr, dturvene@dahetral.com, vincent.vanackere@gmail.com, bgamari@gmail.com, jacmet@sunsite.dk, linux-input@vger.kernel.org

From: Dave Turvene <dturvene@dahetral.com>

These touchpads use a different protocol; they have been seen on Dell
N5110, Dell 17R SE, and others.

The official ALPS driver identifies them by looking for an exact match
on the E7 report: 73 03 50.  Dolphin V1 returns an EC report of
73 01 xx (02 and 0d have been seen); Dolphin V2 returns an EC report of
73 02 xx (02 has been seen).

Dolphin V2 probably needs a different initialization sequence and/or
report parser, so it is left for a future commit.

Signed-off-by: Dave Turvene <dturvene@dahetral.com>
Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/input/mouse/alps.c |   67 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/input/mouse/alps.h |    1 +
 2 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 9c97531..0238e0e 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -490,6 +490,29 @@ static void alps_decode_rushmore(struct alps_fields *f, unsigned char *p)
 	f->y_map |= (p[5] & 0x20) << 6;
 }
 
+static void alps_decode_dolphin(struct alps_fields *f, unsigned char *p)
+{
+	f->first_mp = !!(p[0] & 0x02);
+	f->is_mp = !!(p[0] & 0x20);
+
+	f->fingers = ((p[0] & 0x6) >> 1 |
+		     (p[0] & 0x10) >> 2);
+	f->x_map = ((p[2] & 0x60) >> 5) |
+		   ((p[4] & 0x7f) << 2) |
+		   ((p[5] & 0x7f) << 9) |
+		   ((p[3] & 0x07) << 16) |
+		   ((p[3] & 0x70) << 15) |
+		   ((p[0] & 0x01) << 22);
+	f->y_map = (p[1] & 0x7f) |
+		   ((p[2] & 0x1f) << 7);
+
+	f->x = ((p[1] & 0x7f) | ((p[4] & 0x0f) << 7));
+	f->y = ((p[2] & 0x7f) | ((p[4] & 0xf0) << 3));
+	f->z = (p[0] & 4) ? 0 : p[5] & 0x7f;
+
+	alps_decode_buttons_v3(f, p);
+}
+
 static void alps_process_touchpad_packet_v3(struct psmouse *psmouse)
 {
 	struct alps_data *priv = psmouse->private;
@@ -874,7 +897,8 @@ static psmouse_ret_t alps_process_byte(struct psmouse *psmouse)
 	}
 
 	/* Bytes 2 - pktsize should have 0 in the highest bit */
-	if (psmouse->pktcnt >= 2 && psmouse->pktcnt <= psmouse->pktsize &&
+	if (priv->proto_version != ALPS_PROTO_V5 &&
+	    psmouse->pktcnt >= 2 && psmouse->pktcnt <= psmouse->pktsize &&
 	    (psmouse->packet[psmouse->pktcnt - 1] & 0x80)) {
 		psmouse_dbg(psmouse, "refusing packet[%i] = %x\n",
 			    psmouse->pktcnt - 1,
@@ -1003,7 +1027,8 @@ static int alps_enter_command_mode(struct psmouse *psmouse)
 		return -1;
 	}
 
-	if (param[0] != 0x88 || (param[1] != 0x07 && param[1] != 0x08)) {
+	if ((param[0] != 0x88 || (param[1] != 0x07 && param[1] != 0x08)) &&
+	    param[0] != 0x73) {
 		psmouse_dbg(psmouse,
 			    "unknown response while entering command mode\n");
 		return -1;
@@ -1495,6 +1520,23 @@ error:
 	return -1;
 }
 
+static int alps_hw_init_dolphin_v1(struct psmouse *psmouse)
+{
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
+	unsigned char param[2];
+
+	/* This is dolphin "v1" as empirically defined by florin9doi */
+	param[0] = 0x64;
+	param[1] = 0x28;
+
+	if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSTREAM) ||
+	    ps2_command(ps2dev, &param[0], PSMOUSE_CMD_SETRATE) ||
+	    ps2_command(ps2dev, &param[1], PSMOUSE_CMD_SETRATE))
+		return -1;
+
+	return 0;
+}
+
 static void alps_set_defaults(struct alps_data *priv)
 {
 	priv->byte0 = 0x8f;
@@ -1528,6 +1570,21 @@ static void alps_set_defaults(struct alps_data *priv)
 		priv->nibble_commands = alps_v4_nibble_commands;
 		priv->addr_command = PSMOUSE_CMD_DISABLE;
 		break;
+	case ALPS_PROTO_V5:
+		priv->hw_init = alps_hw_init_dolphin_v1;
+		priv->process_packet = alps_process_packet_v3;
+		priv->decode_fields = alps_decode_dolphin;
+		priv->set_abs_params = alps_set_abs_params_mt;
+		priv->nibble_commands = alps_v3_nibble_commands;
+		priv->addr_command = PSMOUSE_CMD_RESET_WRAP;
+		priv->byte0 = 0xc8;
+		priv->mask0 = 0xc8;
+		priv->flags = 0;
+		priv->x_max = 1360;
+		priv->y_max = 660;
+		priv->x_bits = 23;
+		priv->y_bits = 12;
+		break;
 	}
 }
 
@@ -1588,6 +1645,12 @@ static int alps_identify(struct psmouse *psmouse, struct alps_data *priv)
 
 	if (alps_match_table(psmouse, priv, e7, ec) == 0) {
 		return 0;
+	} else if (e7[0] == 0x73 && e7[1] == 0x03 && e7[2] == 0x50 &&
+		   ec[0] == 0x73 && ec[1] == 0x01) {
+		priv->proto_version = ALPS_PROTO_V5;
+		alps_set_defaults(priv);
+
+		return 0;
 	} else if (ec[0] == 0x88 && ec[1] == 0x08) {
 		priv->proto_version = ALPS_PROTO_V3;
 		alps_set_defaults(priv);
diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
index 9704805..eee5985 100644
--- a/drivers/input/mouse/alps.h
+++ b/drivers/input/mouse/alps.h
@@ -16,6 +16,7 @@
 #define ALPS_PROTO_V2	2
 #define ALPS_PROTO_V3	3
 #define ALPS_PROTO_V4	4
+#define ALPS_PROTO_V5	5
 
 /**
  * struct alps_model_info - touchpad ID table
-- 
1.7.10.4

