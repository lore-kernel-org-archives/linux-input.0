From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] input: cpcap-pwrbutton: new driver
Date: Mon, 27 Feb 2017 18:32:13 -0800
Message-ID: <20170228023213.GR21809@atomide.com>
References: <20170224085909.30559-1-sre@kernel.org>
 <20170225185852.GB31929@dtor-ws>
 <20170225192100.GK21809@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170225192100.GK21809-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [170225 11:21]:
> * Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [170225 11:00]:
> > On Fri, Feb 24, 2017 at 09:59:09AM +0100, Sebastian Reichel wrote:
> > > +#include <linux/mfd/motorola-cpcap.h>
> > > +
> > > +#define CPCAP_IRQ_ON 23
> > > +#define CPCAP_IRQ_ON_BITMASK (1 << (CPCAP_IRQ_ON % 16))
> > 
> > Is this truly static or it could depend= on IRQ returned by
> > platform_get_irq()?
> 
> I suggest we add it to include/linux/mfd/motorola-cpcap.h:
> 
> static inline int cpcap_get_irq_status(struct device *dev,
> 				       struct regmap *regmap,
> 				       int irq,
> 				       u16 *status);
> 
> Or do you guys have better ideas?

Actually after thinking about it, a macro like Sebastian has
is probably better. Otherwise the interface will be confusing
unless we limit it to getting just one bit instead of the whole
bank. So I now suggest let's just keep it in Sebastian's driver,
then we can move it later as it's just a one line.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
