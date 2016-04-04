From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 34/46] clk: pwm: switch to the atomic API
Date: Mon, 4 Apr 2016 17:30:29 +0200
Message-ID: <20160404153029.GC17856@ulmo>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-35-git-send-email-boris.brezillon@free-electrons.com>
 <20160330220149.GU18567@codeaurora.org>
 <20160331085735.3574970b@bbrezillon>
Reply-To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ctP54qlpMx3WjD+/"
Return-path: <linux-sunxi+bncBDTKFPPJUEHRBF4RRK4AKGQEEWA5SGQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20160331085735.3574970b@bbrezillon>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jo>
List-Id: linux-input@vger.kernel.org

--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Thu, Mar 31, 2016 at 08:57:35AM +0200, Boris Brezillon wrote:
> Hi Stephen,
> 
> On Wed, 30 Mar 2016 15:01:49 -0700
> Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> 
> > On 03/30, Boris Brezillon wrote:
> > > diff --git a/drivers/clk/clk-pwm.c b/drivers/clk/clk-pwm.c
> > > index ebcd738..49ec5b1 100644
> > > --- a/drivers/clk/clk-pwm.c
> > > +++ b/drivers/clk/clk-pwm.c
> > > @@ -28,15 +28,29 @@ static inline struct clk_pwm *to_clk_pwm(struct clk_hw *hw)
> > >  static int clk_pwm_prepare(struct clk_hw *hw)
> > >  {
> > >  	struct clk_pwm *clk_pwm = to_clk_pwm(hw);
> > > +	struct pwm_state pstate;
> > >  
> > > -	return pwm_enable(clk_pwm->pwm);
> > > +	pwm_get_state(clk_pwm->pwm, &pstate);
> > > +	if (pstate.enabled)
> > > +		return 0;
> > > +
> > > +	pstate.enabled = true;
> > > +
> > > +	return pwm_apply_state(clk_pwm->pwm, &pstate);
> > 
> > This doesn't seem atomic anymore if we're checking the state and
> > then not calling apply_state if it's already enabled. But I
> > assume this doesn't matter because we "own" the pwm here?
> 
> Yep. Actually it's not atomic in term of concurrency (maybe the
> 'atomic' word is not appropriate here). Atomicity is here referring to
> the fact that we're now providing all the PWM parameters in the same
> request instead of splitting it in pwm_config() + pwm_enable/disable()
> calls.

It's usually not possible to do really atomic updates with PWM hardware.
The idea is merely that we should be able to submit one request and the
framework (and drivers) will be responsible for making sure it is
applied as a whole or not at all. With the legacy API it is possible for
users to set the duty cycle and period, but then fail to enable/disable
the PWM.

pwm_apply_state() reporting success should indicate that the hardware
state is now what software wanted it to be. That kind of implies that
the application is serialized.

This doesn't imply that hardware state won't change between a call to
pwm_get_state() and pwm_apply_state(), though technically this is what
will usually happen because PWM devices are exclusively used by a single
user. Users are responsible for synchronizing accesses within their own
code.

> Concurrent accesses still have to be controlled by the PWM user (which
> is already the case for this driver, thanks to the locking
> infrastructure in the CCF).
> 
> > Otherwise I would think this would be unconditional apply state
> > and duplicates would be ignored in the pwm framework.
> > 
> 
> Yep, I'll remove the if (pstate.enabled) branch.

Yes, it should be the PWM framework's job to check for changes in state
and discard no-ops.

Thierry
--ctP54qlpMx3WjD+/--
