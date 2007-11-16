From: Herbert Valerio Riedel <hvr@gnu.org>
Subject: Re: [PATCH,RFC] Input: gpio-keys - request and configure GPIOs
Date: Fri, 16 Nov 2007 15:15:45 +0100
Message-ID: <1195222545.10848.54.camel@pbook.intra>
References: <1195212830-9137-1-git-send-email-hvr@gnu.org>
	 <d120d5000711160538u6f629e34h9465a880f09be49c@mail.gmail.com>
	 <74d0deb30711160602k3e19a660td5698b395f817a85@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx03.kabsi.at ([195.202.128.130]:38044 "EHLO mx03.kabsi.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765630AbXKPOPw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Nov 2007 09:15:52 -0500
In-Reply-To: <74d0deb30711160602k3e19a660td5698b395f817a85@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: pHilipp Zabel <philipp.zabel@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Paul Sokolovsky <pmiscml@gmail.com>, Philip Blundell <philb@gnu.org>


On Fri, 2007-11-16 at 15:02 +0100, pHilipp Zabel wrote:
> On Nov 16, 2007 2:38 PM, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > On Nov 16, 2007 6:33 AM, Herbert Valerio Riedel <hvr@gnu.org> wrote:
> > > Currently, gpio_keys.c assumes the GPIOs to be already properly configured;
> > > this patch changes gpio-keys to perform explicit calls to gpio_request() and
> > > gpio_configure_input().
> > >
> > > This matches the behaviour of leds-gpio.

> > Makes sense from where I sit but let's see what guys who actually use
> > the module say... ;)

> Looks good to me, too. I have yet to test, but at least the gpio_direction call
> is mandatory as per gpio api docs, so this fixes an actual bug.

> gpio_request is optional and claims the GPIO for this driver's use
> only (on architectures where this is supported), so I'm not sure if this is really needed, but it
> shouldn't harm any of the current users of gpio-keys.

yes, optional and no-harm, to quote the gpio API doc:

> These two calls are optional because not not all current Linux platforms
> offer such functionality in their GPIO support; a valid implementation
> could return success for all gpio_request() calls.  Unlike the other calls,
> the state they represent doesn't normally match anything from a hardware
> register; it's just a software bitmap which clearly is not necessary for
> correct operation of hardware or (bug free) drivers.

...but for instance, the current mach-orion/gpio.c implementation,
prints annoying printk warnings when someone fiddles with "unrequested"
GPIOs... :-)

cheers,
hvr

