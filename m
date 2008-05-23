From: Thomas Kunze <thommycheck@gmx.de>
Subject: [PATCH] locomokbd.c: remove locomo_readl/locomo_writel
Date: Fri, 23 May 2008 23:10:11 +0200
Message-ID: <483732B3.2000608@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:45477 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756277AbYEWVKT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 23 May 2008 17:10:19 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: deller@gmx.de

This patch replaces the locomo_readl/writel calls with standard

ioread/write16 calls. As an additional small bugfix it initializes KSC to zero

at load time. This fixes a bug where some keys don't work until a key that 

works was pressed.

Signed-off-by: Thomas Kunze <thommycheck@gmx.de>

--

diff --git a/drivers/input/keyboard/locomokbd.c b/drivers/input/keyboard/locomokbd.c
index 9caed30..7f9852a 100644
--- a/drivers/input/keyboard/locomokbd.c
+++ b/drivers/input/keyboard/locomokbd.c
@@ -31,6 +31,7 @@
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
+#include <linux/io.h>
 
 #include <asm/hardware/locomo.h>
 #include <asm/irq.h>
@@ -86,17 +87,17 @@ struct locomokbd {
 /* helper functions for reading the keyboard matrix */
 static inline void locomokbd_charge_all(unsigned long membase)
 {
-	locomo_writel(0x00FF, membase + LOCOMO_KSC);
+	iowrite16(0x00FF, membase + LOCOMO_KSC);
 }
 
 static inline void locomokbd_activate_all(unsigned long membase)
 {
 	unsigned long r;
 
-	locomo_writel(0, membase + LOCOMO_KSC);
-	r = locomo_readl(membase + LOCOMO_KIC);
+	iowrite16(0, membase + LOCOMO_KSC);
+	r = ioread16(membase + LOCOMO_KIC);
 	r &= 0xFEFF;
-	locomo_writel(r, membase + LOCOMO_KIC);
+	iowrite16(r, membase + LOCOMO_KIC);
 }
 
 static inline void locomokbd_activate_col(unsigned long membase, int col)
@@ -106,7 +107,7 @@ static inline void locomokbd_activate_col(unsigned long membase, int col)
 
 	nset = 0xFF & ~(1 << col);
 	nbset = (nset << 8) + nset;
-	locomo_writel(nbset, membase + LOCOMO_KSC);
+	iowrite16(nbset, membase + LOCOMO_KSC);
 }
 
 static inline void locomokbd_reset_col(unsigned long membase, int col)
@@ -114,7 +115,7 @@ static inline void locomokbd_reset_col(unsigned long membase, int col)
 	unsigned short nbset;
 
 	nbset = ((0xFF & ~(1 << col)) << 8) + 0xFF;
-	locomo_writel(nbset, membase + LOCOMO_KSC);
+	iowrite16(nbset, membase + LOCOMO_KSC);
 }
 
 /*
@@ -141,7 +142,7 @@ static void locomokbd_scankeyboard(struct locomokbd *locomokbd)
 		locomokbd_activate_col(membase, col);
 		udelay(KB_DELAY);
 
-		rowd = ~locomo_readl(membase + LOCOMO_KIB);
+		rowd = ~ioread16(membase + LOCOMO_KIB);
 		for (row = 0; row < KB_ROWS; row++) {
 			unsigned int scancode, pressed, key;
 
@@ -266,6 +267,8 @@ static int __devinit locomokbd_probe(struct locomo_dev *dev)
 		set_bit(locomokbd->keycode[i], input_dev->keybit);
 	clear_bit(0, input_dev->keybit);
 
+	iowrite16(0, locomokbd->base + LOCOMO_KSC);
+
 	/* attempt to get the interrupt */
 	err = request_irq(dev->irq[0], locomokbd_interrupt, 0, "locomokbd", locomokbd);
 	if (err) {

