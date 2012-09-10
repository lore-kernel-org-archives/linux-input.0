From: Seth Forshee <seth.forshee@canonical.com>
Subject: [PATCH] Input: synaptics - Adjust threshold for treating position values as negative
Date: Mon, 10 Sep 2012 07:47:07 -0500
Message-ID: <1347281227-20973-1-git-send-email-seth.forshee@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:58423 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757761Ab2IJMrM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Sep 2012 08:47:12 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>

Commit c039450 (Input: synaptics - handle out of bounds values from the
hardware) caused any hardware reported values over 7167 to be treated as
a wrapped-around negative value. It turns out that some firmware uses
the value 8176 to indicate a finger near the edge of the touchpad whose
actual position cannot be determined. This value now gets treated as
negative, which can cause pointer jumps and broken edge scrolling on
these machines.

I only know of one touchpad which reports negative values, and this
hardware never reports any value lower than -8 (i.e. 8184). Moving the
threshold for treating a value as negative up to 8176 should work fine
then for any hardware we currently know about, and since we're dealing
with unspecified behavior it's probably the best we can do. The special
8176 value is also likely to result in sudden jumps in position, so
let's also clamp this to the maximum speicified value for the axis.

BugLink: http://bugs.launchpad.net/bugs/1046512
Cc: stable@vger.kernel.org
Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 drivers/input/mouse/synaptics.c |   31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 14eaece..0786919 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -53,14 +53,19 @@
 #define ABS_POS_BITS 13
 
 /*
- * Any position values from the hardware above the following limits are
- * treated as "wrapped around negative" values that have been truncated to
- * the 13-bit reporting range of the hardware. These are just reasonable
- * guesses and can be adjusted if hardware is found that operates outside
- * of these parameters.
+ * These values should represent the absolute maximum value that will
+ * be reported for a positive position value. Some Synaptics firmware
+ * uses this value to indicate a finger near the edge of the touchpad
+ * whose precise position cannot be determined.
+ *
+ * At least one touchpad is known to report positions in excess of this
+ * value which are actually negative values truncated to the 13-bit
+ * reporting range. These values have never been observed to be lower
+ * than 8184 (i.e. -8), so we treat all values greater than 8176 as
+ * negative and any other value as positive.
  */
-#define X_MAX_POSITIVE (((1 << ABS_POS_BITS) + XMAX) / 2)
-#define Y_MAX_POSITIVE (((1 << ABS_POS_BITS) + YMAX) / 2)
+#define X_MAX_POSITIVE 8176
+#define Y_MAX_POSITIVE 8176
 
 /*****************************************************************************
  *	Stuff we need even when we do not want native Synaptics support
@@ -604,11 +609,21 @@ static int synaptics_parse_hw_state(const unsigned char buf[],
 		hw->right = (buf[0] & 0x02) ? 1 : 0;
 	}
 
-	/* Convert wrap-around values to negative */
+	/*
+	 * Convert wrap-around values to negative. (X|Y)_MAX_POSITIVE
+	 * is used by some firmware to indicate a finger at the edge of
+	 * the touchpad whose precise position cannot be determined, so
+	 * convert these values to the maximum axis value.
+	 */
 	if (hw->x > X_MAX_POSITIVE)
 		hw->x -= 1 << ABS_POS_BITS;
+	else if (hw->x == X_MAX_POSITIVE)
+		hw->x = XMAX;
+
 	if (hw->y > Y_MAX_POSITIVE)
 		hw->y -= 1 << ABS_POS_BITS;
+	else if (hw->y == Y_MAX_POSITIVE)
+		hw->y = YMAX;
 
 	return 0;
 }
-- 
1.7.9.5

