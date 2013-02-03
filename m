From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V2 12/14] Input: ALPS - Add support for "Rushmore" touchpads
Date: Sun,  3 Feb 2013 15:56:52 -0800
Message-ID: <1359935815-13507-13-git-send-email-cernekee@gmail.com>
References: <1359935815-13507-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:46807 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044Ab3BCX5k (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Feb 2013 18:57:40 -0500
Received: by mail-pa0-f41.google.com with SMTP id fb11so1143980pad.0
        for <linux-input@vger.kernel.org>; Sun, 03 Feb 2013 15:57:39 -0800 (PST)
In-Reply-To: <1359935815-13507-1-git-send-email-cernekee@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: seth.forshee@canonical.com, emmanuel.thome@inria.fr, dturvene@dahetral.com, vincent.vanackere@gmail.com, bgamari@gmail.com, linux-input@vger.kernel.org

Rushmore touchpads are found on Dell E6230/E6430/E6530.  They use the V3
protocol with slightly tweaked init sequences and report formats.

The E7 report is 73 03 0a, and the EC report is 88 08 1d

Credits: Emmanuel Thome reported the MT bitmap changes.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/input/mouse/alps.c |   52 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 92fe354..801a4dc 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -479,6 +479,14 @@ static void alps_decode_pinnacle(struct alps_fields *f, unsigned char *p)
 	alps_decode_buttons_v3(f, p);
 }
 
+static void alps_decode_rushmore(struct alps_fields *f, unsigned char *p)
+{
+	alps_decode_pinnacle(f, p);
+
+	f->x_map |= (p[5] & 0x10) << 11;
+	f->y_map |= (p[5] & 0x20) << 6;
+}
+
 static void alps_process_touchpad_packet_v3(struct psmouse *psmouse)
 {
 	struct alps_data *priv = psmouse->private;
@@ -1329,6 +1337,40 @@ error:
 	return -1;
 }
 
+static int alps_hw_init_rushmore_v3(struct psmouse *psmouse)
+{
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
+	int reg_val, ret = -1;
+
+	if (alps_enter_command_mode(psmouse, NULL) ||
+	    alps_command_mode_read_reg(psmouse, 0xc2d9) == -1 ||
+	    alps_command_mode_write_reg(psmouse, 0xc2cb, 0x00))
+		goto error;
+
+	reg_val = alps_command_mode_read_reg(psmouse, 0xc2c6);
+	if (reg_val == -1)
+		goto error;
+	if (__alps_command_mode_write_reg(psmouse, reg_val & 0xfd))
+		goto error;
+
+	if (alps_command_mode_write_reg(psmouse, 0xc2c9, 0x64))
+		goto error;
+
+	/* enter absolute mode */
+	reg_val = alps_command_mode_read_reg(psmouse, 0xc2c4);
+	if (reg_val == -1)
+		goto error;
+	if (__alps_command_mode_write_reg(psmouse, reg_val | 0x02))
+		goto error;
+
+	alps_exit_command_mode(psmouse);
+	return ps2_command(ps2dev, NULL, PSMOUSE_CMD_ENABLE);
+
+error:
+	alps_exit_command_mode(psmouse);
+	return ret;
+}
+
 /* Must be in command mode when calling this function */
 static int alps_absolute_mode_v4(struct psmouse *psmouse)
 {
@@ -1512,6 +1554,16 @@ static int alps_identify(struct psmouse *psmouse, struct alps_data *priv)
 
 	if (alps_match_table(psmouse, priv, e7, ec) == 0) {
 		return 0;
+	} else if (ec[0] == 0x88 && ec[1] == 0x08) {
+		priv->proto_version = ALPS_PROTO_V3;
+		alps_set_defaults(priv);
+
+		priv->hw_init = alps_hw_init_rushmore_v3;
+		priv->decode_fields = alps_decode_rushmore;
+		priv->x_bits = 16;
+		priv->y_bits = 12;
+
+		return 0;
 	} else if (ec[0] == 0x88 && ec[1] == 0x07 &&
 		   ec[2] >= 0x90 && ec[2] <= 0x9d) {
 		priv->proto_version = ALPS_PROTO_V3;
-- 
1.7.10.4

