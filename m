From: Anson Huang <anson.huang@nxp.com>
Subject: RE: [RESEND] input: keyboard: imx: make sure keyboard can always wake
 up system
Date: Thu, 25 Apr 2019 01:49:39 +0000
Message-ID: <DB3PR0402MB39167BC7D996F4FF70B5DD2FF53D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1554341727-16084-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1554341727-16084-1-git-send-email-Anson.Huang@nxp.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-input@vger.kernel.org

Gentle ping...

> -----Original Message-----
> From: Anson Huang
> Sent: Thursday, April 4, 2019 9:40 AM
> To: dmitry.torokhov@gmail.com; shawnguo@kernel.org;
> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> linux-input@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Cc: dl-linux-imx <linux-imx@nxp.com>
> Subject: [RESEND] input: keyboard: imx: make sure keyboard can always
> wake up system
> 
> There are several scenarios that keyboard can NOT wake up system from
> suspend, e.g., if a keyboard is depressed between system device suspend
> phase and device noirq suspend phase, the keyboard ISR will be called and
> both keyboard depress and release interrupts will be disabled, then
> keyboard will no longer be able to wake up system. Another scenario would
> be, if a keyboard is kept depressed, and then system goes into suspend, the
> expected behavior would be when keyboard is released, system will be
> waked up, but current implementation can NOT achieve that, because both
> depress and release interrupts are disabled in ISR, and the event check is still
> in progress.
> 
> To fix these issues, need to make sure keyboard's depress or release
> interrupt is enabled after noirq device suspend phase, this patch moves the
> suspend/resume callback to noirq suspend/resume phase, and enable the
> corresponding interrupt according to current keyboard status.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/input/keyboard/imx_keypad.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/keyboard/imx_keypad.c
> b/drivers/input/keyboard/imx_keypad.c
> index cf08f4a..97500a2 100644
> --- a/drivers/input/keyboard/imx_keypad.c
> +++ b/drivers/input/keyboard/imx_keypad.c
> @@ -524,11 +524,12 @@ static int imx_keypad_probe(struct
> platform_device *pdev)
>  	return 0;
>  }
> 
> -static int __maybe_unused imx_kbd_suspend(struct device *dev)
> +static int __maybe_unused imx_kbd_noirq_suspend(struct device *dev)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct imx_keypad *kbd = platform_get_drvdata(pdev);
>  	struct input_dev *input_dev = kbd->input_dev;
> +	unsigned short reg_val = readw(kbd->mmio_base + KPSR);
> 
>  	/* imx kbd can wake up system even clock is disabled */
>  	mutex_lock(&input_dev->mutex);
> @@ -538,13 +539,20 @@ static int __maybe_unused
> imx_kbd_suspend(struct device *dev)
> 
>  	mutex_unlock(&input_dev->mutex);
> 
> -	if (device_may_wakeup(&pdev->dev))
> +	if (device_may_wakeup(&pdev->dev)) {
> +		if (reg_val & KBD_STAT_KPKD)
> +			reg_val |= KBD_STAT_KRIE;
> +		if (reg_val & KBD_STAT_KPKR)
> +			reg_val |= KBD_STAT_KDIE;
> +		writew(reg_val, kbd->mmio_base + KPSR);
> +
>  		enable_irq_wake(kbd->irq);
> +	}
> 
>  	return 0;
>  }
> 
> -static int __maybe_unused imx_kbd_resume(struct device *dev)
> +static int __maybe_unused imx_kbd_noirq_resume(struct device *dev)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct imx_keypad *kbd = platform_get_drvdata(pdev); @@ -568,7
> +576,9 @@ static int __maybe_unused imx_kbd_resume(struct device *dev)
>  	return ret;
>  }
> 
> -static SIMPLE_DEV_PM_OPS(imx_kbd_pm_ops, imx_kbd_suspend,
> imx_kbd_resume);
> +static const struct dev_pm_ops imx_kbd_pm_ops = {
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(imx_kbd_noirq_suspend,
> +imx_kbd_noirq_resume) };
> 
>  static struct platform_driver imx_keypad_driver = {
>  	.driver		= {
> --
> 2.7.4
