From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 3/3] keyboard: imx_keypad: Check error returned by
 clk_prepare_enable()
Date: Fri, 6 Jul 2012 11:34:36 -0700
Message-ID: <20120706183436.GA31613@core.coreip.homeip.net>
References: <1341596514-15972-1-git-send-email-fabio.estevam@freescale.com>
 <1341596514-15972-3-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46808 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700Ab2GFSem (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Jul 2012 14:34:42 -0400
Received: by pbbrp8 with SMTP id rp8so14997212pbb.19
        for <linux-input@vger.kernel.org>; Fri, 06 Jul 2012 11:34:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1341596514-15972-3-git-send-email-fabio.estevam@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: kernel@pengutronix.de, linux-input@vger.kernel.org

On Fri, Jul 06, 2012 at 02:41:54PM -0300, Fabio Estevam wrote:
> Check error returned by clk_prepare_enable().
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/input/keyboard/imx_keypad.c |   17 +++++++++++++----
>  1 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
> index 4830615..bdb8ee7 100644
> --- a/drivers/input/keyboard/imx_keypad.c
> +++ b/drivers/input/keyboard/imx_keypad.c
> @@ -385,13 +385,17 @@ static int imx_keypad_open(struct input_dev *dev)
>  {
>  	struct imx_keypad *keypad = input_get_drvdata(dev);
>  
> +	int ret;
>  	dev_dbg(&dev->dev, ">%s\n", __func__);
>  
>  	/* We became active from now */
>  	keypad->enabled = true;
>  
>  	/* Enable the kpp clock */
> -	clk_prepare_enable(keypad->clk);
> +	ret = clk_prepare_enable(keypad->clk);
> +	if (ret)
> +		return ret;
> +

That would leave "keypad->enabled = true" if clk_prepare_enable() fails.
You need something like below.

Thanks.

-- 
Dmitry

Input: imx_keypad - check error returned by clk_prepare_enable()

From: Fabio Estevam <fabio.estevam@freescale.com>

Check error returned by clk_prepare_enable().

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

 drivers/input/keyboard/imx_keypad.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)


diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index 4830615..ff4c0a8 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -384,14 +384,18 @@ static void imx_keypad_close(struct input_dev *dev)
 static int imx_keypad_open(struct input_dev *dev)
 {
 	struct imx_keypad *keypad = input_get_drvdata(dev);
+	int error;
 
 	dev_dbg(&dev->dev, ">%s\n", __func__);
 
+	/* Enable the kpp clock */
+	error = clk_prepare_enable(keypad->clk);
+	if (error)
+		return error;
+
 	/* We became active from now */
 	keypad->enabled = true;
 
-	/* Enable the kpp clock */
-	clk_prepare_enable(keypad->clk);
 	imx_keypad_config(keypad);
 
 	/* Sanity control, not all the rows must be actived now. */
@@ -596,18 +600,23 @@ static int imx_kbd_resume(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct imx_keypad *kbd = platform_get_drvdata(pdev);
 	struct input_dev *input_dev = kbd->input_dev;
+	int ret = 0;
 
 	if (device_may_wakeup(&pdev->dev))
 		disable_irq_wake(kbd->irq);
 
 	mutex_lock(&input_dev->mutex);
 
-	if (input_dev->users)
-		clk_prepare_enable(kbd->clk);
+	if (input_dev->users) {
+		ret = clk_prepare_enable(kbd->clk);
+		if (ret)
+			goto err_clk;
+	}
 
+err_clk:
 	mutex_unlock(&input_dev->mutex);
 
-	return 0;
+	return ret;
 }
 #endif
 
