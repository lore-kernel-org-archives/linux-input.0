From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] input: cpcap-pwrbutton: new driver
Date: Sat, 25 Feb 2017 11:21:00 -0800
Message-ID: <20170225192100.GK21809@atomide.com>
References: <20170224085909.30559-1-sre@kernel.org>
 <20170225185852.GB31929@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:36330 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751861AbdBYTVW (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 25 Feb 2017 14:21:22 -0500
Content-Disposition: inline
In-Reply-To: <20170225185852.GB31929@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

* Dmitry Torokhov <dmitry.torokhov@gmail.com> [170225 11:00]:
> On Fri, Feb 24, 2017 at 09:59:09AM +0100, Sebastian Reichel wrote:
> > +#include <linux/mfd/motorola-cpcap.h>
> > +
> > +#define CPCAP_IRQ_ON 23
> > +#define CPCAP_IRQ_ON_BITMASK (1 << (CPCAP_IRQ_ON % 16))
> 
> Is this truly static or it could depend= on IRQ returned by
> platform_get_irq()?

I suggest we add it to include/linux/mfd/motorola-cpcap.h:

static inline int cpcap_get_irq_status(struct device *dev,
				       struct regmap *regmap,
				       int irq,
				       u16 *status);

Or do you guys have better ideas?

I'll be needing that for the USB PHY driver too for multiple
bits so we want to return the whole bank register in status.

We may want to change to do that later to avoid dependencies
or set up an immutable branch with just that change.

Other than that things work for me based on a quick test.

Regards,

Tony

