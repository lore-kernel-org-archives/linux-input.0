From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: UCB1400 Touchscreen IRQ
Date: Mon, 21 Apr 2008 12:24:57 -0400
Message-ID: <20080421162457.GB7819@anvil.corenet.prv>
References: <DDFD17CC94A9BD49A82147DDF7D545C5694711@exchange.ZeugmaSystems.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.234]:3568 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755340AbYDUQZP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Apr 2008 12:25:15 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1396171wxd.4
        for <linux-input@vger.kernel.org>; Mon, 21 Apr 2008 09:25:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <DDFD17CC94A9BD49A82147DDF7D545C5694711@exchange.ZeugmaSystems.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Ma <PeterMa@zeugmasystems.com>
Cc: linux-input@vger.kernel.org

Hi Peter,

On Sun, Feb 24, 2008 at 10:24:11PM -0800, Peter Ma wrote:
> I apologize for contacting you directly.  I believe you are the
> maintainer of the Linux input drivers.
> If there is a forum I ought to be checking, please point me in that
> direction.
> 
> The UCB1400 touchscreen driver (input/touchscreen/ucb1400_ts.c)
> currently uses an interrupt autoprobe to self-discover its interrupt.
> The probe_irq_on/off functions indicate interrupts using a 32-bit field.
> I am using a SoC (Atmel AVR32), in which the available external
> interrupts are enumerated starting from 64, which cannot be represented
> in a 32-bit field.  Thus interrupt autoprobing always fails.
> 
> I believe the solution is to somehow pass a IRQ down from the driver
> instantiation, and modify ucb1400_ts_probe() to check for the IRQ number
> before attempting to autoprobe.
> 
> In a couple of board setups I have seen (e.g.
> arch/arm/mach-pca/cm-x270.c), ucb1400_ts is instantiated as a
> "platform_device", eventhough the driver is written as a regular
> "device".  Normally, something board-specific like an IRQ assignment is
> passed in platform_device->resource, but I do not see how ucb1400_ts
> device would be able to fetch that.
> 
> I see there is a device.platform_data, and I see a platform_device.dev.
> I attempted to pass a pointer through
> platform_device->dev.platform_data, but it did not appear to make it
> through to device.platform_data down in the driver.
> 
> Is there a correct method for passing information (like IRQ assignment)
> into a "device" driver, like ucb1400_ts?
> 
> I am quite new to linux drivers, so any guidance you can provide would
> be greatly appreciated.
> 

I apologize for not responding earlier, I was not able to spend much
time on the kernel for the last several months..

I believe your issue is fixed by the following patch from Vernon
Snauder.

-- 
Dmitry

From: Vernon Sauder <vernoninhand@gmail.com>

Input: ucb1400_ts - IRQ probe fix

The UCB1400 driver IRQ probe code fails to find an interrupt if all
the interrupts in the range 0-31 are nonprobe-able. This patch
removes the check of the return value so interrupts above 31 can be
detected.

Tested on InHand Fingertip4 PXA270 board.

Signed-off-by: Vernon Sauder <vsauder@inhand.com>
Acked-by: Nicolas Pitre <nico@marvell.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/touchscreen/ucb1400_ts.c |    4 ----
 1 file changed, 4 deletions(-)

Index: work/drivers/input/touchscreen/ucb1400_ts.c
===================================================================
--- work.orig/drivers/input/touchscreen/ucb1400_ts.c
+++ work/drivers/input/touchscreen/ucb1400_ts.c
@@ -427,10 +427,6 @@ static int ucb1400_detect_irq(struct ucb
 	unsigned long mask, timeout;
 
 	mask = probe_irq_on();
-	if (!mask) {
-		probe_irq_off(mask);
-		return -EBUSY;
-	}
 
 	/* Enable the ADC interrupt. */
 	ucb1400_reg_write(ucb, UCB_IE_RIS, UCB_IE_ADC);
