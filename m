From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v4 RESEND 1/3] Input: egalax_ts: get gpio from
	devicetree
Date: Thu, 11 Oct 2012 11:19:43 +0100
Message-ID: <20121011101943.GN4625@n2100.arm.linux.org.uk>
References: <1349860323-12786-1-git-send-email-jason77.wang@gmail.com> <1349860323-12786-2-git-send-email-jason77.wang@gmail.com> <20121010163036.GC19335@core.coreip.homeip.net> <20121011085535.GA31464@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50249 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755258Ab2JKKUH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Oct 2012 06:20:07 -0400
Content-Disposition: inline
In-Reply-To: <20121011085535.GA31464@S2101-09.ap.freescale.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree-discuss@lists.ozlabs.org, Hui Wang <jason77.wang@gmail.com>, jiejing.zhang@freescale.com, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On Thu, Oct 11, 2012 at 04:55:40PM +0800, Shawn Guo wrote:
> Add LAKML ...
> 
> On Wed, Oct 10, 2012 at 09:30:36AM -0700, Dmitry Torokhov wrote:
> > Hi Hui,
> > 
> > On Wed, Oct 10, 2012 at 05:12:01PM +0800, Hui Wang wrote:
> > > The irq_to_gpio() is old, most platforms use GENERIC_GPIO framework
> > > and don't support this API anymore.
> > > 
> > > The i.MX6q sabrelite platform equips an egalax touchscreen controller,
> > > and this platform already transfered to GENERIC_GPIO framework, to
> > > support this driver, we use a more generic way to get gpio.
> > 
> > Unfortunately this does break the driver for platforms that do still
> > support irq_to_gpio and have not transitioned to device tree (yet?).
> > It looks like the API suffered from premature deletion...
> > 
> > I really do not want to add a new platform data structure with only gpio
> > in it, is there a better way to detect if irq_to_gpio() (even if only a
> > stub) is available?
> > 
> If CONFIG_ARCH_HAVE_CUSTOM_GPIO_H is not enabled for an architecture,
> the irq_to_gpio() in include/linux/gpio.h will tell unavailability by
> returning -EINVAL.  But ARM architecture still selects ARCH_HAVE_CUSTOM_GPIO_H
> because there are still some platforms having mach/gpio.h.
> 
> We may also need a stub irq_to_gpio simply returning -EINVAL into
> arch/arm/include/asm/gpio.h when platform does not provide irq_to_gpio,
> so that driver can detect if irq_to_gpio() is available.  And that
> stub can be removed later when we deselect ARCH_HAVE_CUSTOM_GPIO_H
> for ARM architecture.

Or fix the drivers using irq_to_gpio() not to use it.  I thought we had
resolved to do that already, with Grant's agreement that irq_to_gpio()
needed to die.

(Mainly because neither gpiolib nor the IRQ layer provides any assistance
for irq_to_gpio(), so it's not possible to make it work for all GPIOs in
the system, especially when GPIOs are allocated dynamically.)
