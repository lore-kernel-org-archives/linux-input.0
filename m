From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH] input: sirfsoc-onkey - report onkey untouch event by detecting pin status
Date: Mon, 10 Feb 2014 18:07:39 +0800
Message-ID: <1392026859-4977-1-git-send-email-21cnbao@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:34252 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516AbaBJKID (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Feb 2014 05:08:03 -0500
Received: by mail-pb0-f44.google.com with SMTP id rq2so6049060pbb.31
        for <linux-input@vger.kernel.org>; Mon, 10 Feb 2014 02:08:02 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, workgroup.linux@csr.com, Xianglong Du <Xianglong.Du@csr.com>, Rongjun Ying <Rongjun.Ying@csr.com>, Barry Song <Baohua.Song@csr.com>

From: Xianglong Du <Xianglong.Du@csr.com>

this patch adds a delayed_work to detect the untouch of onkey since HW will
not generate interrupt for it.

at the same time, we move the KEY event to POWER instead of SUSPEND, which
will be suitable for both Android and Linux. Userspace PowerManager Daemon
will decide to suspend or shutdown based on how long we have touched onkey

Signed-off-by: Xianglong Du <Xianglong.Du@csr.com>
Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/input/misc/sirfsoc-onkey.c |   48 ++++++++++++++++++++++++++++-------
 1 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/input/misc/sirfsoc-onkey.c b/drivers/input/misc/sirfsoc-onkey.c
index e8897c3..9cd810b 100644
--- a/drivers/input/misc/sirfsoc-onkey.c
+++ b/drivers/input/misc/sirfsoc-onkey.c
@@ -13,16 +13,44 @@
 #include <linux/input.h>
 #include <linux/rtc/sirfsoc_rtciobrg.h>
 #include <linux/of.h>
+#include <linux/workqueue.h>
 
 struct sirfsoc_pwrc_drvdata {
 	u32			pwrc_base;
 	struct input_dev	*input;
+	struct delayed_work	work;
 };
 
 #define PWRC_ON_KEY_BIT			(1 << 0)
 
 #define PWRC_INT_STATUS			0xc
 #define PWRC_INT_MASK			0x10
+#define PWRC_PIN_STATUS			0x14
+#define PWRC_KEY_DETECT_UP_TIME		20	/* ms*/
+
+static inline int sirfsoc_pwrc_is_on_key_down(
+		struct sirfsoc_pwrc_drvdata *pwrcdrv)
+{
+	int state = sirfsoc_rtc_iobrg_readl(
+				pwrcdrv->pwrc_base + PWRC_PIN_STATUS)
+				& PWRC_ON_KEY_BIT;
+	return !state; /* ON_KEY is active low */
+}
+
+static void sirfsoc_pwrc_report_event(struct work_struct *work)
+{
+	struct sirfsoc_pwrc_drvdata *pwrcdrv =
+				container_of((struct delayed_work *)work,
+				struct sirfsoc_pwrc_drvdata, work);
+
+	if (!sirfsoc_pwrc_is_on_key_down(pwrcdrv)) {
+		input_event(pwrcdrv->input, EV_PWR, KEY_POWER, 0);
+		input_sync(pwrcdrv->input);
+	} else {
+		schedule_delayed_work(&pwrcdrv->work,
+			msecs_to_jiffies(PWRC_KEY_DETECT_UP_TIME));
+	}
+}
 
 static irqreturn_t sirfsoc_pwrc_isr(int irq, void *dev_id)
 {
@@ -34,17 +62,11 @@ static irqreturn_t sirfsoc_pwrc_isr(int irq, void *dev_id)
 	sirfsoc_rtc_iobrg_writel(int_status & ~PWRC_ON_KEY_BIT,
 				 pwrcdrv->pwrc_base + PWRC_INT_STATUS);
 
-	/*
-	 * For a typical Linux system, we report KEY_SUSPEND to trigger apm-power.c
-	 * to queue a SUSPEND APM event
-	 */
-	input_event(pwrcdrv->input, EV_PWR, KEY_SUSPEND, 1);
-	input_sync(pwrcdrv->input);
 
-	/*
-	 * Todo: report KEY_POWER event for Android platforms, Android PowerManager
-	 * will handle the suspend and powerdown/hibernation
-	 */
+	input_event(pwrcdrv->input, EV_PWR, KEY_POWER, 1);
+	input_sync(pwrcdrv->input);
+	schedule_delayed_work(&pwrcdrv->work,
+		msecs_to_jiffies(PWRC_KEY_DETECT_UP_TIME));
 
 	return IRQ_HANDLED;
 }
@@ -88,6 +110,8 @@ static int sirfsoc_pwrc_probe(struct platform_device *pdev)
 	pwrcdrv->input->phys = "pwrc/input0";
 	pwrcdrv->input->evbit[0] = BIT_MASK(EV_PWR);
 
+	INIT_DELAYED_WORK(&pwrcdrv->work, sirfsoc_pwrc_report_event);
+
 	irq = platform_get_irq(pdev, 0);
 	error = devm_request_irq(&pdev->dev, irq,
 				 sirfsoc_pwrc_isr, IRQF_SHARED,
@@ -119,8 +143,12 @@ static int sirfsoc_pwrc_probe(struct platform_device *pdev)
 
 static int sirfsoc_pwrc_remove(struct platform_device *pdev)
 {
+	struct sirfsoc_pwrc_drvdata *pwrcdrv = dev_get_drvdata(&pdev->dev);
+
 	device_init_wakeup(&pdev->dev, 0);
 
+	cancel_delayed_work_sync(&pwrcdrv->work);
+
 	return 0;
 }
 
-- 
1.7.5.4

