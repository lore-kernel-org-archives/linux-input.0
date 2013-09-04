From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] Input: don't push static constants on stack for %*ph
Date: Wed,  4 Sep 2013 13:41:49 +0300
Message-ID: <1378291309-13869-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:5091 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760087Ab3IDKmG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Sep 2013 06:42:06 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There is no need to pass constants via stack. The width may be explicitly
specified in the format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/input/mouse/hgpk.c               | 7 +++----
 drivers/input/touchscreen/atmel_mxt_ts.c | 4 ++--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/input/mouse/hgpk.c b/drivers/input/mouse/hgpk.c
index 62be888..27909a1 100644
--- a/drivers/input/mouse/hgpk.c
+++ b/drivers/input/mouse/hgpk.c
@@ -333,9 +333,8 @@ static bool hgpk_is_byte_valid(struct psmouse *psmouse, unsigned char *packet)
 	}
 
 	if (!valid)
-		psmouse_dbg(psmouse,
-			    "bad data, mode %d (%d) %*ph\n",
-			    priv->mode, pktcnt, 6, psmouse->packet);
+		psmouse_dbg(psmouse, "bad data, mode %d (%d) %6ph\n",
+			    priv->mode, pktcnt, psmouse->packet);
 
 	return valid;
 }
@@ -1027,7 +1026,7 @@ static enum hgpk_model_t hgpk_get_model(struct psmouse *psmouse)
 		return -EIO;
 	}
 
-	psmouse_dbg(psmouse, "ID: %*ph\n", 3, param);
+	psmouse_dbg(psmouse, "ID: %3ph\n", param);
 
 	/* HGPK signature: 0x67, 0x00, 0x<model> */
 	if (param[0] != 0x67 || param[1] != 0x00)
diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 59aa240..dd44ebf 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -331,8 +331,8 @@ static bool mxt_object_writable(unsigned int type)
 static void mxt_dump_message(struct device *dev,
 			     struct mxt_message *message)
 {
-	dev_dbg(dev, "reportid: %u\tmessage: %*ph\n",
-		message->reportid, 7, message->message);
+	dev_dbg(dev, "reportid: %u\tmessage: %7ph\n",
+		message->reportid, message->message);
 }
 
 static int mxt_check_bootloader(struct i2c_client *client,
-- 
1.8.4.rc3

