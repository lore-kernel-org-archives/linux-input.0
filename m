From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] [PATCH] Input: ADP5588 - Support gpio function on unused
 pin
Date: Fri, 16 Jul 2010 09:42:39 -0700
Message-ID: <20100716164239.GC9232@core.coreip.homeip.net>
References: <AANLkTikJKMYajxh799evj7Xv_HV3DFhabCZgYDkhuokh@mail.gmail.com>
 <AANLkTimbg9yhPvR8vya2dN4MIOF0JxyKbOrpQ_T0R_T3@mail.gmail.com>
 <544AC56F16B56944AEC3BD4E3D5917712E7EA5A357@LIMKCMBX1.ad.analog.com>
 <AANLkTimCA8gNc6aQW46ESbSbqxT6UGoqbT5PWC3vwkBc@mail.gmail.com>
 <20100716162017.GA9232@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:56508 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983Ab0GPQms (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Jul 2010 12:42:48 -0400
Received: by pvc7 with SMTP id 7so865483pvc.19
        for <linux-input@vger.kernel.org>; Fri, 16 Jul 2010 09:42:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100716162017.GA9232@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Xiaolong CHEN <a21785@motorola.com>
Cc: "Hennerich, Michael" <Michael.Hennerich@analog.com>, david-b@pacbell.net, Xiaolong CHEN <xiao-long.chen@motorola.com>, Michael Hennerich <hennerich@blackfin.uclinux.org>, linux-input@vger.kernel.org, TAO HU <taohu@motorola.com>, "Yuan.Bo YE" <yuan-bo.ye@motorola.com>

One more thing...

On Fri, Jul 16, 2010 at 09:20:18AM -0700, Dmitry Torokhov wrote:
> On Fri, Jul 16, 2010 at 07:48:07PM +0800, Xiaolong CHEN wrote:
> >  static int __devexit adp5588_remove(struct i2c_client *client)
> >  {
> > +	int ret;
> >  	struct adp5588_kpad *kpad = i2c_get_clientdata(client);
> > 
> >  	adp5588_write(client, CFG, 0);
> >  	free_irq(client->irq, kpad);
> >  	cancel_delayed_work_sync(&kpad->work);
> >  	input_unregister_device(kpad->input);
> > +	if (kpad->support_gpio)
> > +		ret = gpiochip_remove(&kpad->gpio_chip);

You need to actually handle this (add an error message) since we can't
simply ignore errors.

However I think that having gpiochip_remove() __must_check while
gpiochip_add is quite silly.

I'd argue that gpiochip_remove() should wither WARN or BUG if we trying
to remove a chip that still has GPIOs requested and return void since
callers normally can't do anything about the failure. Many simply abort
device teardown leaving device a zombie and report failure up the stack,
to the driver core, where it is ignored. Not very helpful.

-- 
Dmitry
