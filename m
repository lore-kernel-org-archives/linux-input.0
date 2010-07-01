From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v2 2/2] Input: ads7846 - extend the driver for ads7845
 controller support
Date: Thu, 1 Jul 2010 13:23:21 +0200
Message-ID: <20100701132321.5111d872@wker>
References: <1272630181-5364-2-git-send-email-agust@denx.de>
	<1277803793-15077-1-git-send-email-agust@denx.de>
	<20100630081805.GD4154@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:47751 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755521Ab0GALX3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Jul 2010 07:23:29 -0400
In-Reply-To: <20100630081805.GD4154@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Detlev Zundel <dzu@denx.de>

On Wed, 30 Jun 2010 01:18:05 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Tue, Jun 29, 2010 at 11:29:53AM +0200, Anatolij Gustschin wrote:
> > ADS7845 is a controller for 5-wire touch screens and
> > somewhat different from 7846. It requires three serial
> > communications to accomplish one complete conversion.
> > Unlike 7846 it doesn't allow Z1-/Z2- position measurement.
> > 
> > The patch extends the ads7846 driver to also support
> > ads7845. The packet struct is extended to contain
> > needed command and conversion buffers. ads7846_rx()
> > and ads7846_rx_val() now differentiate between 7845
> > and 7846 case. ads7846_probe() is modified to setup
> > ads7845 specific command and conversion messages and
> > to switch ads7845 into power-down mode, since this is
> > needed to be prepared to respond to pendown interrupts.
> > 
> 
> Thank you for making changes Anatolij, I iwll be applying the patch to
> my 2.6.36 queue.
> 
> I just noticed that your previous patch alters pdata which I belive is
> wrong thing to do. Could you please try the following patch and let me
> know if I broke anything?

The patch needs a small fix, please see below.

...
> -	if (!pdata->irq_flags)
> -		pdata->irq_flags = IRQF_TRIGGER_FALLING;
> +	irq_flags = pdata->irq_flags ? : IRQF_TRIGGER_FALLING;
> 
> -	if (request_irq(spi->irq, ads7846_irq, pdata->irq_flags,
> -			spi->dev.driver->name, ts)) {
> +	err = request_irq(spi->irq, ads7846_irq, pdata->irq_flags,
> +			  spi->dev.driver->name, ts);

We should pass previously obtained 'irq_flags' to request_irq(),
not the original 'pdata->irq_flags'. I fixed this and tested the
corrected patch with ads7845, it is okay now. I'll submit the
corrected patch shortly.

Thanks,
Anatolij
