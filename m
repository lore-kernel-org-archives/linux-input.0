From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: egalax_ts - do not release gpio if probe
 successful
Date: Thu, 12 Jan 2017 15:40:57 -0800
Message-ID: <20170112234057.GA17933@dtor-ws>
References: <20170111172841.9825-1-gary.bisson@boundarydevices.com>
 <20170112183019.GB7475@dtor-ws>
 <20170112230343.rt6e2qrhnvl4cvqq@x240.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33406 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750948AbdALXlA (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 12 Jan 2017 18:41:00 -0500
Content-Disposition: inline
In-Reply-To: <20170112230343.rt6e2qrhnvl4cvqq@x240.lan>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gary Bisson <gary.bisson@boundarydevices.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jan 13, 2017 at 12:03:43AM +0100, Gary Bisson wrote:
> Hi Dmitri,
> 
> On Thu, Jan 12, 2017 at 10:30:19AM -0800, Dmitry Torokhov wrote:
> > Hi Gary,
> > 
> > On Wed, Jan 11, 2017 at 06:28:41PM +0100, Gary Bisson wrote:
> > > Thus preventing anyone to later modify the interrupt GPIO direction
> > > and/or state without the driver knowing.
> > 
> > I am afraid not releasing gpio after waking up the controller will cause
> > request_irq to fail if we are using the same pin for interrupt and
> > wakeup (as majority of current DTSes do: see
> > arch/arm/boot/dts/imx53-tx53-x13x.dts for example).
> 
> No, keeping the GPIO doesn't prevent from requesting the IRQ.
> 
> However it keeps other drivers/users from changing the GPIO as output
> later on.


Hmm, I think _gpiod_direction_output_raw() will not let them as it
checks FLAG_USED_AS_IRQ, so as long as it's the same line it's OK. But I
guess if they are separate some other component might try to grab it and
mess with it.

OK, in this case please:

- use devm_gpiod_get
- request with GPIOD_OUT_LOW
- do not override the return value with -ENODEV (especially important
  with probe deferrals)
- lose gpiod_direction_output() call
- move everything into egalax_ts_probe() as egalax_wake_up_device() is
  no longer self-contained. 

Thanks!

-- 
Dmitry
