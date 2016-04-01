From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH v4 3/4] input: synaptics - change default width value of cr48 sensors
Date: Fri,  1 Apr 2016 15:06:51 +0200
Message-ID: <1459516012-8060-4-git-send-email-gabriele.mzt@gmail.com>
References: <1459516012-8060-1-git-send-email-gabriele.mzt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459516012-8060-1-git-send-email-gabriele.mzt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, benjamin.tissoires@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rydberg@bitmath.org, silverhammermba@gmail.com, peter.hutterer@who-t.net, hdegoede@redhat.com, grafi@grafi.jp, oneukum@suse.de, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: linux-input@vger.kernel.org

The minimum value these sensors can report is 4, so this should be the
value used when W is not reporting the width.

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 drivers/input/mouse/synaptics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index ba321e7..27a091b 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1032,7 +1032,7 @@ static void synaptics_process_packet(struct psmouse *psmouse)
 
 	if (hw.z > 0 && hw.x > 1) {
 		num_fingers = 1;
-		finger_width = 5;
+		finger_width = 4;
 		if (SYN_CAP_EXTENDED(priv->capabilities)) {
 			switch (hw.w) {
 			case 0 ... 1:
-- 
2.8.0.rc3
