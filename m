From: Wang Yafei <wangyafei-PiwChjOeyQzQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dt-bindings: input: Add the Goodix GTx5 series
 Touchscreen devicetree bindings
Date: Mon, 26 Jun 2017 21:22:53 +0800
Message-ID: <20170626132253.GA24061@andrew-dell>
References: <22592d94-f482-3e4f-3860-1dce83472d4f@goodix.com>
 <20170623203706.upfzigj6ghdbqx2q@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170623203706.upfzigj6ghdbqx2q@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andrew-PiwChjOeyQzQT0dZR+AlfA@public.gmane.org, mouse-PiwChjOeyQzQT0dZR+AlfA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Rob,

Thank you for the review.

On Fri, Jun 23, 2017 at 03:37:06PM -0500, Rob Herring wrote:
> On Mon, Jun 19, 2017 at 06:40:32PM +0800, Wang Yafei wrote:
> > Signed-off-by: Wang Yafei <wangyafei-PiwChjOeyQzQT0dZR+AlfA@public.gmane.org>
> > ---
> >  .../bindings/input/touchscreen/goodix-gtx5.txt     | 75 ++++++++++++++++++++++
> >  1 file changed, 75 insertions(+)
> >  create mode 100755 Documentation/devicetree/bindings/input/touchscreen/goodix-gtx5.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix-gtx5.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix-gtx5.txt
> > new file mode 100755
> > index 0000000..116c3ec
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix-gtx5.txt
> > @@ -0,0 +1,75 @@
> > +Device tree bindings for Goodix GTx5 series touchscreen controller
> > +
> > +Required properties:
> > +
> > +- compatible	: should be "goodix,gtx5" or "goodix,gsx" 
> > +
> > +- reg	: I2C address of the chip. Should be 0x5d or 0x14
> > +- interrupt-parent	: Inerrupt controller to which the chip is connected
> > +- interrupts	: Interrrupt to which the chip is connected
> > +- touchscreen-size-x	: horizontal resolution of touchscreen          
> > +                                  (in pixels)                                   
> > +- touchscreen-size-y	: vertical resolution of touchscreen            
> > +                                  (in pixels)                                  
> > +- touchscreen-max-id	: panel supported max touch number.
> > +- touchscreen-max-w	: panel max width value.
> 
> Just "See touchscreen.txt" for all of these common props.

Okay, I have noticed that.

> > +
> > +
> > +Optional properties:
> > +- reset-gpios	: reset gpio.
> > +- irq-gpios	: interrupt gpio. 
> 
> Use interrupts binding.
> 
> > +- irq-flags	: irq trigger type config, value should be:
> > +                       1 - rising edge,
> > +                       2 - falling edge,
> > +                       4 - high level,
> > +                       5 - low level.
> 
> Part of the flags for interrupt cells.

Okay, I will remove this property and use the flowing property:
interrupts =  <13 IRQ_TYPE_EDGE_FALLING>;

> > +- touchscreen-swapped-x-y: swap  x/y axis coordinates.
> 
> "See touchscreen.txt"
> 
> > +- touchscreen-key-map: keycode value map  /*KEY_HOMEPAGE, KEY_BACK*/
> 
> This hardly seems sufficient to map screen areas to keys. There's been 
> some discussion about doing that in the past.

Sorry haven't notice that before, I will change it to the flowing
property format:
linux,keycodes = <KEY_HOMEPAGE>, <KEY_MENU>, <KEY_BACK>;

> > +- power-on-delay-us: delay after power on.
> > +- power-off-delay-us: delay after power off.
> 
> These should be implied by the compatible. If not, you need more 
> specific compatible strings.

Okay, I will remove this props from DT.

> > +- normal-cfg: touch device normal config data.
> 
> There's no mention these are a sub-node sensorX.
> 
> Needs a vendor prefix too.
> 
> > +- vtouch-supply	: power supply for the touch device.
> > +Example:
> > +i2c@00000000 {
> > +	/* ... */
> > +
> > +	goodix-ts-i2c@14 {
> 
> touchscreen@14
> 
> > +		compatible = "goodix,gtx5";
> > +		reg = <0x14>;
> > +		interrupt-parent = <&msm_gpio>;
> > +		interrupts = <13 0x2800>;
> > +		vtouch-supply = <&pm8916_l15>;
> > +		reset-gpios = <&msm_gpio 12 0x0>;
> > +		irq-gpios = <&msm_gpio 13 0x2800>;
> > +		irq-flags = <1>; /* 1:trigger rising, 2:trigger falling;*/
> > +		touchscreen-max-id = <10>;
> > +		touchscreen-size-x = <400>;
> > +		touchscreen-size-y = <400>;
> > +		touchscreen-max-w = <400>;
> > +		touchscreen-max-pressure = <255>;
> > +		touchscreen-swapped-x-y;
> > +		touchscreen-key-map = <172 158>; /*KEY_HOMEPAGE, KEY_BACK*/
> > +		sensor0 {
> 
> How many sensors can there be? That needs to be documented.
> 
> Why do you need a sub-node?

sensor is an internal call, we use senesorX to represent the touchpanel
is produced by which factory. A panel factory will have it corresponding
config data to get the best touch results. It will delete the sub-node 
and change to the following format:
	panel0,normal-cfg = [...]  /* panelX,cfg : X is no more than 10*/
 
> > +			normal-cfg = [
> > +				02 00 00 09 09 01 07 02 00 00 00 00 01 00 3C 00 07 07
> > +				00 00 00 00 00 00 40 01 40 01 C8 00 96 00 F4 01 F4 01
> > +				F4 01 20 01 11 0A 0A 03 14 14 14 14 0A 0C 01 01 11 11
> > +				11 00 14 14 14 14 14 14 14 14 14 00 00 0F 00 00 00 00
> > +				00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > +				00 00 00 00 00 00 00 00 00 00 11 09 10 00 31 32 33 34
> > +				00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 CA 64 00
> > +				00 00 00 00 00 00 09 00 13 00 00 00 00 00 00 00 00 00
> > +				50 B0 19 00 19 00 05 00 00 00 00 0A 05 00 00 00 00 00
> > +				01 00 FF 00 0B 06 0D 02 FF 04 05 03 07 01 08 0A 0E 11
> > +				0F 10 09 13 0C 16 17 14 18 12 19 15 1D 1E 1C 1F 1B 20
> > +				1A 2A 29 28 25 2B 27 21 FF 24 22 2C 26 23 FF 00 00 00
> > +				00 00 00 00 00 00 00 00 00 00 00 00 80 80 80 80 80 80
> > +				80 80 80 80 80 80 80 80 80 80 9F 22 01 AE];
> > +		};
> > +		sensor1 {
> > +			normal-cfg = [ ];
> > +		};
> > +	};
> > +}
> > +
> > +
> > -- 
> > 2.7.4
> > 

Sincerely.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
