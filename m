From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH] ARM: S3C64XX: Add s3c64xx support to touchscreen driver
Date: Fri, 7 May 2010 01:40:30 +0100
Message-ID: <20100507004030.GX2589@trinity.fluff.org>
References: <4BE290E5.9050703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4BE290E5.9050703@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Maurus Cuelenaere <mcuelenaere@gmail.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, arnaud.patard@rtp-net.org, ben-linux@fluff.org
List-Id: linux-input@vger.kernel.org

On Thu, May 06, 2010 at 11:50:29AM +0200, Maurus Cuelenaere wrote:
> Add support for the s3c64xx touchscreen to the s3c2410_ts driver,
> ensuring it compiles and supports the extra features such as the
> interrupt generation.
> 
> Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
Acked-by: Ben Dooks <ben-linux@fluff.org>
> ---
>  drivers/input/touchscreen/Kconfig      |    6 +++---
>  drivers/input/touchscreen/s3c2410_ts.c |   26 ++++++++++++++++++++++----
>  2 files changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 8a8fa4d..be8e9ba 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -158,11 +158,11 @@ config TOUCHSCREEN_FUJITSU
>  	  module will be called fujitsu-ts.
>  
>  config TOUCHSCREEN_S3C2410
> -	tristate "Samsung S3C2410 touchscreen input driver"
> -	depends on ARCH_S3C2410
> +	tristate "Samsung S3C touchscreen input driver"
> +	depends on ARCH_S3C2410 || ARCH_S3C64XX
>  	select S3C24XX_ADC
>  	help
> -	  Say Y here if you have the s3c2410 touchscreen.
> +	  Say Y here if you have the s3c touchscreen.
>  
>  	  If unsure, say N.
>  
> diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
> index 98a7d12..66d1c83 100644
> --- a/drivers/input/touchscreen/s3c2410_ts.c
> +++ b/drivers/input/touchscreen/s3c2410_ts.c
> @@ -87,6 +87,12 @@ struct s3c2410ts {
>  
>  static struct s3c2410ts ts;
>  
> +enum s3c_cpu_type {
> +	TYPE_S3C2410,
> +	TYPE_S3C2440,
> +	TYPE_S3C64XX,
> +};
> +
>  /**
>   * s3c2410_ts_connect - configure gpio for s3c2410 systems
>   *
> @@ -96,10 +102,14 @@ static struct s3c2410ts ts;
>  */
>  static inline void s3c2410_ts_connect(void)
>  {
> +#ifdef PLAT_S3C24XX
> +	/* As s3c2410_gpio_cfgpin() isn't defined for non-s3c24xx builds,
> +	   guard these with an ifdef. */
>  	s3c2410_gpio_cfgpin(S3C2410_GPG(12), S3C2410_GPG12_XMON);
>  	s3c2410_gpio_cfgpin(S3C2410_GPG(13), S3C2410_GPG13_nXPON);
>  	s3c2410_gpio_cfgpin(S3C2410_GPG(14), S3C2410_GPG14_YMON);
>  	s3c2410_gpio_cfgpin(S3C2410_GPG(15), S3C2410_GPG15_nYPON);
> +#endif
>  }
>  
>  /**
> @@ -170,6 +180,7 @@ static DEFINE_TIMER(touch_timer, touch_timer_fire, 0, 0);
>   */
>  static irqreturn_t stylus_irq(int irq, void *dev_id)
>  {
> +	struct platform_device *pdev = to_platform_device(ts.dev);
>  	unsigned long data0;
>  	unsigned long data1;
>  	bool down;
> @@ -188,6 +199,12 @@ static irqreturn_t stylus_irq(int irq, void *dev_id)
>  	else
>  		dev_info(ts.dev, "%s: count=%d\n", __func__, ts.count);
>  
> +
> +	if (platform_get_device_id(pdev)->driver_data == TYPE_S3C64XX) {
> +		/* Clear pen down/up interrupt */
> +		writel(0x0, ts.io + S3C64XX_ADCCLRINTPNDNUP);
> +	}
> +
>  	return IRQ_HANDLED;
>  }
>  
> @@ -297,7 +314,7 @@ static int __devinit s3c2410ts_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Configure the touchscreen external FETs on the S3C2410 */
> -	if (!platform_get_device_id(pdev)->driver_data)
> +	if (platform_get_device_id(pdev)->driver_data == TYPE_S3C2410)
>  		s3c2410_ts_connect();
>  
>  	ts.client = s3c_adc_register(pdev, s3c24xx_ts_select,
> @@ -420,15 +437,16 @@ static struct dev_pm_ops s3c_ts_pmops = {
>  #endif
>  
>  static struct platform_device_id s3cts_driver_ids[] = {
> -	{ "s3c2410-ts", 0 },
> -	{ "s3c2440-ts", 1 },
> +	{ "s3c2410-ts", TYPE_S3C2410 },
> +	{ "s3c2440-ts", TYPE_S3C2440 },
> +	{ "s3c64xx-ts", TYPE_S3C64XX },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(platform, s3cts_driver_ids);
>  
>  static struct platform_driver s3c_ts_driver = {
>  	.driver         = {
> -		.name   = "s3c24xx-ts",
> +		.name   = "s3c-ts",
>  		.owner  = THIS_MODULE,
>  #ifdef CONFIG_PM
>  		.pm	= &s3c_ts_pmops,
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
