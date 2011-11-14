From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] edt_ts: EDT Touchscreen driver
Date: Mon, 14 Nov 2011 13:32:42 -0800
Message-ID: <20111114213241.GA26418@core.coreip.homeip.net>
References: <1320795279-2018-1-git-send-email-yanok@emcraft.com>
 <20111114172809.GD12659@core.coreip.homeip.net>
 <4EC1832D.3080405@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:55723 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595Ab1KNVcu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 16:32:50 -0500
Received: by ywt32 with SMTP id 32so2667399ywt.19
        for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 13:32:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4EC1832D.3080405@emcraft.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ilya Yanok <yanok@emcraft.com>
Cc: linux-input@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com, Anatolij Gustshin <agust@denx.de>

On Tue, Nov 15, 2011 at 01:07:57AM +0400, Ilya Yanok wrote:
> Hi Dmitry,
> 
> On 14.11.2011 21:28, Dmitry Torokhov wrote:
> >> +	irq = gpio_to_irq(pdata->irq_gpio);
> >> +	if (irq < 0) {
> >> +		dev_err(&client->dev, "can't get IRQ for GPIO\n");
> >> +		error = -EINVAL;
> >> +		goto err0;
> >> +	}
> > 
> > Why can't we use client->irq?
> 
> Well, my idea was to avoid duplication (passing both GPIO and IRQ
> numbers) and I can't pass only client->irq as we need GPIO number also
> and irq_to_gpio is not guaranteed to work with arbitrary IRQ number.

Do you really need to read gpio state in IRQ? Can't you simply rely on
'event' do decide whether to emit input events?

Also:

- please do not report fake pressure events since the device does
not seem to support true pressure reading (tslib has been fixed ages
ago).

- consider using i2c_transfer() instead of sequential
  master_send/master_receive.

- What stops the contoller from generating more interrupts/schedule more
  work/re-fire timer after edt_ts_close() is completed? You don't
actually communicate to the controller that ti should shut off.

Thanks.

-- 
Dmitry
