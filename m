From: Shine Liu <liuxian@redflag-linux.com>
Subject: Re: [patch 1/1] TOUCHSCREEN: S3C24XX touchscreen driver from
 Arnaud Patard.
Date: Thu, 19 Nov 2009 14:15:31 +0800
Message-ID: <1258611331.2676.53.camel@shinel>
References: <20091118232939.201290297@fluff.org.uk>
	 <20091118232948.063635416@fluff.org.uk>
	 <20091119025930.GA20172@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.redflag-linux.com ([219.237.229.196]:37617 "EHLO
	mail.redflag-linux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbZKSGhi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Nov 2009 01:37:38 -0500
In-Reply-To: <20091119025930.GA20172@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Dooks <ben@simtec.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnaud Patard <arnaud.patard@rtp-net.org>, Simtec Linux Team <linux@simtec.co.uk>

Hi Ben,

On Wed, 2009-11-18 at 18:59 -0800, Dmitry Torokhov wrote:

> > +#ifdef CONFIG_PM
> > +static int s3c2410ts_suspend(struct platform_device *pdev, pm_message_t state)
> > +{
> > +	writel(TSC_SLEEP, ts.io + S3C2410_ADCTSC);
> > +	disable_irq(ts.irq_tc);
> > +	clk_disable(ts.clock);
> > +
> > +	return 0;
> > +}
> > +
> > +static int s3c2410ts_resume(struct platform_device *pdev)
> > +{
> > +	struct s3c2410_ts_mach_info *info = pdev->dev.platform_data;
> > +
> > +	clk_enable(ts.clock);
> > +
> > +	/* Initialise registers */
> > +	if ((info->delay & 0xffff) > 0)
> > +		writel(info->delay & 0xffff, ts.io + S3C2410_ADCDLY);
> > +
> > +	writel(WAIT4INT | INT_DOWN, ts.io + S3C2410_ADCTSC);
> > +
> > +	return 0;
> > +}
> > +
> > +#else
> > +#define s3c2410ts_suspend NULL
> > +#define s3c2410ts_resume  NULL
> > +#endif
> > +
> > +static struct platform_device_id s3cts_driver_ids[] = {
> > +	{ "s3c2410-ts", 0 },
> > +	{ "s3c2440-ts", 1 },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(platform, s3cts_driver_ids);
> > +
> > +static struct platform_driver s3c_ts_driver = {
> > +	.driver         = {
> > +		.name   = "s3c24xx-ts",
> > +		.owner  = THIS_MODULE,
> > +	},
> > +	.id_table	= s3cts_driver_ids,
> > +	.probe		= s3c2410ts_probe,
> > +	.remove		= s3c2410ts_remove,
> 
> __devexit_p()
> 
> > +	.suspend	= s3c2410ts_suspend,
> > +	.resume		= s3c2410ts_resume,
> 
> Switch to pm_ops.

For these comments from Dmitry I have implemented in my patch last month
send to linux-input. You can refer
http://patchwork.kernel.org/patch/54933/ which maybe save some time for
you.


Regards,

Shine Liu


