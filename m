From: Oreste Salerno <oreste.salerno@tomtom.com>
Subject: Re: [PATCH v2 2/3] Input: cyttsp - add device tree support
Date: Thu, 7 Jan 2016 22:35:28 +0100
Message-ID: <20160107213528.GA31600@nl1lxl-107192.ttg.global>
References: <cover.1451997697.git.oreste.salerno@tomtom.com>
 <97cd8c1d98d7406347e4e48f4c7383a394a2ae93.1451997697.git.oreste.salerno@tomtom.com>
 <20160106150256.GA27683@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail3.tomtom.com ([85.90.76.132]:5800 "EHLO mail3.tomtom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752150AbcAGVfb (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 Jan 2016 16:35:31 -0500
Content-Disposition: inline
In-Reply-To: <20160106150256.GA27683@rob-hp-laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, fery@cypress.com, dmitry.torokhov@gmail.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org

Hi Rob,

Thanks a lot for reviewing the patch. I have some comments.

On Wed, Jan 06, 2016 at 09:02:56AM -0600, Rob Herring wrote:
> On Tue, Jan 05, 2016 at 01:59:14PM +0100, Oreste Salerno wrote:
> > Add support for retrieving the platform data from the device
> > tree.
> 
> Converting platform data to DT as is is typically not the right thing to 
> do. There's some overlap, but it is not typically 1-1.
> 

What would be the criteria? I believe that the required properties are
platform-specific values that need to be defined here.
As for the optional properties, they can be useful to tweak the touchscreen
performance based on the use case and the hardware using the touchscreen
controller.

> > Signed-off-by: Oreste Salerno <oreste.salerno@tomtom.com>
> > ---
> >  .../bindings/input/touchscreen/cyttsp.txt          |  73 ++++++++++++++
> >  drivers/input/touchscreen/cyttsp_core.c            | 108 +++++++++++++++++++--
> >  include/linux/input/cyttsp.h                       |   3 +
> >  3 files changed, 177 insertions(+), 7 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cyttsp.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/cyttsp.txt b/Documentation/devicetree/bindings/input/touchscreen/cyttsp.txt
> > new file mode 100644
> > index 0000000..8e0bcc73
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/cyttsp.txt
> > @@ -0,0 +1,73 @@
> > +* Cypress cyttsp touchscreen controller
> > +
> > +Required properties:
> > +- compatible		: must be "cypress,cyttsp-i2c" or "cypress,cyttsp-spi"
> > +- reg			: Device address
> 
> ...or SPI chip select number
> 
> > +- spi-max-frequency 	: Maximum SPI clocking speed of the device (for cyttsp-spi)
> > +- interrupt-parent	: the phandle for the gpio controller
> > +			  (see interrupt binding[0]).
> > +- interrupts		: (gpio) interrupt to which the chip is connected
> > +			  (see interrupt binding[0]).
> > +- reset-gpios		: the reset gpio the chip is connected to
> > +			  (see GPIO binding[1] for more details).
> > +- maxx			: horizontal resolution of touchscreen (in pixels)
> > +- maxy			: vertical resolution of touchscreen (in pixels)
> 
> IIRC, we have standard properties for these. Touchscreens don't really 
> have pixels...
>

Indeed, there are touchscreen-size-x and touchscreen-size-y, I will rename 
them using the standard properties.
To be fair, though, the description for them in touchscreen.txt is identical
to what I wrote ("horizontal resolution of touchscreen (in pixels)") .

> > +- bootloader-key	: the bootloader key used to exit bootloader mode
> 
> I don't understand what this is.
> 

This is a 8-byte key that is required to switch the chip from bootloader mode
(default mode) to application mode. It's platform-specific because it's set
by the customer using the chip (or by Cypress on behalf of the customer).

> > +
> > +Optional properties:
> > +- use_hndshk		: enable handshake bit
> > +- act_dist		: active distance
> > +- act_intrvl		: active refresh interval in ms
> 
> Is this sampling frequency?
>

Yes, it's basically the period between consecutive scanning/processing
cycles when the chip is in active mode. The higher the value, the higher
the response time but the lower the power consumption.
The value below (lp_intrvl) is the equivalent for when the chip is in
low power mode.
 
> > +- tch_tmout		: active touch timeout in ms
> > +- lp_intrvl		: low power refresh interval in ms
> 
> Look whether other touchscreens bindings have similar properties already 
> and copy those. These need better definitions in general.
> 
> Don't use '_' in property names and append units to the name of 
> properties that have units (e.g. ms).
>

The only binding that I found to have somewhat similar properies
is brcm,iproc-touchscreen.txt which calls scanning_period what I call
act_intrvl and touch_timeout what I call tch_tmout.
As I said, these properties are not strictly required but can be
useful to tweak the touchscreen performance.
I'll improve the descriptions and the namings as you suggested.
 
> > +Example:
> > +	&i2c1 {
> > +		/* ... */
> > +		cyttsp@a {
> > +			compatible = "cypress,cyttsp-i2c";
> > +			reg = <0xa>;
> > +			interrupt-parent = <&msm_gpio>;
> > +			interrupts = <13 0x2008>;
> > +			reset-gpios = <&msm_gpio 12 0x00>;
> > +
> > +			maxx = <800>;
> > +			maxy = <480>;
> > +			bootloader-key = /bits/ 8 <0x01 0x02 0x03 0x04 0x05 0x06 0x07 0x08>;
> > +
> > +			use_hndshk;
> > +			act_dist = /bits/ 8 <0xF8>;
> > +			act_intrvl = /bits/ 8 <0x00>;
> > +			tch_tmout = /bits/ 8 <0xFF>;
> > +			lp_intrvl = /bits/ 8 <0x0A>;
> 
> If the size is not 32-bits, you need to state that in the description. 
> There is not really much point in making these 8-bit though.
>

These 8-bit properties are written as-is to 8-bit registers, so I thought
it would be a way to enforce that the binding user cannot specify bigger
values than 0xFF. Would you suggest changing them to 32-bits and handle
possible bigger values as errors in the driver?

Thanks,
Oreste

> Rob
