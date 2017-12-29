From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 03/14] dt-bindings: iio: add binding support for iio
 trigger provider/consumer
Date: Fri, 29 Dec 2017 17:24:01 +0000
Message-ID: <20171229172401.1f6bc823@archlinux>
References: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
        <1513955241-10985-4-git-send-email-eugen.hristev@microchip.com>
        <20171226223500.dxbp26bsx2ojbicr@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751569AbdL2RYG (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 29 Dec 2017 12:24:06 -0500
In-Reply-To: <20171226223500.dxbp26bsx2ojbicr@rob-hp-laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Eugen Hristev <eugen.hristev@microchip.com>, nicolas.ferre@microchip.com, ludovic.desroches@microchip.com, alexandre.belloni@free-electrons.com, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Tue, 26 Dec 2017 16:35:00 -0600
Rob Herring <robh@kernel.org> wrote:

> On Fri, Dec 22, 2017 at 05:07:10PM +0200, Eugen Hristev wrote:
> > Add bindings for producer/consumer for iio triggers.
> > 
> > Similar with iio channels, the iio triggers can be connected between drivers:
> > one driver will be a producer by registering iio triggers, and another driver
> > will connect as a consumer.
> > 
> > Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
In cases where the connectivity is entirely known to the various drivers
(battery chargers integrated in SoCs that use ADC channels for example) we
have always kept the map in driver.

I'm not yet entirely clear if we can do this here.  Might make sense if
we can...


> > ---
> >  .../devicetree/bindings/iio/iio-bindings.txt       | 52 +++++++++++++++++++++-
> >  1 file changed, 51 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/iio-bindings.txt b/Documentation/devicetree/bindings/iio/iio-bindings.txt
> > index 68d6f8c..d861f0df 100644
> > --- a/Documentation/devicetree/bindings/iio/iio-bindings.txt
> > +++ b/Documentation/devicetree/bindings/iio/iio-bindings.txt
> > @@ -11,6 +11,10 @@ value of a #io-channel-cells property in the IIO provider node.
> >  
> >  [1] http://marc.info/?l=linux-iio&m=135902119507483&w=2
> >  
> > +Moreover, the provider can have a set of triggers that can be attached to
> > +from the consumer drivers.
> > +
> > +
> >  ==IIO providers==
> >  
> >  Required properties:
> > @@ -18,6 +22,11 @@ Required properties:
> >  		   with a single IIO output and 1 for nodes with multiple
> >  		   IIO outputs.
> >  
> > +Optional properties:
> > +#io-trigger-cells: Number of cells for the IIO trigger specifier. Typically 0
> > +		   for nodes with a single IIO trigger and 1 for nodes with
> > +		   multiple IIO triggers.
> > +
> >  Example for a simple configuration with no trigger:
> >  
> >  	adc: voltage-sensor@35 {
> > @@ -26,7 +35,7 @@ Example for a simple configuration with no trigger:
> >  		#io-channel-cells = <1>;
> >  	};
> >  
> > -Example for a configuration with trigger:
> > +Example for a configuration with channels provided by trigger:
> >  
> >  	adc@35 {
> >  		compatible = "some-vendor,some-adc";
> > @@ -42,6 +51,17 @@ Example for a configuration with trigger:
> >  		};
> >  	};
> >  
> > +Example for a configuration for a trigger provider:
> > +
> > +	adc: sensor-with-trigger@35 {
> > +		compatible = "some-vendor,some-adc";
> > +		reg = <0x35>;
> > +		#io-channel-cells = <1>;
> > +		#io-trigger-cells = <1>;
> > +		/* other properties */
> > +	};
> > +
> > +
> >  ==IIO consumers==
> >  
> >  Required properties:
> > @@ -61,16 +81,38 @@ io-channel-ranges:
> >  		IIO channels from this node. Useful for bus nodes to provide
> >  		and IIO channel to their children.
> >  
> > +io-triggers:	List of phandle and IIO specifier pairs, one pair
> > +		for each trigger input to the device. Note: if the
> > +		IIO trigger provider specifies '0' for #io-trigger-cells,
> > +		then only the phandle portion of the pair will appear.
> > +
> > +io-trigger-names:
> > +		List of IIO trigger input name strings sorted in the same
> > +		order as the io-triggers property. Consumers drivers
> > +		will use io-trigger-names to match IIO trigger input names
> > +		with IIO specifiers.
> > +
> > +io-trigger-ranges:
> > +		Empty property indicating that child nodes can inherit named
> > +		IIO triggers from this node. Useful for bus nodes to provide
> > +		IIO triggers to their children.  
> 
> I think it would be better to be explicit in the child nodes. What's the 
> use you had in mind?
> 
> Rob
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

