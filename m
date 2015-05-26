From: <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH v5 1/6] rtc: arm: imx: snvs: change use syscon to access register
Date: Wed, 27 May 2015 00:25:57 +0800
Message-ID: <1432657562-5592-2-git-send-email-Frank.Li@freescale.com>
References: <1432657562-5592-1-git-send-email-Frank.Li@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1432657562-5592-1-git-send-email-Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lznuaa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Frank Li <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: Frank Li <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

snvs included rtc, on/off key, power-off module
change to syscon to access register

Signed-off-by: Frank Li <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/rtc/rtc-snvs.c | 132 +++++++++++++++++++++++++------------------------
 1 file changed, 67 insertions(+), 65 deletions(-)

diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
index 0479e80..fa67d7c 100644
--- a/drivers/rtc/rtc-snvs.c
+++ b/drivers/rtc/rtc-snvs.c
@@ -18,6 +18,10 @@
 #include <linux/platform_device.h>
 #include <linux/rtc.h>
 #include <linux/clk.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+
+#define SNVS_LPREGISTER_OFFSET	0x34
 
 /* These register offsets are relative to LP (Low Power) range */
 #define SNVS_LPCR		0x04
@@ -37,31 +41,36 @@
 
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
+static u32 rtc_read_lp_counter(struct snvs_rtc_data *data)
 {
 	u64 read1, read2;
+	u32 val;
 
 	do {
-		read1 = readl(ioaddr + SNVS_LPSRTCMR);
+		regmap_read(data->regmap, data->offset + SNVS_LPSRTCMR, &val);
+		read1 = val;
 		read1 <<= 32;
-		read1 |= readl(ioaddr + SNVS_LPSRTCLR);
+		regmap_read(data->regmap, data->offset + SNVS_LPSRTCLR, &val);
+		read1 |= val;
 
-		read2 = readl(ioaddr + SNVS_LPSRTCMR);
+		regmap_read(data->regmap, data->offset + SNVS_LPSRTCMR, &val);
+		read2 = val;
 		read2 <<= 32;
-		read2 |= readl(ioaddr + SNVS_LPSRTCLR);
+		regmap_read(data->regmap, data->offset + SNVS_LPSRTCLR, &val);
+		read2 |= val;
 	} while (read1 != read2);
 
 	/* Convert 47-bit counter to 32-bit raw second count */
 	return (u32) (read1 >> CNTR_TO_SECS_SH);
 }
 
-static void rtc_write_sync_lp(void __iomem *ioaddr)
+static void rtc_write_sync_lp(struct snvs_rtc_data *data)
 {
 	u32 count1, count2, count3;
 	int i;
@@ -69,15 +78,15 @@ static void rtc_write_sync_lp(void __iomem *ioaddr)
 	/* Wait for 3 CKIL cycles */
 	for (i = 0; i < 3; i++) {
 		do {
-			count1 = readl(ioaddr + SNVS_LPSRTCLR);
-			count2 = readl(ioaddr + SNVS_LPSRTCLR);
+			regmap_read(data->regmap, data->offset + SNVS_LPSRTCLR, &count1);
+			regmap_read(data->regmap, data->offset + SNVS_LPSRTCLR, &count2);
 		} while (count1 != count2);
 
 		/* Now wait until counter value changes */
 		do {
 			do {
-				count2 = readl(ioaddr + SNVS_LPSRTCLR);
-				count3 = readl(ioaddr + SNVS_LPSRTCLR);
+				regmap_read(data->regmap, data->offset + SNVS_LPSRTCLR, &count2);
+				regmap_read(data->regmap, data->offset + SNVS_LPSRTCLR, &count3);
 			} while (count2 != count3);
 		} while (count3 == count1);
 	}
@@ -85,23 +94,14 @@ static void rtc_write_sync_lp(void __iomem *ioaddr)
 
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
@@ -121,7 +121,7 @@ static int snvs_rtc_enable(struct snvs_rtc_data *data, bool enable)
 static int snvs_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct snvs_rtc_data *data = dev_get_drvdata(dev);
-	unsigned long time = rtc_read_lp_counter(data->ioaddr);
+	unsigned long time = rtc_read_lp_counter(data);
 
 	rtc_time_to_tm(time, tm);
 
@@ -139,8 +139,8 @@ static int snvs_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	snvs_rtc_enable(data, false);
 
 	/* Write 32-bit time to 47-bit timer, leaving 15 LSBs blank */
-	writel(time << CNTR_TO_SECS_SH, data->ioaddr + SNVS_LPSRTCLR);
-	writel(time >> (32 - CNTR_TO_SECS_SH), data->ioaddr + SNVS_LPSRTCMR);
+	regmap_write(data->regmap, data->offset + SNVS_LPSRTCLR, time << CNTR_TO_SECS_SH);
+	regmap_write(data->regmap, data->offset + SNVS_LPSRTCMR, time >> (32 - CNTR_TO_SECS_SH));
 
 	/* Enable RTC again */
 	snvs_rtc_enable(data, true);
@@ -153,10 +153,10 @@ static int snvs_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	struct snvs_rtc_data *data = dev_get_drvdata(dev);
 	u32 lptar, lpsr;
 
-	lptar = readl(data->ioaddr + SNVS_LPTAR);
+	regmap_read(data->regmap, data->offset + SNVS_LPTAR, &lptar);
 	rtc_time_to_tm(lptar, &alrm->time);
 
-	lpsr = readl(data->ioaddr + SNVS_LPSR);
+	regmap_read(data->regmap, data->offset + SNVS_LPSR, &lpsr);
 	alrm->pending = (lpsr & SNVS_LPSR_LPTA) ? 1 : 0;
 
 	return 0;
@@ -165,21 +165,12 @@ static int snvs_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 static int snvs_rtc_alarm_irq_enable(struct device *dev, unsigned int enable)
 {
 	struct snvs_rtc_data *data = dev_get_drvdata(dev);
-	u32 lpcr;
-	unsigned long flags;
-
-	spin_lock_irqsave(&data->lock, flags);
 
-	lpcr = readl(data->ioaddr + SNVS_LPCR);
-	if (enable)
-		lpcr |= (SNVS_LPCR_LPTA_EN | SNVS_LPCR_LPWUI_EN);
-	else
-		lpcr &= ~(SNVS_LPCR_LPTA_EN | SNVS_LPCR_LPWUI_EN);
-	writel(lpcr, data->ioaddr + SNVS_LPCR);
+	regmap_update_bits(data->regmap, data->offset + SNVS_LPCR,
+			   (SNVS_LPCR_LPTA_EN | SNVS_LPCR_LPWUI_EN),
+			   enable ? (SNVS_LPCR_LPTA_EN | SNVS_LPCR_LPWUI_EN) : 0);
 
-	spin_unlock_irqrestore(&data->lock, flags);
-
-	rtc_write_sync_lp(data->ioaddr);
+	rtc_write_sync_lp(data);
 
 	return 0;
 }
@@ -189,24 +180,14 @@ static int snvs_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
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
@@ -226,7 +207,7 @@ static irqreturn_t snvs_rtc_irq_handler(int irq, void *dev_id)
 	u32 lpsr;
 	u32 events = 0;
 
-	lpsr = readl(data->ioaddr + SNVS_LPSR);
+	regmap_read(data->regmap, data->offset + SNVS_LPSR, &lpsr);
 
 	if (lpsr & SNVS_LPSR_LPTA) {
 		events |= (RTC_AF | RTC_IRQF);
@@ -238,25 +219,48 @@ static irqreturn_t snvs_rtc_irq_handler(int irq, void *dev_id)
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
+	void __iomem *mmio;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->ioaddr = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(data->ioaddr))
-		return PTR_ERR(data->ioaddr);
+	data->regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node, "regmap");
+
+	if (IS_ERR(data->regmap)) {
+		dev_warn(&pdev->dev, "snvs rtc: you use old dts file, please update it\n");
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+		mmio = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(mmio))
+			return PTR_ERR(mmio);
+
+		data->regmap = devm_regmap_init_mmio(&pdev->dev, mmio, &snvs_rtc_config);
+	} else {
+		data->offset = SNVS_LPREGISTER_OFFSET;
+		of_property_read_u32(pdev->dev.of_node, "offset", &data->offset);
+	}
+
+	if (!data->regmap) {
+		dev_err(&pdev->dev, "Can't find snvs syscon\n");
+		return -ENODEV;
+	}
 
 	data->irq = platform_get_irq(pdev, 0);
 	if (data->irq < 0)
@@ -276,13 +280,11 @@ static int snvs_rtc_probe(struct platform_device *pdev)
 
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
