From: Masaki Ota <012nexus@gmail.com>
Subject: [PATCH] Fix Alps Touchpad two finger scroll does not work on right side
Date: Fri, 21 Jul 2017 09:27:30 +0900
Message-ID: <20170721002730.2640-1-masaki.ota@jp.alps.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-kernel@PaulSD.com, benjamin.tissoires@redhat.com, pali.rohar@gmail.com
Cc: labbott@redhat.com, nick.m.fletcher@gmail.com, tiwai@suse.de, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, masaki.ota@jp.alps.com
List-Id: linux-input@vger.kernel.org

From: Masaki Ota <masaki.ota@jp.alps.com>

Fixed the issue that two finger scroll does not work correctly
on V8 protocol. The cause is that V8 protocol X-coordinate decode
is wrong at SS4 PLUS device. I added SS4 PLUS X decode definition.

Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
Tested-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/input/mouse/alps.c | 41 +++++++++++++++++++++++++++++++----------
 drivers/input/mouse/alps.h |  8 ++++++++
 2 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index f210e19ddba6..2627c724bb7c 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1210,14 +1210,24 @@ static int alps_decode_ss4_v2(struct alps_fields *f,
 
 	case SS4_PACKET_ID_TWO:
 		if (priv->flags & ALPS_BUTTONPAD) {
-			f->mt[0].x = SS4_BTL_MF_X_V2(p, 0);
+			if (IS_SS4PLUS_DEV(priv->dev_id)) {
+				f->mt[0].x = SS4_PLUS_BTL_MF_X_V2(p, 0);
+				f->mt[1].x = SS4_PLUS_BTL_MF_X_V2(p, 1);
+			} else {
+				f->mt[0].x = SS4_BTL_MF_X_V2(p, 0);
+				f->mt[1].x = SS4_BTL_MF_X_V2(p, 1);
+			}
 			f->mt[0].y = SS4_BTL_MF_Y_V2(p, 0);
-			f->mt[1].x = SS4_BTL_MF_X_V2(p, 1);
 			f->mt[1].y = SS4_BTL_MF_Y_V2(p, 1);
 		} else {
-			f->mt[0].x = SS4_STD_MF_X_V2(p, 0);
+			if (IS_SS4PLUS_DEV(priv->dev_id)) {
+				f->mt[0].x = SS4_PLUS_STD_MF_X_V2(p, 0);
+				f->mt[1].x = SS4_PLUS_STD_MF_X_V2(p, 1);
+			} else {
+				f->mt[0].x = SS4_STD_MF_X_V2(p, 0);
+				f->mt[1].x = SS4_STD_MF_X_V2(p, 1);
+			}
 			f->mt[0].y = SS4_STD_MF_Y_V2(p, 0);
-			f->mt[1].x = SS4_STD_MF_X_V2(p, 1);
 			f->mt[1].y = SS4_STD_MF_Y_V2(p, 1);
 		}
 		f->pressure = SS4_MF_Z_V2(p, 0) ? 0x30 : 0;
@@ -1234,16 +1244,27 @@ static int alps_decode_ss4_v2(struct alps_fields *f,
 
 	case SS4_PACKET_ID_MULTI:
 		if (priv->flags & ALPS_BUTTONPAD) {
-			f->mt[2].x = SS4_BTL_MF_X_V2(p, 0);
+			if (IS_SS4PLUS_DEV(priv->dev_id)) {
+				f->mt[0].x = SS4_PLUS_BTL_MF_X_V2(p, 0);
+				f->mt[1].x = SS4_PLUS_BTL_MF_X_V2(p, 1);
+			} else {
+				f->mt[2].x = SS4_BTL_MF_X_V2(p, 0);
+				f->mt[3].x = SS4_BTL_MF_X_V2(p, 1);
+			}
+
 			f->mt[2].y = SS4_BTL_MF_Y_V2(p, 0);
-			f->mt[3].x = SS4_BTL_MF_X_V2(p, 1);
 			f->mt[3].y = SS4_BTL_MF_Y_V2(p, 1);
 			no_data_x = SS4_MFPACKET_NO_AX_BL;
 			no_data_y = SS4_MFPACKET_NO_AY_BL;
 		} else {
-			f->mt[2].x = SS4_STD_MF_X_V2(p, 0);
+			if (IS_SS4PLUS_DEV(priv->dev_id)) {
+				f->mt[0].x = SS4_PLUS_STD_MF_X_V2(p, 0);
+				f->mt[1].x = SS4_PLUS_STD_MF_X_V2(p, 1);
+			} else {
+				f->mt[0].x = SS4_STD_MF_X_V2(p, 0);
+				f->mt[1].x = SS4_STD_MF_X_V2(p, 1);
+			}
 			f->mt[2].y = SS4_STD_MF_Y_V2(p, 0);
-			f->mt[3].x = SS4_STD_MF_X_V2(p, 1);
 			f->mt[3].y = SS4_STD_MF_Y_V2(p, 1);
 			no_data_x = SS4_MFPACKET_NO_AX;
 			no_data_y = SS4_MFPACKET_NO_AY;
@@ -2536,8 +2557,8 @@ static int alps_set_defaults_ss4_v2(struct psmouse *psmouse,
 
 	memset(otp, 0, sizeof(otp));
 
-	if (alps_get_otp_values_ss4_v2(psmouse, 0, &otp[0][0]) ||
-	    alps_get_otp_values_ss4_v2(psmouse, 1, &otp[1][0]))
+	if (alps_get_otp_values_ss4_v2(psmouse, 1, &otp[1][0]) ||
+	    alps_get_otp_values_ss4_v2(psmouse, 0, &otp[0][0]))
 		return -1;
 
 	alps_update_device_area_ss4_v2(otp, priv);
diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
index 4334f2805d93..75542199edda 100644
--- a/drivers/input/mouse/alps.h
+++ b/drivers/input/mouse/alps.h
@@ -99,6 +99,10 @@ enum SS4_PACKET_ID {
 				 ((_b[1 + _i * 3]  << 5) & 0x1F00)	\
 				)
 
+#define SS4_PLUS_STD_MF_X_V2(_b, _i) (((_b[0 + (_i) * 3] << 4) & 0x0070) | \
+				 ((_b[1 + (_i) * 3]  << 4) & 0x0F80)	\
+				)
+
 #define SS4_STD_MF_Y_V2(_b, _i)	(((_b[1 + (_i) * 3] << 3) & 0x0010) |	\
 				 ((_b[2 + (_i) * 3] << 5) & 0x01E0) |	\
 				 ((_b[2 + (_i) * 3] << 4) & 0x0E00)	\
@@ -108,6 +112,10 @@ enum SS4_PACKET_ID {
 				 ((_b[0 + (_i) * 3] >> 3) & 0x0010)	\
 				)
 
+#define SS4_PLUS_BTL_MF_X_V2(_b, _i) (SS4_PLUS_STD_MF_X_V2(_b, _i) |	\
+				 ((_b[0 + (_i) * 3] >> 4) & 0x0008)	\
+				)
+
 #define SS4_BTL_MF_Y_V2(_b, _i)	(SS4_STD_MF_Y_V2(_b, _i) | \
 				 ((_b[0 + (_i) * 3] >> 3) & 0x0008)	\
 				)
-- 
2.11.0
