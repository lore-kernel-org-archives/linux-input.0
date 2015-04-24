From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 6/7] alps: Rename alps_set_abs_params_mt to alps_set_abs_params_semi_mt
Date: Fri, 24 Apr 2015 16:48:55 +0200
Message-ID: <1429886936-24587-7-git-send-email-hdegoede@redhat.com>
References: <1429886936-24587-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48192 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755076AbbDXOtJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Apr 2015 10:49:09 -0400
In-Reply-To: <1429886936-24587-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Hutterer <peter.hutterer@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Rename alps_set_abs_params_mt to alps_set_abs_params_semi_mt,
to make it clear that it is only (to be) used for semi-mt devices.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/alps.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 11fda20..390a308 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -159,8 +159,8 @@ static const struct alps_protocol_info alps_v8_protocol_data = {
 
 static void alps_set_abs_params_st(struct alps_data *priv,
 				   struct input_dev *dev1);
-static void alps_set_abs_params_mt(struct alps_data *priv,
-				   struct input_dev *dev1);
+static void alps_set_abs_params_semi_mt(struct alps_data *priv,
+					struct input_dev *dev1);
 static void alps_set_abs_params_v7(struct alps_data *priv,
 				   struct input_dev *dev1);
 static void alps_set_abs_params_ss4_v2(struct alps_data *priv,
@@ -2615,7 +2615,7 @@ static int alps_set_protocol(struct psmouse *psmouse,
 	case ALPS_PROTO_V3:
 		priv->hw_init = alps_hw_init_v3;
 		priv->process_packet = alps_process_packet_v3;
-		priv->set_abs_params = alps_set_abs_params_mt;
+		priv->set_abs_params = alps_set_abs_params_semi_mt;
 		priv->decode_fields = alps_decode_pinnacle;
 		priv->nibble_commands = alps_v3_nibble_commands;
 		priv->addr_command = PSMOUSE_CMD_RESET_WRAP;
@@ -2624,7 +2624,7 @@ static int alps_set_protocol(struct psmouse *psmouse,
 	case ALPS_PROTO_V3_RUSHMORE:
 		priv->hw_init = alps_hw_init_rushmore_v3;
 		priv->process_packet = alps_process_packet_v3;
-		priv->set_abs_params = alps_set_abs_params_mt;
+		priv->set_abs_params = alps_set_abs_params_semi_mt;
 		priv->decode_fields = alps_decode_rushmore;
 		priv->nibble_commands = alps_v3_nibble_commands;
 		priv->addr_command = PSMOUSE_CMD_RESET_WRAP;
@@ -2640,7 +2640,7 @@ static int alps_set_protocol(struct psmouse *psmouse,
 	case ALPS_PROTO_V4:
 		priv->hw_init = alps_hw_init_v4;
 		priv->process_packet = alps_process_packet_v4;
-		priv->set_abs_params = alps_set_abs_params_mt;
+		priv->set_abs_params = alps_set_abs_params_semi_mt;
 		priv->nibble_commands = alps_v4_nibble_commands;
 		priv->addr_command = PSMOUSE_CMD_DISABLE;
 		break;
@@ -2649,7 +2649,7 @@ static int alps_set_protocol(struct psmouse *psmouse,
 		priv->hw_init = alps_hw_init_dolphin_v1;
 		priv->process_packet = alps_process_touchpad_packet_v3_v5;
 		priv->decode_fields = alps_decode_dolphin;
-		priv->set_abs_params = alps_set_abs_params_mt;
+		priv->set_abs_params = alps_set_abs_params_semi_mt;
 		priv->nibble_commands = alps_v3_nibble_commands;
 		priv->addr_command = PSMOUSE_CMD_RESET_WRAP;
 		priv->x_bits = 23;
@@ -2831,8 +2831,8 @@ static void alps_set_abs_params_mt_common(struct alps_data *priv,
 	set_bit(BTN_TOOL_QUADTAP, dev1->keybit);
 }
 
-static void alps_set_abs_params_mt(struct alps_data *priv,
-				   struct input_dev *dev1)
+static void alps_set_abs_params_semi_mt(struct alps_data *priv,
+					struct input_dev *dev1)
 {
 	alps_set_abs_params_mt_common(priv, dev1);
 	input_set_abs_params(dev1, ABS_PRESSURE, 0, 127, 0, 0);
-- 
2.3.5

