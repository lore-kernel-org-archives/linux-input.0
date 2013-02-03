From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V2 02/14] Input: ALPS - Copy "model" info into alps_data struct
Date: Sun,  3 Feb 2013 15:56:42 -0800
Message-ID: <1359935815-13507-3-git-send-email-cernekee@gmail.com>
References: <1359935815-13507-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f52.google.com ([209.85.210.52]:62700 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753883Ab3BCX5T (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Feb 2013 18:57:19 -0500
Received: by mail-da0-f52.google.com with SMTP id f10so2379527dak.11
        for <linux-input@vger.kernel.org>; Sun, 03 Feb 2013 15:57:18 -0800 (PST)
In-Reply-To: <1359935815-13507-1-git-send-email-cernekee@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: seth.forshee@canonical.com, emmanuel.thome@inria.fr, dturvene@dahetral.com, vincent.vanackere@gmail.com, bgamari@gmail.com, linux-input@vger.kernel.org

Not every type of ALPS touchpad is well-suited to table-based detection.
Start moving the various alps_model_data attributes into the alps_data
struct so that we don't need a unique table entry for every possible
permutation of protocol version, flags, byte0/mask0, etc.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/input/mouse/alps.c |   63 ++++++++++++++++++++++----------------------
 drivers/input/mouse/alps.h |   14 ++++++++--
 2 files changed, 43 insertions(+), 34 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index e229fa3..33ee6e0 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -122,10 +122,10 @@ static const struct alps_model_info alps_model_data[] = {
 
 /* Packet formats are described in Documentation/input/alps.txt */
 
-static bool alps_is_valid_first_byte(const struct alps_model_info *model,
+static bool alps_is_valid_first_byte(struct alps_data *priv,
 				     unsigned char data)
 {
-	return (data & model->mask0) == model->byte0;
+	return (data & priv->mask0) == priv->byte0;
 }
 
 static void alps_report_buttons(struct psmouse *psmouse,
@@ -158,14 +158,13 @@ static void alps_report_buttons(struct psmouse *psmouse,
 static void alps_process_packet_v1_v2(struct psmouse *psmouse)
 {
 	struct alps_data *priv = psmouse->private;
-	const struct alps_model_info *model = priv->i;
 	unsigned char *packet = psmouse->packet;
 	struct input_dev *dev = psmouse->dev;
 	struct input_dev *dev2 = priv->dev2;
 	int x, y, z, ges, fin, left, right, middle;
 	int back = 0, forward = 0;
 
-	if (model->proto_version == ALPS_PROTO_V1) {
+	if (priv->proto_version == ALPS_PROTO_V1) {
 		left = packet[2] & 0x10;
 		right = packet[2] & 0x08;
 		middle = 0;
@@ -181,12 +180,12 @@ static void alps_process_packet_v1_v2(struct psmouse *psmouse)
 		z = packet[5];
 	}
 
-	if (model->flags & ALPS_FW_BK_1) {
+	if (priv->flags & ALPS_FW_BK_1) {
 		back = packet[0] & 0x10;
 		forward = packet[2] & 4;
 	}
 
-	if (model->flags & ALPS_FW_BK_2) {
+	if (priv->flags & ALPS_FW_BK_2) {
 		back = packet[3] & 4;
 		forward = packet[2] & 4;
 		if ((middle = forward && back))
@@ -196,7 +195,7 @@ static void alps_process_packet_v1_v2(struct psmouse *psmouse)
 	ges = packet[2] & 1;
 	fin = packet[2] & 2;
 
-	if ((model->flags & ALPS_DUALPOINT) && z == 127) {
+	if ((priv->flags & ALPS_DUALPOINT) && z == 127) {
 		input_report_rel(dev2, REL_X,  (x > 383 ? (x - 768) : x));
 		input_report_rel(dev2, REL_Y, -(y > 255 ? (y - 512) : y));
 
@@ -239,15 +238,15 @@ static void alps_process_packet_v1_v2(struct psmouse *psmouse)
 	input_report_abs(dev, ABS_PRESSURE, z);
 	input_report_key(dev, BTN_TOOL_FINGER, z > 0);
 
-	if (model->flags & ALPS_WHEEL)
+	if (priv->flags & ALPS_WHEEL)
 		input_report_rel(dev, REL_WHEEL, ((packet[2] << 1) & 0x08) - ((packet[0] >> 4) & 0x07));
 
-	if (model->flags & (ALPS_FW_BK_1 | ALPS_FW_BK_2)) {
+	if (priv->flags & (ALPS_FW_BK_1 | ALPS_FW_BK_2)) {
 		input_report_key(dev, BTN_FORWARD, forward);
 		input_report_key(dev, BTN_BACK, back);
 	}
 
-	if (model->flags & ALPS_FOUR_BUTTONS) {
+	if (priv->flags & ALPS_FOUR_BUTTONS) {
 		input_report_key(dev, BTN_0, packet[2] & 4);
 		input_report_key(dev, BTN_1, packet[0] & 0x10);
 		input_report_key(dev, BTN_2, packet[3] & 4);
@@ -699,9 +698,8 @@ static void alps_process_packet_v4(struct psmouse *psmouse)
 static void alps_process_packet(struct psmouse *psmouse)
 {
 	struct alps_data *priv = psmouse->private;
-	const struct alps_model_info *model = priv->i;
 
-	switch (model->proto_version) {
+	switch (priv->proto_version) {
 	case ALPS_PROTO_V1:
 	case ALPS_PROTO_V2:
 		alps_process_packet_v1_v2(psmouse);
@@ -765,7 +763,7 @@ static psmouse_ret_t alps_handle_interleaved_ps2(struct psmouse *psmouse)
 		if (((psmouse->packet[3] |
 		      psmouse->packet[4] |
 		      psmouse->packet[5]) & 0x80) ||
-		    (!alps_is_valid_first_byte(priv->i, psmouse->packet[6]))) {
+		    (!alps_is_valid_first_byte(priv, psmouse->packet[6]))) {
 			psmouse_dbg(psmouse,
 				    "refusing packet %4ph (suspected interleaved ps/2)\n",
 				    psmouse->packet + 3);
@@ -844,7 +842,6 @@ static void alps_flush_packet(unsigned long data)
 static psmouse_ret_t alps_process_byte(struct psmouse *psmouse)
 {
 	struct alps_data *priv = psmouse->private;
-	const struct alps_model_info *model = priv->i;
 
 	if ((psmouse->packet[0] & 0xc8) == 0x08) { /* PS/2 packet */
 		if (psmouse->pktcnt == 3) {
@@ -857,15 +854,15 @@ static psmouse_ret_t alps_process_byte(struct psmouse *psmouse)
 
 	/* Check for PS/2 packet stuffed in the middle of ALPS packet. */
 
-	if ((model->flags & ALPS_PS2_INTERLEAVED) &&
+	if ((priv->flags & ALPS_PS2_INTERLEAVED) &&
 	    psmouse->pktcnt >= 4 && (psmouse->packet[3] & 0x0f) == 0x0f) {
 		return alps_handle_interleaved_ps2(psmouse);
 	}
 
-	if (!alps_is_valid_first_byte(model, psmouse->packet[0])) {
+	if (!alps_is_valid_first_byte(priv, psmouse->packet[0])) {
 		psmouse_dbg(psmouse,
 			    "refusing packet[0] = %x (mask0 = %x, byte0 = %x)\n",
-			    psmouse->packet[0], model->mask0, model->byte0);
+			    psmouse->packet[0], priv->mask0, priv->byte0);
 		return PSMOUSE_BAD_DATA;
 	}
 
@@ -1190,16 +1187,16 @@ static int alps_poll(struct psmouse *psmouse)
 	unsigned char buf[sizeof(psmouse->packet)];
 	bool poll_failed;
 
-	if (priv->i->flags & ALPS_PASS)
+	if (priv->flags & ALPS_PASS)
 		alps_passthrough_mode_v2(psmouse, true);
 
 	poll_failed = ps2_command(&psmouse->ps2dev, buf,
 				  PSMOUSE_CMD_POLL | (psmouse->pktsize << 8)) < 0;
 
-	if (priv->i->flags & ALPS_PASS)
+	if (priv->flags & ALPS_PASS)
 		alps_passthrough_mode_v2(psmouse, false);
 
-	if (poll_failed || (buf[0] & priv->i->mask0) != priv->i->byte0)
+	if (poll_failed || (buf[0] & priv->mask0) != priv->byte0)
 		return -1;
 
 	if ((psmouse->badbyte & 0xc8) == 0x08) {
@@ -1217,9 +1214,8 @@ static int alps_poll(struct psmouse *psmouse)
 static int alps_hw_init_v1_v2(struct psmouse *psmouse)
 {
 	struct alps_data *priv = psmouse->private;
-	const struct alps_model_info *model = priv->i;
 
-	if ((model->flags & ALPS_PASS) &&
+	if ((priv->flags & ALPS_PASS) &&
 	    alps_passthrough_mode_v2(psmouse, true)) {
 		return -1;
 	}
@@ -1234,7 +1230,7 @@ static int alps_hw_init_v1_v2(struct psmouse *psmouse)
 		return -1;
 	}
 
-	if ((model->flags & ALPS_PASS) &&
+	if ((priv->flags & ALPS_PASS) &&
 	    alps_passthrough_mode_v2(psmouse, false)) {
 		return -1;
 	}
@@ -1520,10 +1516,9 @@ error:
 static int alps_hw_init(struct psmouse *psmouse)
 {
 	struct alps_data *priv = psmouse->private;
-	const struct alps_model_info *model = priv->i;
 	int ret = -1;
 
-	switch (model->proto_version) {
+	switch (priv->proto_version) {
 	case ALPS_PROTO_V1:
 	case ALPS_PROTO_V2:
 		ret = alps_hw_init_v1_v2(psmouse);
@@ -1585,7 +1580,10 @@ int alps_init(struct psmouse *psmouse)
 	if (!model)
 		goto init_fail;
 
-	priv->i = model;
+	priv->proto_version = model->proto_version;
+	priv->byte0 = model->byte0;
+	priv->mask0 = model->mask0;
+	priv->flags = model->flags;
 
 	if (alps_hw_init(psmouse))
 		goto init_fail;
@@ -1609,7 +1607,7 @@ int alps_init(struct psmouse *psmouse)
 
 	dev1->evbit[BIT_WORD(EV_ABS)] |= BIT_MASK(EV_ABS);
 
-	switch (model->proto_version) {
+	switch (priv->proto_version) {
 	case ALPS_PROTO_V1:
 	case ALPS_PROTO_V2:
 		input_set_abs_params(dev1, ABS_X, 0, 1023, 0, 0);
@@ -1633,17 +1631,17 @@ int alps_init(struct psmouse *psmouse)
 
 	input_set_abs_params(dev1, ABS_PRESSURE, 0, 127, 0, 0);
 
-	if (model->flags & ALPS_WHEEL) {
+	if (priv->flags & ALPS_WHEEL) {
 		dev1->evbit[BIT_WORD(EV_REL)] |= BIT_MASK(EV_REL);
 		dev1->relbit[BIT_WORD(REL_WHEEL)] |= BIT_MASK(REL_WHEEL);
 	}
 
-	if (model->flags & (ALPS_FW_BK_1 | ALPS_FW_BK_2)) {
+	if (priv->flags & (ALPS_FW_BK_1 | ALPS_FW_BK_2)) {
 		dev1->keybit[BIT_WORD(BTN_FORWARD)] |= BIT_MASK(BTN_FORWARD);
 		dev1->keybit[BIT_WORD(BTN_BACK)] |= BIT_MASK(BTN_BACK);
 	}
 
-	if (model->flags & ALPS_FOUR_BUTTONS) {
+	if (priv->flags & ALPS_FOUR_BUTTONS) {
 		dev1->keybit[BIT_WORD(BTN_0)] |= BIT_MASK(BTN_0);
 		dev1->keybit[BIT_WORD(BTN_1)] |= BIT_MASK(BTN_1);
 		dev1->keybit[BIT_WORD(BTN_2)] |= BIT_MASK(BTN_2);
@@ -1654,7 +1652,8 @@ int alps_init(struct psmouse *psmouse)
 
 	snprintf(priv->phys, sizeof(priv->phys), "%s/input1", psmouse->ps2dev.serio->phys);
 	dev2->phys = priv->phys;
-	dev2->name = (model->flags & ALPS_DUALPOINT) ? "DualPoint Stick" : "PS/2 Mouse";
+	dev2->name = (priv->flags & ALPS_DUALPOINT) ?
+		     "DualPoint Stick" : "PS/2 Mouse";
 	dev2->id.bustype = BUS_I8042;
 	dev2->id.vendor  = 0x0002;
 	dev2->id.product = PSMOUSE_ALPS;
@@ -1673,7 +1672,7 @@ int alps_init(struct psmouse *psmouse)
 	psmouse->poll = alps_poll;
 	psmouse->disconnect = alps_disconnect;
 	psmouse->reconnect = alps_reconnect;
-	psmouse->pktsize = model->proto_version == ALPS_PROTO_V4 ? 8 : 6;
+	psmouse->pktsize = priv->proto_version == ALPS_PROTO_V4 ? 8 : 6;
 
 	/* We are having trouble resyncing ALPS touchpads so disable it for now */
 	psmouse->resync_time = 0;
diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
index 67be4e5..efd0eea 100644
--- a/drivers/input/mouse/alps.h
+++ b/drivers/input/mouse/alps.h
@@ -63,10 +63,15 @@ struct alps_nibble_commands {
  * struct alps_data - private data structure for the ALPS driver
  * @dev2: "Relative" device used to report trackstick or mouse activity.
  * @phys: Physical path for the relative device.
- * @i: Information on the detected touchpad model.
  * @nibble_commands: Command mapping used for touchpad register accesses.
  * @addr_command: Command used to tell the touchpad that a register address
  *   follows.
+ * @proto_version: Indicates V1/V2/V3/...
+ * @byte0: Helps figure out whether a position report packet matches the
+ *   known format for this model.  The first byte of the report, ANDed with
+ *   mask0, should match byte0.
+ * @mask0: The mask used to check the first byte of the report.
+ * @flags: Additional device capabilities (passthrough port, trackstick, etc.).
  * @prev_fin: Finger bit from previous packet.
  * @multi_packet: Multi-packet data in progress.
  * @multi_data: Saved multi-packet data.
@@ -81,9 +86,14 @@ struct alps_nibble_commands {
 struct alps_data {
 	struct input_dev *dev2;
 	char phys[32];
-	const struct alps_model_info *i;
+
+	/* these are autodetected when the device is identified */
 	const struct alps_nibble_commands *nibble_commands;
 	int addr_command;
+	unsigned char proto_version;
+	unsigned char byte0, mask0;
+	unsigned char flags;
+
 	int prev_fin;
 	int multi_packet;
 	unsigned char multi_data[6];
-- 
1.7.10.4

