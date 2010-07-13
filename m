From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: gpio_keys: polling mode support
Date: Mon, 12 Jul 2010 18:28:19 -0700
Message-ID: <20100713012819.GA15800@core.coreip.homeip.net>
References: <20100706190128.GB24655@chipmunk>
 <20100712192950.GR6976@chipmunk>
 <20100713011707.GA12728@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:39091 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449Ab0GMB2Y (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Jul 2010 21:28:24 -0400
Received: by pwi5 with SMTP id 5so2066211pwi.19
        for <linux-input@vger.kernel.org>; Mon, 12 Jul 2010 18:28:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100713011707.GA12728@linux-sh.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Alexander Clouter <alex@digriz.org.uk>, linux-input@vger.kernel.org

On Tue, Jul 13, 2010 at 10:17:07AM +0900, Paul Mundt wrote:
> On Mon, Jul 12, 2010 at 08:29:51PM +0100, Alexander Clouter wrote:
> > Hi,
> > 
> > -EDONTCARE? :(
> > 
> You could try Cc-ing akpm on the next version, so it at least doesn't get
> lost.
> 
> > >  
> > > +#if defined(CONFIG_INPUT_POLLDEV) || defined(CONFIG_INPUT_POLLDEV_MODULE)
> > > +static void gpio_keys_poll(struct input_polled_dev *dev)
> > > +{
> > > +	struct gpio_keys_drvdata *ddata = dev->private;
> > > +	int i;
> > > +
> > > +	for (i = 0; i < ddata->n_buttons; i++) {
> > > +		struct gpio_button_data *bdata = &ddata->data[i];
> > > +		struct gpio_keys_button *button = bdata->button;
> > > +
> > > +		gpio_handle_button_event(button, bdata);
> > > +	}
> > > +}
> > > +#endif
> > > +
> This gets back to why I opted to select the polldev stuff in the first
> place, to avoid the total mess that all of the ifdeffery causes without
> it. It's also inconsistent, as you have the poll interval tested openly
> in some places and always defined, while the poll dev itself is always
> under ifdef due to the input layer definitions.
> 
> Personally I've never found the argument that the polling stuff should be
> optional very convincing. It's a reasonable mode of operation for devices
> that don't have IRQs bound to GPIOs, and having to depend on the platform
> to select random bits of input subsystem infrastructure to support a
> driver that may or may not be enabled at all is ugly at best.

Let me play a tad with it and if I can't untangle it reasonably I'll
just dig up old Paul's patch.

-- 
Dmitry
