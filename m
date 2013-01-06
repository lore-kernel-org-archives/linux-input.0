From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/4] Input: walkera0701 - switch to using pr_xxx() for
 messages
Date: Sun, 06 Jan 2013 00:59:36 -0800
Message-ID: <20130106085936.18147.70520.stgit@dtor-d630.eng.vmware.com>
References: <20130106085931.18147.78960.stgit@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34736 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740Ab3AFI7k (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 6 Jan 2013 03:59:40 -0500
Received: by mail-pa0-f53.google.com with SMTP id hz1so10071421pad.26
        for <linux-input@vger.kernel.org>; Sun, 06 Jan 2013 00:59:39 -0800 (PST)
In-Reply-To: <20130106085931.18147.78960.stgit@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Popovec <popovec@fei.tuke.sk>
Cc: linux-input@vger.kernel.org

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/walkera0701.c |   23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/input/joystick/walkera0701.c b/drivers/input/joystick/walkera0701.c
index 38386ce..da657e6 100644
--- a/drivers/input/joystick/walkera0701.c
+++ b/drivers/input/joystick/walkera0701.c
@@ -12,7 +12,7 @@
  * the Free Software Foundation.
 */
 
-/* #define WK0701_DEBUG */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #define RESERVE 20000
 #define SYNC_PULSE 1306000
@@ -67,6 +67,7 @@ static inline void walkera0701_parse_frame(struct walkera_dev *w)
 {
 	int i;
 	int val1, val2, val3, val4, val5, val6, val7, val8;
+	int magic, magic_bit;
 	int crc1, crc2;
 
 	for (crc1 = crc2 = i = 0; i < 10; i++) {
@@ -102,17 +103,12 @@ static inline void walkera0701_parse_frame(struct walkera_dev *w)
 	val8 = (w->buf[18] & 1) << 8 | (w->buf[19] << 4) | w->buf[20];
 	val8 *= (w->buf[18] & 2) - 1;	/*sign */
 
-#ifdef WK0701_DEBUG
-	{
-		int magic, magic_bit;
-		magic = (w->buf[21] << 4) | w->buf[22];
-		magic_bit = (w->buf[24] & 8) >> 3;
-		printk(KERN_DEBUG
-		       "walkera0701: %4d %4d %4d %4d  %4d %4d %4d %4d (magic %2x %d)\n",
-		       val1, val2, val3, val4, val5, val6, val7, val8, magic,
-		       magic_bit);
-	}
-#endif
+	magic = (w->buf[21] << 4) | w->buf[22];
+	magic_bit = (w->buf[24] & 8) >> 3;
+	pr_debug("%4d %4d %4d %4d  %4d %4d %4d %4d (magic %2x %d)\n",
+		 val1, val2, val3, val4, val5, val6, val7, val8,
+		 magic, magic_bit);
+
 	input_report_abs(w->input_dev, ABS_X, val2);
 	input_report_abs(w->input_dev, ABS_Y, val1);
 	input_report_abs(w->input_dev, ABS_Z, val6);
@@ -208,7 +204,8 @@ static int walkera0701_connect(struct walkera_dev *w, int parport)
 		return -ENODEV;
 
 	if (w->parport->irq == -1) {
-		printk(KERN_ERR "walkera0701: parport without interrupt\n");
+		pr_err("parport %d does not have interrupt assigned\n",
+			parport);
 		goto init_err;
 	}
 

