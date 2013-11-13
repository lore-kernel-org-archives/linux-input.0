From: Christopher Heiny <cheiny@synaptics.com>
Subject: [RESEND] [PATCH] input synaptics-rmi4: Fix camel case in comments.
Date: Wed, 13 Nov 2013 15:02:01 -0800
Message-ID: <1384383721-385-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:2913 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560Ab3KMXCG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Nov 2013 18:02:06 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>

[Sorry if this is a duplicate - vger.kernel.org has bounced previous attempts.]

Trivial change to make variable names in a comment match those in the code.

Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

---

 include/linux/rmi.h | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index 01f2f13..dc94dc1 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -9,8 +9,19 @@
 
 #ifndef _RMI_H
 #define _RMI_H
-
+#include <linux/kernel.h>
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/input.h>
+#include <linux/list.h>
+#include <linux/lockdep.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/stat.h>
 #include <linux/types.h>
+#include <linux/wait.h>
+#include <linux/debugfs.h>
 
 enum rmi_attn_polarity {
 	RMI_ATTN_ACTIVE_LOW = 0,
@@ -22,16 +33,16 @@ enum rmi_attn_polarity {
  * @swap_axes: set to TRUE if desired to swap x- and y-axis
  * @flip_x: set to TRUE if desired to flip direction on x-axis
  * @flip_y: set to TRUE if desired to flip direction on y-axis
- * @clip_X_low - reported X coordinates below this setting will be clipped to
+ * @clip_x_low - reported X coordinates below this setting will be clipped to
  *               the specified value
- * @clip_X_high - reported X coordinates above this setting will be clipped to
+ * @clip_x_high - reported X coordinates above this setting will be clipped to
  *               the specified value
- * @clip_Y_low - reported Y coordinates below this setting will be clipped to
+ * @clip_y_low - reported Y coordinates below this setting will be clipped to
  *               the specified value
- * @clip_Y_high - reported Y coordinates above this setting will be clipped to
+ * @clip_y_high - reported Y coordinates above this setting will be clipped to
  *               the specified value
- * @offset_X - this value will be added to all reported X coordinates
- * @offset_Y - this value will be added to all reported Y coordinates
+ * @offset_x - this value will be added to all reported X coordinates
+ * @offset_y - this value will be added to all reported Y coordinates
  * @rel_report_enabled - if set to true, the relative reporting will be
  *               automatically enabled for this sensor.
  */
