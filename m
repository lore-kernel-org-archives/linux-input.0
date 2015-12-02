From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 09/24] regulator: pwm: use
 pwm_get/set_default_xxx() helpers where appropriate
Date: Wed, 2 Dec 2015 11:37:20 +0100
Message-ID: <20151202113720.0a6517b1@bbrezillon>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
	<1447664207-24370-10-git-send-email-boris.brezillon@free-electrons.com>
	<20151116105558.GB31303@sirena.org.uk>
	<20151116132359.39d84279@bbrezillon>
	<20151116184238.GJ31303@sirena.org.uk>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBB3ET7OZAKGQEWFND32Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20151116184238.GJ31303-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean-Christophe
List-Id: linux-input@vger.kernel.org

Hi,

On Mon, 16 Nov 2015 18:42:38 +0000
Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> On Mon, Nov 16, 2015 at 01:23:59PM +0100, Boris Brezillon wrote:
> > Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > > On Mon, Nov 16, 2015 at 09:56:32AM +0100, Boris Brezillon wrote:
> 
> > > > -	pwm_reg_period = pwm_get_period(drvdata->pwm);
> > > > +	pwm_reg_period = pwm_get_default_period(drvdata->pwm);
> 
> > > It's not clear to me that we're not looking for the current period here
> > > or in the other use.  Won't configuring based on a period other than the
> > > one that has been set give the wrong answer?
> 
> > Hm, maybe that's naming problem. What I call the 'default' period here
> > is actually the period configured in your board file (using a PWM lookup
> > table) or your DT. This value represent the period requested by the PWM
> > user not a default value specified by the PWM chip driver.
> 
> > The reason we're not using the 'current' period value is because it may
> > have been set by the bootloader, and may be inappropriate for our use
> > case (ie. the period may be to small to represent the different
> > voltages).
> 
> > ITOH, we're using the current period value when calculating the current
> > voltage, because we want to get the correct voltage value, and the PWM
> > device may still use the configuration set by the bootloader (not the
> > default one specified in your board or DT files).
> 
> > I hope this clarifies the differences between the current and default
> > period, and why we should use the default value here.
> 
> To be honest I'm still a bit confused here.  When do we actually apply
> the default setting and why do we keep on having to constantly override
> it rather than doing this once at boot?  It feels wrong to be using it
> every time we set anything.  I'd expect it to be something we only need
> to do at probe time or which would automatically be handled by the PWM
> framework (but that'd have issues changing the state and potentially
> breaking things if done in an uncoordiated fashion).

Thierry, I didn't hear from you after the long discussion we had on IRC
a few weeks ago.
The conclusion of this discussion was that using
pwm_get_default_period() was not acceptable (even after renaming it
differently, like pwm_get_reference_period()), because it was
disturbing to get the default/reference period each time we wanted to
configure the PWM differently.
Another suggestion was to automatically reconfigure the PWM duty_ns
value based on the initial PWM state (retrieved through hardware
readout) and the default period value (specified in the PWM lookup table
or the DT). But this implied supporting hardware readout in all PWM
drivers, which prevents a smooth migration to this new approach.

I also proposed to provide helpers to hide the duty cycle to active
time calculation in the PWM core, so that PWM users just have to choose
their scale (percent, or any other custom scale) and set their duty
cycle based on this scale instead of specifying an active/on time in
nanosecond. You didn't seem to like this idea, but I gave it a try
(see here [1]), and think it might be worth looking at it.

The commit you should look at are [2], [3] and [4], and the idea is to
clarify the notion of duty-cycle, which, according to wikipedia [5]
(and a lot of other references) is supposed to be expressed in a
relative unit (percent, or any other scale as said earlier).
After renaming the pwm_set/get_duty_cycle() helpers into
pwm_set/get_active_time() we can define a new pwm_set_duty_cycle()
helper to let the PWM user configure its PWM device relatively to a
chosen scale, without asking him to choose the PWM period (the
conversion is done based on the default/reference period).
The pwm_get_duty_cycle() is doing the reverse conversion: it returns the
duty-cycle expressed relatively to the scale (here the current PWM
period is used to handle the case where the PWM user hasn't configure
the PWM yet, but want to retrieve the current duty-cycle extracted from
hardware readout).

Please let me know what you think of this approach, and if you're happy
with it I'll rework my series accordingly.

Best Regards,

Boris

[1]https://github.com/bbrezillon/linux-rk/commits/atomic-pwm-alt
[2]https://github.com/bbrezillon/linux-rk/commit/d7d4d04e147d4ec349c59f70e141877661930c6d
[3]https://github.com/bbrezillon/linux-rk/commit/66ce78f308f3eb1a9c536689352f208fd51c9030
[4]https://github.com/bbrezillon/linux-rk/commit/07882a2dd21f0d17d83640ff55204cc7a7d4c8f7
[5]https://en.wikipedia.org/wiki/Duty_cycle

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
