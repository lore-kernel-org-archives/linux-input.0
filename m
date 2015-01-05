From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH v2 3/4] input: synaptics - change default width value of cr48 sensors
Date: Mon,  5 Jan 2015 23:28:34 +0100
Message-ID: <1420496915-31560-4-git-send-email-gabriele.mzt@gmail.com>
References: <1420496915-31560-1-git-send-email-gabriele.mzt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1420496915-31560-1-git-send-email-gabriele.mzt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, linux-kernel@vger.kernel.org, silverhammermba@gmail.com, peter.hutterer@who-t.net, hdegoede@redhat.com, benjamin.tissoires@gmail.com, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: linux-input@vger.kernel.org

The minimum value these sensors can report is 4, so this should be the
value used when W is not reporting the width.

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 drivers/input/mouse/synaptics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 918a727..5008e8c 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -910,7 +910,7 @@ static void synaptics_process_packet(struct psmouse *psmouse)
 
 	if (hw.z > 0 && hw.x > 1) {
 		num_fingers = 1;
-		finger_width = 5;
+		finger_width = 4;
 		if (SYN_CAP_EXTENDED(priv->capabilities)) {
 			switch (hw.w) {
 			case 0 ... 1:
-- 
2.1.4
