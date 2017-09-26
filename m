From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] Input: sa1111ps2 - remove special sa1111 mmio accessors
Date: Tue, 26 Sep 2017 17:53:06 +0100
Message-ID: <20170926165306.GR20805@n2100.armlinux.org.uk>
References: <E1dwqel-000418-51@rmk-PC.armlinux.org.uk>
 <20170926164819.GA14833@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:54076 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968396AbdIZQxQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 26 Sep 2017 12:53:16 -0400
Content-Disposition: inline
In-Reply-To: <20170926164819.GA14833@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Tue, Sep 26, 2017 at 09:48:19AM -0700, Dmitry Torokhov wrote:
> On Tue, Sep 26, 2017 at 03:16:15PM +0100, Russell King wrote:
> > Remove the special SA1111 MMIO accessors from the SA1111 PS/2 driver
> > as their definition will be removed shortly.  The SA1111 accessors are
> > barrierless, so use the _relaxed variants.
> > 
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> 
> Russell,
> 
> Do you want me to take this patch or would you rather take it through
> your tree so removal of the accessors is not stalled by whole release
> cycle? Or there are few more drivers that also need to go through the
> pipeline so that is not a concern?

There's three subsystems of drivers involved: input, pcmcia and usb.
The usb ones have been acked by Alan Stern.  I'm not expecting any
reaction to the pcmcia ones, so that just leaves the input ones.

You're right that there are follow on patches - the stack looks like
this at the moment:

 ARM: sa1111: map interrupt numbers through irqdomain
 ARM: sa1111: use an irqdomain for SA1111 interrupts
 ARM: sa1111: remove some redundant definitions
 ARM: sa1111: remove special sa1111 mmio accessors
 ARM: sa1111: remove legacy suspend/resume methods
 ARM: sa1111: remove legacy shutdown method
 usb: ohci-sa1111: remove special sa1111 mmio accessors
 usb: ohci-sa1111: convert shutdown method to native device_driver
 usb: ohci-sa1111: use sa1111_get_irq() to obtain IRQ resources
 pcmcia: sa1111: remove special sa1111 mmio accessors
 pcmcia: sa1111: use sa1111_get_irq() to obtain IRQ resources
 Input: sa1111ps2 - extend test delay
 Input: sa1111ps2 - remove special sa1111 mmio accessors
 Input: sa1111ps2 - use sa1111_get_irq() to obtain IRQ resources

There's no great rush for this stuff, it's already been quite some time
since the patches were originally created, so waiting another cycle for
the removal and the irqdomain conversion patches doesn't matter much.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
