From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 32/46] pwm: deprecate pwm_config(), pwm_enable() and
 pwm_disable()
Date: Thu, 31 Mar 2016 10:38:58 -0700
Message-ID: <20160331173858.GB39098@dtor-ws>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-33-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459368249-13241-33-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-doc-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kamil Debski <k.debski@samsung.com>, lm-sensors@lm-sensors.org, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, linux-input@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com, Joachim Eastwood <manabian@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jo>
List-Id: linux-input@vger.kernel.org

Hi Boris,

On Wed, Mar 30, 2016 at 10:03:55PM +0200, Boris Brezillon wrote:
> Prefix those function as deprecated to encourage all existing users to
> switch to pwm_apply_state().

Why not keep at least some of them as wrappers where we do not need to
chnage several parameters at once? It is much easier to have a driver
do:

	error = pwm_enable(pwm);
	if (error)
		...

rather than declaring the state variable, fectch it, adjust and then
apply.

> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  include/linux/pwm.h | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index 4aad4eb..9bac10f 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -225,8 +225,8 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state);
>   *
>   * Returns: 0 on success or a negative error code on failure.
>   */
> -static inline int pwm_config(struct pwm_device *pwm, int duty_ns,
> -			     int period_ns)
> +static inline int __deprecated pwm_config(struct pwm_device *pwm, int duty_ns,
> +					  int period_ns)
>  {
>  	struct pwm_state pstate;
>  
> @@ -252,8 +252,8 @@ static inline int pwm_config(struct pwm_device *pwm, int duty_ns,
>   *
>   * Returns: 0 on success or a negative error code on failure.
>   */
> -static inline int pwm_set_polarity(struct pwm_device *pwm,
> -				   enum pwm_polarity polarity)
> +static inline int __deprecated pwm_set_polarity(struct pwm_device *pwm,
> +						enum pwm_polarity polarity)
>  {
>  	struct pwm_state pstate;
>  
> @@ -284,7 +284,7 @@ static inline int pwm_set_polarity(struct pwm_device *pwm,
>   *
>   * Returns: 0 on success or a negative error code on failure.
>   */
> -static inline int pwm_enable(struct pwm_device *pwm)
> +static inline int __deprecated pwm_enable(struct pwm_device *pwm)
>  {
>  	struct pwm_state pstate;
>  
> @@ -303,7 +303,7 @@ static inline int pwm_enable(struct pwm_device *pwm)
>   * pwm_disable() - stop a PWM output toggling
>   * @pwm: PWM device
>   */
> -static inline void pwm_disable(struct pwm_device *pwm)
> +static inline void __deprecated pwm_disable(struct pwm_device *pwm)
>  {
>  	struct pwm_state pstate;
>  
> @@ -360,24 +360,24 @@ static inline int pwm_apply_state(struct pwm_device *pwm,
>  	return -ENOTSUPP;
>  }
>  
> -static inline int pwm_config(struct pwm_device *pwm, int duty_ns,
> -			     int period_ns)
> +static inline int __deprecated pwm_config(struct pwm_device *pwm, int duty_ns,
> +					  int period_ns)
>  {
>  	return -EINVAL;
>  }
>  
> -static inline int pwm_set_polarity(struct pwm_device *pwm,
> -				   enum pwm_polarity polarity)
> +static inline int __deprecated pwm_set_polarity(struct pwm_device *pwm,
> +						enum pwm_polarity polarity)
>  {
>  	return -ENOTSUPP;
>  }
>  
> -static inline int pwm_enable(struct pwm_device *pwm)
> +static inline int __deprecated pwm_enable(struct pwm_device *pwm)
>  {
>  	return -EINVAL;
>  }
>  
> -static inline void pwm_disable(struct pwm_device *pwm)
> +static inline void __deprecated pwm_disable(struct pwm_device *pwm)
>  {
>  }
>  
> -- 
> 2.5.0
> 

-- 
Dmitry
