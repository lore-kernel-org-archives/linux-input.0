From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: wm831x - Add driver for Wolfson WM831x PMIC
 touchscreen controllers
Date: Tue, 25 Jan 2011 11:51:09 -0800
Message-ID: <20110125195109.GB19823@core.coreip.homeip.net>
References: <1295964556-1024-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20110125170729.GD19701@core.coreip.homeip.net>
 <20110125193423.GA19779@opensource.wolfsonmicro.com>
 <20110125195019.GA19823@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43524 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752919Ab1AYTvP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Jan 2011 14:51:15 -0500
Received: by iyj18 with SMTP id 18so5440255iyj.19
        for <linux-input@vger.kernel.org>; Tue, 25 Jan 2011 11:51:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110125195019.GA19823@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com

On Tue, Jan 25, 2011 at 11:50:19AM -0800, Dmitry Torokhov wrote:
> On Tue, Jan 25, 2011 at 07:34:23PM +0000, Mark Brown wrote:
> > On Tue, Jan 25, 2011 at 09:07:29AM -0800, Dmitry Torokhov wrote:
> > > On Tue, Jan 25, 2011 at 02:09:16PM +0000, Mark Brown wrote:
> > 
> > > > +	int data_irq;
> > > > +	int pd_irq;
> > 
> > > Maybe make irqs unsigned?
> > 
> > I guess.
> > 
> > > > +static void wm831x_ts_input_close(struct input_dev *idev)
> > > > +{
> > > > +	struct wm831x_ts *wm831x_ts = input_get_drvdata(idev);
> > > > +	struct wm831x *wm831x = wm831x_ts->wm831x;
> > > > +
> > > > +	wm831x_set_bits(wm831x, WM831X_TOUCH_CONTROL_1,
> > > > +			WM831X_TCH_ENA | WM831X_TCH_CVT_ENA |
> > > > +			WM831X_TCH_X_ENA | WM831X_TCH_Y_ENA |
> > > > +			WM831X_TCH_Z_ENA, 0);
> > > > +
> > > > +	if (wm831x_ts->pen_down)
> > > > +		disable_irq_nosync(wm831x_ts->data_irq);
> > 
> > > Why nosync?
> > 
> > Cut'n'paste from the pen up handling in the data IRQ (which obviously
> > does need to be nosync due to the fact that it runs from IRQ context).
> > 
> > > > +	input_dev = input_allocate_device();
> > 
> > > Are we 100% sure it is impossible for the 2 irqs above to fire up before
> > > we get here? Like if we happen to have hardware in half-active state
> > > while binding?
> > 
> > It's spectacularly unlikely - in the sort of hardware this device is
> > useful for nothing below Linux would realistically want to talk to the
> > touchscreen and since the IRQs are threaded they can't be shared.
> 
> Would you please move input allocation still - even if it works fine
> with your device the code might be used as an example by other
> authors... and there should be no penalties for your driver if you
> allocate just a tad earlier.
> 

Ah, you did already. Thank you.

-- 
Dmitry
