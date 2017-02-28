From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 03/10] Input: eeti_ts - use get_unaligned_be16() to retrieve data
Date: Tue, 28 Feb 2017 14:46:25 -0800
Message-ID: <20170228224632.3401-3-dmitry.torokhov@gmail.com>
References: <20170228224632.3401-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34721 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751547AbdB1Wzq (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 28 Feb 2017 17:55:46 -0500
In-Reply-To: <20170228224632.3401-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Instead of manually converting big endian data on wire into host
endianness, let's use helpers to do that for us. It might save us
a few cycles if host endianness matches what's on wire.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/eeti_ts.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/eeti_ts.c b/drivers/input/touchscreen/eeti_ts.c
index 26b52496748a..0e4b19236d68 100644
--- a/drivers/input/touchscreen/eeti_ts.c
+++ b/drivers/input/touchscreen/eeti_ts.c
@@ -34,6 +34,7 @@
 #include <linux/gpio.h>
 #include <linux/input/eeti_ts.h>
 #include <linux/slab.h>
+#include <asm/unaligned.h>
 
 static bool flip_x;
 module_param(flip_x, bool, 0644);
@@ -89,8 +90,9 @@ static void eeti_ts_read(struct work_struct *work)
 
 	pressed = buf[0] & REPORT_BIT_PRESSED;
 	res = REPORT_RES_BITS(buf[0] & (REPORT_BIT_AD0 | REPORT_BIT_AD1));
-	x = buf[2] | (buf[1] << 8);
-	y = buf[4] | (buf[3] << 8);
+
+	x = get_unaligned_be16(&buf[1]);
+	y = get_unaligned_be16(&buf[3]);
 
 	/* fix the range to 11 bits */
 	x >>= res - EETI_TS_BITDEPTH;
-- 
2.11.0.483.g087da7b7c-goog

