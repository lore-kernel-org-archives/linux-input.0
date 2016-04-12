From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 15/46] pwm: introduce the pwm_state concept
Date: Tue, 12 Apr 2016 14:21:41 +0200
Message-ID: <20160412122141.GP18882@ulmo.ba.sec>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-16-git-send-email-boris.brezillon@free-electrons.com>
 <20160412114904.GM18882@ulmo.ba.sec>
 <20160412141718.5fe4cf24@bbrezillon>
Reply-To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6sj9mcRtP+pTWLOo"
Return-path: <linux-sunxi+bncBDTKFPPJUEHRBV6QWO4AKGQEDB5THRY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20160412141718.5fe4cf24@bbrezillon>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jo>
List-Id: linux-input@vger.kernel.org

--6sj9mcRtP+pTWLOo
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Tue, Apr 12, 2016 at 02:17:18PM +0200, Boris Brezillon wrote:
> On Tue, 12 Apr 2016 13:49:04 +0200
> Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> 
> > On Wed, Mar 30, 2016 at 10:03:38PM +0200, Boris Brezillon wrote:
> > > The PWM state, represented by its period, duty_cycle and polarity,
> > > is currently directly stored in the PWM device.
> > > Declare a pwm_state structure embedding those field so that we can later
> > > use this struct to atomically update all the PWM parameters at once.
> > > 
> > > All pwm_get_xxx() helpers are now implemented as wrappers around
> > > pwm_get_state().
> > > 
> > > Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > > ---
> > >  drivers/pwm/core.c  |  8 ++++----
> > >  include/linux/pwm.h | 54 +++++++++++++++++++++++++++++++++++++++++------------
> > >  2 files changed, 46 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > > index 6433059..f3f91e7 100644
> > > --- a/drivers/pwm/core.c
> > > +++ b/drivers/pwm/core.c
> > > @@ -268,7 +268,7 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
> > >  		pwm->chip = chip;
> > >  		pwm->pwm = chip->base + i;
> > >  		pwm->hwpwm = i;
> > > -		pwm->polarity = polarity;
> > > +		pwm->state.polarity = polarity;
> > 
> > Would this not more correctly be assigned to pwm->args.polarity? After
> > all this is setting up the "initial" state, much like DT or the lookup
> > tables would for duty cycle and period.
> 
> Yes, I wasn't sure about the pwm_add_with_polarity() meaning. To me,
> all the reference info should be extracted from DT, PWM lookup table or
> driver specific ->request() implementation, but I can definitely
> initialize the args.polarity here too.
> 
> Should I keep the pwm->state.polarity assignment (to set the initial
> polarity when the driver does not support hardware readout)?

Wouldn't this work automatically as part of the pwm_apply_args() helper
if we extended it with this setting?

Thierry
--6sj9mcRtP+pTWLOo--
