From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH] Input: sa1111ps2 - use sa1111_get_irq() to obtain IRQ
 resources
Date: Tue, 26 Sep 2017 11:12:02 +0100
Message-ID: <E1dwmqQ-0002nf-9M@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:49392 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754260AbdIZKMM (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 26 Sep 2017 06:12:12 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Use the provided sa1111_get_irq() to fetch the IRQ resources for the
SA1111 PS/2 driver.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/input/serio/sa1111ps2.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/input/serio/sa1111ps2.c b/drivers/input/serio/sa1111ps2.c
index b3e688911fd9..3b54050b9fc7 100644
--- a/drivers/input/serio/sa1111ps2.c
+++ b/drivers/input/serio/sa1111ps2.c
@@ -47,6 +47,8 @@ struct ps2if {
 	struct serio		*io;
 	struct sa1111_dev	*dev;
 	void __iomem		*base;
+	int			rx_irq;
+	int			tx_irq;
 	unsigned int		open;
 	spinlock_t		lock;
 	unsigned int		head;
@@ -126,7 +128,7 @@ static int ps2_write(struct serio *io, unsigned char val)
 		sa1111_writel(val, ps2if->base + PS2DATA);
 	} else {
 		if (ps2if->head == ps2if->tail)
-			enable_irq(ps2if->dev->irq[1]);
+			enable_irq(ps2if->tx_irq);
 		head = (ps2if->head + 1) & (sizeof(ps2if->buf) - 1);
 		if (head != ps2if->tail) {
 			ps2if->buf[ps2if->head] = val;
@@ -147,28 +149,28 @@ static int ps2_open(struct serio *io)
 	if (ret)
 		return ret;
 
-	ret = request_irq(ps2if->dev->irq[0], ps2_rxint, 0,
+	ret = request_irq(ps2if->rx_irq, ps2_rxint, 0,
 			  SA1111_DRIVER_NAME(ps2if->dev), ps2if);
 	if (ret) {
 		printk(KERN_ERR "sa1111ps2: could not allocate IRQ%d: %d\n",
-			ps2if->dev->irq[0], ret);
+			ps2if->rx_irq, ret);
 		sa1111_disable_device(ps2if->dev);
 		return ret;
 	}
 
-	ret = request_irq(ps2if->dev->irq[1], ps2_txint, 0,
+	ret = request_irq(ps2if->tx_irq, ps2_txint, 0,
 			  SA1111_DRIVER_NAME(ps2if->dev), ps2if);
 	if (ret) {
 		printk(KERN_ERR "sa1111ps2: could not allocate IRQ%d: %d\n",
-			ps2if->dev->irq[1], ret);
-		free_irq(ps2if->dev->irq[0], ps2if);
+			ps2if->tx_irq, ret);
+		free_irq(ps2if->rx_irq, ps2if);
 		sa1111_disable_device(ps2if->dev);
 		return ret;
 	}
 
 	ps2if->open = 1;
 
-	enable_irq_wake(ps2if->dev->irq[0]);
+	enable_irq_wake(ps2if->rx_irq);
 
 	sa1111_writel(PS2CR_ENA, ps2if->base + PS2CR);
 	return 0;
@@ -180,12 +182,12 @@ static void ps2_close(struct serio *io)
 
 	sa1111_writel(0, ps2if->base + PS2CR);
 
-	disable_irq_wake(ps2if->dev->irq[0]);
+	disable_irq_wake(ps2if->rx_irq);
 
 	ps2if->open = 0;
 
-	free_irq(ps2if->dev->irq[1], ps2if);
-	free_irq(ps2if->dev->irq[0], ps2if);
+	free_irq(ps2if->tx_irq, ps2if);
+	free_irq(ps2if->rx_irq, ps2if);
 
 	sa1111_disable_device(ps2if->dev);
 }
@@ -264,7 +266,6 @@ static int ps2_probe(struct sa1111_dev *dev)
 		goto free;
 	}
 
-
 	serio->id.type		= SERIO_8042;
 	serio->write		= ps2_write;
 	serio->open		= ps2_open;
@@ -279,6 +280,18 @@ static int ps2_probe(struct sa1111_dev *dev)
 
 	spin_lock_init(&ps2if->lock);
 
+	ps2if->rx_irq = sa1111_get_irq(dev, 0);
+	if (ps2if->rx_irq <= 0) {
+		ret = ps2if->rx_irq ? : -ENXIO;
+		goto free;
+	}
+
+	ps2if->tx_irq = sa1111_get_irq(dev, 1);
+	if (ps2if->tx_irq <= 0) {
+		ret = ps2if->tx_irq ? : -ENXIO;
+		goto free;
+	}
+
 	/*
 	 * Request the physical region for this PS2 port.
 	 */
-- 
2.7.4

