From: Alexander Clouter <alex@digriz.org.uk>
Subject: Re: [PATCH] input: gpio_keys: polling mode support
Date: Tue, 13 Jul 2010 08:26:05 +0100
Message-ID: <20100713072605.GS6976@chipmunk>
References: <20100706190128.GB24655@chipmunk> <20100712192950.GR6976@chipmunk> <20100713011707.GA12728@linux-sh.org> <20100713012819.GA15800@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from chipmunk.wormnet.eu ([195.195.131.226]:57384 "EHLO
	chipmunk.wormnet.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520Ab0GMH0J (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Jul 2010 03:26:09 -0400
Content-Disposition: inline
In-Reply-To: <20100713012819.GA15800@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-input@vger.kernel.org

Hi,

* Dmitry Torokhov <dmitry.torokhov@gmail.com> [2010-07-12 18:28:19-0700]:
>
> > > > +#if defined(CONFIG_INPUT_POLLDEV) || defined(CONFIG_INPUT_POLLDEV_MODULE)
> > > > +static void gpio_keys_poll(struct input_polled_dev *dev)
> > > > +{
> > > > +	struct gpio_keys_drvdata *ddata = dev->private;
> > > > +	int i;
> > > > +
> > > > +	for (i = 0; i < ddata->n_buttons; i++) {
> > > > +		struct gpio_button_data *bdata = &ddata->data[i];
> > > > +		struct gpio_keys_button *button = bdata->button;
> > > > +
> > > > +		gpio_handle_button_event(button, bdata);
> > > > +	}
> > > > +}
> > > > +#endif
> >
> > This gets back to why I opted to select the polldev stuff in the first
> > place, to avoid the total mess that all of the ifdeffery causes without
> > it.
>
Well, for me the ifdef madness really only looks bad as (took me a while 
to work out) as when configuring polldev to be a module things do not 
set CONFIG_INPUT_POLLDEV.  Is this normal?

grep'ing /usr/src/linux/{arch,drivers/input} for 
CONFIG_INPUT_POLLDEV_MODULE comes up with no matchs at all (except for 
gpio_keys.c after my patch is applied).

To clean up the ifdef madness, the only approach I can think of is to 
define some dummy noop input_allocate_polled_device(), 
input_free_polled_device() and input_unregister_polled_device() 
functions defined in gpio_keys.c when CONFIG_INPUT_POLLDEV is not 
compiled in.

I am happy to do this if preferred?

I can see the argument against forcing gpio_key users having to use 
polldev (it adds 10kB to the kernel for me), especially on my platform I 
have a 4MB Flash and my kernel can only be 768kB...

> > It's also inconsistent, as you have the poll interval tested openly
> > in some places and always defined, while the poll dev itself is always
> > under ifdef due to the input layer definitions.
>
It was meant to me, you will notice the non-ifdef sections do not do 
anything other than check if poll_interval is non-zero.  As this is not 
an expensive check for the CPU but it is argubly expensive on 
readability throwing in some more ifdef's...I felt it a good compromise.
 
> > Personally I've never found the argument that the polling stuff should be
> > optional very convincing. It's a reasonable mode of operation for devices
> > that don't have IRQs bound to GPIOs, and having to depend on the platform
> > to select random bits of input subsystem infrastructure to support a
> > driver that may or may not be enabled at all is ugly at best.
> 
> Let me play a tad with it and if I can't untangle it reasonably I'll
> just dig up old Paul's patch.
> 
Paul's patch unneccessarily extends gpio_keys_drvdata with 
gpio_keys_platform_data.

Cheers

-- 
Alexander Clouter
.sigmonster says: Never argue with a woman when she's tired -- or rested.
