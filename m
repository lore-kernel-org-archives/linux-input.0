From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/4] alps: v7: Ignore new packets
Date: Wed,  3 Dec 2014 14:27:46 +0100
Message-ID: <1417613268-13674-2-git-send-email-hdegoede@redhat.com>
References: <1417613268-13674-1-git-send-email-hdegoede@redhat.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1417613268-13674-1-git-send-email-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, stable@vger.kernel.org.#.3.17
List-Id: linux-input@vger.kernel.org

NEW packets are send to indicate a discontinuity in the finger coordinate
reporting. Specifically a finger may have moved from slot 0 to 1 or vice versa.
INPUT_MT_TRACK takes care of this for us.

NEW packets have 3 problems:
1) They do not contain middle / right button info (on non clickpads)
   this can be worked around by preserving the old button state
2) They do not contain an accurate fingercount, and they are
   typically send when the number of fingers changes. We cannot use
   the old finger count as that may mismatch with the amount of
   touch coordinates we've available in the NEW packet
3) Their x data for the second touch is inaccurate leading to
   a possible jump of the x coordinate by 16 units when the first
   non NEW packet comes in

Since problems 2 & 3 cannot be worked around, just ignore them.

BugLink: https://bugs.freedesktop.org/show_bug.cgi?id=86338
Cc: stable@vger.kernel.org # 3.17
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/alps.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index aceaade..6b11629 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -966,18 +966,36 @@ static int alps_decode_packet_v7(struct alps_fields *f,
 		return 0;
 	if (pkt_id == V7_PACKET_ID_UNKNOWN)
 		return -1;
+	/*
+	 * NEW packets are send to indicate a discontinuity in the finger
+	 * coordinate reporting. Specifically a finger may have moved from
+	 * slot 0 to 1 or vice versa. INPUT_MT_TRACK takes care of this for
+	 * us.
+	 *
+	 * NEW packets have 3 problems:
+	 * 1) They do not contain middle / right button info (on non clickpads)
+	 *    this can be worked around by preserving the old button state
+	 * 2) They do not contain an accurate fingercount, and they are
+	 *    typically send when the number of fingers changes. We cannot use
+	 *    the old finger count as that may mismatch with the amount of
+	 *    touch coordinates we've available in the NEW packet
+	 * 3) Their x data for the second touch is inaccurate leading to
+	 *    a possible jump of the x coordinate by 16 units when the first
+	 *    non NEW packet comes in
+	 * Since problems 2 & 3 cannot be worked around, just ignore them.
+	 */
+	if (pkt_id == V7_PACKET_ID_NEW)
+		return 1;
 
 	alps_get_finger_coordinate_v7(f->mt, p, pkt_id);
 
-	if (pkt_id == V7_PACKET_ID_TWO || pkt_id == V7_PACKET_ID_MULTI) {
-		f->left = (p[0] & 0x80) >> 7;
-		f->right = (p[0] & 0x20) >> 5;
-		f->middle = (p[0] & 0x10) >> 4;
-	}
+	f->left = (p[0] & 0x80) >> 7;
+	f->right = (p[0] & 0x20) >> 5;
+	f->middle = (p[0] & 0x10) >> 4;
 
 	if (pkt_id == V7_PACKET_ID_TWO)
 		f->fingers = alps_get_mt_count(f->mt);
-	else if (pkt_id == V7_PACKET_ID_MULTI)
+	else /* pkt_id == V7_PACKET_ID_MULTI */
 		f->fingers = 3 + (p[5] & 0x03);
 
 	return 0;
-- 
2.1.0
