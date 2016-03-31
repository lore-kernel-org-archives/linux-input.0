From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v5 34/46] clk: pwm: switch to the atomic API
Date: Thu, 31 Mar 2016 08:57:35 +0200
Message-ID: <20160331085735.3574970b@bbrezillon>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
	<1459368249-13241-35-git-send-email-boris.brezillon@free-electrons.com>
	<20160330220149.GU18567@codeaurora.org>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBY4U6O3QKGQECI4INZQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20160330220149.GU18567-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jo>
List-Id: linux-input@vger.kernel.org

Hi Stephen,

On Wed, 30 Mar 2016 15:01:49 -0700
Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:

> On 03/30, Boris Brezillon wrote:
> > diff --git a/drivers/clk/clk-pwm.c b/drivers/clk/clk-pwm.c
> > index ebcd738..49ec5b1 100644
> > --- a/drivers/clk/clk-pwm.c
> > +++ b/drivers/clk/clk-pwm.c
> > @@ -28,15 +28,29 @@ static inline struct clk_pwm *to_clk_pwm(struct clk_hw *hw)
> >  static int clk_pwm_prepare(struct clk_hw *hw)
> >  {
> >  	struct clk_pwm *clk_pwm = to_clk_pwm(hw);
> > +	struct pwm_state pstate;
> >  
> > -	return pwm_enable(clk_pwm->pwm);
> > +	pwm_get_state(clk_pwm->pwm, &pstate);
> > +	if (pstate.enabled)
> > +		return 0;
> > +
> > +	pstate.enabled = true;
> > +
> > +	return pwm_apply_state(clk_pwm->pwm, &pstate);
> 
> This doesn't seem atomic anymore if we're checking the state and
> then not calling apply_state if it's already enabled. But I
> assume this doesn't matter because we "own" the pwm here?

Yep. Actually it's not atomic in term of concurrency (maybe the
'atomic' word is not appropriate here). Atomicity is here referring to
the fact that we're now providing all the PWM parameters in the same
request instead of splitting it in pwm_config() + pwm_enable/disable()
calls.

Concurrent accesses still have to be controlled by the PWM user (which
is already the case for this driver, thanks to the locking
infrastructure in the CCF).

> Otherwise I would think this would be unconditional apply state
> and duplicates would be ignored in the pwm framework.
> 

Yep, I'll remove the if (pstate.enabled) branch.

Thanks for your review.

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
