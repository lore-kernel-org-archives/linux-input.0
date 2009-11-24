From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: Re: [PATCH v2 1/2] Input: gpio-keys - allow platform to specify
	exact irq flags
Date: Tue, 24 Nov 2009 19:02:49 +0200
Message-ID: <20091124170249.GQ17675@esdhcp04058.research.nokia.com>
References: <20091120084054.GC3009@core.coreip.homeip.net> <cover.1258976669.git.ext-mika.1.westerberg@nokia.com> <cover.1258976669.git.ext-mika.1.westerberg@nokia.com> <8237c9a4afd1fa883120b5793fcd91a970d2ffb7.1258976669.git.ext-mika.1.westerberg@nokia.com> <87y6lxchwf.fsf@tac.ki.iif.hu> <20091123172451.GD17813@core.coreip.homeip.net> <87tywlcbyr.fsf@tac.ki.iif.hu> <20091124063711.GL17675@esdhcp04058.research.nokia.com> <87my2cp4h6.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:24427 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933471AbZKXRH1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Nov 2009 12:07:27 -0500
Content-Disposition: inline
In-Reply-To: <87my2cp4h6.fsf@tac.ki.iif.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ext Ferenc Wagner <wferi@niif.hu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Tue, Nov 24, 2009 at 12:05:57PM +0100, ext Ferenc Wagner wrote:
[snip]
> >> Or let for example -1 mean 0, which is ugly, to say the least.
> >
> > How about adding (again) new field: bool custom_irqflags?
> 
> Thinking about it, since multiple buttons can share a single IRQ, this
> can't be a per-button field after all.  Perhaps a better solution would
> be adding a new mapping to the platform data:
> 
> struct gpio_keys_irq {
>         int irq;
>         int irqflags;
>         int wakeup;                 /* replace the per-button field */
> }
> 
> struct gpio_keys_platform_data {
>         struct gpio_keys_button *buttons;
>         int nbuttons;
>         unsigned int rep:1;
>         struct gpio_keys_irq *irqs; /* new member */
>         int nirqs;                  /* new member */
> };

OK. This seems reasonable.

> >> Anyway, I'd much prefer an implementation which doesn't work against
> >> having multiple buttons on a single IRQ line, which is the case for
> >> example in arch/mips/bcm47xx/gpio.c.  Then the IRQ could still be
> >> disabled if all its buttons are disabled, unless it's shared with
> >> another driver (and IRQF_SHARED would control this aspect sharing).
> >
> > Do you mean something like:
> >
> > 	if (button->custom_irqflags) {
> > 		if (button->irqflags & IRQF_SHARED) {
> > 			/* cannot mute this button */
> > 		} else {
> > 			...
> > 	}
> 
> Not quite, because the default irqflags contain IRQF_SHARED.  More like:
> 
> disable_button (this);
> if (button->custom_irqflags && !(button->irqflags & IRQF_SHARED)
>     && (all buttons on this IRQ are disabled)) {
>         disable_irq (gpio_to_irq (this));
> }

I actually meant this code snippet to be in the function gpio_keys_setup_key()
where it only checks whether button can be disabled. Sorry for forgotting
to mention the context.

> > In our case, we only have 1:1 mapping between GPIO lines and buttons so
> > current version works but if there are any (possible) users for this kind
> > of setup I can implement it.
> 
> I quoted (and own) a platform with such arrangement.  I'm somewhat short
> on time to work on this hobby project, but of course I don't expect you
> to do the heavy lifting.  Unfortunately I haven't yet managed to get a
> clear picture about how to properly attack it (the problem is GPIO
> access from the IRQ handler, if you didn't read the thread), so I
> couldn't produce acceptable code (even though in my case gpio_get_value
> can't sleep, so I've got working code).  Meanwhile, I'm trying to do my
> best to not let things go in a direction which makes this change harder
> that it currently is.  I'm really sorry this hurts your efforts.

Thanks for clarifying things. It really don't hurt my efforts; I get
paid for doing this :)

So I'll try to implement this gpio-keys muting so that it allows
also multiple buttons to share single IRQ line.

Thanks,
MW
