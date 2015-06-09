From: Matt Whitlock <linux@mattwhitlock.name>
Subject: [PATCH 1/2] Input: input_mt_report_pointer_emulation(), rescale pressure + tool width
Date: Mon,  8 Jun 2015 21:07:54 -0400
Message-ID: <1433812075-16622-1-git-send-email-linux@mattwhitlock.name>
References: <556EF8AB.6090704@bitmath.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from resqmta-ch2-12v.sys.comcast.net ([69.252.207.44]:43473 "EHLO
	resqmta-ch2-12v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752410AbbFIBIo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 8 Jun 2015 21:08:44 -0400
In-Reply-To: <556EF8AB.6090704@bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Matt Whitlock <linux@mattwhitlock.name>

This patch teaches input_mt_report_pointer_emulation() to synthesize
ABS_TOOL_WIDTH from ABS_MT_WIDTH_MAJOR if the touchpad driver reports
ABS_MT_WIDTH_MAJOR. (As of this commit, the only in-tree drivers that do
are mouse/bcm5974.c and touchscreen/goodix.c.)

Additionally, this patch makes input_mt_report_pointer_emulation() rescale
values from each MT axis range to the respective emulated axis range to
allow touchpad drivers to redefine the emulated axis ranges after calling
input_mt_init_slots(). (The X and Y axes presently are not rescaled.)

Signed-off-by: Matt Whitlock <linux@mattwhitlock.name>
---
 drivers/input/input-mt.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c
index 54fce56..ccd55d9 100644
--- a/drivers/input/input-mt.c
+++ b/drivers/input/input-mt.c
@@ -23,6 +23,19 @@ static void copy_abs(struct input_dev *dev, unsigned int dst, unsigned int src)
 	}
 }
 
+static int rescale_abs_value(const struct input_dev *dev, unsigned int dst,
+			unsigned int src, int value)
+{
+	if (dev->absinfo && test_bit(dst, dev->absbit)
+			&& test_bit(src, dev->absbit)) {
+		struct input_absinfo *di = &dev->absinfo[dst], *si = &dev->absinfo[src];
+
+		value = di->minimum + (di->maximum - di->minimum) *
+				(value - si->minimum) / (si->maximum - si->minimum);
+	}
+	return value;
+}
+
 /**
  * input_mt_init_slots() - initialize MT input slots
  * @dev: input device supporting MT events and finger tracking
@@ -65,6 +78,7 @@ int input_mt_init_slots(struct input_dev *dev, unsigned int num_slots,
 		copy_abs(dev, ABS_X, ABS_MT_POSITION_X);
 		copy_abs(dev, ABS_Y, ABS_MT_POSITION_Y);
 		copy_abs(dev, ABS_PRESSURE, ABS_MT_PRESSURE);
+		copy_abs(dev, ABS_TOOL_WIDTH, ABS_MT_WIDTH_MAJOR);
 	}
 	if (flags & INPUT_MT_POINTER) {
 		__set_bit(BTN_TOOL_FINGER, dev->keybit);
@@ -230,11 +244,19 @@ void input_mt_report_pointer_emulation(struct input_dev *dev, bool use_count)
 
 		if (test_bit(ABS_MT_PRESSURE, dev->absbit)) {
 			int p = input_mt_get_value(oldest, ABS_MT_PRESSURE);
+			p = rescale_abs_value(dev, ABS_PRESSURE, ABS_MT_PRESSURE, p);
 			input_event(dev, EV_ABS, ABS_PRESSURE, p);
 		}
+		if (test_bit(ABS_MT_WIDTH_MAJOR, dev->absbit)) {
+			int w = input_mt_get_value(oldest, ABS_MT_WIDTH_MAJOR);
+			w = rescale_abs_value(dev, ABS_TOOL_WIDTH, ABS_MT_WIDTH_MAJOR, w);
+			input_event(dev, EV_ABS, ABS_TOOL_WIDTH, w);
+		}
 	} else {
 		if (test_bit(ABS_MT_PRESSURE, dev->absbit))
 			input_event(dev, EV_ABS, ABS_PRESSURE, 0);
+		if (test_bit(ABS_MT_WIDTH_MAJOR, dev->absbit))
+			input_event(dev, EV_ABS, ABS_TOOL_WIDTH, 0);
 	}
 }
 EXPORT_SYMBOL(input_mt_report_pointer_emulation);
-- 
2.4.2

