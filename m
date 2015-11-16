From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v4 05/24] misc: max77693-haptic: use pwm_get_xxx()
 helpers where appropriate
Date: Mon, 16 Nov 2015 17:00:40 +0100
Message-ID: <20151116170040.00110079@bbrezillon>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
	<1447664207-24370-6-git-send-email-boris.brezillon@free-electrons.com>
	<5649D5D0.6080204@samsung.com>
	<20151116145509.3ea50eb0@bbrezillon>
	<5649FC75.8020203@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <5649FC75.8020203@roeck-us.net>
Sender: linux-clk-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kamil Debski <k.debski@samsung.com>, lm-sensors@lm-sensors.org, Jean Delvare <jdelvare@suse.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com, Joachim Eastwood <manabian@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.or
List-Id: linux-input@vger.kernel.org

On Mon, 16 Nov 2015 07:55:33 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> On 11/16/2015 05:55 AM, Boris Brezillon wrote:
> > Hi Krzysztof,
> >
> > On Mon, 16 Nov 2015 22:10:40 +0900
> > Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
> >
> >> W dniu 16.11.2015 o 17:56, Boris Brezillon pisze:
> >>> Use pwm_get_xxx() helpers instead of directly accessing the pwm->xxx field.
> >>> Doing that will ease adaptation of the PWM framework to support atomic
> >>> update.
> >>>
> >>> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> >>> ---
> >>> Patch generated with the following coccinelle script:
> >>>
> >>> --->8---
> >>> virtual patch
> >>>
> >>> @@
> >>> struct pwm_device *p;
> >>> expression e;
> >>> @@
> >>> (
> >>> -(p)->polarity = e;
> >>> +pwm_set_polarity((p), e);
> >>> |
> >>> -(p)->polarity
> >>> +pwm_get_polarity((p))
> >>> |
> >>> -(p)->period = e;
> >>> +pwm_set_period((p), e);
> >>> |
> >>> -(p)->period
> >>> +pwm_get_period((p))
> >>> |
> >>> -(p)->duty_cycle = e;
> >>> +pwm_set_duty_cycle((p), e);
> >>> |
> >>> -(p)->duty_cycle
> >>> +pwm_get_duty_cycle((p))
> >>> )
> >>> --->8---
> >>> ---
> >>>   drivers/input/misc/max77693-haptic.c | 7 ++++---
> >>>   1 file changed, 4 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/input/misc/max77693-haptic.c b/drivers/input/misc/max77693-haptic.c
> >>> index 6d96bff..a038fb3 100644
> >>> --- a/drivers/input/misc/max77693-haptic.c
> >>> +++ b/drivers/input/misc/max77693-haptic.c
> >>> @@ -70,10 +70,11 @@ struct max77693_haptic {
> >>>
> >>>   static int max77693_haptic_set_duty_cycle(struct max77693_haptic *haptic)
> >>>   {
> >>> -	int delta = (haptic->pwm_dev->period + haptic->pwm_duty) / 2;
> >>> +	int delta = (pwm_get_period((haptic->pwm_dev)) + haptic->pwm_duty) / 2;
> >>
> >> Double parentheses over argument are not needed so just:
> >> pwm_get_period(haptic->pwm_dev) + ...
> >
> > Actually it was generated with coccinelle, hence I didn't fix existing
> > coding style issues, but I have no problem fixing them.
> >
> There was no existing coding style issue. Your coccinelle script introduces it.
> You might want to consider updating your script and remove the unnecessary (( ))
> from it.

My bad, you are right: my script is buggy. I'll fix that.

Thanks,

Boris


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
