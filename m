From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/4] alps: v7: Document the v7 touchpad packet protocol
Date: Wed,  3 Dec 2014 14:27:45 +0100
Message-ID: <1417613268-13674-1-git-send-email-hdegoede@redhat.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, stable@vger.kernel.org.#.3.17
List-Id: linux-input@vger.kernel.org

Add a table documenting where all the bits are in the v7 touchpad packets.

Cc: stable@vger.kernel.org # 3.17
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/alps.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index d125a01..aceaade 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -881,6 +881,34 @@ static void alps_get_finger_coordinate_v7(struct input_mt_pos *mt,
 					  unsigned char *pkt,
 					  unsigned char pkt_id)
 {
+	/*
+	 *       packet-fmt    b7   b6    b5   b4   b3   b2   b1   b0
+	 * Byte0 TWO & MULTI    L    1     R    M    1 Y0-2 Y0-1 Y0-0
+	 * Byte0 NEW            L    1  X1-5    1    1 Y0-2 Y0-1 Y0-0
+	 * Byte1            Y0-10 Y0-9  Y0-8 Y0-7 Y0-6 Y0-5 Y0-4 Y0-3
+	 * Byte2            X0-11    1 X0-10 X0-9 X0-8 X0-7 X0-6 X0-5
+	 * Byte3            X1-11    1  X0-4 X0-3    1 X0-2 X0-1 X0-0
+	 * Byte4 TWO        X1-10  TWO  X1-9 X1-8 X1-7 X1-6 X1-5 X1-4
+	 * Byte4 MULTI      X1-10  TWO  X1-9 X1-8 X1-7 X1-6 Y1-5    1
+	 * Byte4 NEW        X1-10  TWO  X1-9 X1-8 X1-7 X1-6    0    0
+	 * Byte5 TWO & NEW  Y1-10    0  Y1-9 Y1-8 Y1-7 Y1-6 Y1-5 Y1-4
+	 * Byte5 MULTI      Y1-10    0  Y1-9 Y1-8 Y1-7 Y1-6  F-1  F-0
+	 * L:         Left button
+	 * R / M:     Non-clickpads: Right / Middle button
+	 *            Clickpads: When > 2 fingers are down, and some fingers
+	 *            are in the button area, then the 2 coordinates reported
+	 *            are for fingers outside the button area and these report
+	 *            extra fingers being present in the right / left button
+	 *            area. Note these fingers are not added to the F field!
+	 *            so if a TWO packet is received and R = 1 then there are
+	 *            3 fingers down, etc.
+	 * TWO:       1: Two touches present, byte 0/4/5 are in TWO fmt
+	 *            0: If byte 4 bit 0 is 1, then byte 0/4/5 are in MULTI fmt
+	 *               otherwise byte 0 bit 4 must be set and byte 0/4/5 are
+	 *               in NEW fmt
+	 * F:         Number of fingers - 3, 0 means 3 fingers, 1 means 4 ...
+	 */
+
 	mt[0].x = ((pkt[2] & 0x80) << 4);
 	mt[0].x |= ((pkt[2] & 0x3F) << 5);
 	mt[0].x |= ((pkt[3] & 0x30) >> 1);
-- 
2.1.0
