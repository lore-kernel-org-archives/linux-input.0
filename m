From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] edt_ts: EDT Touchscreen driver
Date: Tue, 15 Nov 2011 10:17:15 +0100
Message-ID: <20111115101715.7b330e1d@wker>
References: <1320795279-2018-1-git-send-email-yanok@emcraft.com>
	<20111114172809.GD12659@core.coreip.homeip.net>
	<4EC1832D.3080405@emcraft.com>
	<20111114213241.GA26418@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:34642 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754092Ab1KOJRX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Nov 2011 04:17:23 -0500
In-Reply-To: <20111114213241.GA26418@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ilya Yanok <yanok@emcraft.com>, linux-input@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com

Hi Dmitry,

On Mon, 14 Nov 2011 13:32:42 -0800
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Tue, Nov 15, 2011 at 01:07:57AM +0400, Ilya Yanok wrote:
> > Hi Dmitry,
> > 
> > On 14.11.2011 21:28, Dmitry Torokhov wrote:
> > >> +	irq = gpio_to_irq(pdata->irq_gpio);
> > >> +	if (irq < 0) {
> > >> +		dev_err(&client->dev, "can't get IRQ for GPIO\n");
> > >> +		error = -EINVAL;
> > >> +		goto err0;
> > >> +	}
> > > 
> > > Why can't we use client->irq?
> > 
> > Well, my idea was to avoid duplication (passing both GPIO and IRQ
> > numbers) and I can't pass only client->irq as we need GPIO number also
> > and irq_to_gpio is not guaranteed to work with arbitrary IRQ number.
> 
> Do you really need to read gpio state in IRQ? Can't you simply rely on
> 'event' do decide whether to emit input events?

We can't rely on the 'event' only. The peculiar behaviour of the
touch controller enforces this. The touch controller toggles the
interrupt line when you keep the finger down. The rate is not exactly
specified by the the manufacturer (~80/sec). Measured rate deviates
from this specified rate. Valid touch packet data can be read when
interrupt line is pulled down. The designer of the target device
insisted on driver implementation reading touch packet data only
when irq line is pulled down.

> Also:
> 
> - please do not report fake pressure events since the device does
> not seem to support true pressure reading (tslib has been fixed ages
> ago).

Many projects still use tslib-1.0 (e.g. distributions based on
recent yoctoproject releases). Removing pressure event reporting
will certainly break touch screen support there.

Thanks,

Anatolij
