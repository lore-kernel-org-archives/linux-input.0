From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: Re: [RFC PATCH 2/2] Input: gpio-keys: implemented support for
	enabling/disabling gpios
Date: Thu, 12 Nov 2009 08:23:26 +0200
Message-ID: <20091112062326.GB3955@esdhcp04058.research.nokia.com>
References: <1257929573.21596.960.camel@localhost> <cover.1257931659.git.ext-mika.1.westerberg@nokia.com> <ac11b18d9fbb22ca88b61d73bc1e47e0068e9a86.1257931659.git.ext-mika.1.westerberg@nokia.com> <cover.1257931659.git.ext-mika.1.westerberg@nokia.com> <9b012ed801479acf5d4cbdf29292fdfc937d5e07.1257931659.git.ext-mika.1.westerberg@nokia.com> <873a4li0ul.fsf@tac.ki.iif.hu> <20091111145206.GA3955@esdhcp04058.research.nokia.com> <20091111170849.GA10663@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:25679 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbZKLG2I (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Nov 2009 01:28:08 -0500
Content-Disposition: inline
In-Reply-To: <20091111170849.GA10663@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ext Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: ext Ferenc Wagner <wferi@niif.hu>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Wed, Nov 11, 2009 at 06:08:49PM +0100, ext Dmitry Torokhov wrote:
> On Wed, Nov 11, 2009 at 04:52:06PM +0200, Mika Westerberg wrote:
> > On Wed, Nov 11, 2009 at 03:37:38PM +0100, ext Ferenc Wagner wrote:
> > > Mika Westerberg <ext-mika.1.westerberg@nokia.com> writes:
> > > 
> > > > +	for (i = 0; i < pdata->nbuttons; i++) {
> > > > +		struct gpio_keys_button *button = &pdata->buttons[i];
> > > > +		struct gpio_button_data *bdata = &ddata->data[i];
> > > > +
> > > > +		if (button->code == st->code && button->type == st->type) {
> > > > +			switch (st->state) {
> > > > +			case EVENT_STATE_DISABLE:
> > > > +				if (bdata->state == EVENT_STATE_ENABLE) {
> > > > +					bdata->state = EVENT_STATE_DISABLE;
> > > > +					/*
> > > > +					 * Disable physical irq line.  This is
> > > > +					 * enough also for keeping device from
> > > > +					 * waking up during sleep so no need
> > > > +					 * to change wakeup flags for this irq.
> > > > +					 */
> > > > +					disable_irq(gpio_to_irq(button->gpio));
> > > 
> > > Hi Mika,
> > > 
> > > Did you consider what would happen when several GPIO buttons share a
> > > single IRQ?  The current code does not support this (it uses IRQF_SHARED
> > > for a different reason), but this is very much possible: see for example
> > > http://thread.gmane.org/gmane.linux.kernel.input/8775 for a related
> > > thread which unfortunately died off without conclusion (but the patch
> > > went in).
> > 
> > Good point!  I didn't consider that at all. 
> > 
> > Maybe we disable irq only when it is not shared with anything else (even
> > with other GPIO button) and otherwise return -EINVAL or something like
> > that?
> > 
> 
> How could a driver know if it is [going to] share irq with another
> driver. Dmitry's (the other one ;) ) patch was needed because he wanted
> to share IRQ with another device entirely.

Ah, it seems that there is no such API in the kernel :(

How about specifying whether some GPIO button allows sharing of the IRQ
in board files (e.g amend gpio_keys_button struct)? Then we can disable
only those GPIO buttons where IRQ line is not shared.

Thanks,
MW
