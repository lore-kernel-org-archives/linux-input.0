From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v5 13/24] input: misc: max8997: explicitly
 apply PWM config extracted from pwm_args
Date: Sun, 17 Apr 2016 17:39:08 +0200
Message-ID: <20160417173908.3554ddda@bbrezillon>
References: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
	<1460661464-11216-14-git-send-email-boris.brezillon@free-electrons.com>
	<20160417124548.GE33215@dtor-ws>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBMO4Z24AKGQECTTFBCI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20160417124548.GE33215@dtor-ws>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones@lin>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On Sun, 17 Apr 2016 05:45:48 -0700
Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On Thu, Apr 14, 2016 at 09:17:33PM +0200, Boris Brezillon wrote:
> > Call pwm_apply_args() just after requesting the PWM device so that the
> > polarity and period are initialized according to the information provided
> > in pwm_args.
> > 
> > This is an intermediate state, and pwm_apply_args() should be dropped as
> > soon as the atomic PWM infrastructure is in place and the driver makes
> > use of it.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > ---
> >  drivers/input/misc/max8997_haptic.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/input/misc/max8997_haptic.c b/drivers/input/misc/max8997_haptic.c
> > index a806ba3..bf17f65 100644
> > --- a/drivers/input/misc/max8997_haptic.c
> > +++ b/drivers/input/misc/max8997_haptic.c
> > @@ -304,6 +304,12 @@ static int max8997_haptic_probe(struct platform_device *pdev)
> >  				error);
> >  			goto err_free_mem;
> >  		}
> > +
> > +		/*
> > +		 * FIXME: pwm_apply_args() should be removed when switching to
> > +		 * the atomic PWM API.
> > +		 */
> > +		pwm_apply_args(chip->pwm);
> 
> I do not understand. We did not fetch/modify any args, what are we
> applying and why? Especially since we saying we want to remove this
> later.

This is part of the process to allow some PWM users to retrieve the
current PWM state instead of blindly applying a new config. This is
particularly useful when one want a smooth handover between the
bootloader and the kernel, and we have a real case here with a critical
regulator (controlling the DDR voltage) controlled by a PWM device:
the bootloader setup the PWM to 1.2V, and we want the kernel to
retrieve the current PWM config and adjust the duty_cycle according to
the PWM arguments provided by the DT definition.

So, now let's switch to the actual reason for calling pwm_apply_args()
directly from PWM users code. The operations done in pwm_apply_args()
were previously done by the core when the user was requesting the PWM.
Those operations consisted in initializing the PWM period and polarity
to the values specified in the DT or PWM lookup table (what we call
pwm_args).
This is working fine as long as we don't care about the initial PWM
state, but as explained above, that may no longer be the case. That's
why we want PWM users to explicitly state that they don't care about the
initial PWM state and want to apply the default state instead: 
period = pwm_args.period and polarity = pwm_args.polarity.

Once all PWM users have been patched to explicitly call
pwm_apply_args(), we'll be able to remove this call from the core
(patch 17), and let PWM drivers implement ->get_state() to provide
hardware readout (patch 20).

PWM users that are interested in adjusting existing PWM config to the
polarity and period specified in pwm_args will be able to do so instead
of calling pwm_apply_args(). And for those who just don't care about
initial state, they should just call pwm_apply_state() with the initial
state they expect instead of pwm_apply_args(), which is only partially
describing the PWM config (PWM args don't specify whether the PWM
should be disabled or enabled, and what duty_cycle to use).

Hope this clarifies a bit the situation.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
