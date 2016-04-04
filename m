From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 36/46] input: misc: max77693: switch to
 the atomic API
Date: Mon, 4 Apr 2016 17:34:33 +0200
Message-ID: <20160404153433.GD17856@ulmo>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-37-git-send-email-boris.brezillon@free-electrons.com>
 <20160331174801.GC39098@dtor-ws>
 <20160331205718.057a6f38@bbrezillon>
Reply-To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8w3uRX/HFJGApMzv"
Return-path: <linux-sunxi+bncBDTKFPPJUEHRBDETRK4AKGQEP54XSRQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20160331205718.057a6f38@bbrezillon>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jon>
List-Id: linux-input@vger.kernel.org

--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Thu, Mar 31, 2016 at 08:57:18PM +0200, Boris Brezillon wrote:
> On Thu, 31 Mar 2016 10:48:01 -0700
> Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> 
> > Hi Boris,
> > 
> > On Wed, Mar 30, 2016 at 10:03:59PM +0200, Boris Brezillon wrote:
> > > pwm_config/enable/disable() have been deprecated and should be replaced
> > > by pwm_apply_state().
> > > 
> > > Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > > ---
> > >  drivers/input/misc/max77693-haptic.c | 23 +++++++++++++++++------
> > >  1 file changed, 17 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/input/misc/max77693-haptic.c b/drivers/input/misc/max77693-haptic.c
> > > index cf6aac0..aef7dc4 100644
> > > --- a/drivers/input/misc/max77693-haptic.c
> > > +++ b/drivers/input/misc/max77693-haptic.c
> > > @@ -70,13 +70,16 @@ struct max77693_haptic {
> > >  
> > >  static int max77693_haptic_set_duty_cycle(struct max77693_haptic *haptic)
> > >  {
> > > +	struct pwm_state pstate;
> > >  	struct pwm_args pargs = { };
> > > -	int delta;
> > >  	int error;
> > >  
> > >  	pwm_get_args(haptic->pwm_dev, &pargs);
> > > -	delta = (pargs.period + haptic->pwm_duty) / 2;
> > > -	error = pwm_config(haptic->pwm_dev, delta, pargs.period);
> > > +	pwm_get_state(haptic->pwm_dev, &pstate);
> > > +
> > > +	pstate.period = pargs.period;
> > > +	pstate.duty_cycle = (pargs.period + haptic->pwm_duty) / 2;
> > > +	error = pwm_apply_state(haptic->pwm_dev, &pstate);
> > 
> > This does not make sense with regard to the atomic API. If you look in
> > max77693_haptic_play_work(), right after calling
> > max77693_haptic_set_duty_cycle() we either try to enable or disable the
> > pwm. When switching to this new API we should combine both actions.
> 
> True. I'll address that, unless Thierry is fine keeping the non-atomic
> API, in which case I'll just drop patches 32 to 46.

I'm fine with keeping the pwm_enable(), pwm_disable() and pwm_config()
APIs, but they should only be used as shortcuts. Where possible the new
atomic API should be used to combine multiple operations into one.

Thierry
--8w3uRX/HFJGApMzv--
