From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 36/46] input: misc: max77693: switch to the atomic API
Date: Thu, 31 Mar 2016 10:48:01 -0700
Message-ID: <20160331174801.GC39098@dtor-ws>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-37-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459368249-13241-37-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-leds-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kamil Debski <k.debski@samsung.com>, lm-sensors@lm-sensors.org, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, linux-input@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com, Joachim Eastwood <manabian@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jo>
List-Id: linux-input@vger.kernel.org

Hi Boris,

On Wed, Mar 30, 2016 at 10:03:59PM +0200, Boris Brezillon wrote:
> pwm_config/enable/disable() have been deprecated and should be replaced
> by pwm_apply_state().
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/input/misc/max77693-haptic.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/misc/max77693-haptic.c b/drivers/input/misc/max77693-haptic.c
> index cf6aac0..aef7dc4 100644
> --- a/drivers/input/misc/max77693-haptic.c
> +++ b/drivers/input/misc/max77693-haptic.c
> @@ -70,13 +70,16 @@ struct max77693_haptic {
>  
>  static int max77693_haptic_set_duty_cycle(struct max77693_haptic *haptic)
>  {
> +	struct pwm_state pstate;
>  	struct pwm_args pargs = { };
> -	int delta;
>  	int error;
>  
>  	pwm_get_args(haptic->pwm_dev, &pargs);
> -	delta = (pargs.period + haptic->pwm_duty) / 2;
> -	error = pwm_config(haptic->pwm_dev, delta, pargs.period);
> +	pwm_get_state(haptic->pwm_dev, &pstate);
> +
> +	pstate.period = pargs.period;
> +	pstate.duty_cycle = (pargs.period + haptic->pwm_duty) / 2;
> +	error = pwm_apply_state(haptic->pwm_dev, &pstate);

This does not make sense with regard to the atomic API. If you look in
max77693_haptic_play_work(), right after calling
max77693_haptic_set_duty_cycle() we either try to enable or disable the
pwm. When switching to this new API we should combine both actions.

>  	if (error) {
>  		dev_err(haptic->dev, "failed to configure pwm: %d\n", error);
>  		return error;
> @@ -161,12 +164,16 @@ static int max77693_haptic_lowsys(struct max77693_haptic *haptic, bool enable)
>  
>  static void max77693_haptic_enable(struct max77693_haptic *haptic)
>  {
> +	struct pwm_state pstate;
>  	int error;
>  
>  	if (haptic->enabled)
>  		return;
>  
> -	error = pwm_enable(haptic->pwm_dev);
> +	pwm_get_state(haptic->pwm_dev, &pstate);
> +	pstate.enabled = true;
> +
> +	error = pwm_apply_state(haptic->pwm_dev, &pstate);

As I mentioned I'd rather we did not deprecate pwm_enable() and
pwm_disable() (and maybe others), as it forces us to add unnecessary
boilerplate code to the drivers.
 
>  	if (error) {
>  		dev_err(haptic->dev,
>  			"failed to enable haptic pwm device: %d\n", error);
> @@ -188,11 +195,13 @@ static void max77693_haptic_enable(struct max77693_haptic *haptic)
>  err_enable_config:
>  	max77693_haptic_lowsys(haptic, false);
>  err_enable_lowsys:
> -	pwm_disable(haptic->pwm_dev);
> +	pstate.enabled = false;
> +	pwm_apply_state(haptic->pwm_dev, &pstate);
>  }
>  
>  static void max77693_haptic_disable(struct max77693_haptic *haptic)
>  {
> +	struct pwm_state pstate;
>  	int error;
>  
>  	if (!haptic->enabled)
> @@ -206,7 +215,9 @@ static void max77693_haptic_disable(struct max77693_haptic *haptic)
>  	if (error)
>  		goto err_disable_lowsys;
>  
> -	pwm_disable(haptic->pwm_dev);
> +	pwm_get_state(haptic->pwm_dev, &pstate);
> +	pstate.enabled = false;
> +	pwm_apply_state(haptic->pwm_dev, &pstate);

Same here.

>  	haptic->enabled = false;
>  
>  	return;
> -- 
> 2.5.0
> 

Thanks.

-- 
Dmitry
