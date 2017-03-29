From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCHv4] mfd: cpcap: implement irq sense helper
Date: Wed, 29 Mar 2017 09:04:23 +0100
Message-ID: <20170329080423.ijbl4seczla2s4nm@dell>
References: <20170323142337.4c4d6lnhqtugbb2r@dell>
 <20170324084240.23251-1-sre@kernel.org>
 <20170328102716.gz7agm7kx3gz56jt@dell>
 <20170328145415.td4xeqxedem5yjen@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170328145415.td4xeqxedem5yjen@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 28 Mar 2017, Sebastian Reichel wrote:

> Hi Lee,
> 
> On Tue, Mar 28, 2017 at 11:27:16AM +0100, Lee Jones wrote:
> > > +int cpcap_sense_virq(struct regmap *regmap, int virq)
> > > +{
> > > +	struct regmap_irq_chip_data *d = irq_get_chip_data(virq);
> > > +	int base = regmap_irq_chip_get_base(d);
> > 
> > What base is this?
> 
> This function takes an Linux irq number. That number is a virtual
> irq number, which has nothing to do with the hardware. For example
> a platform could look like this:
> 
> linux irq   device          base   device irq
> ---------------------------------------------
> 0-63        SoC             0      0-63
> 64-127      SoC-GPIO        64     0-63
> 128-191     CPCAP           128    0-63
> 
> For the above example the function would map 128-191 to 0-63 as
> used by the device.

In which case may I suggest that you rename the variable, since 'base'
is commonly used in the kernel to mean base of a particular IP's
memory block.

> > Could it be used to avoid some calculations in cpcap_sense_irq()?
> 
> No.
> 
> > > +	return cpcap_sense_irq(regmap, virq - base);
> > > +}
> > > +EXPORT_SYMBOL_GPL(cpcap_sense_virq);
> 
> -- Sebastian



-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
