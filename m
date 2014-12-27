From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH 2/2] input: synaptics - fix width calculation on image sensors
Date: Sat, 27 Dec 2014 12:31:29 +0100
Message-ID: <1419679889-6582-3-git-send-email-gabriele.mzt@gmail.com>
References: <1419679889-6582-1-git-send-email-gabriele.mzt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1419679889-6582-1-git-send-email-gabriele.mzt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, rydberg@euromail.se
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, silverhammermba@gmail.com, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: linux-input@vger.kernel.org

When two or more fingers are on the touchpad, the 'w' slot holds the
finger count rather than the width. Retrieve the correct value encoded
in the lower bits of 'x', 'y' and 'z'.

The minimum width reported is 8 rather than 4 in this case, while the
maximum remains 15.

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 drivers/input/mouse/synaptics.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index ea0563e..5ff4c5b 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -593,7 +593,9 @@ static void synaptics_parse_agm(const unsigned char buf[],
 	switch (agm_packet_type) {
 	case 1:
 		/* Gesture packet: (x, y, z) half resolution */
-		agm->w = hw->w;
+		agm->w = ((buf[1] & 0x01) |
+			  ((buf[2] & 0x01) << 1) |
+			  ((buf[5] & 0x01) << 2)) + 8;
 		agm->x = (((buf[4] & 0x0f) << 8) | buf[1]) << 1;
 		agm->y = (((buf[4] & 0xf0) << 4) | buf[2]) << 1;
 		agm->z = ((buf[3] & 0x30) | (buf[5] & 0x0f)) << 1;
-- 
2.1.4
