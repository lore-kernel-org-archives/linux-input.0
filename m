From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH v3 1/5] input: synaptics - fix width values calculation on image sensors
Date: Sun, 22 Mar 2015 15:43:52 +0100
Message-ID: <1427035436-2168-2-git-send-email-gabriele.mzt@gmail.com>
References: <1427035436-2168-1-git-send-email-gabriele.mzt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427035436-2168-1-git-send-email-gabriele.mzt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, rydberg@bitmath.org, silverhammermba@gmail.com, peter.hutterer@who-t.net, hdegoede@redhat.com, benjamin.tissoires@gmail.com, grafi@grafi.jp, oneukum@suse.de, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: linux-input@vger.kernel.org

When multiple fingers are on the touchpad, W holds the finger
count rather than the width. Retrieve the correct value that is
encoded in X, Y and Z of AGM and SGM packets.

The minimum width reported is 8 rather than 4 in this case, while the
maximum remains 15.

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 drivers/input/mouse/synaptics.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index d73a942..133e488 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -661,10 +661,12 @@ static void synaptics_parse_agm(const unsigned char buf[],
 	switch (agm_packet_type) {
 	case 1:
 		/* Gesture packet: (x, y, z) half resolution */
-		agm->w = hw->w;
-		agm->x = (((buf[4] & 0x0f) << 8) | buf[1]) << 1;
-		agm->y = (((buf[4] & 0xf0) << 4) | buf[2]) << 1;
-		agm->z = ((buf[3] & 0x30) | (buf[5] & 0x0f)) << 1;
+		agm->w = ((buf[1] & 0x01) |
+			  ((buf[2] & 0x01) << 1) |
+			  ((buf[5] & 0x01) << 2)) + 8;
+		agm->x = (((buf[4] & 0x0f) << 8) | (buf[1] & 0xfe)) << 1;
+		agm->y = (((buf[4] & 0xf0) << 4) | (buf[2] & 0xfe)) << 1;
+		agm->z = ((buf[3] & 0x30) | (buf[5] & 0x0e)) << 2;
 		break;
 
 	case 2:
@@ -960,6 +962,17 @@ static void synaptics_image_sensor_process(struct psmouse *psmouse,
 	else
 		num_fingers = 4;
 
+	/* When multiple fingers are on the TouchPad, the width is encoded in
+	 * X, Y and Z */
+	if (sgm->w == 0 || sgm->w == 1) {
+		sgm->w = (((sgm->x & BIT(1)) >> 1) |
+			  (sgm->y & BIT(1)) |
+			  ((sgm->z & BIT(0)) << 2)) + 8;
+		sgm->x &= ~BIT(1);
+		sgm->y &= ~BIT(1);
+		sgm->z &= ~BIT(0);
+	}
+
 	/* Send resulting input events to user space */
 	synaptics_report_mt_data(psmouse, sgm, num_fingers);
 }
-- 
2.1.4
