From: Kevin Cernekee <cernekee@gmail.com>
Subject: [RFT V2 14/14] Input: ALPS - First attempt at "Dolphin" touchpad support
Date: Sun,  3 Feb 2013 15:56:54 -0800
Message-ID: <1359935815-13507-15-git-send-email-cernekee@gmail.com>
References: <1359935815-13507-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:58143 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044Ab3BCX5o (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Feb 2013 18:57:44 -0500
Received: by mail-pa0-f48.google.com with SMTP id hz10so79661pad.21
        for <linux-input@vger.kernel.org>; Sun, 03 Feb 2013 15:57:43 -0800 (PST)
In-Reply-To: <1359935815-13507-1-git-send-email-cernekee@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: seth.forshee@canonical.com, emmanuel.thome@inria.fr, dturvene@dahetral.com, vincent.vanackere@gmail.com, bgamari@gmail.com, linux-input@vger.kernel.org

These touchpads use a different protocol; they have been seen on Dell
N5110, Dell 17R SE, and Fujitsu A512.

The official ALPS driver identifies them by looking for an exact match
on the E7 report: 73 03 50.  Dolphin V1 returns an EC report of
73 01 xx (02 and 0d have been seen); Dolphin V2 returns an EC report of
73 02 xx (02 has been seen).

Credits: Dave Turvene for the report format; Vincent Vanackere for the
V2 init log

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/input/mouse/alps.c |  102 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/input/mouse/alps.h |    1 +
 2 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 3c7bd2f..ef591af 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -107,6 +107,8 @@ static const struct alps_model_info alps_model_data[] = {
 	{ { 0x52, 0x01, 0x14 }, 0x00, ALPS_PROTO_V2, 0xff, 0xff,
 		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED },				/* Toshiba Tecra A11-11L */
 	{ { 0x73, 0x02, 0x64 },	0x8a, ALPS_PROTO_V4, 0x8f, 0x8f, 0 },
+		/* Dell Inspiron N5110 */
+	{ { 0x73, 0x03, 0x50 }, 0x00, ALPS_PROTO_V5, 0xc8, 0xc8, 0 },
 };
 
 static void alps_set_abs_params_st(struct alps_data *priv,
@@ -490,6 +492,29 @@ static void alps_decode_rushmore(struct alps_fields *f, unsigned char *p)
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
@@ -874,7 +899,8 @@ static psmouse_ret_t alps_process_byte(struct psmouse *psmouse)
 	}
 
 	/* Bytes 2 - pktsize should have 0 in the highest bit */
-	if (psmouse->pktcnt >= 2 && psmouse->pktcnt <= psmouse->pktsize &&
+	if (priv->proto_version != ALPS_PROTO_V5 &&
+	    psmouse->pktcnt >= 2 && psmouse->pktcnt <= psmouse->pktsize &&
 	    (psmouse->packet[psmouse->pktcnt - 1] & 0x80)) {
 		psmouse_dbg(psmouse, "refusing packet[%i] = %x\n",
 			    psmouse->pktcnt - 1,
@@ -1004,7 +1030,14 @@ static int alps_enter_command_mode(struct psmouse *psmouse,
 		return -1;
 	}
 
-	if (param[0] != 0x88 || (param[1] != 0x07 && param[1] != 0x08)) {
+	/*
+	 * 88 08 xx: Rushmore
+	 * 88 07 xx: Some other Pinnacle series touchpad
+	 * 73 xx xx: Dolphin
+	 * Anything else: bogus response
+	 */
+	if ((param[0] != 0x88 || (param[1] != 0x07 && param[1] != 0x08)) &&
+	    param[0] != 0x73) {
 		psmouse_dbg(psmouse,
 			    "unknown response while entering command mode\n");
 		return -1;
@@ -1499,6 +1532,59 @@ error:
 	return -1;
 }
 
+static int alps_short_cmd_v5(struct psmouse *psmouse, u8 cmd)
+{
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
+
+	if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETPOLL) ||
+	    ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETPOLL) ||
+	    __alps_command_mode_write_reg(psmouse, cmd))
+		return -EIO;
+	return 0;
+}
+
+static int alps_hw_init_v5(struct psmouse *psmouse)
+{
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
+
+	/* set sensitivity */
+	if (alps_enter_command_mode(psmouse, NULL) ||
+	    alps_command_mode_write_reg(psmouse, 0x0022, 0x80))
+		goto error;
+
+	/*
+	 * TODO: For Dolphin V2 touchpads, this should be calculated from the
+	 * OTP settings instead.  Also, there is another register (0x0020)
+	 * which should be initialized too.
+	 */
+	if (alps_command_mode_write_reg(psmouse, 0x001f, 0x08) ||
+	    alps_exit_command_mode(psmouse))
+		goto error;
+
+	/* select V1 packet format */
+	if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_DISABLE) ||
+	    alps_short_cmd_v5(psmouse, 0x85))
+		goto error;
+
+	/* XY and gesture */
+	if (alps_short_cmd_v5(psmouse, 0x73))
+		goto error;
+
+	/* final init */
+	if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSTREAM) ||
+	    alps_command_mode_send_nibble(psmouse, 0x7) ||
+	    alps_command_mode_send_nibble(psmouse, 0xf) ||
+	    alps_command_mode_send_nibble(psmouse, 0xe) ||
+	    ps2_command(ps2dev, NULL, PSMOUSE_CMD_ENABLE))
+		goto error;
+
+	return 0;
+
+error:
+	alps_exit_command_mode(psmouse);
+	return -1;
+}
+
 static void alps_set_defaults(struct alps_data *priv)
 {
 	priv->byte0 = 0x8f;
@@ -1532,6 +1618,18 @@ static void alps_set_defaults(struct alps_data *priv)
 		priv->nibble_commands = alps_v4_nibble_commands;
 		priv->addr_command = PSMOUSE_CMD_DISABLE;
 		break;
+	case ALPS_PROTO_V5:
+		priv->hw_init = alps_hw_init_v5;
+		priv->process_packet = alps_process_packet_v3;
+		priv->decode_fields = alps_decode_dolphin;
+		priv->set_abs_params = alps_set_abs_params_mt;
+		priv->nibble_commands = alps_v3_nibble_commands;
+		priv->addr_command = PSMOUSE_CMD_RESET_WRAP;
+		priv->x_max = 1360;
+		priv->y_max = 660;
+		priv->x_bits = 23;
+		priv->y_bits = 12;
+		break;
 	}
 }
 
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

