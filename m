From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH v3] input: sirfsoc-onkey - report onkey untouch event by detecting pin status
Date: Fri, 14 Feb 2014 11:20:01 +0800
Message-ID: <1392348001-4950-1-git-send-email-21cnbao@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:51837 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbaBNDUT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Feb 2014 22:20:19 -0500
Received: by mail-pb0-f48.google.com with SMTP id rr13so11739456pbb.35
        for <linux-input@vger.kernel.org>; Thu, 13 Feb 2014 19:20:19 -0800 (PST)
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
 -v3: move to use custom devres action

 drivers/input/misc/sirfsoc-onkey.c |   60 +++++++++++++++++++++++++++++------
 1 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/drivers/input/misc/sirfsoc-onkey.c b/drivers/input/misc/sirfsoc-onkey.c
index e8897c3..b354da8 100644
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
+		input_event(pwrcdrv->input, EV_KEY, KEY_POWER, 0);
+		input_sync(pwrcdrv->input);
+	} else {
+		schedule_delayed_work(&pwrcdrv->work,
+			msecs_to_jiffies(PWRC_KEY_DETECT_UP_TIME));
+	}
+}
 
 static irqreturn_t sirfsoc_pwrc_isr(int irq, void *dev_id)
 {
@@ -34,21 +62,22 @@ static irqreturn_t sirfsoc_pwrc_isr(int irq, void *dev_id)
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
 
+static void sirfsoc_pwrc_stop_updetect(void *data)
+{
+	struct sirfsoc_pwrc_drvdata *pwrcdrv = data;
+
+	cancel_delayed_work_sync(&pwrcdrv->work);
+}
+
 static const struct of_device_id sirfsoc_pwrc_of_match[] = {
 	{ .compatible = "sirf,prima2-pwrc" },
 	{},
@@ -86,7 +115,9 @@ static int sirfsoc_pwrc_probe(struct platform_device *pdev)
 
 	pwrcdrv->input->name = "sirfsoc pwrckey";
 	pwrcdrv->input->phys = "pwrc/input0";
-	pwrcdrv->input->evbit[0] = BIT_MASK(EV_PWR);
+	pwrcdrv->input->evbit[0] = BIT_MASK(EV_KEY);
+
+	INIT_DELAYED_WORK(&pwrcdrv->work, sirfsoc_pwrc_report_event);
 
 	irq = platform_get_irq(pdev, 0);
 	error = devm_request_irq(&pdev->dev, irq,
@@ -98,6 +129,13 @@ static int sirfsoc_pwrc_probe(struct platform_device *pdev)
 		return error;
 	}
 
+	error = devm_add_action(&pdev->dev, sirfsoc_pwrc_stop_updetect, pwrcdrv);
+	if (error) {
+		dev_err(&pdev->dev, "failed to add stop untouch detection action, %d\n",
+			error);
+		return error;
+	}
+
 	sirfsoc_rtc_iobrg_writel(
 		sirfsoc_rtc_iobrg_readl(pwrcdrv->pwrc_base + PWRC_INT_MASK) |
 			PWRC_ON_KEY_BIT,
-- 
1.7.5.4

