From: Ben Gamari <ben@smart-cactus.org>
Subject: [PATCH 1/5] input/alps: Add touchstick support for SS5 hardware
Date: Mon,  3 Oct 2016 08:16:26 -0400
Message-ID: <20161003121630.5285-1-ben@smart-cactus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from turtle.smart-cactus.org ([163.172.166.228]:55554 "EHLO
        mail.smart-cactus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751583AbcJCMZo (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 3 Oct 2016 08:25:44 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michal Hocko <mhocko@kernel.org>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Allen Hung <Allen_Hung@dell.com>, Masaki Ota <masaki.ota@jp.alps.com>, Ben Morgan <Ben_Morgan@dell.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>
Cc: Ben Gamari <ben@smart-cactus.org>

Add touchstick support for the so-called SS5 hardware, which uses a
variant of the SS4 protocol.

Reviewed-by: Pali Rohár <pali.rohar@gmail.com>
Tested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Ben Gamari <ben@smart-cactus.org>
---
 drivers/input/mouse/alps.c | 64 ++++++++++++++++++++++++++++++++++++++--------
 drivers/input/mouse/alps.h |  2 ++
 2 files changed, 55 insertions(+), 11 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 936f07a..b8454af 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1156,15 +1156,27 @@ static unsigned char alps_get_pkt_id_ss4_v2(unsigned char *byte)
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
@@ -1246,16 +1258,38 @@ static int alps_decode_ss4_v2(struct alps_fields *f,
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
@@ -1266,6 +1300,7 @@ static void alps_process_packet_ss4_v2(struct psmouse *psmouse)
 	struct alps_data *priv = psmouse->private;
 	unsigned char *packet = psmouse->packet;
 	struct input_dev *dev = psmouse->dev;
+	struct input_dev *dev2 = priv->dev2;
 	struct alps_fields *f = &priv->f;
 
 	memset(f, 0, sizeof(struct alps_fields));
@@ -1311,6 +1346,13 @@ static void alps_process_packet_ss4_v2(struct psmouse *psmouse)
 
 	input_report_abs(dev, ABS_PRESSURE, f->pressure);
 	input_sync(dev);
+
+	if (priv->flags & ALPS_DUALPOINT) {
+		input_report_key(dev2, BTN_LEFT, f->ts_left);
+		input_report_key(dev2, BTN_RIGHT, f->ts_right);
+		input_report_key(dev2, BTN_MIDDLE, f->ts_middle);
+		input_sync(dev2);
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
2.9.3

