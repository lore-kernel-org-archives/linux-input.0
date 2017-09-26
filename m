From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH] Input: sa1111ps2 - remove special sa1111 mmio accessors
Date: Tue, 26 Sep 2017 15:16:15 +0100
Message-ID: <E1dwqel-000418-51@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:52288 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965155AbdIZOQY (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 26 Sep 2017 10:16:24 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Remove the special SA1111 MMIO accessors from the SA1111 PS/2 driver
as their definition will be removed shortly.  The SA1111 accessors are
barrierless, so use the _relaxed variants.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/input/serio/sa1111ps2.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/input/serio/sa1111ps2.c b/drivers/input/serio/sa1111ps2.c
index 3b54050b9fc7..f1c036260d25 100644
--- a/drivers/input/serio/sa1111ps2.c
+++ b/drivers/input/serio/sa1111ps2.c
@@ -66,22 +66,22 @@ static irqreturn_t ps2_rxint(int irq, void *dev_id)
 	struct ps2if *ps2if = dev_id;
 	unsigned int scancode, flag, status;
 
-	status = sa1111_readl(ps2if->base + PS2STAT);
+	status = readl_relaxed(ps2if->base + PS2STAT);
 	while (status & PS2STAT_RXF) {
 		if (status & PS2STAT_STP)
-			sa1111_writel(PS2STAT_STP, ps2if->base + PS2STAT);
+			writel_relaxed(PS2STAT_STP, ps2if->base + PS2STAT);
 
 		flag = (status & PS2STAT_STP ? SERIO_FRAME : 0) |
 		       (status & PS2STAT_RXP ? 0 : SERIO_PARITY);
 
-		scancode = sa1111_readl(ps2if->base + PS2DATA) & 0xff;
+		scancode = readl_relaxed(ps2if->base + PS2DATA) & 0xff;
 
 		if (hweight8(scancode) & 1)
 			flag ^= SERIO_PARITY;
 
 		serio_interrupt(ps2if->io, scancode, flag);
 
-		status = sa1111_readl(ps2if->base + PS2STAT);
+		status = readl_relaxed(ps2if->base + PS2STAT);
         }
 
         return IRQ_HANDLED;
@@ -96,12 +96,12 @@ static irqreturn_t ps2_txint(int irq, void *dev_id)
 	unsigned int status;
 
 	spin_lock(&ps2if->lock);
-	status = sa1111_readl(ps2if->base + PS2STAT);
+	status = readl_relaxed(ps2if->base + PS2STAT);
 	if (ps2if->head == ps2if->tail) {
 		disable_irq_nosync(irq);
 		/* done */
 	} else if (status & PS2STAT_TXE) {
-		sa1111_writel(ps2if->buf[ps2if->tail], ps2if->base + PS2DATA);
+		writel_relaxed(ps2if->buf[ps2if->tail], ps2if->base + PS2DATA);
 		ps2if->tail = (ps2if->tail + 1) & (sizeof(ps2if->buf) - 1);
 	}
 	spin_unlock(&ps2if->lock);
@@ -124,8 +124,8 @@ static int ps2_write(struct serio *io, unsigned char val)
 	/*
 	 * If the TX register is empty, we can go straight out.
 	 */
-	if (sa1111_readl(ps2if->base + PS2STAT) & PS2STAT_TXE) {
-		sa1111_writel(val, ps2if->base + PS2DATA);
+	if (readl_relaxed(ps2if->base + PS2STAT) & PS2STAT_TXE) {
+		writel_relaxed(val, ps2if->base + PS2DATA);
 	} else {
 		if (ps2if->head == ps2if->tail)
 			enable_irq(ps2if->tx_irq);
@@ -172,7 +172,7 @@ static int ps2_open(struct serio *io)
 
 	enable_irq_wake(ps2if->rx_irq);
 
-	sa1111_writel(PS2CR_ENA, ps2if->base + PS2CR);
+	writel_relaxed(PS2CR_ENA, ps2if->base + PS2CR);
 	return 0;
 }
 
@@ -180,7 +180,7 @@ static void ps2_close(struct serio *io)
 {
 	struct ps2if *ps2if = io->port_data;
 
-	sa1111_writel(0, ps2if->base + PS2CR);
+	writel_relaxed(0, ps2if->base + PS2CR);
 
 	disable_irq_wake(ps2if->rx_irq);
 
@@ -200,7 +200,7 @@ static void ps2_clear_input(struct ps2if *ps2if)
 	int maxread = 100;
 
 	while (maxread--) {
-		if ((sa1111_readl(ps2if->base + PS2DATA) & 0xff) == 0xff)
+		if ((readl_relaxed(ps2if->base + PS2DATA) & 0xff) == 0xff)
 			break;
 	}
 }
@@ -210,11 +210,11 @@ static unsigned int ps2_test_one(struct ps2if *ps2if,
 {
 	unsigned int val;
 
-	sa1111_writel(PS2CR_ENA | mask, ps2if->base + PS2CR);
+	writel_relaxed(PS2CR_ENA | mask, ps2if->base + PS2CR);
 
 	udelay(2);
 
-	val = sa1111_readl(ps2if->base + PS2STAT);
+	val = readl_relaxed(ps2if->base + PS2STAT);
 	return val & (PS2STAT_KBC | PS2STAT_KBD);
 }
 
@@ -245,7 +245,7 @@ static int ps2_test(struct ps2if *ps2if)
 		ret = -ENODEV;
 	}
 
-	sa1111_writel(0, ps2if->base + PS2CR);
+	writel_relaxed(0, ps2if->base + PS2CR);
 
 	return ret;
 }
@@ -310,8 +310,8 @@ static int ps2_probe(struct sa1111_dev *dev)
 	sa1111_enable_device(ps2if->dev);
 
 	/* Incoming clock is 8MHz */
-	sa1111_writel(0, ps2if->base + PS2CLKDIV);
-	sa1111_writel(127, ps2if->base + PS2PRECNT);
+	writel_relaxed(0, ps2if->base + PS2CLKDIV);
+	writel_relaxed(127, ps2if->base + PS2PRECNT);
 
 	/*
 	 * Flush any pending input.
-- 
2.7.4

