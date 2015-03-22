From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH v3 5/5] input: MT - add ABS_TOOL_WIDTH to the legacy pointer emulation
Date: Sun, 22 Mar 2015 15:43:56 +0100
Message-ID: <1427035436-2168-6-git-send-email-gabriele.mzt@gmail.com>
References: <1427035436-2168-1-git-send-email-gabriele.mzt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427035436-2168-1-git-send-email-gabriele.mzt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, rydberg@bitmath.org, silverhammermba@gmail.com, peter.hutterer@who-t.net, hdegoede@redhat.com, benjamin.tissoires@gmail.com, grafi@grafi.jp, oneukum@suse.de, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: linux-input@vger.kernel.org

Userspace might still rely on ABS_TOOL_WIDTH to determine the width of
contacts, so add it to the legacy pointer emulation.

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 drivers/input/input-mt.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c
index cb150a1..bb4ca6d 100644
--- a/drivers/input/input-mt.c
+++ b/drivers/input/input-mt.c
@@ -65,6 +65,7 @@ int input_mt_init_slots(struct input_dev *dev, unsigned int num_slots,
 		copy_abs(dev, ABS_X, ABS_MT_POSITION_X);
 		copy_abs(dev, ABS_Y, ABS_MT_POSITION_Y);
 		copy_abs(dev, ABS_PRESSURE, ABS_MT_PRESSURE);
+		copy_abs(dev, ABS_TOOL_WIDTH, ABS_MT_TOUCH_MAJOR);
 	}
 	if (flags & INPUT_MT_POINTER) {
 		__set_bit(BTN_TOOL_FINGER, dev->keybit);
@@ -182,8 +183,9 @@ EXPORT_SYMBOL(input_mt_report_finger_count);
  * @dev: input device with allocated MT slots
  * @use_count: report number of active contacts as finger count
  *
- * Performs legacy pointer emulation via BTN_TOUCH, ABS_X, ABS_Y and
- * ABS_PRESSURE. Touchpad finger count is emulated if use_count is true.
+ * Performs legacy pointer emulation via BTN_TOUCH, ABS_X, ABS_Y,
+ * ABS_PRESSURE and ABS_TOOL_WIDTH. Touchpad finger count is emulated
+ * if use_count is true.
  *
  * The input core ensures only the KEY and ABS axes already setup for
  * this device will produce output.
@@ -229,9 +231,15 @@ void input_mt_report_pointer_emulation(struct input_dev *dev, bool use_count)
 			int p = input_mt_get_value(oldest, ABS_MT_PRESSURE);
 			input_event(dev, EV_ABS, ABS_PRESSURE, p);
 		}
+		if (test_bit(ABS_MT_TOUCH_MAJOR, dev->absbit)) {
+			int w = input_mt_get_value(oldest, ABS_MT_TOUCH_MAJOR);
+			input_event(dev, EV_ABS, ABS_TOOL_WIDTH, w);
+		}
 	} else {
 		if (test_bit(ABS_MT_PRESSURE, dev->absbit))
 			input_event(dev, EV_ABS, ABS_PRESSURE, 0);
+		if (test_bit(ABS_MT_TOUCH_MAJOR, dev->absbit))
+			input_event(dev, EV_ABS, ABS_TOOL_WIDTH, 0);
 	}
 }
 EXPORT_SYMBOL(input_mt_report_pointer_emulation);
-- 
2.1.4
