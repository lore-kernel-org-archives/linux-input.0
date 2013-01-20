From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 2/3] Input: ALPS - Add code to support "Rushmore" touchpads
Date: Sun, 20 Jan 2013 01:31:15 -0800
Message-ID: <092b691c8e994d31cb235fd7c45afee4@localhost>
References: <10bf6ea5c8f86eca66cd39498ca38d58@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [69.28.251.93] ([69.28.251.93]:45599 "EHLO b32.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751698Ab3ATJng (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Jan 2013 04:43:36 -0500
In-Reply-To: <10bf6ea5c8f86eca66cd39498ca38d58@localhost>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: seth.forshee@canonical.com, linux-input@vger.kernel.org

These touchpads mostly speak the V3 protocol, but they use a different
method for detection.  The manufacturer's driver follows a sequence that
looks something like:

  Send E7 query and look for an exact match: 73 03 50 ("Dolphin")
  If no match, send EC query and look for 88 {07,08} xx ("Pinnacle")
  If no match, send E7 query and look for 73 02 {0a,14,3c,50} ("Mercury II")
  If no match, send a more complicated query and look for 88 05 xx ("Mercury")

This patch adds the new EC query before the usual E7 query.  It is
presumed (hoped) that anything that isn't in the Pinnacle series will not
return "88 07 xx" or "88 08 xx".

Tested on:

Dell E6230 ("Rushmore" model from the "Pinnacle" series)
Dell E6430 (same as above, but with trackstick + more buttons)

On both PCs, the E7 report is 73 03 0a, and the EC report is 88 08 1d.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/input/mouse/alps.c |   93 ++++++++++++++++++++++++++++++++++++++++----
 drivers/input/mouse/alps.h |    6 +++
 2 files changed, 92 insertions(+), 7 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index bb99923..7d5e939 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -114,6 +114,10 @@ static const struct alps_model_info alps_model_data[] = {
 	{ { 0x73, 0x02, 0x64 },	0x8a, ALPS_PROTO_V4, 0x8f, 0x8f, 0 },
 };
 
+static const struct alps_model_info alps_model_rushmore = {
+	{ ALPS_RUSHMORE }, 0x00, ALPS_PROTO_V3, 0x8f, 0x8f, ALPS_DUALPOINT
+};
+
 /*
  * XXX - this entry is suspicious. First byte has zero lower nibble,
  * which is what a normal mouse would report. Also, the value 0x0e
@@ -393,7 +397,7 @@ static void alps_process_trackstick_packet_v3(struct psmouse *psmouse)
 	struct alps_data *priv = psmouse->private;
 	unsigned char *packet = psmouse->packet;
 	struct input_dev *dev = priv->dev2;
-	int x, y, z, left, right, middle;
+	int x, y, z, left, right, middle, divisor = 8;
 
 	/* Sanity check packet */
 	if (!(packet[0] & 0x40)) {
@@ -408,17 +412,24 @@ static void alps_process_trackstick_packet_v3(struct psmouse *psmouse)
 	if (packet[1] == 0x7f && packet[2] == 0x7f && packet[4] == 0x7f)
 		return;
 
-	x = (s8)(((packet[0] & 0x20) << 2) | (packet[1] & 0x7f));
-	y = (s8)(((packet[0] & 0x10) << 3) | (packet[2] & 0x7f));
-	z = (packet[4] & 0x7c) >> 2;
+	if (priv->i->signature[0] == ALPS_RUSHMORE) {
+		x = (s8)(((packet[0] & 0x20) << 2) | ((packet[1] << 1) & 0x7f));
+		y = (s8)(((packet[2] & 0x10) << 3) | ((packet[4] << 1) & 0x7f));
+		z = (packet[4] & 0x7c) >> 2;
+		divisor = 2;
+	} else {
+		x = (s8)(((packet[0] & 0x20) << 2) | (packet[1] & 0x7f));
+		y = (s8)(((packet[0] & 0x10) << 3) | (packet[2] & 0x7f));
+		z = (packet[4] & 0x7c) >> 2;
+	}
 
 	/*
 	 * The x and y values tend to be quite large, and when used
 	 * alone the trackstick is difficult to use. Scale them down
 	 * to compensate.
 	 */
-	x /= 8;
-	y /= 8;
+	x /= divisor;
+	y /= divisor;
 
 	input_report_rel(dev, REL_X, x);
 	input_report_rel(dev, REL_Y, -y);
@@ -996,7 +1007,7 @@ static int alps_enter_command_mode(struct psmouse *psmouse,
 		return -1;
 	}
 
-	if (param[0] != 0x88 && param[1] != 0x07) {
+	if (param[0] != 0x88) {
 		psmouse_dbg(psmouse,
 			    "unknown response while entering command mode: %2.2x %2.2x %2.2x\n",
 			    param[0], param[1], param[2]);
@@ -1016,6 +1027,34 @@ static inline int alps_exit_command_mode(struct psmouse *psmouse)
 	return 0;
 }
 
+static const struct alps_model_info *alps_probe_pinnacle(
+	struct psmouse *psmouse, int *version)
+{
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
+	unsigned char param[4];
+	const struct alps_model_info *model = NULL;
+
+	if (alps_rpt_cmd(ps2dev, PSMOUSE_CMD_SETSTREAM, PSMOUSE_CMD_RESET_WRAP,
+			 param) ||
+	    param[0] != 0x88 ||
+	    (param[1] != 0x07 && param[1] != 0x08))
+		goto out;
+
+	/* For now this code has only been verified to detect Rushmore */
+	if (param[1] == 0x08)
+		model = &alps_model_rushmore;
+	else if (param[2] >= 0x80 && param[2] <= 0x8f)
+		psmouse_info(psmouse, "detected Pinnacle AG via EC report\n");
+	else if (param[2] >= 0x90 && param[2] <= 0x9d)
+		psmouse_info(psmouse, "detected Pinnacle AGx via EC report\n");
+	else if (param[2] < 0x80)
+		psmouse_info(psmouse, "detected Pinnacle via EC report\n");
+
+out:
+	alps_exit_command_mode(psmouse);
+	return model;
+}
+
 static const struct alps_model_info *alps_get_model(struct psmouse *psmouse, int *version)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
@@ -1024,6 +1063,11 @@ static const struct alps_model_info *alps_get_model(struct psmouse *psmouse, int
 	const struct alps_model_info *model = NULL;
 	int i;
 
+	/* Newer devices detect based on the EC report, not the E7 report */
+	model = alps_probe_pinnacle(psmouse, version);
+	if (model)
+		return model;
+
 	/*
 	 * First try "E6 report".
 	 * ALPS should return 0,0,10 or 0,0,100 if no buttons are pressed.
@@ -1285,6 +1329,38 @@ static int alps_absolute_mode_v3(struct psmouse *psmouse)
 	return 0;
 }
 
+static int alps_hw_init_rushmore(struct psmouse *psmouse)
+{
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
+	int reg_val, ret = -1;
+
+	if (alps_command_mode_read_reg(psmouse, 0xc2d9) == -1 ||
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
 static int alps_hw_init_v3(struct psmouse *psmouse)
 {
 	struct alps_data *priv = psmouse->private;
@@ -1298,6 +1374,9 @@ static int alps_hw_init_v3(struct psmouse *psmouse)
 	if (alps_enter_command_mode(psmouse, NULL))
 		goto error;
 
+	if (priv->i->signature[0] == ALPS_RUSHMORE)
+		return alps_hw_init_rushmore(psmouse);
+
 	/* Check for trackstick */
 	reg_val = alps_command_mode_read_reg(psmouse, 0x0008);
 	if (reg_val == -1)
diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
index ae1ac35..152d96b 100644
--- a/drivers/input/mouse/alps.h
+++ b/drivers/input/mouse/alps.h
@@ -17,6 +17,12 @@
 #define ALPS_PROTO_V3	2
 #define ALPS_PROTO_V4	3
 
+/* These are in the same "Pinnacle" family but have different init sequences */
+#define ALPS_PIN	0x01
+#define ALPS_PINAG	0x02
+#define ALPS_PINAGX	0x03
+#define ALPS_RUSHMORE	0x04
+
 struct alps_model_info {
         unsigned char signature[3];
 	unsigned char command_mode_resp; /* v3/v4 only */
-- 
1.7.10.4

