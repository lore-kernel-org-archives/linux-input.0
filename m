From: <Frank.Li@freescale.com>
Subject: [PATCH v3 1/6] rtc: arm: imx: snvs: change use syscon to access register
Date: Fri, 22 May 2015 00:16:47 +0800
Message-ID: <1432225012-20598-2-git-send-email-Frank.Li@freescale.com>
References: <1432225012-20598-1-git-send-email-Frank.Li@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-by2on0140.outbound.protection.outlook.com ([207.46.100.140]:46880
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756343AbbEUQRn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 21 May 2015 12:17:43 -0400
In-Reply-To: <1432225012-20598-1-git-send-email-Frank.Li@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: lznuaa@gmail.com, shawn.guo@linaro.org, dmitry.torokhov@gmail.com, robh+dt@kernel.org, alexandre.belloni@free-electrons.com, linux@arm.linux.org.uk
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, rtc-linux@googlegroups.com, devicetree@vger.kernel.org, Frank Li <Frank.Li@freescale.com>

From: Frank Li <Frank.Li@freescale.com>

snvs included rtc, on/off key, power-off module
change to syscon to access register

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 drivers/rtc/rtc-snvs.c | 136 +++++++++++++++++++++++++------------------------
 1 file changed, 70 insertions(+), 66 deletions(-)

diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
index 0479e80..a22c8b4 100644
--- a/drivers/rtc/rtc-snvs.c
+++ b/drivers/rtc/rtc-snvs.c
@@ -18,6 +18,8 @@
 #include <linux/platform_device.h>
 #include <linux/rtc.h>
 #include <linux/clk.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
 /* These register offsets are relative to LP (Low Power) range */
 #define SNVS_LPCR		0x04
@@ -37,31 +39,35 @@
 
 struct snvs_rtc_data {
 	struct rtc_device *rtc;
-	void __iomem *ioaddr;
+	struct regmap *regmap;
+	int offset;
 	int irq;
-	spinlock_t lock;
 	struct clk *clk;
 };
 
-static u32 rtc_read_lp_counter(void __iomem *ioaddr)
+static u32 rtc_read_lp_counter(struct snvs_rtc_data *snvs)
 {
 	u64 read1, read2;
-
+	u32 val;
 	do {
-		read1 = readl(ioaddr + SNVS_LPSRTCMR);
+		regmap_read(snvs->regmap, snvs->offset + SNVS_LPSRTCMR, &val);
+		read1 = val;
 		read1 <<= 32;
-		read1 |= readl(ioaddr + SNVS_LPSRTCLR);
+		regmap_read(snvs->regmap, snvs->offset + SNVS_LPSRTCLR, &val);
+		read1 |= val;
 
-		read2 = readl(ioaddr + SNVS_LPSRTCMR);
+		regmap_read(snvs->regmap, snvs->offset + SNVS_LPSRTCMR, &val);
+		read2 = val;
 		read2 <<= 32;
-		read2 |= readl(ioaddr + SNVS_LPSRTCLR);
+		regmap_read(snvs->regmap, snvs->offset + SNVS_LPSRTCLR, &val);
+		read2 |= val;
 	} while (read1 != read2);
 
 	/* Convert 47-bit counter to 32-bit raw second count */
 	return (u32) (read1 >> CNTR_TO_SECS_SH);
 }
 
-static void rtc_write_sync_lp(void __iomem *ioaddr)
+static void rtc_write_sync_lp(struct snvs_rtc_data *snvs)
 {
 	u32 count1, count2, count3;
 	int i;
@@ -69,15 +75,15 @@ static void rtc_write_sync_lp(void __iomem *ioaddr)
 	/* Wait for 3 CKIL cycles */
 	for (i = 0; i < 3; i++) {
 		do {
-			count1 = readl(ioaddr + SNVS_LPSRTCLR);
-			count2 = readl(ioaddr + SNVS_LPSRTCLR);
+			regmap_read(snvs->regmap, snvs->offset + SNVS_LPSRTCLR, &count1);
+			regmap_read(snvs->regmap, snvs->offset + SNVS_LPSRTCLR, &count2);
 		} while (count1 != count2);
 
 		/* Now wait until counter value changes */
 		do {
 			do {
-				count2 = readl(ioaddr + SNVS_LPSRTCLR);
-				count3 = readl(ioaddr + SNVS_LPSRTCLR);
+				regmap_read(snvs->regmap, snvs->offset + SNVS_LPSRTCLR, &count2);
+				regmap_read(snvs->regmap, snvs->offset + SNVS_LPSRTCLR, &count3);
 			} while (count2 != count3);
 		} while (count3 == count1);
 	}
@@ -85,23 +91,14 @@ static void rtc_write_sync_lp(void __iomem *ioaddr)
 
 static int snvs_rtc_enable(struct snvs_rtc_data *data, bool enable)
 {
-	unsigned long flags;
 	int timeout = 1000;
 	u32 lpcr;
 
-	spin_lock_irqsave(&data->lock, flags);
-
-	lpcr = readl(data->ioaddr + SNVS_LPCR);
-	if (enable)
-		lpcr |= SNVS_LPCR_SRTC_ENV;
-	else
-		lpcr &= ~SNVS_LPCR_SRTC_ENV;
-	writel(lpcr, data->ioaddr + SNVS_LPCR);
-
-	spin_unlock_irqrestore(&data->lock, flags);
+	regmap_update_bits(data->regmap, data->offset + SNVS_LPCR, SNVS_LPCR_SRTC_ENV,
+			   enable ? SNVS_LPCR_SRTC_ENV : 0);
 
 	while (--timeout) {
-		lpcr = readl(data->ioaddr + SNVS_LPCR);
+		regmap_read(data->regmap, data->offset + SNVS_LPCR, &lpcr);
 
 		if (enable) {
 			if (lpcr & SNVS_LPCR_SRTC_ENV)
@@ -121,7 +118,7 @@ static int snvs_rtc_enable(struct snvs_rtc_data *data, bool enable)
 static int snvs_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct snvs_rtc_data *data = dev_get_drvdata(dev);
-	unsigned long time = rtc_read_lp_counter(data->ioaddr);
+	unsigned long time = rtc_read_lp_counter(data);
 
 	rtc_time_to_tm(time, tm);
 
@@ -139,8 +136,8 @@ static int snvs_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	snvs_rtc_enable(data, false);
 
 	/* Write 32-bit time to 47-bit timer, leaving 15 LSBs blank */
-	writel(time << CNTR_TO_SECS_SH, data->ioaddr + SNVS_LPSRTCLR);
-	writel(time >> (32 - CNTR_TO_SECS_SH), data->ioaddr + SNVS_LPSRTCMR);
+	regmap_write(data->regmap, data->offset + SNVS_LPSRTCLR, time << CNTR_TO_SECS_SH);
+	regmap_write(data->regmap, data->offset + SNVS_LPSRTCMR, time >> (32 - CNTR_TO_SECS_SH));
 
 	/* Enable RTC again */
 	snvs_rtc_enable(data, true);
@@ -153,10 +150,10 @@ static int snvs_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	struct snvs_rtc_data *data = dev_get_drvdata(dev);
 	u32 lptar, lpsr;
 
-	lptar = readl(data->ioaddr + SNVS_LPTAR);
+	regmap_read(data->regmap, data->offset + SNVS_LPTAR, &lptar);
 	rtc_time_to_tm(lptar, &alrm->time);
 
-	lpsr = readl(data->ioaddr + SNVS_LPSR);
+	regmap_read(data->regmap, data->offset + SNVS_LPSR, &lpsr);
 	alrm->pending = (lpsr & SNVS_LPSR_LPTA) ? 1 : 0;
 
 	return 0;
@@ -165,21 +162,12 @@ static int snvs_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 static int snvs_rtc_alarm_irq_enable(struct device *dev, unsigned int enable)
 {
 	struct snvs_rtc_data *data = dev_get_drvdata(dev);
-	u32 lpcr;
-	unsigned long flags;
-
-	spin_lock_irqsave(&data->lock, flags);
-
-	lpcr = readl(data->ioaddr + SNVS_LPCR);
-	if (enable)
-		lpcr |= (SNVS_LPCR_LPTA_EN | SNVS_LPCR_LPWUI_EN);
-	else
-		lpcr &= ~(SNVS_LPCR_LPTA_EN | SNVS_LPCR_LPWUI_EN);
-	writel(lpcr, data->ioaddr + SNVS_LPCR);
 
-	spin_unlock_irqrestore(&data->lock, flags);
+	regmap_update_bits(data->regmap, data->offset + SNVS_LPCR,
+			  (SNVS_LPCR_LPTA_EN | SNVS_LPCR_LPWUI_EN),
+			   enable ? (SNVS_LPCR_LPTA_EN | SNVS_LPCR_LPWUI_EN) : 0);
 
-	rtc_write_sync_lp(data->ioaddr);
+	rtc_write_sync_lp(data);
 
 	return 0;
 }
@@ -189,24 +177,14 @@ static int snvs_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	struct snvs_rtc_data *data = dev_get_drvdata(dev);
 	struct rtc_time *alrm_tm = &alrm->time;
 	unsigned long time;
-	unsigned long flags;
-	u32 lpcr;
 
 	rtc_tm_to_time(alrm_tm, &time);
 
-	spin_lock_irqsave(&data->lock, flags);
-
-	/* Have to clear LPTA_EN before programming new alarm time in LPTAR */
-	lpcr = readl(data->ioaddr + SNVS_LPCR);
-	lpcr &= ~SNVS_LPCR_LPTA_EN;
-	writel(lpcr, data->ioaddr + SNVS_LPCR);
-
-	spin_unlock_irqrestore(&data->lock, flags);
-
-	writel(time, data->ioaddr + SNVS_LPTAR);
+	regmap_update_bits(data->regmap, data->offset + SNVS_LPCR, SNVS_LPCR_LPTA_EN, 0);
+	regmap_write(data->regmap, data->offset + SNVS_LPTAR, time);
 
 	/* Clear alarm interrupt status bit */
-	writel(SNVS_LPSR_LPTA, data->ioaddr + SNVS_LPSR);
+	regmap_write(data->regmap, data->offset + SNVS_LPSR, SNVS_LPSR_LPTA);
 
 	return snvs_rtc_alarm_irq_enable(dev, alrm->enabled);
 }
@@ -226,7 +204,7 @@ static irqreturn_t snvs_rtc_irq_handler(int irq, void *dev_id)
 	u32 lpsr;
 	u32 events = 0;
 
-	lpsr = readl(data->ioaddr + SNVS_LPSR);
+	regmap_read(data->regmap, data->offset + SNVS_LPSR, &lpsr);
 
 	if (lpsr & SNVS_LPSR_LPTA) {
 		events |= (RTC_AF | RTC_IRQF);
@@ -238,25 +216,53 @@ static irqreturn_t snvs_rtc_irq_handler(int irq, void *dev_id)
 	}
 
 	/* clear interrupt status */
-	writel(lpsr, data->ioaddr + SNVS_LPSR);
+	regmap_write(data->regmap, data->offset + SNVS_LPSR, lpsr);
 
 	return events ? IRQ_HANDLED : IRQ_NONE;
 }
 
+static const struct regmap_config snvs_rtc_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
+
 static int snvs_rtc_probe(struct platform_device *pdev)
 {
 	struct snvs_rtc_data *data;
 	struct resource *res;
 	int ret;
+	struct device_node *snvs_np;
+	void __iomem *mmio;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->ioaddr = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(data->ioaddr))
-		return PTR_ERR(data->ioaddr);
+	snvs_np = of_get_parent(pdev->dev.of_node);
+	if (!snvs_np)
+		return -ENODEV;
+
+	if (of_device_is_compatible(snvs_np, "syscon")) {
+		data->regmap = syscon_node_to_regmap(snvs_np);
+		data->offset = 0x34;
+	} else {
+		pr_warning("snvs rtc: you use old dts file, please update it\n");
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+		mmio = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(mmio))
+			return PTR_ERR(mmio);
+
+		data->regmap = devm_regmap_init_mmio(&pdev->dev, mmio, &snvs_rtc_config);
+	}
+
+	of_node_put(snvs_np);
+
+	if (!data->regmap) {
+		pr_err("Can't snvs syscon\n");
+		return -ENODEV;
+	}
 
 	data->irq = platform_get_irq(pdev, 0);
 	if (data->irq < 0)
@@ -276,13 +282,11 @@ static int snvs_rtc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, data);
 
-	spin_lock_init(&data->lock);
-
 	/* Initialize glitch detect */
-	writel(SNVS_LPPGDR_INIT, data->ioaddr + SNVS_LPPGDR);
+	regmap_write(data->regmap, data->offset + SNVS_LPPGDR, SNVS_LPPGDR_INIT);
 
 	/* Clear interrupt status */
-	writel(0xffffffff, data->ioaddr + SNVS_LPSR);
+	regmap_write(data->regmap, data->offset + SNVS_LPSR, 0xffffffff);
 
 	/* Enable RTC */
 	snvs_rtc_enable(data, true);
-- 
1.9.1

