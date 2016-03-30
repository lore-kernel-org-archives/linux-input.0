From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 08/46] hwmon: pwm-fan: use pwm_get_args() where
 appropriate
Date: Wed, 30 Mar 2016 15:52:44 -0700
Message-ID: <20160330225244.GA24044@roeck-us.net>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-9-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459368249-13241-9-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-clk-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kamil Debski <k.debski@samsung.com>, lm-sensors@lm-sensors.org, Jean Delvare <jdelvare@suse.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com, Joachim Eastwood <manabian@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Jingoo Han <jingoohan1@gmail.com>, Lee
List-Id: linux-input@vger.kernel.org

On Wed, Mar 30, 2016 at 10:03:31PM +0200, Boris Brezillon wrote:
> The PWM framework has clarified the concept of reference PWM config
> (the platform dependent config retrieved from the DT or the PWM
> lookup table) and real PWM state.
> 
> Use pwm_get_args() when the PWM user wants to retrieve this reference
> config and not the current state.
> 
> This is part of the rework allowing the PWM framework to support
> hardware readout and expose real PWM state even when the PWM has
> just been requested (before the user calls pwm_config/enable/disable()).
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/hwmon/pwm-fan.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index 3e23003..82c5656 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -40,15 +40,18 @@ struct pwm_fan_ctx {
>  
>  static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
>  {
> +	struct pwm_args pargs = { };

Hi Boris,

I guess I am missing some context; sorry for that. Unfortunately,
I did not easily find an explanation, so please bear with me.

Two questions: Why do we need a local copy of struct pwm_args instead
of a pointer to it ? If it can change while being used, isn't it
inconsistent anyway ?

Also, assuming the local copy is necessary, why initialize pargs ? 
After all, pwm_get_args() just overwrites it.

Thanks,
Guenter

>  	unsigned long duty;
>  	int ret = 0;
>  
> +	pwm_get_args(ctx->pwm, &pargs);
> +
>  	mutex_lock(&ctx->lock);
>  	if (ctx->pwm_value == pwm)
>  		goto exit_set_pwm_err;
>  
> -	duty = DIV_ROUND_UP(pwm * (ctx->pwm->period - 1), MAX_PWM);
> -	ret = pwm_config(ctx->pwm, duty, ctx->pwm->period);
> +	duty = DIV_ROUND_UP(pwm * (pargs.period - 1), MAX_PWM);
> +	ret = pwm_config(ctx->pwm, duty, pargs.period);
>  	if (ret)
>  		goto exit_set_pwm_err;
>  
> @@ -214,6 +217,7 @@ static int pwm_fan_of_get_cooling_data(struct device *dev,
>  static int pwm_fan_probe(struct platform_device *pdev)
>  {
>  	struct thermal_cooling_device *cdev;
> +	struct pwm_args pargs = { };
>  	struct pwm_fan_ctx *ctx;
>  	struct device *hwmon;
>  	int duty_cycle;
> @@ -234,10 +238,11 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, ctx);
>  
>  	/* Set duty cycle to maximum allowed */
> -	duty_cycle = ctx->pwm->period - 1;
> +	pwm_get_args(ctx->pwm, &pargs);
> +	duty_cycle = pargs.period - 1;
>  	ctx->pwm_value = MAX_PWM;
>  
> -	ret = pwm_config(ctx->pwm, duty_cycle, ctx->pwm->period);
> +	ret = pwm_config(ctx->pwm, duty_cycle, pargs.period);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to configure PWM\n");
>  		return ret;
> @@ -303,14 +308,16 @@ static int pwm_fan_suspend(struct device *dev)
>  static int pwm_fan_resume(struct device *dev)
>  {
>  	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
> +	struct pwm_args pargs = { };
>  	unsigned long duty;
>  	int ret;
>  
>  	if (ctx->pwm_value == 0)
>  		return 0;
>  
> -	duty = DIV_ROUND_UP(ctx->pwm_value * (ctx->pwm->period - 1), MAX_PWM);
> -	ret = pwm_config(ctx->pwm, duty, ctx->pwm->period);
> +	pwm_get_args(ctx->pwm, &pargs);
> +	duty = DIV_ROUND_UP(ctx->pwm_value * (pargs.period - 1), MAX_PWM);
> +	ret = pwm_config(ctx->pwm, duty, pargs.period);
>  	if (ret)
>  		return ret;
>  	return pwm_enable(ctx->pwm);
> -- 
> 2.5.0
> 
