From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v5 05/46] pwm: introduce the pwm_args concept
Date: Thu, 31 Mar 2016 09:57:49 +0200
Message-ID: <20160331095749.4be1e76b@bbrezillon>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
	<1459368249-13241-6-git-send-email-boris.brezillon@free-electrons.com>
	<20160330215510.GS18567@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:58889 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752735AbcCaH5y (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Mar 2016 03:57:54 -0400
In-Reply-To: <20160330215510.GS18567@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mike Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kamil Debski <k.debski@samsung.com>, lm-sensors@lm-sensors.org, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com, Joachim Eastwood <manabian@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Jingoo Han <jingoohan1@gmail.com>, Lee

On Wed, 30 Mar 2016 14:55:10 -0700
Stephen Boyd <sboyd@codeaurora.org> wrote:

> On 03/30, Boris Brezillon wrote:
> > @@ -74,6 +74,23 @@ enum pwm_polarity {
> >  	PWM_POLARITY_INVERSED,
> >  };
> >  
> > +/**
> > + * struct pwm_args - PWM arguments
> > + * @period: reference period
> > + * @polarity: reference polarity
> > + *
> > + * This structure describe board-dependent arguments attached to a PWM
> 
> s/describe/describes/
> 
> > + * device. Those arguments are usually retrieved from the PWM lookup table or
> > + * DT definition.
> > + * This should not be confused with the PWM state: PWM args not representing
> 
> s/not representing/don't represent/ ?

Yes, I meant "are not representing", but "don't represent" is fine.

> 
> > + * the current PWM state, but the configuration the PWM user plan to use
> 
> s/plan/plans/
> 
> > + * on this PWM device.
> > + */
> > +struct pwm_args {
> > +	unsigned int period;
> > +	enum pwm_polarity polarity;
> > +};
> > +
> 



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
