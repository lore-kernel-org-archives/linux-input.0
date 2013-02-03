From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V2 06/14] Input: ALPS - Use function pointers for different protocol handlers
Date: Sun,  3 Feb 2013 15:56:46 -0800
Message-ID: <1359935815-13507-7-git-send-email-cernekee@gmail.com>
References: <1359935815-13507-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:34567 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031Ab3BCX51 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Feb 2013 18:57:27 -0500
Received: by mail-pb0-f54.google.com with SMTP id rr4so2881633pbb.27
        for <linux-input@vger.kernel.org>; Sun, 03 Feb 2013 15:57:27 -0800 (PST)
In-Reply-To: <1359935815-13507-1-git-send-email-cernekee@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: seth.forshee@canonical.com, emmanuel.thome@inria.fr, dturvene@dahetral.com, vincent.vanackere@gmail.com, bgamari@gmail.com, linux-input@vger.kernel.org

In anticipation of adding more ALPS protocols and more per-device quirks,
use function pointers instead of switch statements to call functions that
differ from one device to the next.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/input/mouse/alps.c |  101 +++++++++++++++++++++-----------------------
 drivers/input/mouse/alps.h |    7 +++
 2 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index fb39fda..ffe0fad 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -114,6 +114,11 @@ static const struct alps_model_info alps_model_data[] = {
 	{ { 0x73, 0x02, 0x64 },	0x8a, ALPS_PROTO_V4, 0x8f, 0x8f, 0 },
 };
 
+static void alps_set_abs_params_st(struct alps_data *priv,
+				   struct input_dev *dev1);
+static void alps_set_abs_params_mt(struct alps_data *priv,
+				   struct input_dev *dev1);
+
 /*
  * XXX - this entry is suspicious. First byte has zero lower nibble,
  * which is what a normal mouse would report. Also, the value 0x0e
@@ -695,24 +700,6 @@ static void alps_process_packet_v4(struct psmouse *psmouse)
 	input_sync(dev);
 }
 
-static void alps_process_packet(struct psmouse *psmouse)
-{
-	struct alps_data *priv = psmouse->private;
-
-	switch (priv->proto_version) {
-	case ALPS_PROTO_V1:
-	case ALPS_PROTO_V2:
-		alps_process_packet_v1_v2(psmouse);
-		break;
-	case ALPS_PROTO_V3:
-		alps_process_packet_v3(psmouse);
-		break;
-	case ALPS_PROTO_V4:
-		alps_process_packet_v4(psmouse);
-		break;
-	}
-}
-
 static void alps_report_bare_ps2_packet(struct psmouse *psmouse,
 					unsigned char packet[],
 					bool report_buttons)
@@ -770,7 +757,7 @@ static psmouse_ret_t alps_handle_interleaved_ps2(struct psmouse *psmouse)
 			return PSMOUSE_BAD_DATA;
 		}
 
-		alps_process_packet(psmouse);
+		priv->process_packet(psmouse);
 
 		/* Continue with the next packet */
 		psmouse->packet[0] = psmouse->packet[6];
@@ -814,6 +801,7 @@ static psmouse_ret_t alps_handle_interleaved_ps2(struct psmouse *psmouse)
 static void alps_flush_packet(unsigned long data)
 {
 	struct psmouse *psmouse = (struct psmouse *)data;
+	struct alps_data *priv = psmouse->private;
 
 	serio_pause_rx(psmouse->ps2dev.serio);
 
@@ -831,7 +819,7 @@ static void alps_flush_packet(unsigned long data)
 				    "refusing packet %3ph (suspected interleaved ps/2)\n",
 				    psmouse->packet + 3);
 		} else {
-			alps_process_packet(psmouse);
+			priv->process_packet(psmouse);
 		}
 		psmouse->pktcnt = 0;
 	}
@@ -876,7 +864,7 @@ static psmouse_ret_t alps_process_byte(struct psmouse *psmouse)
 	}
 
 	if (psmouse->pktcnt == psmouse->pktsize) {
-		alps_process_packet(psmouse);
+		priv->process_packet(psmouse);
 		return PSMOUSE_FULL_PACKET;
 	}
 
@@ -1430,25 +1418,26 @@ error:
 	return -1;
 }
 
-static int alps_hw_init(struct psmouse *psmouse)
+static void alps_set_defaults(struct alps_data *priv)
 {
-	struct alps_data *priv = psmouse->private;
-	int ret = -1;
-
 	switch (priv->proto_version) {
 	case ALPS_PROTO_V1:
 	case ALPS_PROTO_V2:
-		ret = alps_hw_init_v1_v2(psmouse);
+		priv->hw_init = alps_hw_init_v1_v2;
+		priv->process_packet = alps_process_packet_v1_v2;
+		priv->set_abs_params = alps_set_abs_params_st;
 		break;
 	case ALPS_PROTO_V3:
-		ret = alps_hw_init_v3(psmouse);
+		priv->hw_init = alps_hw_init_v3;
+		priv->process_packet = alps_process_packet_v3;
+		priv->set_abs_params = alps_set_abs_params_mt;
 		break;
 	case ALPS_PROTO_V4:
-		ret = alps_hw_init_v4(psmouse);
+		priv->hw_init = alps_hw_init_v4;
+		priv->process_packet = alps_process_packet_v4;
+		priv->set_abs_params = alps_set_abs_params_mt;
 		break;
 	}
-
-	return ret;
 }
 
 static int alps_match_table(struct psmouse *psmouse, struct alps_data *priv,
@@ -1470,6 +1459,8 @@ static int alps_match_table(struct psmouse *psmouse, struct alps_data *priv,
 	}
 
 	priv->proto_version = model->proto_version;
+	alps_set_defaults(priv);
+
 	priv->flags = model->flags;
 	priv->byte0 = model->byte0;
 	priv->mask0 = model->mask0;
@@ -1524,7 +1515,7 @@ static int alps_reconnect(struct psmouse *psmouse)
 	if (alps_identify(psmouse, priv) < 0)
 		return -1;
 
-	return alps_hw_init(psmouse);
+	return priv->hw_init(psmouse);
 }
 
 static void alps_disconnect(struct psmouse *psmouse)
@@ -1537,6 +1528,29 @@ static void alps_disconnect(struct psmouse *psmouse)
 	kfree(priv);
 }
 
+static void alps_set_abs_params_st(struct alps_data *priv,
+				   struct input_dev *dev1)
+{
+	input_set_abs_params(dev1, ABS_X, 0, 1023, 0, 0);
+	input_set_abs_params(dev1, ABS_Y, 0, 767, 0, 0);
+}
+
+static void alps_set_abs_params_mt(struct alps_data *priv,
+				   struct input_dev *dev1)
+{
+	set_bit(INPUT_PROP_SEMI_MT, dev1->propbit);
+	input_mt_init_slots(dev1, 2, 0);
+	input_set_abs_params(dev1, ABS_MT_POSITION_X, 0, ALPS_V3_X_MAX, 0, 0);
+	input_set_abs_params(dev1, ABS_MT_POSITION_Y, 0, ALPS_V3_Y_MAX, 0, 0);
+
+	set_bit(BTN_TOOL_DOUBLETAP, dev1->keybit);
+	set_bit(BTN_TOOL_TRIPLETAP, dev1->keybit);
+	set_bit(BTN_TOOL_QUADTAP, dev1->keybit);
+
+	input_set_abs_params(dev1, ABS_X, 0, ALPS_V3_X_MAX, 0, 0);
+	input_set_abs_params(dev1, ABS_Y, 0, ALPS_V3_Y_MAX, 0, 0);
+}
+
 int alps_init(struct psmouse *psmouse)
 {
 	struct alps_data *priv;
@@ -1557,7 +1571,7 @@ int alps_init(struct psmouse *psmouse)
 	if (alps_identify(psmouse, priv) < 0)
 		goto init_fail;
 
-	if (alps_hw_init(psmouse))
+	if (priv->hw_init(psmouse))
 		goto init_fail;
 
 	/*
@@ -1579,28 +1593,7 @@ int alps_init(struct psmouse *psmouse)
 
 	dev1->evbit[BIT_WORD(EV_ABS)] |= BIT_MASK(EV_ABS);
 
-	switch (priv->proto_version) {
-	case ALPS_PROTO_V1:
-	case ALPS_PROTO_V2:
-		input_set_abs_params(dev1, ABS_X, 0, 1023, 0, 0);
-		input_set_abs_params(dev1, ABS_Y, 0, 767, 0, 0);
-		break;
-	case ALPS_PROTO_V3:
-	case ALPS_PROTO_V4:
-		set_bit(INPUT_PROP_SEMI_MT, dev1->propbit);
-		input_mt_init_slots(dev1, 2, 0);
-		input_set_abs_params(dev1, ABS_MT_POSITION_X, 0, ALPS_V3_X_MAX, 0, 0);
-		input_set_abs_params(dev1, ABS_MT_POSITION_Y, 0, ALPS_V3_Y_MAX, 0, 0);
-
-		set_bit(BTN_TOOL_DOUBLETAP, dev1->keybit);
-		set_bit(BTN_TOOL_TRIPLETAP, dev1->keybit);
-		set_bit(BTN_TOOL_QUADTAP, dev1->keybit);
-
-		input_set_abs_params(dev1, ABS_X, 0, ALPS_V3_X_MAX, 0, 0);
-		input_set_abs_params(dev1, ABS_Y, 0, ALPS_V3_Y_MAX, 0, 0);
-		break;
-	}
-
+	priv->set_abs_params(priv, dev1);
 	input_set_abs_params(dev1, ABS_PRESSURE, 0, 127, 0, 0);
 
 	if (priv->flags & ALPS_WHEEL) {
diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
index a81b318..0934f8b 100644
--- a/drivers/input/mouse/alps.h
+++ b/drivers/input/mouse/alps.h
@@ -72,6 +72,9 @@ struct alps_nibble_commands {
  *   mask0, should match byte0.
  * @mask0: The mask used to check the first byte of the report.
  * @flags: Additional device capabilities (passthrough port, trackstick, etc.).
+ * @hw_init: Protocol-specific hardware init function.
+ * @process_packet: Protocol-specific function to process a report packet.
+ * @set_abs_params: Protocol-specific function to configure the input_dev.
  * @prev_fin: Finger bit from previous packet.
  * @multi_packet: Multi-packet data in progress.
  * @multi_data: Saved multi-packet data.
@@ -94,6 +97,10 @@ struct alps_data {
 	unsigned char byte0, mask0;
 	unsigned char flags;
 
+	int (*hw_init)(struct psmouse *psmouse);
+	void (*process_packet)(struct psmouse *psmouse);
+	void (*set_abs_params)(struct alps_data *priv, struct input_dev *dev1);
+
 	int prev_fin;
 	int multi_packet;
 	unsigned char multi_data[6];
-- 
1.7.10.4

