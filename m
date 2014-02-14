From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] input: sirfsoc-onkey - report onkey untouch event by
 detecting pin status
Date: Thu, 13 Feb 2014 23:57:17 -0800
Message-ID: <20140214075717.GA14682@core.coreip.homeip.net>
References: <1392348001-4950-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:58383 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956AbaBNIZu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Feb 2014 03:25:50 -0500
Received: by mail-pd0-f170.google.com with SMTP id p10so11675242pdj.15
        for <linux-input@vger.kernel.org>; Fri, 14 Feb 2014 00:25:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1392348001-4950-1-git-send-email-21cnbao@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, workgroup.linux@csr.com, Xianglong Du <Xianglong.Du@csr.com>, Rongjun Ying <Rongjun.Ying@csr.com>, Barry Song <Baohua.Song@csr.com>

Hi Barry,

On Fri, Feb 14, 2014 at 11:20:01AM +0800, Barry Song wrote:
> From: Xianglong Du <Xianglong.Du@csr.com>
> 
> this patch adds a delayed_work to detect the untouch of onkey since HW will
> not generate interrupt for it.
> 
> at the same time, we move the KEY event to POWER instead of SUSPEND, which
> will be suitable for both Android and Linux. Userspace PowerManager Daemon
> will decide to suspend or shutdown based on how long we have touched onkey
> 
> Signed-off-by: Xianglong Du <Xianglong.Du@csr.com>
> Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  -v3: move to use custom devres action

Thank you for making the changes, however it seems that we can control
whether the device generates interrupts or not and so we can implement
open and close methods. If patch below works then your
cancel_delayed_work() call should go into sirfosc_pwrc_close() and we do
not need to use devm_free_irq() not custom action.

Thanks.

-- 
Dmitry


Input: sirfsoc-onkey - implement open and close methods

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

We can control whetehr device generates interrupts or not so let's
implement open and close methods of input device so that we do not do any
processing until there are users.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/sirfsoc-onkey.c |   50 +++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/drivers/input/misc/sirfsoc-onkey.c b/drivers/input/misc/sirfsoc-onkey.c
index e8897c3..dc7db65 100644
--- a/drivers/input/misc/sirfsoc-onkey.c
+++ b/drivers/input/misc/sirfsoc-onkey.c
@@ -49,6 +49,35 @@ static irqreturn_t sirfsoc_pwrc_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void sirfsoc_pwrc_toggle_interrupts(struct sirfsoc_pwrc_drvdata *pwrcdrv,
+					   bool enable)
+{
+	u32 int_mask;
+
+	int_mask = sirfsoc_rtc_iobrg_readl(pwrcdrv->pwrc_base + PWRC_INT_MASK);
+	if (enable)
+		int_mask |= PWRC_ON_KEY_BIT;
+	else
+		int_mask &= ~PWRC_ON_KEY_BIT;
+	sirfsoc_rtc_iobrg_writel(int_mask, pwrcdrv->pwrc_base + PWRC_INT_MASK);
+}
+
+static int sirfsoc_pwrc_open(struct input_dev *input)
+{
+	struct sirfsoc_pwrc_drvdata *pwrcdrv = input_get_drvdata(input);
+
+	sirfsoc_pwrc_toggle_interrupts(pwrcdrv, true);
+
+	return 0;
+}
+
+static void sirfsoc_pwrc_close(struct input_dev *input)
+{
+	struct sirfsoc_pwrc_drvdata *pwrcdrv = input_get_drvdata(input);
+
+	sirfsoc_pwrc_toggle_interrupts(pwrcdrv, false);
+}
+
 static const struct of_device_id sirfsoc_pwrc_of_match[] = {
 	{ .compatible = "sirf,prima2-pwrc" },
 	{},
@@ -70,7 +99,7 @@ static int sirfsoc_pwrc_probe(struct platform_device *pdev)
 	}
 
 	/*
-	 * we can't use of_iomap because pwrc is not mapped in memory,
+	 * We can't use of_iomap because pwrc is not mapped in memory,
 	 * the so-called base address is only offset in rtciobrg
 	 */
 	error = of_property_read_u32(np, "reg", &pwrcdrv->pwrc_base);
@@ -88,6 +117,11 @@ static int sirfsoc_pwrc_probe(struct platform_device *pdev)
 	pwrcdrv->input->phys = "pwrc/input0";
 	pwrcdrv->input->evbit[0] = BIT_MASK(EV_PWR);
 
+	pwrcdrv->input->open = sirfsoc_pwrc_open;
+	pwrcdrv->input->close = sirfsoc_pwrc_close;
+
+	input_set_drvdata(pwrcdrv->input, pwrcdrv);
+
 	irq = platform_get_irq(pdev, 0);
 	error = devm_request_irq(&pdev->dev, irq,
 				 sirfsoc_pwrc_isr, IRQF_SHARED,
@@ -98,11 +132,6 @@ static int sirfsoc_pwrc_probe(struct platform_device *pdev)
 		return error;
 	}
 
-	sirfsoc_rtc_iobrg_writel(
-		sirfsoc_rtc_iobrg_readl(pwrcdrv->pwrc_base + PWRC_INT_MASK) |
-			PWRC_ON_KEY_BIT,
-		pwrcdrv->pwrc_base + PWRC_INT_MASK);
-
 	error = input_register_device(pwrcdrv->input);
 	if (error) {
 		dev_err(&pdev->dev,
@@ -129,15 +158,16 @@ static int pwrc_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct sirfsoc_pwrc_drvdata *pwrcdrv = platform_get_drvdata(pdev);
+	struct input_dev *input = pwrcdrv->input;
 
 	/*
 	 * Do not mask pwrc interrupt as we want pwrc work as a wakeup source
 	 * if users touch X_ONKEY_B, see arch/arm/mach-prima2/pm.c
 	 */
-	sirfsoc_rtc_iobrg_writel(
-		sirfsoc_rtc_iobrg_readl(
-		pwrcdrv->pwrc_base + PWRC_INT_MASK) | PWRC_ON_KEY_BIT,
-		pwrcdrv->pwrc_base + PWRC_INT_MASK);
+	mutex_lock(&input->mutex);
+	if (input->users)
+		sirfsoc_pwrc_toggle_interrupts(pwrcdrv, true);
+	mutex_unlock(&input->mutex);
 
 	return 0;
 }
