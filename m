From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 3/3] wm97xx-core: Support use as a wakeup source
Date: Mon, 14 Apr 2008 17:29:07 -0700
Message-ID: <200804141729.08036.david-b@pacbell.net>
References: <20080414173841.GA2213@rakim.wolfsonmicro.main> <1208194775-4293-3-git-send-email-broonie@opensource.wolfsonmicro.com> <20080414163033.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:46216 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753847AbYDOA3L (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Apr 2008 20:29:11 -0400
In-Reply-To: <20080414163033.ZZRA012@mailhub.coreip.homeip.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Andrew Morton <akpm@linux-foundation.org>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 14 April 2008, Dmitry Torokhov wrote:
> Hi Mark,
> 
> On Mon, Apr 14, 2008 at 06:39:35PM +0100, Mark Brown wrote:
> > The PENDOWN signal from the WM97xx touch screen controllers can be used
> > to generate a wakeup event when the system is suspended. Provide a new
> > machine configuration option 'suspend_mode' allowing machine drivers to
> > enable this. If no suspend_mode is provided then the touch panel will be
> > powered down when the system is suspended.
> > 
> 
> Hmm, another unique module option... How about using device_can_wakeup()
> infrastructure that we already have. I'm adding David Brownell to CC since
> I believe he's doing a lot of similar work.

I don't quite follow the technical content of this "suspend_mode"
mask, but it sure looks as if it should use the driver model flags
in addition to whatever that mask is doing.

There are two aspects to this:

 (a) Whether on a given system the touchscreen *can* issue wakeup
     events ... call device_init_wakeup(dev, true) to say it can.
     In this case, presumably suspend_mode == 0 means it can't.
     Board setup, or at latest probe(), should device_init_wakeup().

 (b) Whether it *should* do so ... e.g. the Nokia N810 has a mode
     where it doesn't, and usually when you're carrying one around
     in a pocket (or purse, or whatever) you would say "doesn't".
     Userspace manages that answer via a sysfs file, and drivers
     test the answer with device_may_wakeup(dev).

So:  yes, this should initialize and use those driver model flags.


> > Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > ---
> >  drivers/input/touchscreen/wm97xx-core.c |   22 ++++++++++++++++++++++
> >  include/linux/wm97xx.h                  |    3 +++
> >  2 files changed, 25 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
> > index fec07c2..e1a1ca0 100644
> > --- a/drivers/input/touchscreen/wm97xx-core.c
> > +++ b/drivers/input/touchscreen/wm97xx-core.c
> > @@ -689,10 +689,32 @@ static int wm97xx_remove(struct device *dev)
> >  static int wm97xx_suspend(struct device *dev, pm_message_t state)
> >  {
> >  	struct wm97xx *wm = dev_get_drvdata(dev);
> > +	u16 reg;
> > +	int suspend_mode;
> > +
> > +	if (wm->mach_ops)
> > +		suspend_mode = wm->mach_ops->suspend_mode;
> > +	else
> > +		suspend_mode = 0;
> >  
> >  	if (wm->input_dev->users)
> >  		cancel_delayed_work_sync(&wm->ts_reader);
> >  
> > +	/* Power down the digitiser (bypassing the cache for resume) */
> > +	reg = wm97xx_reg_read(wm, AC97_WM97XX_DIGITISER2);
> > +	reg &= ~WM97XX_PRP_DET_DIG;
> > +	if (wm->input_dev->users && suspend_mode)

This should probably check device_may_wakeup(SOMEDEV), rather
than testing suspend_mode.

The wakeup mechanism here isn't clear to me.  Does this assume
that the touchscreen IRQ is wakeup-capable?  I don't see any
calls to enable_irq_wake() or disable_irq_wake() ... or for that
matter any other calls that might affect system behavior.


> > +		reg |= suspend_mode;
> > +	wm->ac97->bus->ops->write(wm->ac97, AC97_WM97XX_DIGITISER2, reg);
> > +
> > +	/* WM9713 has an additional power bit - turn it off if there
> > +	 * are no users or if suspend mode is zero. */
> > +	if (wm->id == WM9713_ID2 &&
> > +	    (!wm->input_dev->users || !suspend_mode)) {
> > +		reg = wm97xx_reg_read(wm, AC97_EXTENDED_MID) | 0x8000;
> > +		wm97xx_reg_write(wm, AC97_EXTENDED_MID, reg);
> > +	}
> > +
> >  	return 0;
> >  }
> >  
> > diff --git a/include/linux/wm97xx.h b/include/linux/wm97xx.h
> > index ed01c7d..2082833 100644
> > --- a/include/linux/wm97xx.h
> > +++ b/include/linux/wm97xx.h
> > @@ -258,6 +258,9 @@ struct wm97xx_mach_ops {
> >  	/* pre and post sample - can be used to minimise any analog noise */
> >  	void (*pre_sample) (int);  /* function to run before sampling */
> >  	void (*post_sample) (int);  /* function to run after sampling */
> > +
> > +	/* WM97XX_PRP value to configure while system is suspended */
> > +	u16 suspend_mode;

I'm more accustomed to thinking that the driver will
know "the" setup bit values to assign which will
ensure that the chip issues wakeup events ... that
stuff is usually not board-specific.


> >  };
> >  
> >  struct wm97xx {
> > -- 
> > 1.5.5
> > 
> 
> -- 
> Dmitry
> 


