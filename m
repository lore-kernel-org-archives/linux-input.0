From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v4 02/24] pwm: use pwm_get_xxx() helpers where
 appropriate
Date: Mon, 16 Nov 2015 19:06:46 +0100
Message-ID: <20151116190646.1d5ba16e@bbrezillon>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
	<1447664207-24370-3-git-send-email-boris.brezillon@free-electrons.com>
	<CAGhQ9VwEuwazF5Kdw=9R60EovVoiwen6fXiVjL+=EddXPYVGAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:52976 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751132AbbKPSPn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Nov 2015 13:15:43 -0500
In-Reply-To: <CAGhQ9VwEuwazF5Kdw=9R60EovVoiwen6fXiVjL+=EddXPYVGAg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kamil Debski <k.debski@samsung.com>, lm-sensors@lm-sensors.org, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Jingoo Han <jingoohan1@gmail.com>

Hi Joachim,

On Mon, 16 Nov 2015 18:46:44 +0100
Joachim  Eastwood <manabian@gmail.com> wrote:

> Hi Boris
> 
> (Adding Ariel for pwm-lpc18xx-sct)
> 
> On 16 November 2015 at 09:56, Boris Brezillon
> <boris.brezillon@free-electrons.com> wrote:
> > Use pwm_get_xxx() helpers instead of directly accessing the pwm->xxx field.
> > Doing that will ease adaptation of the PWM framework to support atomic
> > update.
> >
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> > Patch generated with the following coccinelle script:
> >
> > --->8---
> > virtual patch
> >
> > @@
> > struct pwm_device *p;
> > expression e;
> > @@
> > (
> > -(p)->polarity = e;
> > +pwm_set_polarity((p), e);
> > |
> > -(p)->polarity
> > +pwm_get_polarity((p))
> > |
> > -(p)->period = e;
> > +pwm_set_period((p), e);
> > |
> > -(p)->period
> > +pwm_get_period((p))
> > |
> > -(p)->duty_cycle = e;
> > +pwm_set_duty_cycle((p), e);
> > |
> > -(p)->duty_cycle
> > +pwm_get_duty_cycle((p))
> > )
> > --->8---
> > ---
> >  drivers/pwm/pwm-crc.c         | 2 +-
> >  drivers/pwm/pwm-lpc18xx-sct.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
> > index 7101c70..2f88543 100644
> > --- a/drivers/pwm/pwm-crc.c
> > +++ b/drivers/pwm/pwm-crc.c
> > @@ -75,7 +75,7 @@ static int crc_pwm_config(struct pwm_chip *c, struct pwm_device *pwm,
> >                 return -EINVAL;
> >         }
> >
> > -       if (pwm->period != period_ns) {
> > +       if (pwm_get_period((pwm)) != period_ns) {
> >                 int clk_div;
> >
> >                 /* changing the clk divisor, need to disable fisrt */
> > diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
> > index 9163085..091fa13 100644
> > --- a/drivers/pwm/pwm-lpc18xx-sct.c
> > +++ b/drivers/pwm/pwm-lpc18xx-sct.c
> > @@ -249,7 +249,7 @@ static int lpc18xx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> >                            LPC18XX_PWM_EVSTATEMSK(lpc18xx_data->duty_event),
> >                            LPC18XX_PWM_EVSTATEMSK_ALL);
> >
> > -       if (pwm->polarity == PWM_POLARITY_NORMAL) {
> > +       if (pwm_get_polarity((pwm)) == PWM_POLARITY_NORMAL) {
> 
> What is the deal with the double parentheses?
> 
> Think I saw that in some of the other patches as well.

It comes from a typo in my coccinelle script. I already fixed it and
regenerated the faulty patches, so please ignore this aspect while
reviewing (this will be addressed in the next version).

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
