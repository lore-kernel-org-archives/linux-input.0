From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv5] mfd: cpcap: implement irq sense helper
Date: Tue, 11 Apr 2017 15:21:44 +0100
Message-ID: <20170411142144.r6r5jljrhsvvypbj@dell>
References: <20170329080423.ijbl4seczla2s4nm@dell>
 <20170329121820.14237-1-sre@kernel.org>
 <20170403102615.h7i53ow2dqzpxox2@dell>
 <20170410142748.jxqd65jrcz2ijp47@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170410142748.jxqd65jrcz2ijp47@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, 10 Apr 2017, Sebastian Reichel wrote:
> On Mon, Apr 03, 2017 at 11:26:15AM +0100, Lee Jones wrote:
> > On Wed, 29 Mar 2017, Sebastian Reichel wrote:
> > 
> > > CPCAP can sense if IRQ is currently set or not. This
> > > functionality is required for a few subdevices, such
> > > as the power button and usb phy modules.
> > > 
> > > Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> > > Signed-off-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > > ---
> > > Changes since PATCHv3:
> > >  - add extern to function definition
> > >  - use BIT macro for mask variable
> > >  - avoid magic numbers
> > > Changes since PATCHv4:
> > >  - rename base to irq_base
> > > ---
> > >  drivers/mfd/motorola-cpcap.c       | 28 ++++++++++++++++++++++++++++
> > >  include/linux/mfd/motorola-cpcap.h |  2 ++
> > >  2 files changed, 30 insertions(+)
> > 
> > Applied, thanks.
> 
> Thanks, will you also pick up the input patch?
> 
> https://patchwork.kernel.org/patch/9637807/

Done, and pull-request sent.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
