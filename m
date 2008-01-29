From: "eric miao" <eric.y.miao@gmail.com>
Subject: Re: [PATCH 2/12] pxa: remove the pin configuration from the keypad driver
Date: Tue, 29 Jan 2008 14:51:51 +0800
Message-ID: <f17812d70801282251g79b7c29ehf1f6afdf5274fcd4@mail.gmail.com>
References: <f17812d70801222317k641d55fy8f94c436770a8b0a@mail.gmail.com>
	 <200801290124.56565.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.224]:37205 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369AbYA2Gvx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jan 2008 01:51:53 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1428585wxd.4
        for <linux-input@vger.kernel.org>; Mon, 28 Jan 2008 22:51:52 -0800 (PST)
In-Reply-To: <200801290124.56565.dtor@insightbb.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-input@vger.kernel.org

On Jan 29, 2008 2:24 PM, Dmitry Torokhov <dtor@insightbb.com> wrote:
> Hi Eric,
>
> On Wednesday 23 January 2008 02:17, eric miao wrote:
> > From dbd62bced0f789765d1823f66af792933c6b46a1 Mon Sep 17 00:00:00 2001
> > From: eric miao <eric.miao@marvell.com>
> > Date: Tue, 22 Jan 2008 16:34:12 +0800
> > Subject: [PATCH] pxa: remove the pin configuration from the keypad driver
> >
> > The pin configurations will slowly be moved to the board specific code
> > at initialization thus to make the driver more generic.
> >
> > Signed-off-by: eric miao <eric.miao@marvell.com>
> > ---
> >  drivers/input/keyboard/pxa27x_keypad.c   |    4 ----
> >  include/asm-arm/arch-pxa/pxa27x_keypad.h |    1 -
> >  2 files changed, 0 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/input/keyboard/pxa27x_keypad.c
> > b/drivers/input/keyboard/pxa27x_keypad.c
> > index 06c1d5a..43fb63d 100644
> > --- a/drivers/input/keyboard/pxa27x_keypad.c
> > +++ b/drivers/input/keyboard/pxa27x_keypad.c
> > @@ -208,10 +208,6 @@ static int __devinit pxa27x_keypad_probe(struct
> > platform_device *pdev)
> >       if (error)
> >               goto err_free_irq;
> >
> > -     /* Setup GPIOs. */
> > -     for (i = 0; i < pdata->nr_rows + pdata->nr_cols; i++)
> > -             pxa_gpio_mode(pdata->gpio_modes[i]);
> > -
>
> That would require GPIO code to be replicated in every subarch piece. Do you
> expect many boards require special GPIO setup or maybe it would make sense
> to keep something similar to the code above (possibly have pointer to array
> of gpio modes and array size in pdata)? This way simpler boards will just
> supply the list and more complex setups can still do it themselves?
>

Actually, pin configurations on different platforms vary much, and to keep
the driver generic enough, this stuff should really be pushed to the platform
code.

Currently, we (Nicolas, Russell King and I) are proposing a similar
pin configuration scheme as pxa3xx is currently doing for pxa{25x,27x}.

The specific reasons behind this change are:

1. pxa3xx uses a different mechanism and API to configure pins other
than the pxa{25x,27x}'s pxa_gpio_mode(), i.e., pxa_gpio_mode() is
no longer valid for pxa3xx. So this is really processor specific code
we need to keep out side of the driver

2. The driver should have no assumption to the platform configuration,
that is, when the ->probe() is called, any settings should be ready for
the driver to work, thus including pin configurations.

> --
> Dmitry
>



-- 
Cheers
- eric
