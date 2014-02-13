From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH v2] input: sirfsoc-onkey - report onkey untouch event by detecting pin status
Date: Thu, 13 Feb 2014 14:38:56 +0800
Message-ID: <1392273536-22848-1-git-send-email-21cnbao@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:54353 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbaBMGjZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Feb 2014 01:39:25 -0500
Received: by mail-pa0-f44.google.com with SMTP id kq14so10317887pab.17
        for <linux-input@vger.kernel.org>; Wed, 12 Feb 2014 22:39:24 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: workgroup.linux@csr.com, Xianglong Du <Xianglong.Du@csr.com>, Rongjun Ying <Rongjun.Ying@csr.com>, Barry Song <Baohua.Song@csr.com>

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
 -v2:
 avoid the race of reschedule the work in remove;
 fix the typo about reporting KEY_POWER;

 drivers/input/misc/sirfsoc-onkey.c |   60 +++++++++++++++++++++++++++---------
 1 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/drivers/input/misc/sirfsoc-onkey.c b/drivers/input/misc/sirfsoc-onkey.c
index e8897c3..4d13903 100644
--- a/drivers/input/misc/sirfsoc-onkey.c
+++ b/drivers/input/misc/sirfsoc-onkey.c
@@ -13,16 +13,45 @@
 #include <linux/input.h>
 #include <linux/rtc/sirfsoc_rtciobrg.h>
 #include <linux/of.h>
+#include <linux/workqueue.h>
 
 struct sirfsoc_pwrc_drvdata {
 	u32			pwrc_base;
 	struct input_dev	*input;
+	int			irq;
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
+		input_event(pwrcdrv->input, EV_KEY, KEY_POWER, 0);
+		input_sync(pwrcdrv->input);
+	} else {
+		schedule_delayed_work(&pwrcdrv->work,
+			msecs_to_jiffies(PWRC_KEY_DETECT_UP_TIME));
+	}
+}
 
 static irqreturn_t sirfsoc_pwrc_isr(int irq, void *dev_id)
 {
@@ -34,17 +63,11 @@ static irqreturn_t sirfsoc_pwrc_isr(int irq, void *dev_id)
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
+	input_event(pwrcdrv->input, EV_KEY, KEY_POWER, 1);
+	input_sync(pwrcdrv->input);
+	schedule_delayed_work(&pwrcdrv->work,
+		msecs_to_jiffies(PWRC_KEY_DETECT_UP_TIME));
 
 	return IRQ_HANDLED;
 }
@@ -59,7 +82,6 @@ static int sirfsoc_pwrc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct sirfsoc_pwrc_drvdata *pwrcdrv;
-	int irq;
 	int error;
 
 	pwrcdrv = devm_kzalloc(&pdev->dev, sizeof(struct sirfsoc_pwrc_drvdata),
@@ -86,15 +108,17 @@ static int sirfsoc_pwrc_probe(struct platform_device *pdev)
 
 	pwrcdrv->input->name = "sirfsoc pwrckey";
 	pwrcdrv->input->phys = "pwrc/input0";
-	pwrcdrv->input->evbit[0] = BIT_MASK(EV_PWR);
+	pwrcdrv->input->evbit[0] = BIT_MASK(EV_KEY);
 
-	irq = platform_get_irq(pdev, 0);
-	error = devm_request_irq(&pdev->dev, irq,
+	INIT_DELAYED_WORK(&pwrcdrv->work, sirfsoc_pwrc_report_event);
+
+	pwrcdrv->irq = platform_get_irq(pdev, 0);
+	error = devm_request_irq(&pdev->dev, pwrcdrv->irq,
 				 sirfsoc_pwrc_isr, IRQF_SHARED,
 				 "sirfsoc_pwrc_int", pwrcdrv);
 	if (error) {
 		dev_err(&pdev->dev, "unable to claim irq %d, error: %d\n",
-			irq, error);
+			pwrcdrv->irq, error);
 		return error;
 	}
 
@@ -119,8 +143,14 @@ static int sirfsoc_pwrc_probe(struct platform_device *pdev)
 
 static int sirfsoc_pwrc_remove(struct platform_device *pdev)
 {
+	struct sirfsoc_pwrc_drvdata *pwrcdrv = dev_get_drvdata(&pdev->dev);
+
 	device_init_wakeup(&pdev->dev, 0);
 
+	devm_free_irq(&pdev->dev, pwrcdrv->irq, pwrcdrv);
+
+	cancel_delayed_work_sync(&pwrcdrv->work);
+
 	return 0;
 }
 
-- 
1.7.5.4

