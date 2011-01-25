From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Input: wm831x - Add driver for Wolfson WM831x PMIC
 touchscreen controllers
Date: Tue, 25 Jan 2011 19:34:23 +0000
Message-ID: <20110125193423.GA19779@opensource.wolfsonmicro.com>
References: <1295964556-1024-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20110125170729.GD19701@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:58564 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751508Ab1AYTeH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Jan 2011 14:34:07 -0500
Content-Disposition: inline
In-Reply-To: <20110125170729.GD19701@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com

On Tue, Jan 25, 2011 at 09:07:29AM -0800, Dmitry Torokhov wrote:
> On Tue, Jan 25, 2011 at 02:09:16PM +0000, Mark Brown wrote:

> > +	int data_irq;
> > +	int pd_irq;

> Maybe make irqs unsigned?

I guess.

> > +static void wm831x_ts_input_close(struct input_dev *idev)
> > +{
> > +	struct wm831x_ts *wm831x_ts = input_get_drvdata(idev);
> > +	struct wm831x *wm831x = wm831x_ts->wm831x;
> > +
> > +	wm831x_set_bits(wm831x, WM831X_TOUCH_CONTROL_1,
> > +			WM831X_TCH_ENA | WM831X_TCH_CVT_ENA |
> > +			WM831X_TCH_X_ENA | WM831X_TCH_Y_ENA |
> > +			WM831X_TCH_Z_ENA, 0);
> > +
> > +	if (wm831x_ts->pen_down)
> > +		disable_irq_nosync(wm831x_ts->data_irq);

> Why nosync?

Cut'n'paste from the pen up handling in the data IRQ (which obviously
does need to be nosync due to the fact that it runs from IRQ context).

> > +	input_dev = input_allocate_device();

> Are we 100% sure it is impossible for the 2 irqs above to fire up before
> we get here? Like if we happen to have hardware in half-active state
> while binding?

It's spectacularly unlikely - in the sort of hardware this device is
useful for nothing below Linux would realistically want to talk to the
touchscreen and since the IRQs are threaded they can't be shared.
