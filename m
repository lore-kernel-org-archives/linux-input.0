From: Masaki Ota <012nexus@gmail.com>
Subject: [PATCH 1/2] Fix V8 device information issue
Date: Mon, 13 Mar 2017 16:04:09 +0900
Message-ID: <20170313070410.4710-1-masaki.ota@jp.alps.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36360 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbdCMHER (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 13 Mar 2017 03:04:17 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-kernel@paulsd.com, nick.m.fletcher@gmail.com
Cc: joseph.salisbury@canonical.com, ben@smart-cactus.org, mhocko@suse.com, pali.rohar@gmail.com, rydberg@bitmath.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, masaki.ota@jp.alps.com

From: Masaki Ota <masaki.ota@jp.alps.com>
-Fix the issue that V8(E7=73 03 28) devices are not assined correct device information bit from OTP.
-Specified correct OTP bit for the V8 device setting of Button pad, DualPoint and Touchpad size.
-Deleted extra code from alps_v8_protocol_data decision process.

Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
---
 drivers/input/mouse/alps.c | 66 +++++++++++++++++++++++++++++++++++-----------
 drivers/input/mouse/alps.h | 11 ++++++++
 2 files changed, 61 insertions(+), 16 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index e761955..a70c860 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -2467,14 +2467,34 @@ static int alps_update_device_area_ss4_v2(unsigned char otp[][4],
 	int num_y_electrode;
 	int x_pitch, y_pitch, x_phys, y_phys;
 
-	num_x_electrode = SS4_NUMSENSOR_XOFFSET + (otp[1][0] & 0x0F);
-	num_y_electrode = SS4_NUMSENSOR_YOFFSET + ((otp[1][0] >> 4) & 0x0F);
+	if (IS_SS4PLUS_DEV(priv->dev_id)) {
+		num_x_electrode =
+			SS4PLUS_NUMSENSOR_XOFFSET + (otp[0][2] & 0x0F);
+		num_y_electrode =
+			SS4PLUS_NUMSENSOR_YOFFSET + ((otp[0][2] >> 4) & 0x0F);
 
-	priv->x_max = (num_x_electrode - 1) * SS4_COUNT_PER_ELECTRODE;
-	priv->y_max = (num_y_electrode - 1) * SS4_COUNT_PER_ELECTRODE;
+		priv->x_max =
+			(num_x_electrode - 1) * SS4PLUS_COUNT_PER_ELECTRODE;
+		priv->y_max =
+			(num_y_electrode - 1) * SS4PLUS_COUNT_PER_ELECTRODE;
 
-	x_pitch = ((otp[1][2] >> 2) & 0x07) + SS4_MIN_PITCH_MM;
-	y_pitch = ((otp[1][2] >> 5) & 0x07) + SS4_MIN_PITCH_MM;
+		x_pitch = (otp[0][1] & 0x0F) + SS4PLUS_MIN_PITCH_MM;
+		y_pitch = ((otp[0][1] >> 4) & 0x0F) + SS4PLUS_MIN_PITCH_MM;
+
+	} else {
+		num_x_electrode =
+			SS4_NUMSENSOR_XOFFSET + (otp[1][0] & 0x0F);
+		num_y_electrode =
+			SS4_NUMSENSOR_YOFFSET + ((otp[1][0] >> 4) & 0x0F);
+
+		priv->x_max =
+			(num_x_electrode - 1) * SS4_COUNT_PER_ELECTRODE;
+		priv->y_max =
+			(num_y_electrode - 1) * SS4_COUNT_PER_ELECTRODE;
+
+		x_pitch = ((otp[1][2] >> 2) & 0x07) + SS4_MIN_PITCH_MM;
+		y_pitch = ((otp[1][2] >> 5) & 0x07) + SS4_MIN_PITCH_MM;
+	}
 
 	x_phys = x_pitch * (num_x_electrode - 1); /* In 0.1 mm units */
 	y_phys = y_pitch * (num_y_electrode - 1); /* In 0.1 mm units */
@@ -2490,7 +2510,10 @@ static int alps_update_btn_info_ss4_v2(unsigned char otp[][4],
 {
 	unsigned char is_btnless;
 
-	is_btnless = (otp[1][1] >> 3) & 0x01;
+	if (IS_SS4PLUS_DEV(priv->dev_id))
+		is_btnless = (otp[1][0] >> 1) & 0x01;
+	else
+		is_btnless = (otp[1][1] >> 3) & 0x01;
 
 	if (is_btnless)
 		priv->flags |= ALPS_BUTTONPAD;
@@ -2498,6 +2521,21 @@ static int alps_update_btn_info_ss4_v2(unsigned char otp[][4],
 	return 0;
 }
 
+static int alps_update_dual_info_ss4_v2(unsigned char otp[][4],
+				       struct alps_data *priv)
+{
+	unsigned char is_dual = 0;
+
+	if (IS_SS4PLUS_DEV(priv->dev_id))
+		is_dual = (otp[0][0] >> 4) & 0x01;
+
+	if (is_dual)
+		priv->flags |= ALPS_DUALPOINT |
+					ALPS_DUALPOINT_WITH_PRESSURE;
+
+	return 0;
+}
+
 static int alps_set_defaults_ss4_v2(struct psmouse *psmouse,
 				    struct alps_data *priv)
 {
@@ -2513,6 +2551,8 @@ static int alps_set_defaults_ss4_v2(struct psmouse *psmouse,
 
 	alps_update_btn_info_ss4_v2(otp, priv);
 
+	alps_update_dual_info_ss4_v2(otp, priv);
+
 	return 0;
 }
 
@@ -2758,10 +2798,6 @@ static int alps_set_protocol(struct psmouse *psmouse,
 		if (alps_set_defaults_ss4_v2(psmouse, priv))
 			return -EIO;
 
-		if (priv->fw_ver[1] == 0x1)
-			priv->flags |= ALPS_DUALPOINT |
-					ALPS_DUALPOINT_WITH_PRESSURE;
-
 		break;
 	}
 
@@ -2831,10 +2867,7 @@ static int alps_identify(struct psmouse *psmouse, struct alps_data *priv)
 			   ec[2] >= 0x90 && ec[2] <= 0x9d) {
 			protocol = &alps_v3_protocol_data;
 		} else if (e7[0] == 0x73 && e7[1] == 0x03 &&
-			   e7[2] == 0x14 && ec[1] == 0x02) {
-			protocol = &alps_v8_protocol_data;
-		} else if (e7[0] == 0x73 && e7[1] == 0x03 &&
-			   e7[2] == 0x28 && ec[1] == 0x01) {
+			   (e7[2] == 0x14 || e7[2] == 0x28)) {
 			protocol = &alps_v8_protocol_data;
 		} else if (e7[0] == 0x73 && e7[1] == 0x03 && e7[2] == 0xc8) {
 			protocol = &alps_v9_protocol_data;
@@ -2850,7 +2883,8 @@ static int alps_identify(struct psmouse *psmouse, struct alps_data *priv)
 	}
 
 	if (priv) {
-		/* Save the Firmware version */
+		/* Save Device ID and Firmware version */
+		memcpy(priv->dev_id, e7, 3);
 		memcpy(priv->fw_ver, ec, 3);
 		error = alps_set_protocol(psmouse, priv, protocol);
 		if (error)
diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
index dea3163..ed2d687 100644
--- a/drivers/input/mouse/alps.h
+++ b/drivers/input/mouse/alps.h
@@ -55,6 +55,16 @@ enum SS4_PACKET_ID {
 
 #define SS4_MASK_NORMAL_BUTTONS		0x07
 
+#define SS4PLUS_COUNT_PER_ELECTRODE	128
+#define SS4PLUS_NUMSENSOR_XOFFSET	16
+#define SS4PLUS_NUMSENSOR_YOFFSET	5
+#define SS4PLUS_MIN_PITCH_MM		37
+
+#define IS_SS4PLUS_DEV(_b)	(((_b[0]) == 0x73) &&	\
+				 ((_b[1]) == 0x03) &&	\
+				 ((_b[2]) == 0x28)		\
+				)
+
 #define SS4_IS_IDLE_V2(_b)	(((_b[0]) == 0x18) &&		\
 				 ((_b[1]) == 0x10) &&		\
 				 ((_b[2]) == 0x00) &&		\
@@ -279,6 +289,7 @@ struct alps_data {
 	int addr_command;
 	u16 proto_version;
 	u8 byte0, mask0;
+	u8 dev_id[3];
 	u8 fw_ver[3];
 	int flags;
 	int x_max;
-- 
2.9.3

