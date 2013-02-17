From: Kevin Cernekee <cernekee@gmail.com>
Subject: [WIP 3/3] Input: ALPS - Add "Dolphin V2" touchpad support
Date: Sat, 16 Feb 2013 22:40:05 -0800
Message-ID: <1361083206-5094-3-git-send-email-cernekee@gmail.com>
References: <1361083206-5094-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:58970 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669Ab3BQGk1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Feb 2013 01:40:27 -0500
Received: by mail-pb0-f50.google.com with SMTP id up1so1178462pbc.37
        for <linux-input@vger.kernel.org>; Sat, 16 Feb 2013 22:40:27 -0800 (PST)
In-Reply-To: <1361083206-5094-1-git-send-email-cernekee@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: seth.forshee@canonical.com, emmanuel.thome@inria.fr, dturvene@dahetral.com, vincent.vanackere@gmail.com, bgamari@gmail.com, jacmet@sunsite.dk, linux-input@vger.kernel.org

Another ALPS variant; seen on the Fujitsu A512.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
Signed-off-by: Vincent Vanackere <vincent.vanackere@gmail.com>
---
 drivers/input/mouse/alps.c |   79 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)


This is a work-in-progress and not ready to be merged yet.  See:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/606238
https://bugs.freedesktop.org/show_bug.cgi?id=59478

The init sequence is probably "mostly OK" but the pressure values read
near the edges are not accurate, so edge scrolling does not work well.
Maybe this is fixable by changing some of the register settings, maybe
the report decoder is slightly off, or maybe the software will actually
need to scale z based on the x/y values.

One thing that might be worth trying is to select the native V2 report
format (short cmd 0x89) instead of the V1 format (short cmd 0x85).  This
probably affects the bit assignments and may require writing a new
alps_decode_* function.

I don't actually have access to any of the "Dolphin" based systems, so
I'm not able to make much progress on my own here.  Hopefully it's a
useful starting point though.


diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 0238e0e..d288f4c 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1520,6 +1520,17 @@ error:
 	return -1;
 }
 
+static int alps_short_cmd_v5(struct psmouse *psmouse, u8 init_command, u8 cmd)
+{
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
+
+	if (ps2_command(ps2dev, NULL, init_command) ||
+	    ps2_command(ps2dev, NULL, init_command) ||
+	    __alps_command_mode_write_reg(psmouse, cmd))
+		return -EIO;
+	return 0;
+}
+
 static int alps_hw_init_dolphin_v1(struct psmouse *psmouse)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
@@ -1537,6 +1548,69 @@ static int alps_hw_init_dolphin_v1(struct psmouse *psmouse)
 	return 0;
 }
 
+static int alps_hw_init_dolphin_v2(struct psmouse *psmouse)
+{
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
+
+	/* sample rate */
+	if (alps_short_cmd_v5(psmouse, PSMOUSE_CMD_SETSTREAM, 0x55))
+		goto error;
+
+	/* idle count */
+	if (alps_short_cmd_v5(psmouse, PSMOUSE_CMD_SETSTREAM, 0x64))
+		goto error;
+
+	/* button swap */
+	if (alps_short_cmd_v5(psmouse, PSMOUSE_CMD_SETSTREAM, 0x47))
+		goto error;
+
+	/* data priority */
+	if (alps_short_cmd_v5(psmouse, PSMOUSE_CMD_SETSTREAM, 0x43))
+		goto error;
+
+	/* power mode */
+	if (alps_short_cmd_v5(psmouse, PSMOUSE_CMD_SETPOLL, 0x57))
+		goto error;
+
+	/*
+	 * TODO: For Dolphin V2 touchpads, the threshold should be calculated
+	 * from the OTP settings instead.
+	 */
+	if (alps_enter_command_mode(psmouse) ||
+	    alps_command_mode_write_reg(psmouse, 0x001f, 0x09) ||
+	    alps_command_mode_write_reg(psmouse, 0x0020, 0x09) ||
+	    alps_command_mode_write_reg(psmouse, 0x0022, 0x80) ||
+	    alps_exit_command_mode(psmouse))
+		goto error;
+
+	/* select V1 packet format */
+	if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_DISABLE) ||
+	    alps_short_cmd_v5(psmouse, PSMOUSE_CMD_SETSTREAM, 0x85))
+		goto error;
+
+	/* XY and gesture */
+	if (alps_short_cmd_v5(psmouse, PSMOUSE_CMD_SETSTREAM, 0x73))
+		goto error;
+
+	/* profile sequence */
+	if (alps_short_cmd_v5(psmouse, PSMOUSE_CMD_SETSTREAM, 0x94))
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
@@ -1646,10 +1720,13 @@ static int alps_identify(struct psmouse *psmouse, struct alps_data *priv)
 	if (alps_match_table(psmouse, priv, e7, ec) == 0) {
 		return 0;
 	} else if (e7[0] == 0x73 && e7[1] == 0x03 && e7[2] == 0x50 &&
-		   ec[0] == 0x73 && ec[1] == 0x01) {
+		   ec[0] == 0x73 && (ec[1] == 0x01 || ec[1] == 0x02)) {
 		priv->proto_version = ALPS_PROTO_V5;
 		alps_set_defaults(priv);
 
+		if (ec[1] == 0x02)
+			priv->hw_init = alps_hw_init_dolphin_v2;
+
 		return 0;
 	} else if (ec[0] == 0x88 && ec[1] == 0x08) {
 		priv->proto_version = ALPS_PROTO_V3;
-- 
1.7.10.4

