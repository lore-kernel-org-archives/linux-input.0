From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v5 26/46] pwm: sun4i: implement hardware readout
Date: Thu, 31 Mar 2016 10:00:33 +0200
Message-ID: <20160331080033.GR2346@piout.net>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-27-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDS7HNEFSALRBJFS6O3QKGQEEKYFEYY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <1459368249-13241-27-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jingoo
List-Id: linux-input@vger.kernel.org

On 30/03/2016 at 22:03:49 +0200, Boris Brezillon wrote :
> Implement ->get_state() instead of only initializing the polarity in
> the probe function.
> 
> This implementation also takes care of keeping the PWM clk enabled if at
> least one of the PWM exported by the PWM chip is already enabled, which
> should prevent glitches.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Reviewed-by: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

> ---
>  drivers/pwm/pwm-sun4i.c | 74 ++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 55 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 03a99a5..34cb296 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -252,11 +252,65 @@ static void sun4i_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>  	clk_disable_unprepare(sun4i_pwm->clk);
>  }
>  
> +static void sun4i_pwm_get_state(struct pwm_chip *chip,
> +				struct pwm_device *pwm,
> +				struct pwm_state *pstate)
> +{
> +	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
> +	unsigned int clk_rate = clk_get_rate(sun4i_pwm->clk);
> +	int prescaler, prescalerid;
> +	int ret;
> +	u32 val;
> +
> +	ret = clk_prepare_enable(sun4i_pwm->clk);
> +	if (ret) {
> +		dev_err(chip->dev, "Failed to enable PWM clock");
> +		return;
> +	}
> +
> +	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> +	if (val & BIT_CH(PWM_ACT_STATE, pwm->hwpwm))
> +		pstate->polarity = PWM_POLARITY_INVERSED;
> +	else
> +		pstate->polarity = PWM_POLARITY_NORMAL;
> +
> +	if ((val & BIT_CH(PWM_EN, pwm->hwpwm)) &&
> +	    (val & BIT_CH(PWM_CLK_GATING, pwm->hwpwm)))
> +		pstate->enabled = true;
> +	else
> +		pstate->enabled = false;
> +
> +	pstate->period = 0;
> +	pstate->duty_cycle = 0;
> +	prescalerid = (val >> (PWMCH_OFFSET * pwm->hwpwm)) & PWM_PRESCAL_MASK;
> +	prescaler = prescaler_table[prescalerid];
> +	if (prescaler) {
> +		u64 timens;
> +
> +		clk_rate /= prescaler;
> +
> +		val = sun4i_pwm_readl(sun4i_pwm, PWM_CH_PRD(pwm->hwpwm));
> +
> +		timens = ((val >> 16) & PWM_PRD_MASK) + 1;
> +		timens *= NSEC_PER_SEC;
> +		do_div(timens, clk_rate);
> +		pstate->period = timens;
> +
> +		timens = val & PWM_DTY_MASK;
> +		timens *= NSEC_PER_SEC;
> +		do_div(timens, clk_rate);
> +		pstate->duty_cycle = timens;
> +	}
> +
> +	clk_disable_unprepare(sun4i_pwm->clk);
> +}
> +
>  static const struct pwm_ops sun4i_pwm_ops = {
>  	.config = sun4i_pwm_config,
>  	.set_polarity = sun4i_pwm_set_polarity,
>  	.enable = sun4i_pwm_enable,
>  	.disable = sun4i_pwm_disable,
> +	.get_state = sun4i_pwm_get_state,
>  	.owner = THIS_MODULE,
>  };
>  
> @@ -307,8 +361,7 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
>  {
>  	struct sun4i_pwm_chip *pwm;
>  	struct resource *res;
> -	u32 val;
> -	int i, ret;
> +	int ret;
>  	const struct of_device_id *match;
>  
>  	match = of_match_device(sun4i_pwm_dt_ids, &pdev->dev);
> @@ -345,24 +398,7 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, pwm);
>  
> -	ret = clk_prepare_enable(pwm->clk);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to enable PWM clock\n");
> -		goto clk_error;
> -	}
> -
> -	val = sun4i_pwm_readl(pwm, PWM_CTRL_REG);
> -	for (i = 0; i < pwm->chip.npwm; i++)
> -		if (!(val & BIT_CH(PWM_ACT_STATE, i)))
> -			pwm_set_polarity(&pwm->chip.pwms[i],
> -					 PWM_POLARITY_INVERSED);
> -	clk_disable_unprepare(pwm->clk);
> -
>  	return 0;
> -
> -clk_error:
> -	pwmchip_remove(&pwm->chip);
> -	return ret;
>  }
>  
>  static int sun4i_pwm_remove(struct platform_device *pdev)
> -- 
> 2.5.0
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
