From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/4] alps: v7: Sometimes a single touch is reported in mt[1] rather then mt[0]
Date: Wed,  3 Dec 2014 14:27:47 +0100
Message-ID: <1417613268-13674-3-git-send-email-hdegoede@redhat.com>
References: <1417613268-13674-1-git-send-email-hdegoede@redhat.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1417613268-13674-1-git-send-email-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, stable@vger.kernel.org.#.3.17
List-Id: linux-input@vger.kernel.org

The v7 proto differentiates between a primary touch (with high precision)
and a secondary touch (with lower precision). Normally when 2 fingers are
down and one is lifted the still present touch becomes the primary touch,
but some traces have shown that this does not happen always.

This commit deals with this by making alps_get_mt_count() not stop at the
first empty mt slot, and if a touch is present in mt[1] and not mt[0] moving
the data to mt[0] (for input_mt_assign_slots).

BugLink: https://bugs.freedesktop.org/show_bug.cgi?id=86338
Cc: stable@vger.kernel.org # 3.17
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/alps.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 6b11629..77c7afe 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -947,12 +947,14 @@ static void alps_get_finger_coordinate_v7(struct input_mt_pos *mt,
 
 static int alps_get_mt_count(struct input_mt_pos *mt)
 {
-	int i;
+	int i, fingers = 0;
 
-	for (i = 0; i < MAX_TOUCHES && mt[i].x != 0 && mt[i].y != 0; i++)
-		/* empty */;
+	for (i = 0; i < MAX_TOUCHES; i++) {
+		if (mt[i].x != 0 || mt[i].y != 0)
+			fingers++;
+	}
 
-	return i;
+	return fingers;
 }
 
 static int alps_decode_packet_v7(struct alps_fields *f,
@@ -998,6 +1000,14 @@ static int alps_decode_packet_v7(struct alps_fields *f,
 	else /* pkt_id == V7_PACKET_ID_MULTI */
 		f->fingers = 3 + (p[5] & 0x03);
 
+	/* Sometimes a single touch is reported in mt[1] rather then mt[0] */
+	if (f->fingers == 1 && f->mt[0].x == 0 && f->mt[0].y == 0) {
+		f->mt[0].x = f->mt[1].x;
+		f->mt[0].y = f->mt[1].y;
+		f->mt[1].x = 0;
+		f->mt[1].y = 0;
+	}
+
 	return 0;
 }
 
-- 
2.1.0
