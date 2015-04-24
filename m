From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/7] alps: Only set fields actually present when decoding pinnacle / rushmore pkts
Date: Fri, 24 Apr 2015 16:48:51 +0200
Message-ID: <1429886936-24587-3-git-send-email-hdegoede@redhat.com>
References: <1429886936-24587-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48179 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755076AbbDXOtD (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Apr 2015 10:49:03 -0400
In-Reply-To: <1429886936-24587-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Hutterer <peter.hutterer@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Pinnacle / Rushmore packets contain either position info, or bitmap info,
never both. So far we've in essence been storing garbage in the position /
bitmap fields of the fields struct when decoding a bitmap / pos packet.

We've been relying on the following sequence to get away with this:

1) Decode bitmap packet
2) Process bitmap packet
3) Decode position packet
4) Use position / button info

This patch allows us to change this sequence, which will allow using the
position info when processing the bitmap for more accurate results.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/alps.c | 62 ++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index e2ae6ca..5449537 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -584,20 +584,22 @@ static int alps_decode_pinnacle(struct alps_fields *f, unsigned char *p,
 	f->first_mp = !!(p[4] & 0x40);
 	f->is_mp = !!(p[0] & 0x40);
 
-	f->fingers = (p[5] & 0x3) + 1;
-	f->x_map = ((p[4] & 0x7e) << 8) |
-		   ((p[1] & 0x7f) << 2) |
-		   ((p[0] & 0x30) >> 4);
-	f->y_map = ((p[3] & 0x70) << 4) |
-		   ((p[2] & 0x7f) << 1) |
-		   (p[4] & 0x01);
-
-	f->st.x = ((p[1] & 0x7f) << 4) | ((p[4] & 0x30) >> 2) |
-	       ((p[0] & 0x30) >> 4);
-	f->st.y = ((p[2] & 0x7f) << 4) | (p[4] & 0x0f);
-	f->pressure = p[5] & 0x7f;
+	if (f->is_mp) {
+		f->fingers = (p[5] & 0x3) + 1;
+		f->x_map = ((p[4] & 0x7e) << 8) |
+			   ((p[1] & 0x7f) << 2) |
+			   ((p[0] & 0x30) >> 4);
+		f->y_map = ((p[3] & 0x70) << 4) |
+			   ((p[2] & 0x7f) << 1) |
+			   (p[4] & 0x01);
+	} else {
+		f->st.x = ((p[1] & 0x7f) << 4) | ((p[4] & 0x30) >> 2) |
+		       ((p[0] & 0x30) >> 4);
+		f->st.y = ((p[2] & 0x7f) << 4) | (p[4] & 0x0f);
+		f->pressure = p[5] & 0x7f;
 
-	alps_decode_buttons_v3(f, p);
+		alps_decode_buttons_v3(f, p);
+	}
 
 	return 0;
 }
@@ -608,22 +610,24 @@ static int alps_decode_rushmore(struct alps_fields *f, unsigned char *p,
 	f->first_mp = !!(p[4] & 0x40);
 	f->is_mp = !!(p[5] & 0x40);
 
-	f->fingers = max((p[5] & 0x3), ((p[5] >> 2) & 0x3)) + 1;
-	f->x_map = ((p[5] & 0x10) << 11) |
-		   ((p[4] & 0x7e) << 8) |
-		   ((p[1] & 0x7f) << 2) |
-		   ((p[0] & 0x30) >> 4);
-	f->y_map = ((p[5] & 0x20) << 6) |
-		   ((p[3] & 0x70) << 4) |
-		   ((p[2] & 0x7f) << 1) |
-		   (p[4] & 0x01);
-
-	f->st.x = ((p[1] & 0x7f) << 4) | ((p[4] & 0x30) >> 2) |
-	       ((p[0] & 0x30) >> 4);
-	f->st.y = ((p[2] & 0x7f) << 4) | (p[4] & 0x0f);
-	f->pressure = p[5] & 0x7f;
-
-	alps_decode_buttons_v3(f, p);
+	if (f->is_mp) {
+		f->fingers = max((p[5] & 0x3), ((p[5] >> 2) & 0x3)) + 1;
+		f->x_map = ((p[5] & 0x10) << 11) |
+			   ((p[4] & 0x7e) << 8) |
+			   ((p[1] & 0x7f) << 2) |
+			   ((p[0] & 0x30) >> 4);
+		f->y_map = ((p[5] & 0x20) << 6) |
+			   ((p[3] & 0x70) << 4) |
+			   ((p[2] & 0x7f) << 1) |
+			   (p[4] & 0x01);
+	} else {
+		f->st.x = ((p[1] & 0x7f) << 4) | ((p[4] & 0x30) >> 2) |
+		       ((p[0] & 0x30) >> 4);
+		f->st.y = ((p[2] & 0x7f) << 4) | (p[4] & 0x0f);
+		f->pressure = p[5] & 0x7f;
+
+		alps_decode_buttons_v3(f, p);
+	}
 
 	return 0;
 }
-- 
2.3.5

