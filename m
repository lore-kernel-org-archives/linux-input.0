From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 01/03] input: break out hw access functions in sh_keysc
Date: Mon, 08 Feb 2010 15:32:25 +0900
Message-ID: <20100208063225.2003.78459.sendpatchset@rxone.opensource.se>
References: <20100208063216.2003.84260.sendpatchset@rxone.opensource.se>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20100208063216.2003.84260.sendpatchset@rxone.opensource.se>
Sender: linux-sh-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org, dmitry.torokhov@gmail.com, linux-sh@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update the sh_keysc driver to break out the register
access functions sh_keysc_read(), sh_keysc_write()
together with sh_keysc_level_mode(). This makes the
code a bit easier to follow.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/input/keyboard/sh_keysc.c |   69 +++++++++++++++++++++++--------------
 1 file changed, 43 insertions(+), 26 deletions(-)

--- 0004/drivers/input/keyboard/sh_keysc.c
+++ work/drivers/input/keyboard/sh_keysc.c	2010-02-05 13:02:22.000000000 +0900
@@ -22,14 +22,6 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#define KYCR1_OFFS   0x00
-#define KYCR2_OFFS   0x04
-#define KYINDR_OFFS  0x08
-#define KYOUTDR_OFFS 0x0c
-
-#define KYCR2_IRQ_LEVEL    0x10
-#define KYCR2_IRQ_DISABLED 0x00
-
 static const struct {
 	unsigned char kymd, keyout, keyin;
 } sh_keysc_mode[] = {
@@ -48,6 +40,37 @@ struct sh_keysc_priv {
 	struct sh_keysc_info pdata;
 };
 
+#define KYCR1 0
+#define KYCR2 1
+#define KYINDR 2
+#define KYOUTDR 3
+
+#define KYCR2_IRQ_LEVEL    0x10
+#define KYCR2_IRQ_DISABLED 0x00
+
+static unsigned long sh_keysc_read(struct sh_keysc_priv *p, int reg_nr)
+{
+	return ioread16(p->iomem_base + (reg_nr << 2));
+}
+
+static void sh_keysc_write(struct sh_keysc_priv *p, int reg_nr,
+			   unsigned long value)
+{
+	iowrite16(value, p->iomem_base + (reg_nr << 2));
+}
+
+static void sh_keysc_level_mode(struct sh_keysc_priv *p,
+				unsigned long keys_set)
+{
+	struct sh_keysc_info *pdata = &p->pdata;
+
+	sh_keysc_write(p, KYOUTDR, 0);
+	sh_keysc_write(p, KYCR2, KYCR2_IRQ_LEVEL | (keys_set << 8));
+
+	if (pdata->kycr2_delay)
+		udelay(pdata->kycr2_delay);
+}
+
 static irqreturn_t sh_keysc_isr(int irq, void *dev_id)
 {
 	struct platform_device *pdev = dev_id;
@@ -66,24 +89,19 @@ static irqreturn_t sh_keysc_isr(int irq,
 		keys = 0;
 		keyin_set = 0;
 
-		iowrite16(KYCR2_IRQ_DISABLED, priv->iomem_base + KYCR2_OFFS);
+		sh_keysc_write(priv, KYCR2, KYCR2_IRQ_DISABLED);
 
 		for (i = 0; i < sh_keysc_mode[pdata->mode].keyout; i++) {
-			iowrite16(0xfff ^ (3 << (i * 2)),
-				  priv->iomem_base + KYOUTDR_OFFS);
+			sh_keysc_write(priv, KYOUTDR, 0xfff ^ (3 << (i * 2)));
 			udelay(pdata->delay);
-			tmp = ioread16(priv->iomem_base + KYINDR_OFFS);
+			tmp = sh_keysc_read(priv, KYINDR);
+
 			keys |= tmp << (sh_keysc_mode[pdata->mode].keyin * i);
 			tmp ^= (1 << sh_keysc_mode[pdata->mode].keyin) - 1;
 			keyin_set |= tmp;
 		}
 
-		iowrite16(0, priv->iomem_base + KYOUTDR_OFFS);
-		iowrite16(KYCR2_IRQ_LEVEL | (keyin_set << 8),
-			  priv->iomem_base + KYCR2_OFFS);
-
-		if (pdata->kycr2_delay)
-			udelay(pdata->kycr2_delay);
+		sh_keysc_level_mode(priv, keyin_set);
 
 		keys ^= ~0;
 		keys &= (1 << (sh_keysc_mode[pdata->mode].keyin *
@@ -93,7 +111,7 @@ static irqreturn_t sh_keysc_isr(int irq,
 
 		dev_dbg(&pdev->dev, "keys 0x%08lx\n", keys);
 
-	} while (ioread16(priv->iomem_base + KYCR2_OFFS) & 0x01);
+	} while (sh_keysc_read(priv, KYCR2) & 0x01);
 
 	dev_dbg(&pdev->dev, "last_keys 0x%08lx keys0 0x%08lx keys1 0x%08lx\n",
 		priv->last_keys, keys0, keys1);
@@ -220,10 +238,9 @@ static int __devinit sh_keysc_probe(stru
 
 	clk_enable(priv->clk);
 
-	iowrite16((sh_keysc_mode[pdata->mode].kymd << 8) |
-		  pdata->scan_timing, priv->iomem_base + KYCR1_OFFS);
-	iowrite16(0, priv->iomem_base + KYOUTDR_OFFS);
-	iowrite16(KYCR2_IRQ_LEVEL, priv->iomem_base + KYCR2_OFFS);
+	sh_keysc_write(priv, KYCR1, (sh_keysc_mode[pdata->mode].kymd << 8) |
+		       pdata->scan_timing);
+	sh_keysc_level_mode(priv, 0);
 
 	device_init_wakeup(&pdev->dev, 1);
 
@@ -248,7 +265,7 @@ static int __devexit sh_keysc_remove(str
 {
 	struct sh_keysc_priv *priv = platform_get_drvdata(pdev);
 
-	iowrite16(KYCR2_IRQ_DISABLED, priv->iomem_base + KYCR2_OFFS);
+	sh_keysc_write(priv, KYCR2, KYCR2_IRQ_DISABLED);
 
 	input_unregister_device(priv->input);
 	free_irq(platform_get_irq(pdev, 0), pdev);
@@ -270,7 +287,7 @@ static int sh_keysc_suspend(struct devic
 	int irq = platform_get_irq(pdev, 0);
 	unsigned short value;
 
-	value = ioread16(priv->iomem_base + KYCR1_OFFS);
+	value = sh_keysc_read(priv, KYCR1);
 
 	if (device_may_wakeup(dev)) {
 		value |= 0x80;
@@ -279,7 +296,7 @@ static int sh_keysc_suspend(struct devic
 		value &= ~0x80;
 	}
 
-	iowrite16(value, priv->iomem_base + KYCR1_OFFS);
+	sh_keysc_write(priv, KYCR1, value);
 
 	return 0;
 }
