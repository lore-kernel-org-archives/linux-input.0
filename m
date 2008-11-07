From: Henrik Rydberg <rydberg@euromail.se>
Subject: [PATCH] input: Add a detailed multi-touch finger data report protocol
Date: Fri, 07 Nov 2008 12:15:29 +0100
Message-ID: <49142351.9080805@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:34338 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751809AbYKGLPl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 7 Nov 2008 06:15:41 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

In order to utilize the full power of the new multi-touch devices, a
way to report detailed finger data to user space is needed. This patch
adds a multi-touch (MT) protocol which allows drivers to report details
for an arbitrary number of fingers.

BTN_MT_REPORT_PACKET

The driver presses this button to indicate the start of a packet of
finger data. The button is released after the whole packet has been
reported.

BTN_MT_REPORT_FINGER

The driver presses this button to indicate the start of a new
finger. The button is released when the finger has been reported.

In order to stay compatible with existing applications, the data
reported in a finger packet must not be recognized as single-touch
events. Therefore, a specific set of ABS_MT events is used instead.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 include/linux/input.h |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/include/linux/input.h b/include/linux/input.h
index b86fb55..c82dd42 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -590,6 +590,9 @@ struct input_absinfo {
 #define KEY_NUMERIC_STAR	0x20a
 #define KEY_NUMERIC_POUND	0x20b

+#define BTN_MT_REPORT_PACKET	0x210	/* report multitouch packet data */
+#define BTN_MT_REPORT_FINGER	0x211	/* report multitouch finger data */
+
 /* We avoid low common keys in module aliases so they don't get huge. */
 #define KEY_MIN_INTERESTING	KEY_MUTE
 #define KEY_MAX			0x2ff
@@ -642,6 +645,15 @@ struct input_absinfo {
 #define ABS_TOOL_WIDTH		0x1c
 #define ABS_VOLUME		0x20
 #define ABS_MISC		0x28
+#define ABS_MT_TOUCH		0x30	/* Diameter of touching circle */
+#define ABS_MT_TOUCH_MAJOR	0x30	/* Major axis of touching ellipse */
+#define ABS_MT_TOUCH_MINOR	0x31	/* Minor axis of touching ellipse */
+#define ABS_MT_WIDTH		0x32	/* Diameter of approaching circle */
+#define ABS_MT_WIDTH_MAJOR	0x32	/* Major axis of approaching ellipse */
+#define ABS_MT_WIDTH_MINOR	0x33	/* Minor axis of approaching ellipse */
+#define ABS_MT_ORIENTATION	0x34	/* Ellipse orientation */
+#define ABS_MT_POSITION_X	0x35	/* Center X ellipse position */
+#define ABS_MT_POSITION_Y	0x36	/* Center Y ellipse position */
 #define ABS_MAX			0x3f
 #define ABS_CNT			(ABS_MAX+1)

-- 
1.5.6.3

