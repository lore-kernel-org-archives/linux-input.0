From: chris@cnpbagwell.com
Subject: [PATCH 1/2] input: synaptics - only report width on hardware that supports it
Date: Sun, 18 Jul 2010 14:06:06 -0500
Message-ID: <1279479967-4499-1-git-send-email-chris@cnpbagwell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59382 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757154Ab0GRTGo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 18 Jul 2010 15:06:44 -0400
Received: by gyh4 with SMTP id 4so1888086gyh.19
        for <linux-input@vger.kernel.org>; Sun, 18 Jul 2010 12:06:43 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Chris Bagwell <chris@cnpbagwell.com>

From: Chris Bagwell <chris@cnpbagwell.com>

Synaptics devices report fixed value of 5 for finger/palm widths
on devices that do not support capability and driver further
hardcodes to 5.  Stop reporting this fixed value when its
not supported since its not useful.

This will aid applications so they can better auto-enable
support for multi-touch emulation and palm detection logic
using finger width only for devices that support width detection.

I can find no applications that currently require existence
on ABS_TOOL_WIDTH. Since only synaptics and bcm input devices
currently support this tool, it seems they must handle it gracefully.

Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
---
 drivers/input/mouse/synaptics.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 40cea33..1b49d7f 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -496,7 +496,9 @@ static void synaptics_process_packet(struct psmouse *psmouse)
 	}
 	input_report_abs(dev, ABS_PRESSURE, hw.z);
 
-	input_report_abs(dev, ABS_TOOL_WIDTH, finger_width);
+	if (SYN_CAP_PALMDETECT(priv->capabilities))
+		input_report_abs(dev, ABS_TOOL_WIDTH, finger_width);
+
 	input_report_key(dev, BTN_TOOL_FINGER, num_fingers == 1);
 	input_report_key(dev, BTN_LEFT, hw.left);
 	input_report_key(dev, BTN_RIGHT, hw.right);
@@ -596,7 +598,9 @@ static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
 	input_set_abs_params(dev, ABS_Y,
 			     YMIN_NOMINAL, priv->y_max ?: YMAX_NOMINAL, 0, 0);
 	input_set_abs_params(dev, ABS_PRESSURE, 0, 255, 0, 0);
-	__set_bit(ABS_TOOL_WIDTH, dev->absbit);
+
+	if (SYN_CAP_PALMDETECT(priv->capabilities))
+		__set_bit(ABS_TOOL_WIDTH, dev->absbit);
 
 	__set_bit(EV_KEY, dev->evbit);
 	__set_bit(BTN_TOUCH, dev->keybit);
-- 
1.7.1.1

