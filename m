From: Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 0/3] input: rmi4: Regulator supply support
Date: Tue, 10 May 2016 08:49:04 -0700
Message-ID: <20160510154904.GI1256@tuxbot>
References: <1462596008-21381-1-git-send-email-bjorn.andersson@linaro.org>
 <57312CFB.2040304@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <57312CFB.2040304-Gq53QDLGkWKakBO8gow8eQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Duggan <aduggan-Gq53QDLGkWKakBO8gow8eQ@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Christopher Heiny <cheiny-Gq53QDLGkWKakBO8gow8eQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon 09 May 17:36 PDT 2016, Andrew Duggan wrote:

> Hi Bjorn,
> 
> On 05/06/2016 09:40 PM, Bjorn Andersson wrote:
> >The first version of the regulator support patch suffered from being
> >implemented in the transport driver, as a work around for resource availability
> >racing (EPROBE_DEFER of the core driver) with the interrupt handler.
> >
> >After reconsidering the solutions discussed following that I concluded that the
> >interrupt management is not really part of the transport, neither conceptually
> >or electrically. I therefor here suggest (patch 1/3) to move the interrupt
> >registration and handling to the core rmi driver.
> 
> My concern with moving interrupt processing to the core is that not all
> transports report attn to the rmi core using an irq. The HID and SMBus
> transports which are currently in development, reside a little higher in the
> stack and attention is reported using different mechanisms. We moved
> interrupt handling to the transport drivers so that they could handle the
> differences in how attn is reported.
> 

I suspected that to be the case.

> This message has some of the previous discussion regarding interrupt
> processing:
> https://lkml.org/lkml/2015/11/28/123
> 
> Similarly, not all transports will need support for regulators. Implementing
> both in the transport drivers avoids the EPROBE_DEFER racing and avoids
> adding checks in the core to see if it needs to handle interrupts and manage
> regulators.
> 

So either we duplicate the regulator support in spi/i2c or we make them
optional in the core driver. Sounds like you prefer the prior, i.e. v1
of my patch.

Regards,
Bjorn
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
