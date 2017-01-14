From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 3/3] Input: pwm-beeper: add optional amplifier
 regulator
Date: Sat, 14 Jan 2017 11:19:43 -0800
Message-ID: <20170114191943.GC31309@dtor-ws>
References: <1484164921-30587-1-git-send-email-david@lechnology.com>
 <1484164921-30587-4-git-send-email-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1484164921-30587-4-git-send-email-david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, Jan 11, 2017 at 02:02:01PM -0600, David Lechner wrote:
> This adds an optional regulator to the pwm-beeper device. This regulator
> acts as an amplifier. The amplifier is only enabled while beeping in order
> to reduce power consumption.
> 
> Tested on LEGO MINDSTORMS EV3, which has a speaker connected to PWM through
> an amplifier.
> 
> Signed-off-by: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
> ---
>  drivers/input/misc/pwm-beeper.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
> index 30ac227..708e88e 100644
> --- a/drivers/input/misc/pwm-beeper.c
> +++ b/drivers/input/misc/pwm-beeper.c
> @@ -14,6 +14,7 @@
>   */
>  
>  #include <linux/input.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/of.h>
> @@ -25,8 +26,10 @@
>  struct pwm_beeper {
>  	struct input_dev *input;
>  	struct pwm_device *pwm;
> +	struct regulator *reg;
>  	struct work_struct work;
>  	unsigned long period;
> +	bool reg_enabled;
>  };
>  
>  #define HZ_TO_NANOSECONDS(x) (1000000000UL/(x))
> @@ -38,8 +41,20 @@ static void __pwm_beeper_set(struct pwm_beeper *beeper)
>  	if (period) {
>  		pwm_config(beeper->pwm, period / 2, period);
>  		pwm_enable(beeper->pwm);
> -	} else
> +		if (beeper->reg) {
> +			int error;
> +
> +			error = regulator_enable(beeper->reg);
> +			if (!error)
> +				beeper->reg_enabled = true;
> +		}
> +	} else {
> +		if (beeper->reg_enabled) {
> +			regulator_disable(beeper->reg);
> +			beeper->reg_enabled = false;
> +		}
>  		pwm_disable(beeper->pwm);
> +	}
>  }
>  
>  static void pwm_beeper_work(struct work_struct *work)
> @@ -82,6 +97,10 @@ static void pwm_beeper_stop(struct pwm_beeper *beeper)
>  {
>  	cancel_work_sync(&beeper->work);
>  
> +	if (beeper->reg_enabled) {
> +		regulator_disable(beeper->reg);
> +		beeper->reg_enabled = false;
> +	}
>  	if (beeper->period)
>  		pwm_disable(beeper->pwm);
>  }
> @@ -111,6 +130,14 @@ static int pwm_beeper_probe(struct platform_device *pdev)
>  		return error;
>  	}
>  
> +	beeper->reg = devm_regulator_get_optional(&pdev->dev, "amp");

If you do not use optional regulator then you will not have to check if
you have it or not everywhere: regulator core will give you a dummy that
you can toggle to your heart's content.

> +	error = PTR_ERR_OR_ZERO(beeper->reg);
> +	if (error) {
> +		if (error != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to get amp regulator\n");
> +		return error;
> +	}
> +
>  	/*
>  	 * FIXME: pwm_apply_args() should be removed when switching to
>  	 * the atomic PWM API.
> -- 
> 2.7.4
> 

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
