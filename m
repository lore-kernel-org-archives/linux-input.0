From: Sonic Zhang <sonic.adi@gmail.com>
Subject: [PATCH 3/3] bfin_rotary: replace bfin specific MMR function with generic IO function
Date: Wed, 14 Jan 2015 15:52:55 +0800
Message-ID: <1421221975-30728-3-git-send-email-sonic.adi@gmail.com>
References: <1421221975-30728-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-by2on0098.outbound.protection.outlook.com ([207.46.100.98]:27642
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753257AbbANI2I (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Jan 2015 03:28:08 -0500
In-Reply-To: <1421221975-30728-1-git-send-email-sonic.adi@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>, adi-buildroot-devel@lists.sourceforge.net, Sonic Zhang <sonic.zhang@analog.com>

From: Sonic Zhang <sonic.zhang@analog.com>

- use readw and writew to access rotary MMRs
- remap rotary register physical address into kernel space in probe

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
---
 arch/blackfin/mach-bf527/boards/ad7160eval.c |    5 +++
 arch/blackfin/mach-bf527/boards/ezkit.c      |    5 +++
 arch/blackfin/mach-bf548/boards/ezkit.c      |    5 +++
 arch/blackfin/mach-bf609/boards/ezkit.c      |    5 +++
 drivers/input/misc/bfin_rotary.c             |   59 +++++++++++++++++---------
 5 files changed, 60 insertions(+), 19 deletions(-)

diff --git a/arch/blackfin/mach-bf527/boards/ad7160eval.c b/arch/blackfin/mach-bf527/boards/ad7160eval.c
index 029a050..68f2a8a 100644
--- a/arch/blackfin/mach-bf527/boards/ad7160eval.c
+++ b/arch/blackfin/mach-bf527/boards/ad7160eval.c
@@ -688,6 +688,11 @@ static struct bfin_rotary_platform_data bfin_rotary_data = {
 
 static struct resource bfin_rotary_resources[] = {
 	{
+		.start = CNT_CONFIG,
+		.end   = CNT_CONFIG + 0xff,
+		.flags = IORESOURCE_MEM,
+	},
+	{
 		.start = IRQ_CNT,
 		.end = IRQ_CNT,
 		.flags = IORESOURCE_IRQ,
diff --git a/arch/blackfin/mach-bf527/boards/ezkit.c b/arch/blackfin/mach-bf527/boards/ezkit.c
index cc80c5b..d4219e8 100644
--- a/arch/blackfin/mach-bf527/boards/ezkit.c
+++ b/arch/blackfin/mach-bf527/boards/ezkit.c
@@ -1114,6 +1114,11 @@ static struct bfin_rotary_platform_data bfin_rotary_data = {
 
 static struct resource bfin_rotary_resources[] = {
 	{
+		.start = CNT_CONFIG,
+		.end   = CNT_CONFIG + 0xff,
+		.flags = IORESOURCE_MEM,
+	},
+	{
 		.start = IRQ_CNT,
 		.end = IRQ_CNT,
 		.flags = IORESOURCE_IRQ,
diff --git a/arch/blackfin/mach-bf548/boards/ezkit.c b/arch/blackfin/mach-bf548/boards/ezkit.c
index 0b68781..aaee1af 100644
--- a/arch/blackfin/mach-bf548/boards/ezkit.c
+++ b/arch/blackfin/mach-bf548/boards/ezkit.c
@@ -181,6 +181,11 @@ static struct bfin_rotary_platform_data bfin_rotary_data = {
 
 static struct resource bfin_rotary_resources[] = {
 	{
+		.start = CNT_CONFIG,
+		.end   = CNT_CONFIG + 0xff,
+		.flags = IORESOURCE_MEM,
+	},
+	{
 		.start = IRQ_CNT,
 		.end = IRQ_CNT,
 		.flags = IORESOURCE_IRQ,
diff --git a/arch/blackfin/mach-bf609/boards/ezkit.c b/arch/blackfin/mach-bf609/boards/ezkit.c
index 4ac72c6..57ce0a8 100644
--- a/arch/blackfin/mach-bf609/boards/ezkit.c
+++ b/arch/blackfin/mach-bf609/boards/ezkit.c
@@ -96,6 +96,11 @@ static struct bfin_rotary_platform_data bfin_rotary_data = {
 
 static struct resource bfin_rotary_resources[] = {
 	{
+		.start = CNT_CONFIG,
+		.end   = CNT_CONFIG + 0xff,
+		.flags = IORESOURCE_MEM,
+	},
+	{
 		.start = IRQ_CNT,
 		.end = IRQ_CNT,
 		.flags = IORESOURCE_IRQ,
diff --git a/drivers/input/misc/bfin_rotary.c b/drivers/input/misc/bfin_rotary.c
index dd62fc9..1726aea 100644
--- a/drivers/input/misc/bfin_rotary.c
+++ b/drivers/input/misc/bfin_rotary.c
@@ -7,6 +7,7 @@
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/pm.h>
 #include <linux/platform_device.h>
@@ -16,8 +17,18 @@
 
 #include <asm/portmux.h>
 
+#define CNT_CONFIG_OFF		0	/* CNT Config Offset */
+#define CNT_IMASK_OFF		4	/* CNT Interrupt Mask Offset */
+#define CNT_STATUS_OFF		8	/* CNT Status Offset */
+#define CNT_COMMAND_OFF		12	/* CNT Command Offset */
+#define CNT_DEBOUNCE_OFF	16	/* CNT Debounce Offset */
+#define CNT_COUNTER_OFF		20	/* CNT Counter Offset */
+#define CNT_MAX_OFF		24	/* CNT Maximum Count Offset */
+#define CNT_MIN_OFF		28	/* CNT Minimum Count Offset */
+
 struct bfin_rot {
 	struct input_dev *input;
+	void __iomem *base;
 	int irq;
 	unsigned int up_key;
 	unsigned int down_key;
@@ -56,14 +67,14 @@ static irqreturn_t bfin_rotary_isr(int irq, void *dev_id)
 	struct bfin_rot *rotary = platform_get_drvdata(pdev);
 	int delta;
 
-	switch (bfin_read_CNT_STATUS()) {
+	switch (readw(rotary->base + CNT_STATUS_OFF)) {
 
 	case ICII:
 		break;
 
 	case UCII:
 	case DCII:
-		delta = bfin_read_CNT_COUNTER();
+		delta = readl(rotary->base + CNT_COUNTER_OFF);
 		if (delta)
 			report_rotary_event(rotary, delta);
 		break;
@@ -76,8 +87,8 @@ static irqreturn_t bfin_rotary_isr(int irq, void *dev_id)
 		break;
 	}
 
-	bfin_write_CNT_COMMAND(W1LCNT_ZERO);	/* Clear COUNTER */
-	bfin_write_CNT_STATUS(-1);	/* Clear STATUS */
+	writew(W1LCNT_ZERO, rotary->base + CNT_COMMAND_OFF); /* Clear COUNTER */
+	writew(-1, rotary->base + CNT_STATUS_OFF); /* Clear STATUS */
 
 	return IRQ_HANDLED;
 }
@@ -86,6 +97,7 @@ static int bfin_rotary_probe(struct platform_device *pdev)
 {
 	struct bfin_rotary_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct bfin_rot *rotary;
+	struct resource *res;
 	struct input_dev *input;
 	int error;
 
@@ -108,6 +120,11 @@ static int bfin_rotary_probe(struct platform_device *pdev)
 		goto out1;
 	}
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	rotary->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(rotary->base))
+		return PTR_ERR(rotary->base);
+
 	rotary->input = input;
 
 	rotary->up_key = pdata->rotary_up_key;
@@ -161,17 +178,21 @@ static int bfin_rotary_probe(struct platform_device *pdev)
 	}
 
 	if (pdata->rotary_button_key)
-		bfin_write_CNT_IMASK(CZMIE);
+		writew(CZMIE, rotary->base + CNT_IMASK_OFF);
 
 	if (pdata->mode & ROT_DEBE)
-		bfin_write_CNT_DEBOUNCE(pdata->debounce & DPRESCALE);
+		writew(pdata->debounce & DPRESCALE,
+			rotary->base + CNT_DEBOUNCE_OFF);
 
 	if (pdata->mode)
-		bfin_write_CNT_CONFIG(bfin_read_CNT_CONFIG() |
-					(pdata->mode & ~CNTE));
+		writew(readw(rotary->base + CNT_CONFIG_OFF) |
+			(pdata->mode & ~CNTE),
+			rotary->base + CNT_CONFIG_OFF);
 
-	bfin_write_CNT_IMASK(bfin_read_CNT_IMASK() | UCIE | DCIE);
-	bfin_write_CNT_CONFIG(bfin_read_CNT_CONFIG() | CNTE);
+	writew(readw(rotary->base + CNT_IMASK_OFF) | UCIE | DCIE,
+		rotary->base + CNT_IMASK_OFF);
+	writew(readw(rotary->base + CNT_CONFIG_OFF) | CNTE,
+		rotary->base + CNT_CONFIG_OFF);
 
 	platform_set_drvdata(pdev, rotary);
 	device_init_wakeup(&pdev->dev, 1);
@@ -193,8 +214,8 @@ static int bfin_rotary_remove(struct platform_device *pdev)
 	struct bfin_rotary_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct bfin_rot *rotary = platform_get_drvdata(pdev);
 
-	bfin_write_CNT_CONFIG(0);
-	bfin_write_CNT_IMASK(0);
+	writew(0, rotary->base + CNT_CONFIG_OFF);
+	writew(0, rotary->base + CNT_IMASK_OFF);
 
 	free_irq(rotary->irq, pdev);
 	input_unregister_device(rotary->input);
@@ -211,9 +232,9 @@ static int bfin_rotary_suspend(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct bfin_rot *rotary = platform_get_drvdata(pdev);
 
-	rotary->cnt_config = bfin_read_CNT_CONFIG();
-	rotary->cnt_imask = bfin_read_CNT_IMASK();
-	rotary->cnt_debounce = bfin_read_CNT_DEBOUNCE();
+	rotary->cnt_config = readw(rotary->base + CNT_CONFIG_OFF);
+	rotary->cnt_imask = readw(rotary->base + CNT_IMASK_OFF);
+	rotary->cnt_debounce = readw(rotary->base + CNT_DEBOUNCE_OFF);
 
 	if (device_may_wakeup(&pdev->dev))
 		enable_irq_wake(rotary->irq);
@@ -226,15 +247,15 @@ static int bfin_rotary_resume(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct bfin_rot *rotary = platform_get_drvdata(pdev);
 
-	bfin_write_CNT_DEBOUNCE(rotary->cnt_debounce);
-	bfin_write_CNT_IMASK(rotary->cnt_imask);
-	bfin_write_CNT_CONFIG(rotary->cnt_config & ~CNTE);
+	writew(rotary->cnt_debounce, rotary->base + CNT_DEBOUNCE_OFF);
+	writew(rotary->cnt_imask, rotary->base + CNT_IMASK_OFF);
+	writew(rotary->cnt_config & ~CNTE, rotary->base + CNT_CONFIG_OFF);
 
 	if (device_may_wakeup(&pdev->dev))
 		disable_irq_wake(rotary->irq);
 
 	if (rotary->cnt_config & CNTE)
-		bfin_write_CNT_CONFIG(rotary->cnt_config);
+		writew(rotary->cnt_config, rotary->base + CNT_CONFIG_OFF);
 
 	return 0;
 }
-- 
1.7.9.5

