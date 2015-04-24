From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/7] alps: Always decode the position packet before the packet with the bitmap data
Date: Fri, 24 Apr 2015 16:48:52 +0200
Message-ID: <1429886936-24587-4-git-send-email-hdegoede@redhat.com>
References: <1429886936-24587-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34343 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754959AbbDXOtD (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Apr 2015 10:49:03 -0400
In-Reply-To: <1429886936-24587-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Hutterer <peter.hutterer@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

This way we can use the more accurate position info in process_bitmap() to
get better results.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/alps.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 5449537..1cfee85 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -696,25 +696,18 @@ static void alps_process_touchpad_packet_v3_v5(struct psmouse *psmouse)
 		 */
 		if (f->is_mp) {
 			fingers = f->fingers;
+			/*
+			 * Bitmap processing uses position packet's coordinate
+			 * data, so we need to do decode it first.
+			 */
+			priv->decode_fields(f, priv->multi_data, psmouse);
+
 			if (priv->proto_version == ALPS_PROTO_V3 ||
 			    priv->proto_version == ALPS_PROTO_V3_RUSHMORE) {
 				if (alps_process_bitmap(priv, f) == 0)
 					fingers = 0; /* Use st data */
-
-				/* Now process position packet */
-				priv->decode_fields(f, priv->multi_data,
-						    psmouse);
 			} else {
 				/*
-				 * Because Dolphin uses position packet's
-				 * coordinate data as Pt1 and uses it to
-				 * calculate Pt2, so we need to do position
-				 * packet decode first.
-				 */
-				priv->decode_fields(f, priv->multi_data,
-						    psmouse);
-
-				/*
 				 * Since Dolphin's finger number is reliable,
 				 * there is no need to compare with bmap_fn.
 				 */
@@ -881,6 +874,14 @@ static void alps_process_packet_v4(struct psmouse *psmouse)
 	priv->multi_data[offset] = packet[6];
 	priv->multi_data[offset + 1] = packet[7];
 
+	f->left = !!(packet[4] & 0x01);
+	f->right = !!(packet[4] & 0x02);
+
+	f->st.x = ((packet[1] & 0x7f) << 4) | ((packet[3] & 0x30) >> 2) |
+		  ((packet[0] & 0x30) >> 4);
+	f->st.y = ((packet[2] & 0x7f) << 4) | (packet[3] & 0x0f);
+	f->pressure = packet[5] & 0x7f;
+
 	if (++priv->multi_packet > 2) {
 		priv->multi_packet = 0;
 
@@ -895,14 +896,6 @@ static void alps_process_packet_v4(struct psmouse *psmouse)
 		f->fingers = alps_process_bitmap(priv, f);
 	}
 
-	f->left = !!(packet[4] & 0x01);
-	f->right = !!(packet[4] & 0x02);
-
-	f->st.x = ((packet[1] & 0x7f) << 4) | ((packet[3] & 0x30) >> 2) |
-		  ((packet[0] & 0x30) >> 4);
-	f->st.y = ((packet[2] & 0x7f) << 4) | (packet[3] & 0x0f);
-	f->pressure = packet[5] & 0x7f;
-
 	alps_report_semi_mt_data(psmouse, f->fingers);
 }
 
-- 
2.3.5

