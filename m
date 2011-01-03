From: Steve Grahovac <steve.grahovac@gmail.com>
Subject: [PATCH 2/2] Corrected errors and warnings reported by "checkpatch.pl" utility.
Date: Sun,  2 Jan 2011 22:13:11 -0600
Message-ID: <1294027991-2537-3-git-send-email-user@linux-mint>
References: <1294027991-2537-1-git-send-email-user@linux-mint>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55704 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653Ab1ACENZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 2 Jan 2011 23:13:25 -0500
Received: by mail-vw0-f46.google.com with SMTP id 16so5706272vws.19
        for <linux-input@vger.kernel.org>; Sun, 02 Jan 2011 20:13:25 -0800 (PST)
In-Reply-To: <1294027991-2537-1-git-send-email-user@linux-mint>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Steve Grahovac <steve.grahovac@microchip.com>

From: Steve Grahovac <steve.grahovac@microchip.com>


Signed-off-by: Steve Grahovac <steve.grahovac@microchip.com>
---
 drivers/input/touchscreen/Kconfig      |   11 ++++
 drivers/input/touchscreen/Makefile     |    1 +
 drivers/input/touchscreen/mchpar1xxx.c |   88 ++++++++++++++------------------
 include/linux/serio.h                  |    1 +
 4 files changed, 52 insertions(+), 49 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 400c99d..3b041ef 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -648,4 +648,15 @@ config TOUCHSCREEN_STMPE
 	  To compile this driver as a module, choose M here: the
 	  module will be called stmpe-ts.
 
+config TOUCHSCREEN_MCHPAR1XXX
+	tristate "Microchip AR1XXX touchscreen"
+	select SERIO
+	help
+	  Say Y here if you have a Microchip AR1XXX Controller and
+	  want to enable support for the built-in touchscreen.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called mchipar1xxx.
 endif
+
+
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 22e2d59..0bde571 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -53,3 +53,4 @@ obj-$(CONFIG_TOUCHSCREEN_WM97XX_MAINSTONE)	+= mainstone-wm97xx.o
 obj-$(CONFIG_TOUCHSCREEN_WM97XX_ZYLONITE)	+= zylonite-wm97xx.o
 obj-$(CONFIG_TOUCHSCREEN_W90X900)	+= w90p910_ts.o
 obj-$(CONFIG_TOUCHSCREEN_TPS6507X)	+= tps6507x-ts.o
+obj-$(CONFIG_TOUCHSCREEN_MCHPAR1XXX)	+= mchpar1xxx.o
diff --git a/drivers/input/touchscreen/mchpar1xxx.c b/drivers/input/touchscreen/mchpar1xxx.c
index c7a5848..fa2bb5b 100755
--- a/drivers/input/touchscreen/mchpar1xxx.c
+++ b/drivers/input/touchscreen/mchpar1xxx.c
@@ -2,7 +2,7 @@
  * Microchip Serial Touchscreen Driver
  *
  * Copyright (c) 2010 Microchip Technology, Inc.
- * 
+ *
  * http://www.microchip.com/mtouch
  */
 
@@ -13,7 +13,8 @@
  */
 
 /*
- * This driver can handle serial Microchip controllers using the AR1XXX 5-byte protocol 
+ * This driver can handle serial Microchip controllers using the AR1XXX 5-byte
+ * protocol
  */
 
 #include <linux/errno.h>
@@ -57,57 +58,46 @@ static void mchpar1xxx_process_data(struct mchip *mchip, unsigned char data)
 	mchip->data[mchip->index] = data;
 
 	/****************************************************
-	
 	Data format, 5 bytes: SYNC, DATA1, DATA2, DATA3, DATA4
-	
 	SYNC [7:0]: 1,0,0,0,0,TOUCHSTATUS[0:0]
 	DATA1[7:0]: 0,X-LOW[6:0]
 	DATA2[7:0]: 0,X-HIGH[4:0]
 	DATA3[7:0]: 0,Y-LOW[6:0]
 	DATA4[7:0]: 0,Y-HIGH[4:0]
-	
 	TOUCHSTATUS: 0 = Touch up, 1 = Touch down
-	
-	****************************************************/		
-	
+	****************************************************/
 	switch (mchip->index++) {
-		case 0:
-			if (!(0x80 & data))
-			{
-/*			    printk(KERN_ERR "mchip: Sync bit not set\n"); */
-			    mchip->index = 0;			  
-			}
-			break;
-
-		case (MCHIP_MAX_LENGTH - 1):
-			/* verify byte is valid for current index */
-			if (0x80 & data)
-			{
-				/* byte not valid */			  
-				mchip->data[0]=data;
-				mchip->index = 1;
-				break;
-			}			  
-
+	case 0:
+		/* Verify sync bit on first byte of packet */
+		if (!(0x80 & data))
 			mchip->index = 0;
-
-/*			printk(KERN_ERR "mchip: %d %d %d\n",((mchip->data[2] & 0x1f) << 7) | (mchip->data[1] & 0x7f), 				((mchip->data[4] & 0x1f) << 7) | (mchip->data[3] & 0x7f), 0 != (mchip->data[0] & 7)); */			
-			
-			input_report_abs(dev, ABS_X, ((mchip->data[2] & 0x1f) << 7) | (mchip->data[1] & 0x7f));
-			input_report_abs(dev, ABS_Y, ((mchip->data[4] & 0x1f) << 7) | (mchip->data[3] & 0x7f));
-			input_report_key(dev, BTN_TOUCH, 0 != (mchip->data[0] & 1) );
-			input_sync(dev);			
-			break;
-		default:
-			/* verify byte is valid for current index */
-			if (0x80 & data)
-			{
-				/* byte not valid */
-				mchip->data[0]=data;
-				mchip->index = 1;
-			}			  
+		break;
+
+	case (MCHIP_MAX_LENGTH - 1):
+		/* verify byte is valid for current index */
+		if (0x80 & data) {
+			/* byte not valid */
+			mchip->data[0] = data;
+			mchip->index = 1;
 			break;
-			
+		}
+
+		mchip->index = 0;
+		input_report_abs(dev, ABS_X, \
+		((mchip->data[2] & 0x1f) << 7) | (mchip->data[1] & 0x7f));
+		input_report_abs(dev, ABS_Y, \
+		((mchip->data[4] & 0x1f) << 7) | (mchip->data[3] & 0x7f));
+		input_report_key(dev, BTN_TOUCH, 0 != (mchip->data[0] & 1));
+		input_sync(dev);
+		break;
+	default:
+		/* verify byte is valid for current index */
+		if (0x80 & data) {
+			/* byte not valid */
+			mchip->data[0] = data;
+			mchip->index = 1;
+		}
+		break;
 	}
 }
 
@@ -115,11 +105,11 @@ static void mchpar1xxx_process_data(struct mchip *mchip, unsigned char data)
 static irqreturn_t mchpar1xxx_interrupt(struct serio *serio,
 		unsigned char data, unsigned int flags)
 {
-    struct mchip *mchip = serio_get_drvdata(serio);
+	struct mchip *mchip = serio_get_drvdata(serio);
 
-    mchpar1xxx_process_data(mchip, data);
+	mchpar1xxx_process_data(mchip, data);
 
-    return IRQ_HANDLED;
+	return IRQ_HANDLED;
 }
 
 static int mchpar1xxx_setup(struct mchip *mchip)
@@ -196,9 +186,9 @@ static int mchpar1xxx_connect(struct serio *serio, struct serio_driver *drv)
 
 	return 0;
 
- fail3: serio_close(serio);
- fail2:	serio_set_drvdata(serio, NULL);
- fail1:	input_free_device(input_dev);
+fail3: serio_close(serio);
+fail2: serio_set_drvdata(serio, NULL);
+fail1: input_free_device(input_dev);
 	kfree(mchip);
 	return err;
 }
diff --git a/include/linux/serio.h b/include/linux/serio.h
index b555256..13fd94b 100644
--- a/include/linux/serio.h
+++ b/include/linux/serio.h
@@ -197,5 +197,6 @@ static inline void serio_continue_rx(struct serio *serio)
 #define SERIO_W8001	0x39
 #define SERIO_DYNAPRO	0x3a
 #define SERIO_HAMPSHIRE	0x3b
+#define SERIO_MCHPAR1XXX	0x3c
 
 #endif
-- 
1.7.1

