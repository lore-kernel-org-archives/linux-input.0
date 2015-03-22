From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH v3 4/5] input: synaptics - make image sensors and cr48 sensors report widths
Date: Sun, 22 Mar 2015 15:43:55 +0100
Message-ID: <1427035436-2168-5-git-send-email-gabriele.mzt@gmail.com>
References: <1427035436-2168-1-git-send-email-gabriele.mzt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427035436-2168-1-git-send-email-gabriele.mzt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, rydberg@bitmath.org, silverhammermba@gmail.com, peter.hutterer@who-t.net, hdegoede@redhat.com, benjamin.tissoires@gmail.com, grafi@grafi.jp, oneukum@suse.de, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: linux-input@vger.kernel.org

The driver was not reporting widths for image sensors and cr48 sensors
despite it was calculating them.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=77161
Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 drivers/input/mouse/synaptics.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index ff47084..4e86ba6 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -927,6 +927,7 @@ static void synaptics_report_mt_data(struct psmouse *psmouse,
 		input_report_abs(dev, ABS_MT_POSITION_X, pos[i].x);
 		input_report_abs(dev, ABS_MT_POSITION_Y, pos[i].y);
 		input_report_abs(dev, ABS_MT_PRESSURE, hw[i]->z);
+		input_report_abs(dev, ABS_MT_TOUCH_MAJOR, hw[i]->w);
 	}
 
 	input_mt_drop_unused(dev);
@@ -1192,8 +1193,9 @@ static void set_input_params(struct psmouse *psmouse,
 	if (SYN_CAP_IMAGE_SENSOR(priv->ext_cap_0c)) {
 		set_abs_position_params(dev, priv, ABS_MT_POSITION_X,
 					ABS_MT_POSITION_Y);
-		/* Image sensors can report per-contact pressure */
+		/* Image sensors can report per-contact pressure and width */
 		input_set_abs_params(dev, ABS_MT_PRESSURE, 0, 255, 0, 0);
+		input_set_abs_params(dev, ABS_MT_TOUCH_MAJOR, 4, 15, 0, 0);
 		input_mt_init_slots(dev, 2, INPUT_MT_POINTER | INPUT_MT_TRACK);
 		/* Image sensors can signal 4 and 5 finger clicks */
 		__set_bit(BTN_TOOL_QUADTAP, dev->keybit);
@@ -1202,6 +1204,7 @@ static void set_input_params(struct psmouse *psmouse,
 		set_abs_position_params(dev, priv, ABS_MT_POSITION_X,
 					ABS_MT_POSITION_Y);
 		input_set_abs_params(dev, ABS_MT_PRESSURE, 0, 255, 0, 0);
+		input_set_abs_params(dev, ABS_MT_TOUCH_MAJOR, 4, 15, 0, 0);
 		/*
 		 * Profile sensor in CR-48 tracks contacts reasonably well,
 		 * other non-image sensors with AGM use semi-mt.
-- 
2.1.4
