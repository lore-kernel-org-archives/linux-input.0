From: Seth Forshee <seth.forshee@canonical.com>
Subject: [PATCH v3] Input: synaptics - handle out of bounds values from the hardware
Date: Fri, 29 Jun 2012 13:22:18 -0500
Message-ID: <1340994138-8969-1-git-send-email-seth.forshee@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:39567 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755383Ab2F2SWX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 29 Jun 2012 14:22:23 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>

The touchpad on the Acer Aspire One D250 will report out of range values
in the extreme lower portion of the touchpad. These appear as abrupt
changes in the values reported by the hardware from very low values to
very high values, which can cause unexpected vertical jumps in the
position of the mouse pointer.

What seems to be happening is that the value is wrapping to a two's
compliment negative value of higher resolution than the 13-bit value
reported by the hardware, with the high-order bits being truncated. The
safest way to deal with this is to clamp any out of bounds values to the
minimum or maximum value for the axis.

Distinguishing between positive and negative is problematic, since we
lack definitive sign information in the value reported by the hardware.
The approach taken here is to split the difference between the maximum
legitimate value for the axis and the maximum possible value that the
hardware can report, treating values greater than this number as
negative and all other values as positive. This can be tweaked later if
hardware is found that operates outside of these parameters.

BugLink: http://bugs.launchpad.net/bugs/1001251
Cc: stable@vger.kernel.org
Cc: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 drivers/input/mouse/synaptics.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index c6d9869..698f1b8 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -40,6 +40,10 @@
  * Note that newer firmware allows querying device for maximum useable
  * coordinates.
  */
+#define XMIN 0
+#define XMAX 6143
+#define YMIN 0
+#define YMAX 6143
 #define XMIN_NOMINAL 1472
 #define XMAX_NOMINAL 5472
 #define YMIN_NOMINAL 1408
@@ -555,6 +559,29 @@ static int synaptics_parse_hw_state(const unsigned char buf[],
 		hw->right = (buf[0] & 0x02) ? 1 : 0;
 	}
 
+	/*
+	 * Some hardware is known to wrap negative on the y axis,
+	 * providing the low-order bits of a higher resolution negative
+	 * number as a 13-bit unsigned value. No hardware is known to
+	 * give out-of-bounds values on the high end, but since we're
+	 * dealing with unspecified behavior we take a conservative
+	 * approach to handling the out of bounds values.
+	 *
+	 * Clamp out of bounds values to the minimum or maximum value
+	 * for the axis. Use the midpoint between the maximum axis
+	 * value and maximum possible reported value as the dividing
+	 * line between positive and negative values.
+	 */
+	if (hw->x > ((1 << 13) + XMAX) / 2)
+		hw->x = XMIN;
+	else if (hw->x > XMAX)
+		hw->x = XMAX;
+
+	if (hw->y > ((1 << 13) + YMAX) / 2)
+		hw->y = YMIN;
+	else if (hw->y > YMAX)
+		hw->y = YMAX;
+
 	return 0;
 }
 
-- 
1.7.9.5

