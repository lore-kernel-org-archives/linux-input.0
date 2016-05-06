From: Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] Input: synaptics-rmi4: Support regulator supplies
Date: Thu, 5 May 2016 17:58:32 -0700
Message-ID: <20160506005832.GB1256@tuxbot>
References: <1459357049-5608-1-git-send-email-bjorn.andersson@linaro.org>
 <20160331181905.GJ39098@dtor-ws>
 <20160331191421.GC8929@tuxbot>
 <56FDD345.20605@synaptics.com>
 <20160421223755.GB3202@tuxbot>
 <572BB344.6030100@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <572BB344.6030100-Gq53QDLGkWKakBO8gow8eQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Duggan <aduggan-Gq53QDLGkWKakBO8gow8eQ@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Christopher Heiny <cheiny-Gq53QDLGkWKakBO8gow8eQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu 05 May 13:55 PDT 2016, Andrew Duggan wrote:

> Hi Bjorn,
> 
> On 04/21/2016 03:37 PM, Bjorn Andersson wrote:
[..]
> >I see no (sane) way of waiting for the rmi_driver to finish probeing;
> >there could be cases where it's powered by a regulator (or reset gpio)
> >that is not yet probed. EPROBE_DEFER will handle this, but we can't wait
> >for it in the transport driver.
> 
> Do we need to wait for rmi_driver to finish probing? What about setting a
> flag at the end of rmi_driver_probe() which rmi_process_interrupt_requests()
> can check before processing interrupts. If rmi_driver hasn't finished
> probing it could just return.
> 

Note that the required resources could be provided by a kernel module
that is loaded at some future time, or never. So we can't really stall
the transport probe().

> >
> >I therefor think these physical resources should be handled in the
> >context of the transport layer, to make sure we don't have temporal
> >dependencies to the other layers.
> 
> I'm fine with enabling the regulators in the transport driver's probe
> function before calling rmi_register_transport_device() to make sure the
> device is powered on. What about exporting common functions from
> rmi_driver.c which implement common regulator functionality which can then
> be called by the transports? To avoid duplication between rmi_i2c and
> rmi_spi.
> 

For the DT binding documents I think it's best to just duplicate the
information, as long as we don't see more common properties between a
growing number of transports (unlikely).


For the implementation we need a context to operate on before probing
the common code, as far as I can see the two places are per transport or
in struct rmi_transport_dev.

The latter would allow us to provide a few common helper functions.


That part that I can see would make it worth adding this is the delay
(Tpowerup?), especially if we need to do something more advanced here.

I've found various numbers of Tpowerup (10ms to 150ms) and some
implementations out there leave the regulators on during sleep, while
others cut the power.

So it seems we will be up for some level of additional logic here, that
warrants the de-duplication.

> >Or we should not have the rmi_driver as a separate device driver at all
> >- it could be a "library" that runs in the context of the transport
> >device.
> 
> I would have to look into this further to understand the impact on the bus
> architecture of merging the physical and transport drivers. But, I don't
> think this particular issue warrants such a change. But, if having them as
> separate devices does cause a lot of other problems, it  might be possible
> to merge them.
> 

I get the feeling that there is an expected 1:1 relationship between the
transport and core driver, making the use of the driver model for
separation overkill and a potential cause of issues.

I agree this might not warrant the churn of a rewrite, but I'm concern
about the above helpers just working around an artificial issue.

Regards,
Bjorn
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
