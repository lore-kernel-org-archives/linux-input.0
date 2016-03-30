From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v5 34/46] clk: pwm: switch to the atomic API
Date: Wed, 30 Mar 2016 15:01:49 -0700
Message-ID: <20160330220149.GU18567@codeaurora.org>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-35-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459368249-13241-35-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-clk-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mike Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kamil Debski <k.debski@samsung.com>, lm-sensors@lm-sensors.org, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com, Joachim Eastwood <manabian@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Jingoo Han <jingoohan1@gmail.com>, Lee
List-Id: linux-input@vger.kernel.org

On 03/30, Boris Brezillon wrote:
> diff --git a/drivers/clk/clk-pwm.c b/drivers/clk/clk-pwm.c
> index ebcd738..49ec5b1 100644
> --- a/drivers/clk/clk-pwm.c
> +++ b/drivers/clk/clk-pwm.c
> @@ -28,15 +28,29 @@ static inline struct clk_pwm *to_clk_pwm(struct clk_hw *hw)
>  static int clk_pwm_prepare(struct clk_hw *hw)
>  {
>  	struct clk_pwm *clk_pwm = to_clk_pwm(hw);
> +	struct pwm_state pstate;
>  
> -	return pwm_enable(clk_pwm->pwm);
> +	pwm_get_state(clk_pwm->pwm, &pstate);
> +	if (pstate.enabled)
> +		return 0;
> +
> +	pstate.enabled = true;
> +
> +	return pwm_apply_state(clk_pwm->pwm, &pstate);

This doesn't seem atomic anymore if we're checking the state and
then not calling apply_state if it's already enabled. But I
assume this doesn't matter because we "own" the pwm here?
Otherwise I would think this would be unconditional apply state
and duplicates would be ignored in the pwm framework.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
