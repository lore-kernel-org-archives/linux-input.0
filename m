From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v4 RESEND 1/3] Input: egalax_ts: get gpio from devicetree
Date: Thu, 11 Oct 2012 16:55:40 +0800
Message-ID: <20121011085535.GA31464@S2101-09.ap.freescale.net>
References: <1349860323-12786-1-git-send-email-jason77.wang@gmail.com>
 <1349860323-12786-2-git-send-email-jason77.wang@gmail.com>
 <20121010163036.GC19335@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59933 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211Ab2JKIzs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Oct 2012 04:55:48 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so1635858pbb.19
        for <linux-input@vger.kernel.org>; Thu, 11 Oct 2012 01:55:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20121010163036.GC19335@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hui Wang <jason77.wang@gmail.com>, jiejing.zhang@freescale.com, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Add LAKML ...

On Wed, Oct 10, 2012 at 09:30:36AM -0700, Dmitry Torokhov wrote:
> Hi Hui,
> 
> On Wed, Oct 10, 2012 at 05:12:01PM +0800, Hui Wang wrote:
> > The irq_to_gpio() is old, most platforms use GENERIC_GPIO framework
> > and don't support this API anymore.
> > 
> > The i.MX6q sabrelite platform equips an egalax touchscreen controller,
> > and this platform already transfered to GENERIC_GPIO framework, to
> > support this driver, we use a more generic way to get gpio.
> 
> Unfortunately this does break the driver for platforms that do still
> support irq_to_gpio and have not transitioned to device tree (yet?).
> It looks like the API suffered from premature deletion...
> 
> I really do not want to add a new platform data structure with only gpio
> in it, is there a better way to detect if irq_to_gpio() (even if only a
> stub) is available?
> 
If CONFIG_ARCH_HAVE_CUSTOM_GPIO_H is not enabled for an architecture,
the irq_to_gpio() in include/linux/gpio.h will tell unavailability by
returning -EINVAL.  But ARM architecture still selects ARCH_HAVE_CUSTOM_GPIO_H
because there are still some platforms having mach/gpio.h.

We may also need a stub irq_to_gpio simply returning -EINVAL into
arch/arm/include/asm/gpio.h when platform does not provide irq_to_gpio,
so that driver can detect if irq_to_gpio() is available.  And that
stub can be removed later when we deselect ARCH_HAVE_CUSTOM_GPIO_H
for ARM architecture.

Shawn
