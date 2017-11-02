From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: input: Add Atmel PTC subsystem
 bindings
Date: Thu, 2 Nov 2017 10:24:46 +0100
Message-ID: <20171102092446.ehuilhqtfb7ouses@rfolt0960.corp.atmel.com>
References: <20171020133121.7992-1-ludovic.desroches@microchip.com>
 <20171020133121.7992-2-ludovic.desroches@microchip.com>
 <20171030230658.csl2sxfrmdcdx3lj@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:2565 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751782AbdKBJYw (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 2 Nov 2017 05:24:52 -0400
Content-Disposition: inline
In-Reply-To: <20171030230658.csl2sxfrmdcdx3lj@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com, linux-kernel@vger.kernel.org

Hi Dmitry,

On Mon, Oct 30, 2017 at 04:06:58PM -0700, Dmitry Torokhov wrote:
> Hi Ludovic,
> 
> On Fri, Oct 20, 2017 at 03:31:17PM +0200, Ludovic Desroches wrote:
> > Add description of the Atmel PTC subsystem bindings.
> > 
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/input/atmel,ptc.txt        | 67 ++++++++++++++++++++++
> >  1 file changed, 67 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/atmel,ptc.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/input/atmel,ptc.txt b/Documentation/devicetree/bindings/input/atmel,ptc.txt
> > new file mode 100644
> > index 000000000000..a183fd511e04
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/atmel,ptc.txt
> > @@ -0,0 +1,67 @@
> > +Atmel PTC Subsystem
> > +
> > +The Atmel Peripheral Touch Controller subsystem offers built-in hardware
> > +for capacitive touch measurement on sensors that function as buttons, sliders
> > +and wheels.
> > +
> > +1) PTC Subsystem node
> > +
> > +Required properties:
> > +- compatible: 		Must be "atmel,sama5d2-ptc"
> > +- reg: 			Address, length of the shared memory and ppp registers location
> > +			and length.
> > +- clocks: 		Phandlers to the clocks.
> > +- clock-names: 		Must be "ptc_clk", "ptc_int_osc", "slow_clk".
> > +- #address-cells:	Must be one. The cell is the button or scroller id.
> > +- #size-cells: 		Must be zero.
> > +
> > +Example:
> > +	ptc@fc060000 {
> > +		compatible = "atmel,sama5d2-ptc";
> > +		reg = <0x00800000 0x10000
> > +		       0xfc060000 0xcf>;
> > +		interrupts = <58 IRQ_TYPE_LEVEL_HIGH 7>;
> > +		clocks = <&ptc_clk>, <&main>, <&clk32k>;
> > +		clock-names = "ptc_clk", "ptc_int_osc", "slow_clk";
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		[ child node definitions... ]
> > +	};
> > +
> > +2) Scroller / buttons subnodes
> > +
> > +Subnodes describe the kind of sensors the customer want to use. They have to be
> > +named according to their function: button, slider or wheel.
> 
> I wonder do we really need this? Or we can have a generic:
> 
> 	slider@0 {
> 		reg = <0>;
> 		linux,type = <EV_ABS>;
> 		linux,code = <ABS_X>;
> 	},
> 	vertical-slider@1 {
> 		reg = <1>;
> 		linux,type = <EV_ABS>;
> 		linux,code = <ABS_Y>;
> 	},
> 	wheel@2 {
> 		reg = <2>;
> 		linux,type = <EV_ABS>;
> 		linux,code = <ABS_WHEEL>;
> 	},
> 	button@3 {
> 		reg = <3>;
> 		linux,type = <EV_KEY>;
> 		linux,code = <KEY_A>;
> 	},
> 	...
> 
> I.e. you specify type/code in a generic way.

No problem with this approach, I can retrieve the kind of sensors from
the linux,type property.

Can I set both ABS_X and ABS_Y? In the future, we may have a "surface"
object reporting coordinates for these axes. It seems there are no
generic helpers to parse the 'linux,code' property, so I assume it won't be a
problem.

Regards

Ludovic
