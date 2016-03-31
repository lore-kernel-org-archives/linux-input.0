From: Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [PATCH v5 10/46] leds: pwm: use pwm_get_args() where appropriate
Date: Thu, 31 Mar 2016 09:13:26 +0200
Message-ID: <56FCCE16.8040200@samsung.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-11-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-reply-to: <1459368249-13241-11-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-doc-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kamil Debski <k.debski@samsung.com>, lm-sensors@lm-sensors.org, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, linux-leds@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com, Joachim Eastwood <manabian@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jon>
List-Id: linux-input@vger.kernel.org

Hi Boris,

On 03/30/2016 10:03 PM, Boris Brezillon wrote:
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
>   drivers/leds/leds-pwm.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
> index 4783bac..b48231c 100644
> --- a/drivers/leds/leds-pwm.c
> +++ b/drivers/leds/leds-pwm.c
> @@ -91,6 +91,7 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
>   		       struct led_pwm *led, struct device_node *child)
>   {
>   	struct led_pwm_data *led_data = &priv->leds[priv->num_leds];
> +	struct pwm_args pargs = { };
>   	int ret;
>
>   	led_data->active_low = led->active_low;
> @@ -117,7 +118,8 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
>   	else
>   		led_data->cdev.brightness_set_blocking = led_pwm_set_blocking;
>
> -	led_data->period = pwm_get_period(led_data->pwm);
> +	pwm_get_args(led_data->pwm, &pargs);
> +	led_data->period = pargs.period;
>   	if (!led_data->period && (led->pwm_period_ns > 0))
>   		led_data->period = led->pwm_period_ns;
>
>

Acked-by: Jacek Anaszewski <j.anaszewski@samsung.com>

-- 
Best regards,
Jacek Anaszewski
