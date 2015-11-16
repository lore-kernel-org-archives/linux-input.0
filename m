From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4 13/24] hwmon: pwm-fan: use pwm_get/set_default_xxx()
 helpers where appropriate
Date: Mon, 16 Nov 2015 08:00:54 -0800
Message-ID: <5649FDB6.9070305@roeck-us.net>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
 <1447664207-24370-14-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:53404 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051AbbKPQBB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Nov 2015 11:01:01 -0500
In-Reply-To: <1447664207-24370-14-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kamil Debski <k.debski@samsung.com>, lm-sensors@lm-sensors.org, Jean Delvare <jdelvare@suse.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com, Joachim Eastwood <manabian@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-fbdev@vger.kernel.org, Jean-Christophe

On 11/16/2015 12:56 AM, Boris Brezillon wrote:
> pwm_set/get_default_xxx() helpers have been introduced to differentiate
> the default PWM states (those retrieved through DT, PWM lookup table or
> statically assigned by the driver) and the current ones.
> Make use of those helpers where appropriate.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>   drivers/hwmon/pwm-fan.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index 105b964..989d7b4 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -47,8 +47,9 @@ static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
>   	if (ctx->pwm_value == pwm)
>   		goto exit_set_pwm_err;
>
> -	duty = DIV_ROUND_UP(pwm * (pwm_get_period((ctx->pwm)) - 1), MAX_PWM);
> -	ret = pwm_config(ctx->pwm, duty, pwm_get_period((ctx->pwm)));
> +	duty = DIV_ROUND_UP(pwm * (pwm_get_default_period((ctx->pwm)) - 1),
> +			    MAX_PWM);
> +	ret = pwm_config(ctx->pwm, duty, pwm_get_default_period((ctx->pwm)));

Same here - please no unnecessary ( ) [ which were first introduced by
the other patch ].

Guenter

>   	if (ret)
>   		goto exit_set_pwm_err;
>
> @@ -234,10 +235,11 @@ static int pwm_fan_probe(struct platform_device *pdev)
>   	platform_set_drvdata(pdev, ctx);
>
>   	/* Set duty cycle to maximum allowed */
> -	duty_cycle = pwm_get_period((ctx->pwm)) - 1;
> +	duty_cycle = pwm_get_default_period((ctx->pwm)) - 1;
>   	ctx->pwm_value = MAX_PWM;
>
> -	ret = pwm_config(ctx->pwm, duty_cycle, pwm_get_period((ctx->pwm)));
> +	ret = pwm_config(ctx->pwm, duty_cycle,
> +			 pwm_get_default_period((ctx->pwm)));
>   	if (ret) {
>   		dev_err(&pdev->dev, "Failed to configure PWM\n");
>   		return ret;
> @@ -309,9 +311,10 @@ static int pwm_fan_resume(struct device *dev)
>   	if (ctx->pwm_value == 0)
>   		return 0;
>
> -	duty = DIV_ROUND_UP(ctx->pwm_value * (pwm_get_period((ctx->pwm)) - 1),
> +	duty = DIV_ROUND_UP(ctx->pwm_value *
> +			    (pwm_get_default_period((ctx->pwm)) - 1),
>   			    MAX_PWM);
> -	ret = pwm_config(ctx->pwm, duty, pwm_get_period((ctx->pwm)));
> +	ret = pwm_config(ctx->pwm, duty, pwm_get_default_period((ctx->pwm)));
>   	if (ret)
>   		return ret;
>   	return pwm_enable(ctx->pwm);
>

