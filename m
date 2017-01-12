From: Gary Bisson <gary.bisson@boundarydevices.com>
Subject: Re: [PATCH] Input: egalax_ts - do not release gpio if probe
 successful
Date: Fri, 13 Jan 2017 00:03:43 +0100
Message-ID: <20170112230343.rt6e2qrhnvl4cvqq@x240.lan>
References: <20170111172841.9825-1-gary.bisson@boundarydevices.com>
 <20170112183019.GB7475@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170112183019.GB7475@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitri,

On Thu, Jan 12, 2017 at 10:30:19AM -0800, Dmitry Torokhov wrote:
> Hi Gary,
> 
> On Wed, Jan 11, 2017 at 06:28:41PM +0100, Gary Bisson wrote:
> > Thus preventing anyone to later modify the interrupt GPIO direction
> > and/or state without the driver knowing.
> 
> I am afraid not releasing gpio after waking up the controller will cause
> request_irq to fail if we are using the same pin for interrupt and
> wakeup (as majority of current DTSes do: see
> arch/arm/boot/dts/imx53-tx53-x13x.dts for example).

No, keeping the GPIO doesn't prevent from requesting the IRQ.

However it keeps other drivers/users from changing the GPIO as output
later on.

> You'll need to figure out if irq is backed by the same gpio as wakeup
> and act accordingly.
> 
> What setup did you test this on? Was it shared pin or dedicated wakeup?

I've tested on i.MX6Q Nitrogen6x [1] with Hannstar 10" display [2].

Regards,
Gary

[1] https://boundarydevices.com/product/nitrogen6x-board-imx6-arm-cortex-a9-sbc/
[2] https://boundarydevices.com/product/nit6x_10-1hannstar/
