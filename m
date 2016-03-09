From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 05/13] input: convert sun4i-ts to use
 devm_thermal_zone_of_sensor_register
Date: Wed, 9 Mar 2016 13:45:14 -0800
Message-ID: <20160309214514.GA18066@dtor-ws>
References: <1457559336-17652-1-git-send-email-edubezval@gmail.com>
 <1457559336-17652-6-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34147 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbcCIVpS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Mar 2016 16:45:18 -0500
Content-Disposition: inline
In-Reply-To: <1457559336-17652-6-git-send-email-edubezval@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Rui Zhang <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Sascha Hauer <s.hauer@pengutronix.de>, Jens Thiele <karme@karme.de>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Mar 09, 2016 at 01:35:27PM -0800, Eduardo Valentin wrote:
> This changes the driver to use the devm_ version
> of thermal_zone_of_sensor_register and cleans
> up the  local points and unregister calls.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Lukasz Majewski <l.majewski@samsung.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Jens Thiele <karme@karme.de>
> Cc: linux-input@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Eduardo Valentin <edubezval@gmail.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I guess it will make sense to merge through your tree unless you want to
hold off until after I merge winth mainline (around -rc3) assuming that
it even makes into 4.6.

Thanks.

> ---
>  drivers/input/touchscreen/sun4i-ts.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/touchscreen/sun4i-ts.c
> index 4857943..d07dd29 100644
> --- a/drivers/input/touchscreen/sun4i-ts.c
> +++ b/drivers/input/touchscreen/sun4i-ts.c
> @@ -115,7 +115,6 @@
>  struct sun4i_ts_data {
>  	struct device *dev;
>  	struct input_dev *input;
> -	struct thermal_zone_device *tz;
>  	void __iomem *base;
>  	unsigned int irq;
>  	bool ignore_fifo_data;
> @@ -366,10 +365,7 @@ static int sun4i_ts_probe(struct platform_device *pdev)
>  	if (IS_ERR(hwmon))
>  		return PTR_ERR(hwmon);
>  
> -	ts->tz = thermal_zone_of_sensor_register(ts->dev, 0, ts,
> -						 &sun4i_ts_tz_ops);
> -	if (IS_ERR(ts->tz))
> -		ts->tz = NULL;
> +	devm_thermal_zone_of_sensor_register(ts->dev, 0, ts, &sun4i_ts_tz_ops);
>  
>  	writel(TEMP_IRQ_EN(1), ts->base + TP_INT_FIFOC);
>  
> @@ -377,7 +373,6 @@ static int sun4i_ts_probe(struct platform_device *pdev)
>  		error = input_register_device(ts->input);
>  		if (error) {
>  			writel(0, ts->base + TP_INT_FIFOC);
> -			thermal_zone_of_sensor_unregister(ts->dev, ts->tz);
>  			return error;
>  		}
>  	}
> @@ -394,8 +389,6 @@ static int sun4i_ts_remove(struct platform_device *pdev)
>  	if (ts->input)
>  		input_unregister_device(ts->input);
>  
> -	thermal_zone_of_sensor_unregister(ts->dev, ts->tz);
> -
>  	/* Deactivate all IRQs */
>  	writel(0, ts->base + TP_INT_FIFOC);
>  
> -- 
> 2.1.4
> 

-- 
Dmitry
