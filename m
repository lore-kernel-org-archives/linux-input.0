From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 2/2] Input: add wm97xx accelerated driver for AVR32 AT32AP700X
 microprocessors
Date: Mon, 02 Mar 2009 15:34:43 +0100
Message-ID: <49ABEE83.904@gmail.com>
References: <1236000228-13025-1-git-send-email-broonie@opensource.wolfsonmicro.com> <1236000228-13025-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:30563 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062AbZCBOes (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Mar 2009 09:34:48 -0500
In-Reply-To: <1236000228-13025-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Hans-Christian Egtvedt <hcegtvedt@atmel.com>

> --- /dev/null
> +++ b/drivers/input/touchscreen/at32-wm97xx.c
> +static void at32_wm97xx_pen_timer(unsigned long data)

Wouldn't be delayed_work more appropriate (and convenient) here?

> +{
> +	struct at32_wm97xx *at32_wm97xx = (struct at32_wm97xx *)data;
> +	struct wm97xx *wm = at32_wm97xx->wm;
> +	int pen_down = gpio_get_value(at32_wm97xx->gpio_pen);
> +
> +	if (pen_down != 0) {
> +		mod_timer(&at32_wm97xx->pen_timer, jiffies
> +				+ msecs_to_jiffies(1));
> +	} else {
> +		input_report_abs(wm->input_dev, ABS_PRESSURE, 0);
> +		input_sync(wm->input_dev);
> +	}
> +}

> +static int __init at32_wm97xx_probe(struct platform_device *pdev)
> +{
[...]
> +	at32_wm97xx->regs	= (void *)AT32_WM97XX_AC97C_IOMEM;

(void __iomem *)?
Did you feed it through sparse?

> +	ret = request_irq(at32_wm97xx->ac97c_irq,
> +			at32_wm97xx_channel_b_interrupt,
> +			IRQF_SHARED, "at32-wm97xx-ch-b", at32_wm97xx);
[...]
> +	return wm97xx_register_mach_ops(wm,&at32_mach_ops);

In case it fails, irq remains set up.

> +#ifdef CONFIG_PM
> +static int at32_wm97xx_suspend(struct platform_device *pdev, pm_message_t msg)
> +{
> +	struct at32_wm97xx *at32_wm97xx = platform_get_drvdata(pdev);
> +
> +	ac97c_writel(at32_wm97xx, IDR, AC97C_INT_CBEVT);
> +	disable_irq(at32_wm97xx->gpio_irq);

Here, you should call disable_irq_sync() (that's what I meant by _sync 
in the last post).
