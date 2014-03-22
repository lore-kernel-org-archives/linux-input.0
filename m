From: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Subject: Re: Re: [PATCH v2 2/8] mfd: AXP20x: Add bindings documentation
Date: Sat, 22 Mar 2014 15:11:57 +0100
Message-ID: <20140322141157.GA20668@localhost.fastwebnet.it>
References: <1394898225-28452-1-git-send-email-carlo@caione.org>
 <1394898225-28452-3-git-send-email-carlo@caione.org>
 <20140318084505.GT27873@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDWJTUUC5UCBBV5TW2MQKGQE4MDPKZI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140318084505.GT27873@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, Mar 18, 2014 at 09:45:05AM +0100, Maxime Ripard wrote:
> On Sat, Mar 15, 2014 at 04:43:39PM +0100, Carlo Caione wrote:
> > Bindings documentation for the AXP20x driver. In this file also two
> > sub-nodes (PEK and regulators) are documented.
> 
> PEK doesn't look to be documented, either in this patch, or any other.

Residue from v1. To be deleted.

> > Signed-off-by: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
> > ---
> >  Documentation/devicetree/bindings/mfd/axp20x.txt   | 83 ++++++++++++++++++++++
> >  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
> 
> I don't really know what the DT maintainers are expecting here, but I
> would have done two patches.

Uhm, no idea (and no feedback). I'll split it.

> >  2 files changed, 84 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/axp20x.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
> > new file mode 100644
> > index 0000000..982aefe
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> > @@ -0,0 +1,83 @@
> > +* axp20x device tree bindings
> > +
> > +The axp20x family current members :-
> > +axp202 (X-Powers)
> > +axp209 (X-Powers)
> > +
> > +Required properties:
> > +- compatible 			: Should be "x-powers,axp202" or "x-powers,axp209"
> > +- interrupt-controller 		: axp20x has its own internal IRQs
> > +- #interrupt-cells 		: Should be set to 1
> > +- interrupt-parent 		: The parent interrupt controller
> > +- interrupts 			: Interrupt specifiers for interrupt sources
> > +- reg 				: The I2C slave address for the AXP chip
> > +
> > +Sub-nodes:
> > +* regulators : Contain the regulator nodes. The regulators are bound using
> > +	       their name as listed here: dcdc2, dcdc3, ldo1, ldo2, ldo3,
> > +	       ldo4, ldo5.
> > +	       The bindings details of individual regulator device can be found in:
> > +	       Documentation/devicetree/bindings/regulator/regulator.txt with the
> > +	       exception of:
> > +
> > +	- dcdc-freq		: defines the work frequency of DC-DC in KHz
> > +				  (range: 750-1875). Default: 1.5MHz
> > +	- dcdc-workmode		: Optional. 1 for PWM mode, 0 for AUTO mode
> > +				  Default: AUTO mode
> 
> Those two are x-powers specific, or would it make sense to have them
> in other drivers too?
> 
> If the former, please add the x-powers prefix.

AFAIK this is AXP specific. I'll add the prefix.

> > +
> > +Example:
> > +
> > +axp: axp20x@34 {
> > +	reg = <0x34>;
> > +	interrupt-parent = <&nmi_intc>;
> > +	interrupts = <0 8>;
> > +
> > +	compatible = "x-powers,axp209";
> > +	interrupt-controller;
> > +	#interrupt-cells = <1>;
> > +
> > +	regulators {
> 
> Do we really need that subnode ? it looks useless, and we already know
> that we are defining regulators here.

What do you mean? We are defining the MFD and regulators are just one of
the subsystem here. Moveover I'm using the "regulators" node in the
regulators driver (using of_find_node_by_name()) to get the regulators
configuration.

> > +		dcdc-freq = "1500";
> 
> That frequency is defined at the same level than the dcdc-workmode
> property, yet they both seem to be placed at different levels.

They are at different level. dcdc-freq is valid for all the dcdc,
whereas dcdc-workmode is dcdc-specific.
I'll clarify the point.

> > +
> > +		axp_dcdc2: dcdc2 {
> > +			regulator-min-microvolt = <700000>;
> > +			regulator-max-microvolt = <2275000>;
> > +			dcdc-workmode = <0>;
> > +			regulator-always-on;
> > +		};
> > +
> > +		axp_dcdc3: dcdc3 {
> > +			regulator-min-microvolt = <700000>;
> > +			regulator-max-microvolt = <3500000>;
> > +			dcdc-workmode = <0>;
> 
> It looks like those are at their default values?

Yes. To be fixed.

Thanks,

-- 
Carlo Caione
