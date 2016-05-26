From: Ben Gamari <ben@smart-cactus.org>
Subject: [PATCH 2/3] input/alps: Add touchstick support for V8 protocol devices
Date: Thu, 26 May 2016 10:55:13 +0200
Message-ID: <1464252914-11450-3-git-send-email-ben@smart-cactus.org>
References: <201605251801.45240@pali>
 <1464252914-11450-1-git-send-email-ben@smart-cactus.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.smart-cactus.org ([54.187.36.80]:56250 "EHLO
	mail.smart-cactus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbcEZI4R (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 May 2016 04:56:17 -0400
In-Reply-To: <1464252914-11450-1-git-send-email-ben@smart-cactus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>, Allen Hung <Allen_Hung@dell.com>, Masaki Ota <masaki.ota@jp.alps.com>, Ben Gamari <ben@smart-cactus.org>

---
 drivers/input/mouse/alps.c | 64 ++++++++++++++++++++++++++++++++++++++--------
 drivers/input/mouse/alps.h |  2 ++
 2 files changed, 55 insertions(+), 11 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index daf9421..10e6836 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1161,15 +1161,27 @@ static unsigned char alps_get_pkt_id_ss4_v2(unsigned char *byte)
 {
 	unsigned char pkt_id = SS4_PACKET_ID_IDLE;
 
-	if (byte[0] == 0x18 && byte[1] == 0x10 && byte[2] == 0x00 &&
-	    (byte[3] & 0x88) == 0x08 && byte[4] == 0x10 && byte[5] == 0x00) {
-		pkt_id = SS4_PACKET_ID_IDLE;
-	} else if (!(byte[3] & 0x10)) {
-		pkt_id = SS4_PACKET_ID_ONE;
-	} else if (!(byte[3] & 0x20)) {
+	switch (byte[3] & 0x30) {
+	case 0x00:
+		if (byte[0] == 0x18 && byte[1] == 0x10 && byte[2] == 0x00 &&
+				(byte[3] & 0x88) == 0x08 && byte[4] == 0x10 && byte[5] == 0x00) {
+			pkt_id = SS4_PACKET_ID_IDLE;
+		} else {
+			pkt_id = SS4_PACKET_ID_ONE;
+		}
+		break;
+	case 0x10:
+		/* two-finger finger positions */
 		pkt_id = SS4_PACKET_ID_TWO;
-	} else {
+		break;
+	case 0x20:
+		/* stick pointer */
+		pkt_id = SS4_PACKET_ID_STICK;
+		break;
+	case 0x30:
+		/* third and fourth finger positions */
 		pkt_id = SS4_PACKET_ID_MULTI;
+		break;
 	}
 
 	return pkt_id;
@@ -1251,16 +1263,38 @@ static int alps_decode_ss4_v2(struct alps_fields *f,
 		}
 		break;
 
+	case SS4_PACKET_ID_STICK:
+		if (!(priv->flags & ALPS_DUALPOINT)) {
+			psmouse_warn(psmouse,
+				     "Rejected trackstick packet from non DualPoint device");
+		} else {
+			int x = (s8)(((p[0] & 1) << 7) | (p[1] & 0x7f));
+			int y = (s8)(((p[3] & 1) << 7) | (p[2] & 0x7f));
+
+			input_report_rel(priv->dev2, REL_X, x);
+			input_report_rel(priv->dev2, REL_Y, -y);
+		}
+		break;
+
 	case SS4_PACKET_ID_IDLE:
 	default:
 		memset(f, 0, sizeof(struct alps_fields));
 		break;
 	}
 
-	f->left = !!(SS4_BTN_V2(p) & 0x01);
-	if (!(priv->flags & ALPS_BUTTONPAD)) {
-		f->right = !!(SS4_BTN_V2(p) & 0x02);
-		f->middle = !!(SS4_BTN_V2(p) & 0x04);
+	/* handle buttons */
+	if (pkt_id == SS4_PACKET_ID_STICK) {
+		f->ts_left = !!(SS4_BTN_V2(p) & 0x01);
+		if (!(priv->flags & ALPS_BUTTONPAD)) {
+			f->ts_right = !!(SS4_BTN_V2(p) & 0x02);
+			f->ts_middle = !!(SS4_BTN_V2(p) & 0x04);
+		}
+	} else {
+		f->left = !!(SS4_BTN_V2(p) & 0x01);
+		if (!(priv->flags & ALPS_BUTTONPAD)) {
+			f->right = !!(SS4_BTN_V2(p) & 0x02);
+			f->middle = !!(SS4_BTN_V2(p) & 0x04);
+		}
 	}
 
 	return 0;
@@ -1271,6 +1305,7 @@ static void alps_process_packet_ss4_v2(struct psmouse *psmouse)
 	struct alps_data *priv = psmouse->private;
 	unsigned char *packet = psmouse->packet;
 	struct input_dev *dev = psmouse->dev;
+	struct input_dev *dev2 = priv->dev2;
 	struct alps_fields *f = &priv->f;
 
 	memset(f, 0, sizeof(struct alps_fields));
@@ -1316,6 +1351,13 @@ static void alps_process_packet_ss4_v2(struct psmouse *psmouse)
 
 	input_report_abs(dev, ABS_PRESSURE, f->pressure);
 	input_sync(dev);
+
+	if (priv->flags & ALPS_DUALPOINT) {
+          input_report_key(dev2, BTN_LEFT, f->ts_left);
+          input_report_key(dev2, BTN_RIGHT, f->ts_right);
+          input_report_key(dev2, BTN_MIDDLE, f->ts_middle);
+          input_sync(dev2);
+	}
 }
 
 static bool alps_is_valid_package_ss4_v2(struct psmouse *psmouse)
diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
index d37f814..b9417e2 100644
--- a/drivers/input/mouse/alps.h
+++ b/drivers/input/mouse/alps.h
@@ -37,12 +37,14 @@
  *  or there's button activities.
  * SS4_PACKET_ID_TWO: There's two or more fingers on touchpad
  * SS4_PACKET_ID_MULTI: There's three or more fingers on touchpad
+ * SS4_PACKET_ID_STICK: A stick pointer packet
 */
 enum SS4_PACKET_ID {
 	SS4_PACKET_ID_IDLE = 0,
 	SS4_PACKET_ID_ONE,
 	SS4_PACKET_ID_TWO,
 	SS4_PACKET_ID_MULTI,
+	SS4_PACKET_ID_STICK,
 };
 
 #define SS4_COUNT_PER_ELECTRODE		256
-- 
2.8.1

