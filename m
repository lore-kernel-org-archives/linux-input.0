From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v4 09/24] regulator: pwm: use pwm_get/set_default_xxx()
 helpers where appropriate
Date: Wed, 30 Dec 2015 12:01:25 +0100
Message-ID: <20151230120125.3ab6e0bd@bbrezillon>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
	<1447664207-24370-10-git-send-email-boris.brezillon@free-electrons.com>
	<20151116105558.GB31303@sirena.org.uk>
	<20151116132359.39d84279@bbrezillon>
	<20151116184238.GJ31303@sirena.org.uk>
	<20151202113720.0a6517b1@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20151202113720.0a6517b1@bbrezillon>
Sender: linux-clk-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-pwm@vger.kernel.org, Mike Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Kamil Debski <k.debski@samsung.com>, lm-sensors@lm-sensors.org, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com, Joachim Eastwood <manabian@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-fbdev@vger.kernel.org, Jean-Christophe
List-Id: linux-input@vger.kernel.org

Hi Thierry,

I'm trying to get these "atomic PWM config" and "initial PWM state
retrieval" stuff in for at least 3 releases. I can understand that some
things have to be discussed and reworked in order to be good enough for
mainline, but that's not what I'm seeing here.

You and Mark raised some concerns about the usage of the
pwm_{get,set}_default_xxx() helpers which I tried to address by
proposing something else. I asked you to comment on it a few weeks ago,
but you never did.
You also told me that you would search for an alternative solution, but
never came back to me.

So I think it's now time to take a decision, whether you want to take
this series with some minor reworks (changing function names to clarify
what is a default and current PWM state), or decide that you expect
something else (but in that case I'd like you to explain what you want).

And by the way, the behavior you're complaining about is already
currently in place: even if the pwm_get_period() function does not
contain the 'default' word in its name, what's actually returned is the
default (or reference) period (the one retrieved from the DT or the PWM
lookup table) not the period currently in use on the PWM device (the
same goes for other helpers).

Can we please settle on something for 4.6 so that I can repost a series
when 4.5-rc1 is out?

Thanks,

Boris

On Wed, 2 Dec 2015 11:37:20 +0100
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> Hi,
> 
> On Mon, 16 Nov 2015 18:42:38 +0000
> Mark Brown <broonie@kernel.org> wrote:
> 
> > On Mon, Nov 16, 2015 at 01:23:59PM +0100, Boris Brezillon wrote:
> > > Mark Brown <broonie@kernel.org> wrote:
> > > > On Mon, Nov 16, 2015 at 09:56:32AM +0100, Boris Brezillon wrote:
> > 
> > > > > -	pwm_reg_period = pwm_get_period(drvdata->pwm);
> > > > > +	pwm_reg_period = pwm_get_default_period(drvdata->pwm);
> > 
> > > > It's not clear to me that we're not looking for the current period here
> > > > or in the other use.  Won't configuring based on a period other than the
> > > > one that has been set give the wrong answer?
> > 
> > > Hm, maybe that's naming problem. What I call the 'default' period here
> > > is actually the period configured in your board file (using a PWM lookup
> > > table) or your DT. This value represent the period requested by the PWM
> > > user not a default value specified by the PWM chip driver.
> > 
> > > The reason we're not using the 'current' period value is because it may
> > > have been set by the bootloader, and may be inappropriate for our use
> > > case (ie. the period may be to small to represent the different
> > > voltages).
> > 
> > > ITOH, we're using the current period value when calculating the current
> > > voltage, because we want to get the correct voltage value, and the PWM
> > > device may still use the configuration set by the bootloader (not the
> > > default one specified in your board or DT files).
> > 
> > > I hope this clarifies the differences between the current and default
> > > period, and why we should use the default value here.
> > 
> > To be honest I'm still a bit confused here.  When do we actually apply
> > the default setting and why do we keep on having to constantly override
> > it rather than doing this once at boot?  It feels wrong to be using it
> > every time we set anything.  I'd expect it to be something we only need
> > to do at probe time or which would automatically be handled by the PWM
> > framework (but that'd have issues changing the state and potentially
> > breaking things if done in an uncoordiated fashion).
> 
> Thierry, I didn't hear from you after the long discussion we had on IRC
> a few weeks ago.
> The conclusion of this discussion was that using
> pwm_get_default_period() was not acceptable (even after renaming it
> differently, like pwm_get_reference_period()), because it was
> disturbing to get the default/reference period each time we wanted to
> configure the PWM differently.
> Another suggestion was to automatically reconfigure the PWM duty_ns
> value based on the initial PWM state (retrieved through hardware
> readout) and the default period value (specified in the PWM lookup table
> or the DT). But this implied supporting hardware readout in all PWM
> drivers, which prevents a smooth migration to this new approach.
> 
> I also proposed to provide helpers to hide the duty cycle to active
> time calculation in the PWM core, so that PWM users just have to choose
> their scale (percent, or any other custom scale) and set their duty
> cycle based on this scale instead of specifying an active/on time in
> nanosecond. You didn't seem to like this idea, but I gave it a try
> (see here [1]), and think it might be worth looking at it.
> 
> The commit you should look at are [2], [3] and [4], and the idea is to
> clarify the notion of duty-cycle, which, according to wikipedia [5]
> (and a lot of other references) is supposed to be expressed in a
> relative unit (percent, or any other scale as said earlier).
> After renaming the pwm_set/get_duty_cycle() helpers into
> pwm_set/get_active_time() we can define a new pwm_set_duty_cycle()
> helper to let the PWM user configure its PWM device relatively to a
> chosen scale, without asking him to choose the PWM period (the
> conversion is done based on the default/reference period).
> The pwm_get_duty_cycle() is doing the reverse conversion: it returns the
> duty-cycle expressed relatively to the scale (here the current PWM
> period is used to handle the case where the PWM user hasn't configure
> the PWM yet, but want to retrieve the current duty-cycle extracted from
> hardware readout).
> 
> Please let me know what you think of this approach, and if you're happy
> with it I'll rework my series accordingly.
> 
> Best Regards,
> 
> Boris
> 
> [1]https://github.com/bbrezillon/linux-rk/commits/atomic-pwm-alt
> [2]https://github.com/bbrezillon/linux-rk/commit/d7d4d04e147d4ec349c59f70e141877661930c6d
> [3]https://github.com/bbrezillon/linux-rk/commit/66ce78f308f3eb1a9c536689352f208fd51c9030
> [4]https://github.com/bbrezillon/linux-rk/commit/07882a2dd21f0d17d83640ff55204cc7a7d4c8f7
> [5]https://en.wikipedia.org/wiki/Duty_cycle
> 



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
