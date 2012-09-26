From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] atmel_mxt: simplify mxt_dump_message
Date: Wed, 26 Sep 2012 14:05:55 +0300
Message-ID: <1348657555-8226-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:35284 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753879Ab2IZLGE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Sep 2012 07:06:04 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This patch applies %*ph to print small buffer and marks function as inline.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index e92615d..211bfb4 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -317,13 +317,11 @@ static bool mxt_object_writable(unsigned int type)
 	}
 }
 
-static void mxt_dump_message(struct device *dev,
-			     struct mxt_message *message)
+static inline void mxt_dump_message(struct device *dev,
+				    struct mxt_message *message)
 {
-	dev_dbg(dev, "reportid: %u\tmessage: %02x %02x %02x %02x %02x %02x %02x\n",
-		message->reportid, message->message[0], message->message[1],
-		message->message[2], message->message[3], message->message[4],
-		message->message[5], message->message[6]);
+	dev_dbg(dev, "reportid: %u\tmessage: %*ph\n",
+		message->reportid, 7, message->message);
 }
 
 static int mxt_check_bootloader(struct i2c_client *client,
-- 
1.7.10.4

