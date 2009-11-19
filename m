From: Shine Liu <shinel@foxmail.com>
Subject: Re: [patch 1/1] TOUCHSCREEN: S3C24XX touchscreen driver from
 Arnaud Patard.
Date: Thu, 19 Nov 2009 13:46:55 +0800
Message-ID: <1258609615.2676.31.camel@shinel>
References: <20091118232939.201290297@fluff.org.uk>
	 <20091118232948.063635416@fluff.org.uk>
Reply-To: shinel@foxmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtpbg72.qq.com ([119.147.10.231]:38011 "HELO smtpbg72.qq.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751298AbZKSFrk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Nov 2009 00:47:40 -0500
In-Reply-To: <20091118232948.063635416@fluff.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Dooks <ben@simtec.co.uk>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnaud Patard <arnaud.patard@rtp-net.org>, Simtec Linux Team <linux@simtec.co.uk>

Hi,Ben

Besides Dmitry's comments,

On Wed, 2009-11-18 at 23:29 +0000, Ben Dooks wrote:

> +config TOUCHSCREEN_S3C2410
> +       tristate "Samsung S3C2410 touchscreen input driver"
> +       depends on ARCH_S3C2410 && INPUT && INPUT_TOUCHSCREEN
> +       select SERIO
> +       help
> +         Say Y here if you have the s3c2410 touchscreen.
> +
> +         If unsure, say N.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called s3c2410_ts.

S3C24XX_ADC should be added to the depends.

> +#include <linux/slab.h>

I think this is not really needed because kernel.h is included already.


> +
> +	ts.clock = clk_get(dev, "adc");
> +	if (IS_ERR(ts.clock)) {
> +		dev_err(dev, "cannot get adc clock source\n");
> +		return -ENOENT;
> +	}
> +
> +	clk_enable(ts.clock);
> +	dev_dbg(dev, "got and enabled clocks\n");

Well, we take 2410_ts as s3c adc client, so these work has been done in
s3c_adc_probe function of arch/arm/plat-s3c24xx.c

This should be duplicated.

And "#include <linux/clk.h>" is not needed because we don't use these
APIs


> + err_clk:
> +       clk_put(ts.clock);
> +       return ret;
> +}

Above reason and also for those "goto err_clk;"

> );
> +
> +	clk_disable(ts.clock);
> +	clk_put(ts.clock);

Same as above

> +
> +#ifdef CONFIG_PM
> +static int s3c2410ts_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	writel(TSC_SLEEP, ts.io + S3C2410_ADCTSC);
> +	disable_irq(ts.irq_tc);

Same as above

> +
> +static int s3c2410ts_resume(struct platform_device *pdev)
> +{
> +	struct s3c2410_ts_mach_info *info = pdev->dev.platform_data;
> +
> +	clk_enable(ts.clock);

Same as above


Cheers,

Shine


