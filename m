From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH v4 2/4] input: synaptics - fix width values calculation on image sensors
Date: Fri,  1 Apr 2016 15:06:50 +0200
Message-ID: <1459516012-8060-3-git-send-email-gabriele.mzt@gmail.com>
References: <1459516012-8060-1-git-send-email-gabriele.mzt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459516012-8060-1-git-send-email-gabriele.mzt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, benjamin.tissoires@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rydberg@bitmath.org, silverhammermba@gmail.com, peter.hutterer@who-t.net, hdegoede@redhat.com, grafi@grafi.jp, oneukum@suse.de, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: linux-input@vger.kernel.org

When multiple fingers are on the touchpad, W reports the finger
count rather than the width. Retrieve the correct value that is
encoded in X, Y and Z of AGM and SGM packets.

The minimum width reported is 8 rather than 4 in this case, while the
maximum remains 15.

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 drivers/input/mouse/synaptics.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 01fccca..ba321e7 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -674,10 +674,12 @@ static void synaptics_parse_agm(const unsigned char buf[],
 	switch (agm_packet_type) {
 	case 1:
 		/* Gesture packet: (x, y, z) half resolution */
-		agm->w = hw->w;
-		agm->x = (((buf[4] & 0x0f) << 8) | buf[1]) << 1;
-		agm->y = (((buf[4] & 0xf0) << 4) | buf[2]) << 1;
-		agm->z = ((buf[3] & 0x30) | (buf[5] & 0x0f)) << 2;
+		agm->w = ((buf[1] & 0x01) |
+			  ((buf[2] & 0x01) << 1) |
+			  ((buf[5] & 0x01) << 2)) + 8;
+		agm->x = (((buf[4] & 0x0f) << 8) | (buf[1] & 0xfe)) << 1;
+		agm->y = (((buf[4] & 0xf0) << 4) | (buf[2] & 0xfe)) << 1;
+		agm->z = ((buf[3] & 0x30) | (buf[5] & 0x0e)) << 2;
 		break;
 
 	case 2:
@@ -974,6 +976,17 @@ static void synaptics_image_sensor_process(struct psmouse *psmouse,
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
2.8.0.rc3
