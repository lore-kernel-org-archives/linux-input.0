From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v5 15/46] pwm: introduce the pwm_state concept
Date: Tue, 12 Apr 2016 14:45:08 +0200
Message-ID: <20160412144508.2ee181fe@bbrezillon>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
	<1459368249-13241-16-git-send-email-boris.brezillon@free-electrons.com>
	<20160412114904.GM18882@ulmo.ba.sec>
	<20160412141718.5fe4cf24@bbrezillon>
	<20160412122141.GP18882@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:35594 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932649AbcDLMpX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Apr 2016 08:45:23 -0400
In-Reply-To: <20160412122141.GP18882@ulmo.ba.sec>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kamil Debski <k.debski@samsung.com>, lm-sensors@lm-sensors.org, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com, Joachim Eastwood <manabian@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.>

On Tue, 12 Apr 2016 14:21:41 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Tue, Apr 12, 2016 at 02:17:18PM +0200, Boris Brezillon wrote:
> > On Tue, 12 Apr 2016 13:49:04 +0200
> > Thierry Reding <thierry.reding@gmail.com> wrote:
> > 
> > > On Wed, Mar 30, 2016 at 10:03:38PM +0200, Boris Brezillon wrote:
> > > > The PWM state, represented by its period, duty_cycle and polarity,
> > > > is currently directly stored in the PWM device.
> > > > Declare a pwm_state structure embedding those field so that we can later
> > > > use this struct to atomically update all the PWM parameters at once.
> > > > 
> > > > All pwm_get_xxx() helpers are now implemented as wrappers around
> > > > pwm_get_state().
> > > > 
> > > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > > ---
> > > >  drivers/pwm/core.c  |  8 ++++----
> > > >  include/linux/pwm.h | 54 +++++++++++++++++++++++++++++++++++++++++------------
> > > >  2 files changed, 46 insertions(+), 16 deletions(-)
> > > > 
> > > > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > > > index 6433059..f3f91e7 100644
> > > > --- a/drivers/pwm/core.c
> > > > +++ b/drivers/pwm/core.c
> > > > @@ -268,7 +268,7 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
> > > >  		pwm->chip = chip;
> > > >  		pwm->pwm = chip->base + i;
> > > >  		pwm->hwpwm = i;
> > > > -		pwm->polarity = polarity;
> > > > +		pwm->state.polarity = polarity;
> > > 
> > > Would this not more correctly be assigned to pwm->args.polarity? After
> > > all this is setting up the "initial" state, much like DT or the lookup
> > > tables would for duty cycle and period.
> > 
> > Yes, I wasn't sure about the pwm_add_with_polarity() meaning. To me,
> > all the reference info should be extracted from DT, PWM lookup table or
> > driver specific ->request() implementation, but I can definitely
> > initialize the args.polarity here too.
> > 
> > Should I keep the pwm->state.polarity assignment (to set the initial
> > polarity when the driver does not support hardware readout)?
> 
> Wouldn't this work automatically as part of the pwm_apply_args() helper
> if we extended it with this setting?

Well, as you explained in you answer to patch 5, pwm_apply_args()
should be called on a per-request basis (each time a PWM device is
requested), while the initial polarity setting should only be applied
when registering the PWM chip (and its devices). After that, the
framework takes care of keeping the PWM state in sync with the hardware
state.

Let's take a real (though a bit unusual) example. Say you have a single
PWM device referenced by two different users. Only one user can be
enabled at a time, but each of them has its own reference config
(different polarity, different period).

User1 calls pwm_get() and applies its own polarity and period. Then
user1 is unregistered and release the PWM device, leaving the polarity
and period untouched.

User2 is registered and request the same PWM device, but user2 is
smarter and tries to extract the current PWM state before adapting the
config according to pwm_args. If you just reset pwm->state.polarity
each time pwm_apply_args() is called (and you suggested to call it as
part of the request procedure), then this means the PWM state is no
longer in sync with the hardware state.


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
