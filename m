From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] edt_ts: EDT Touchscreen driver
Date: Tue, 15 Nov 2011 09:41:37 -0800
Message-ID: <20111115174137.GB15129@core.coreip.homeip.net>
References: <1320795279-2018-1-git-send-email-yanok@emcraft.com>
 <20111114172809.GD12659@core.coreip.homeip.net>
 <4EC1832D.3080405@emcraft.com>
 <20111114213241.GA26418@core.coreip.homeip.net>
 <20111115101715.7b330e1d@wker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:36239 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958Ab1KORlo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Nov 2011 12:41:44 -0500
Received: by ywt32 with SMTP id 32so3722532ywt.19
        for <linux-input@vger.kernel.org>; Tue, 15 Nov 2011 09:41:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111115101715.7b330e1d@wker>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anatolij Gustschin <agust@denx.de>
Cc: Ilya Yanok <yanok@emcraft.com>, linux-input@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com

On Tue, Nov 15, 2011 at 10:17:15AM +0100, Anatolij Gustschin wrote:
> Hi Dmitry,
> 
> On Mon, 14 Nov 2011 13:32:42 -0800
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > On Tue, Nov 15, 2011 at 01:07:57AM +0400, Ilya Yanok wrote:
> > > Hi Dmitry,
> > > 
> > > On 14.11.2011 21:28, Dmitry Torokhov wrote:
> > > >> +	irq = gpio_to_irq(pdata->irq_gpio);
> > > >> +	if (irq < 0) {
> > > >> +		dev_err(&client->dev, "can't get IRQ for GPIO\n");
> > > >> +		error = -EINVAL;
> > > >> +		goto err0;
> > > >> +	}
> > > > 
> > > > Why can't we use client->irq?
> > > 
> > > Well, my idea was to avoid duplication (passing both GPIO and IRQ
> > > numbers) and I can't pass only client->irq as we need GPIO number also
> > > and irq_to_gpio is not guaranteed to work with arbitrary IRQ number.
> > 
> > Do you really need to read gpio state in IRQ? Can't you simply rely on
> > 'event' do decide whether to emit input events?
> 
> We can't rely on the 'event' only. The peculiar behaviour of the
> touch controller enforces this. The touch controller toggles the
> interrupt line when you keep the finger down. The rate is not exactly
> specified by the the manufacturer (~80/sec). Measured rate deviates
> from this specified rate. Valid touch packet data can be read when
> interrupt line is pulled down.

So what ensures that the gpio line stays low between the check and the
time you get access to i2c bus and get around reading the data.

> The designer of the target device
> insisted on driver implementation reading touch packet data only
> when irq line is pulled down.

Well... have you tried checkign whether it is really necessary. Because
if it is not necessary you could do away with the platform data
altogether.

Thanks.

-- 
Dmitry
