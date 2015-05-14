From: <Frank.Li@freescale.com>
Subject: [PATCH 2/7] rtc: arm: imx: snvs: change use syscon to access register
Date: Fri, 15 May 2015 01:18:48 +0800
Message-ID: <1431623933-3473-3-git-send-email-Frank.Li@freescale.com>
References: <1431623933-3473-1-git-send-email-Frank.Li@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1431623933-3473-1-git-send-email-Frank.Li@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
To: lznuaa@gmail.com, shawn.guo@linaro.org, dmitry.torokhov@gmail.com, robh+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, rtc-linux@googlegroups.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Frank Li <Frank.Li@freescale.com>
List-Id: linux-input@vger.kernel.org

From: Frank Li <Frank.Li@freescale.com>

snvs included rtc, on/off key, power-off module
change to syscon to access register

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 drivers/rtc/rtc-snvs.c | 124 +++++++++++++++++++++----------------------------
 1 file changed, 54 insertions(+), 70 deletions(-)

diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
index 0479e80..4e85fbe 100644
--- a/drivers/rtc/rtc-snvs.c
+++ b/drivers/rtc/rtc-snvs.c
@@ -18,14 +18,16 @@
 #include <linux/platform_device.h>
 #include <linux/rtc.h>
 #include <linux/clk.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
 /* These register offsets are relative to LP (Low Power) range */
-#define SNVS_LPCR		0x04
-#define SNVS_LPSR		0x18
-#define SNVS_LPSRTCMR		0x1c
-#define SNVS_LPSRTCLR		0x20
-#define SNVS_LPTAR		0x24
-#define SNVS_LPPGDR		0x30
+#define SNVS_LPCR		0x38
+#define SNVS_LPSR		0x4c
+#define SNVS_LPSRTCMR		0x50
+#define SNVS_LPSRTCLR		0x54
+#define SNVS_LPTAR		0x58
+#define SNVS_LPPGDR		0x64
 
 #define SNVS_LPCR_SRTC_ENV	(1 << 0)
 #define SNVS_LPCR_LPTA_EN	(1 << 1)
@@ -37,31 +39,35 @@
 
 struct snvs_rtc_data {
 	struct rtc_device *rtc;
-	void __iomem *ioaddr;
+	struct regmap *snvs;
 	int irq;
 	spinlock_t lock;
 	struct clk *clk;
 };
 
-static u32 rtc_read_lp_counter(void __iomem *ioaddr)
+static u32 rtc_read_lp_counter(struct regmap *snvs)
 {
 	u64 read1, read2;
-
+	u32 val;
 	do {
-		read1 = readl(ioaddr + SNVS_LPSRTCMR);
+		regmap_read(snvs, SNVS_LPSRTCMR, &val);
+		read1 = val;
 		read1 <<= 32;
-		read1 |= readl(ioaddr + SNVS_LPSRTCLR);
+		regmap_read(snvs, SNVS_LPSRTCLR, &val);
+		read1 |= val;
 
-		read2 = readl(ioaddr + SNVS_LPSRTCMR);
+		regmap_read(snvs, SNVS_LPSRTCMR, &val);
+		read2 = val;
 		read2 <<= 32;
-		read2 |= readl(ioaddr + SNVS_LPSRTCLR);
+		regmap_read(snvs, SNVS_LPSRTCLR, &val);
+		read2 |= val;
 	} while (read1 != read2);
 
 	/* Convert 47-bit counter to 32-bit raw second count */
 	return (u32) (read1 >> CNTR_TO_SECS_SH);
 }
 
-static void rtc_write_sync_lp(void __iomem *ioaddr)
+static void rtc_write_sync_lp(struct regmap *snvs)
 {
 	u32 count1, count2, count3;
 	int i;
@@ -69,15 +75,15 @@ static void rtc_write_sync_lp(void __iomem *ioaddr)
 	/* Wait for 3 CKIL cycles */
 	for (i = 0; i < 3; i++) {
 		do {
-			count1 = readl(ioaddr + SNVS_LPSRTCLR);
-			count2 = readl(ioaddr + SNVS_LPSRTCLR);
+			regmap_read(snvs, SNVS_LPSRTCLR, &count1);
+			regmap_read(snvs, SNVS_LPSRTCLR, &count2);
 		} while (count1 != count2);
 
 		/* Now wait until counter value changes */
 		do {
 			do {
-				count2 = readl(ioaddr + SNVS_LPSRTCLR);
-				count3 = readl(ioaddr + SNVS_LPSRTCLR);
+				regmap_read(snvs, SNVS_LPSRTCLR, &count2);
+				regmap_read(snvs, SNVS_LPSRTCLR, &count3);
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
+	regmap_update_bits(data->snvs, SNVS_LPCR, SNVS_LPCR_SRTC_ENV,
+			   enable ? SNVS_LPCR_SRTC_ENV : 0);
 
 	while (--timeout) {
-		lpcr = readl(data->ioaddr + SNVS_LPCR);
+		regmap_read(data->snvs, SNVS_LPCR, &lpcr);
 
 		if (enable) {
 			if (lpcr & SNVS_LPCR_SRTC_ENV)
@@ -121,7 +118,7 @@ static int snvs_rtc_enable(struct snvs_rtc_data *data, bool enable)
 static int snvs_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct snvs_rtc_data *data = dev_get_drvdata(dev);
-	unsigned long time = rtc_read_lp_counter(data->ioaddr);
+	unsigned long time = rtc_read_lp_counter(data->snvs);
 
 	rtc_time_to_tm(time, tm);
 
@@ -139,8 +136,8 @@ static int snvs_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	snvs_rtc_enable(data, false);
 
 	/* Write 32-bit time to 47-bit timer, leaving 15 LSBs blank */
-	writel(time << CNTR_TO_SECS_SH, data->ioaddr + SNVS_LPSRTCLR);
-	writel(time >> (32 - CNTR_TO_SECS_SH), data->ioaddr + SNVS_LPSRTCMR);
+	regmap_write(data->snvs, SNVS_LPSRTCLR, time << CNTR_TO_SECS_SH);
+	regmap_write(data->snvs, SNVS_LPSRTCMR, time >> (32 - CNTR_TO_SECS_SH));
 
 	/* Enable RTC again */
 	snvs_rtc_enable(data, true);
@@ -153,10 +150,10 @@ static int snvs_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	struct snvs_rtc_data *data = dev_get_drvdata(dev);
 	u32 lptar, lpsr;
 
-	lptar = readl(data->ioaddr + SNVS_LPTAR);
+	regmap_read(data->snvs, SNVS_LPTAR, &lptar);
 	rtc_time_to_tm(lptar, &alrm->time);
 
-	lpsr = readl(data->ioaddr + SNVS_LPSR);
+	regmap_read(data->snvs, SNVS_LPSR, &lpsr);
 	alrm->pending = (lpsr & SNVS_LPSR_LPTA) ? 1 : 0;
 
 	return 0;
@@ -165,21 +162,11 @@ static int snvs_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 static int snvs_rtc_alarm_irq_enable(struct device *dev, unsigned int enable)
 {
 	struct snvs_rtc_data *data = dev_get_drvdata(dev);
-	u32 lpcr;
-	unsigned long flags;
 
-	spin_lock_irqsave(&data->lock, flags);
+	regmap_update_bits(data->snvs, SNVS_LPCR, (SNVS_LPCR_LPTA_EN | SNVS_LPCR_LPWUI_EN),
+			   enable ? (SNVS_LPCR_LPTA_EN | SNVS_LPCR_LPWUI_EN) : 0);
 
-	lpcr = readl(data->ioaddr + SNVS_LPCR);
-	if (enable)
-		lpcr |= (SNVS_LPCR_LPTA_EN | SNVS_LPCR_LPWUI_EN);
-	else
-		lpcr &= ~(SNVS_LPCR_LPTA_EN | SNVS_LPCR_LPWUI_EN);
-	writel(lpcr, data->ioaddr + SNVS_LPCR);
-
-	spin_unlock_irqrestore(&data->lock, flags);
-
-	rtc_write_sync_lp(data->ioaddr);
+	rtc_write_sync_lp(data->snvs);
 
 	return 0;
 }
@@ -189,24 +176,14 @@ static int snvs_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
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
+	regmap_update_bits(data->snvs, SNVS_LPCR, SNVS_LPCR_LPTA_EN, 0);
+	regmap_write(data->snvs, SNVS_LPTAR, time);
 
 	/* Clear alarm interrupt status bit */
-	writel(SNVS_LPSR_LPTA, data->ioaddr + SNVS_LPSR);
+	regmap_write(data->snvs, SNVS_LPSR, SNVS_LPSR_LPTA);
 
 	return snvs_rtc_alarm_irq_enable(dev, alrm->enabled);
 }
@@ -226,7 +203,7 @@ static irqreturn_t snvs_rtc_irq_handler(int irq, void *dev_id)
 	u32 lpsr;
 	u32 events = 0;
 
-	lpsr = readl(data->ioaddr + SNVS_LPSR);
+	regmap_read(data->snvs, SNVS_LPSR, &lpsr);
 
 	if (lpsr & SNVS_LPSR_LPTA) {
 		events |= (RTC_AF | RTC_IRQF);
@@ -238,7 +215,7 @@ static irqreturn_t snvs_rtc_irq_handler(int irq, void *dev_id)
 	}
 
 	/* clear interrupt status */
-	writel(lpsr, data->ioaddr + SNVS_LPSR);
+	regmap_write(data->snvs, SNVS_LPSR, lpsr);
 
 	return events ? IRQ_HANDLED : IRQ_NONE;
 }
@@ -246,17 +223,24 @@ static irqreturn_t snvs_rtc_irq_handler(int irq, void *dev_id)
 static int snvs_rtc_probe(struct platform_device *pdev)
 {
 	struct snvs_rtc_data *data;
-	struct resource *res;
 	int ret;
+	struct device_node *snvs_np;
 
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
+	data->snvs = syscon_node_to_regmap(snvs_np);
+	of_node_put(snvs_np);
+
+	if (!data->snvs) {
+		pr_err("Can't snvs syscon\n");
+		return -ENODEV;
+	}
 
 	data->irq = platform_get_irq(pdev, 0);
 	if (data->irq < 0)
@@ -279,10 +263,10 @@ static int snvs_rtc_probe(struct platform_device *pdev)
 	spin_lock_init(&data->lock);
 
 	/* Initialize glitch detect */
-	writel(SNVS_LPPGDR_INIT, data->ioaddr + SNVS_LPPGDR);
+	regmap_write(data->snvs, SNVS_LPPGDR, SNVS_LPPGDR_INIT);
 
 	/* Clear interrupt status */
-	writel(0xffffffff, data->ioaddr + SNVS_LPSR);
+	regmap_write(data->snvs, SNVS_LPSR, 0xffffffff);
 
 	/* Enable RTC */
 	snvs_rtc_enable(data, true);
-- 
1.9.1

