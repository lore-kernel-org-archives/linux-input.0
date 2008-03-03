From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: +
 input-add-debouncing-for-generic-gpio-input-device-gpio_keyc.patch added to
 -mm tree
Date: Mon, 3 Mar 2008 15:10:08 -0800
Message-ID: <20080303151008.3efdc9d6.akpm@linux-foundation.org>
References: <200803032230.m23MUgas010098@imap1.linux-foundation.org>
	<47CC81FD.2050905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49008 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752761AbYCCXKs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 3 Mar 2008 18:10:48 -0500
In-Reply-To: <47CC81FD.2050905@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: ek9852@gmail.com, anti.sullin@artecdesign.ee, david-b@pacbell.net, dtor@mail.ru, hvr@gnu.org, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Mon, 03 Mar 2008 23:55:57 +0100
Jiri Slaby <jirislaby@gmail.com> wrote:

> On 03/03/2008 11:30 PM, akpm@linux-foundation.org wrote:
> > Subject: input: add debouncing for generic gpio input device gpio_key.c
> > From: Keith Mok <ek9852@gmail.com>
> > 
> > Add debouncing support for the generic gpio input device, since debouncing is
> > most likely to happen.
> > 
> > Signed-off-by: Keith Mok <ek9852@gmail.com>
> > Cc: Herbert Valerio Riedel <hvr@gnu.org>
> > Cc: Dmitry Torokhov <dtor@mail.ru>
> > Cc: Jiri Slaby <jirislaby@gmail.com>
> > Cc: Anti Sullin <anti.sullin@artecdesign.ee>
> > Cc: David Brownell <david-b@pacbell.net>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > ---
> > 
> >  drivers/input/keyboard/gpio_keys.c |  106 +++++++++++++++++++++++----
> >  1 file changed, 93 insertions(+), 13 deletions(-)
> > 
> > diff -puN drivers/input/keyboard/gpio_keys.c~input-add-debouncing-for-generic-gpio-input-device-gpio_keyc drivers/input/keyboard/gpio_keys.c
> > --- a/drivers/input/keyboard/gpio_keys.c~input-add-debouncing-for-generic-gpio-input-device-gpio_keyc
> > +++ a/drivers/input/keyboard/gpio_keys.c
> [...]
> >  static irqreturn_t gpio_keys_isr(int irq, void *dev_id)
> [...]
> > +	/* disable keyboard interrupt and schedule for handling */
> > +	for (i = 0; i < pdata->nbuttons; i++) {
> > +		int irq = gpio_to_irq(pdata->buttons[i].gpio);
> > +		disable_irq(irq);
> 
> Are you 100% sure here (are you disabling irqs other than this one)? No 
> disable_irq_nosync? Anyway why is the disabling needed at all?
> 

lol, I cc'ed the wrong Jiri and it worked out well.

Please do cc the appropriate mailing list when replying to -mm commit
emails.
