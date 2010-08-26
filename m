From: Sundar R IYER <sundar.iyer@stericsson.com>
Subject: Re: [Patch v2] input: add support for Nomadik SKE keypad controller
Date: Thu, 26 Aug 2010 21:39:01 +0530
Message-ID: <20100826160901.GE9924@bnru01.bnr.st.com>
References: <1282638651-8000-1-git-send-email-sundar.iyer@stericsson.com>
 <20100826154907.GA5603@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:35689 "EHLO
	eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754045Ab0HZQJY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Aug 2010 12:09:24 -0400
Content-Disposition: inline
In-Reply-To: <20100826154907.GA5603@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Shubhrajyoti Datta <shubhrajyoti@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, Linus WALLEIJ <linus.walleij@stericsson.com>

Hello Dmitry,

Thanx for the review.

On Thu, Aug 26, 2010 at 17:49:08 +0200, Dmitry Torokhov wrote:
> > +     int (*init)(void);
> > +     int (*exit)(void);
> > +     struct matrix_keymap_data *keymap_data;
> 
> const?

Okay.

> > +     struct input_dev *input;
> > +     struct ske_keypad_platform_data *board;
> 
> const?

Okay.

> > +DEFINE_MUTEX(ske_keypad_lock);
> 
> Why isn't this lock part of ske_keypad structure?
> 

Will move it in.

> > +
> > +     mutex_lock(&ske_keypad_lock);
> 
> Should probably be a spinlock.
> 

Since I am using a threaded_irq, I used mutex over spinlock.

> > +static int __init ske_keypad_chip_init(struct ske_keypad *keypad)
> 
> This must be __devinit, not __init since it is called from __devinit
> code.

Sure.

> > +     /* while away till the SKEx registers are stable and can be read */
> > +     while (readl(keypad->reg_base + SKE_CR) & SKE_KPASON)
> > +             cpu_relax();
> 
> I'd rather this loop had a bound. We do not want to completely wedge IRQ
> thread if something goes wrong.
> 

My main concern is: what do I return from here in case of a timeout. For
the HW, this flag is always high as long as any key is pressed and the
auto scan active. For a multi key press, this flag has to be waited upon
before reading the data registers. Please advise on how do I return from
here.

> BTW, it this the only reason why we are using threaded IRQ here? What is
> the expected time for the registers to settle? Might we use a timer to
> postpone the read (I think that threaded IRQs are very convenient and
> quite often the best solution but hard IRQ + timer is probably easier on
> resources unless leads to complicated logic).

Yes. The expected settling time for the register is ~10msc when the key
is pressed to almost nil when the key is released. Please note that
these are just initial figures which I probed for a rough a data. But,
even for the timer, I dont know when to start reading because, a key
press might still betriggering an auto scan.

> > +     struct resource *res = NULL;
> 
> Why does it need to be initialized?

Okay. will remove it.

> > +     struct ske_keypad_platform_data *plat = pdev->dev.platform_data;
> 
> const.

Okay.

> > +             dev_err(&pdev->dev, "failed to allocate keypad memory\n");
> 
> ret = -ENOMEM. Presonally I prefer these to be called err or error and
> explicitely "return 0" in success path.

Will add it up.

> > +
> > +     if (!keypad->board->init) {
> > +             dev_err(&pdev->dev, "NULL board initialization helper\n");
> 
> Could be checked earlier. Also, does it have to be an error?
> 

The platform code takes care to request the GPIOs and the GPIO configurations.
Hence I return error in case the board configurations dont get completed.

> > +     free_irq(keypad->irq, keypad);
> 
> 
> You need to free IRQ before unregistering the device or you may end up
> referencing free memory.

Okay.

> 
> Where is the call to board->exit()?
> 

Yes. I did miss that.

> > +static int __init ske_keypad_init(void)
> > +{
> > +     return platform_driver_register(&ske_keypad_driver);
> 
> Maybe switch to platform_driver_probe() since it is unlikely the
> device would appear after driver initialized?
> 
Okay.

Regards,
Sundar

