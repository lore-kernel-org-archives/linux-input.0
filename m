From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 08/46] hwmon: pwm-fan: use pwm_get_args()
 where appropriate
Date: Mon, 4 Apr 2016 17:20:48 +0200
Message-ID: <20160404152048.GA17856@ulmo>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-9-git-send-email-boris.brezillon@free-electrons.com>
 <20160330225244.GA24044@roeck-us.net>
 <20160331090709.5c3bdf70@bbrezillon>
Reply-To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Return-path: <linux-sunxi+bncBDTKFPPJUEHRBU4MRK4AKGQEZTB7PDQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20160331090709.5c3bdf70@bbrezillon>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jo>
List-Id: linux-input@vger.kernel.org

--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Thu, Mar 31, 2016 at 09:07:09AM +0200, Boris Brezillon wrote:
> Hi Guenter,
> 
> On Wed, 30 Mar 2016 15:52:44 -0700
> Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org> wrote:
> 
> > On Wed, Mar 30, 2016 at 10:03:31PM +0200, Boris Brezillon wrote:
> > > The PWM framework has clarified the concept of reference PWM config
> > > (the platform dependent config retrieved from the DT or the PWM
> > > lookup table) and real PWM state.
> > > 
> > > Use pwm_get_args() when the PWM user wants to retrieve this reference
> > > config and not the current state.
> > > 
> > > This is part of the rework allowing the PWM framework to support
> > > hardware readout and expose real PWM state even when the PWM has
> > > just been requested (before the user calls pwm_config/enable/disable()).
> > > 
> > > Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > > ---
> > >  drivers/hwmon/pwm-fan.c | 19 +++++++++++++------
> > >  1 file changed, 13 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> > > index 3e23003..82c5656 100644
> > > --- a/drivers/hwmon/pwm-fan.c
> > > +++ b/drivers/hwmon/pwm-fan.c
> > > @@ -40,15 +40,18 @@ struct pwm_fan_ctx {
> > >  
> > >  static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
> > >  {
> > > +	struct pwm_args pargs = { };
> > 
> > Hi Boris,
> > 
> > I guess I am missing some context; sorry for that. Unfortunately,
> > I did not easily find an explanation, so please bear with me.
> > 
> > Two questions: Why do we need a local copy of struct pwm_args instead
> > of a pointer to it ? If it can change while being used, isn't it
> > inconsistent anyway ?
> 
> It cannot change after pwm_get() is called. For the reason behind
> prototype: I just followed the Thierry's proposal, but I'm perfectly
> fine returning a const struct pwm_args pointer intead of passing
> pwm_args as a parameter.
> 
> Thierry, what's your opinion?

I do prefer the current variant because it is more consistent with the
new atomic API, even if not strictly necessary because of the immutable
data.

> > Also, assuming the local copy is necessary, why initialize pargs ? 
> > After all, pwm_get_args() just overwrites it.
> 
> It's a leftover from a previous version where pwm_get_args was
> implemented this way:
> 
> static inline void pwm_get_args(pwm, args)
> {
> 	if (pwm)
> 		*args = pwm->args
> }
> 
> and this implementation was generating a lot of 'uninitialized
> variable' warnings.
> 
> I just decided to drop the 'if (pwm)' test, because, IMO, this
> should be checked way before calling pwm_get_args() is called.

Sounds fine to me.

Thierry
--PNTmBPCT7hxwcZjr--
