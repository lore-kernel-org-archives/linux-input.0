From: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Subject: Re: Re: [PATCH 2/7] mfd: AXP20x: Add bindings documentation
Date: Sat, 8 Mar 2014 12:38:43 +0100
Message-ID: <20140308113843.GB14009@localhost.fastwebnet.it>
References: <1393692352-10839-1-git-send-email-carlo@caione.org>
 <1393692352-10839-3-git-send-email-carlo@caione.org>
 <20140307181300.GZ607@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDWJTUUC5UCBBE4C5SMAKGQE5KTU5JQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140307181300.GZ607@lukather>
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

On Fri, Mar 07, 2014 at 07:13:00PM +0100, Maxime Ripard wrote:
> On Sat, Mar 01, 2014 at 05:45:47PM +0100, Carlo Caione wrote:
> > Bindings documentation for the AXP20x driver. In this file also two
> > sub-nodes (PEK and regulators) are documented.
> > 
> > Signed-off-by: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
> > ---
> >  Documentation/devicetree/bindings/mfd/axp20x.txt | 93 ++++++++++++++++++++++++
> >  1 file changed, 93 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/axp20x.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
> > new file mode 100644
> > index 0000000..ae3e3c4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> > @@ -0,0 +1,93 @@
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
> > +- axp,system-power-controller	: Telling whether or not this pmic is
> > +				  controlling the system power
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
> > +				  (range: 750-1875)
> > +	- dcdc-workmode		: 1 for PWM mode, 0 for AUTO mode
> 
> You don't seem to always set this. You should mention that it is
> optional, and which default value it has.

Fix in v2.

> > +
> > +* axp20x-pek : Power Enable Key
> > +	- compatible		: should be "x-powers,axp20x-pek"
> 
> Why is this needed for?
> 
> Plus, please don't use any generic, or pattern matching compatibles,
> but rather precise ones, so that if it is needed, we can add any quirk
> we want.

It is not needed, in fact I deleted it from dts. It is a refuse from the
previous submission. I'll fix it.

> > +Example:
> > +
> > +axp: axp20x@34 {
> > +	reg = <0x34>;
> > +	interrupt-parent = <&nmi_intc>;
> > +	interrupts = <0 8>;
> > +
> > +	axp,system-power-controller;
> > +
> > +	compatible = "x-powers,axp209";
> > +	interrupt-controller;
> > +	#interrupt-cells = <1>;
> > +
> > +	axp20x-pek {
> > +		compatible = "x-powers,axp20x-pek";
> > +	};
> > +
> > +	regulators {
> > +		dcdc-freq = "8";
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
> > +			regulator-always-on;
> > +		};
> > +
> > +		axp_ldo1: ldo1 {
> > +			regulator-min-microvolt = <1300000>;
> > +			regulator-max-microvolt = <1300000>;
> > +		};
> > +
> > +		axp_ldo2: ldo2 {
> > +			regulator-min-microvolt = <1800000>;
> > +			regulator-max-microvolt = <3300000>;
> > +			regulator-always-on;
> > +		};
> > +
> > +		axp_ldo3: ldo3 {
> > +			regulator-min-microvolt = <700000>;
> > +			regulator-max-microvolt = <3500000>;
> > +		};
> > +
> > +		axp_ldo4: ldo4 {
> > +			regulator-min-microvolt = <1250000>;
> > +			regulator-max-microvolt = <3300000>;
> > +		};
> > +
> > +		axp_ldo5: ldo5 {
> > +			regulator-min-microvolt = <1800000>;
> > +			regulator-max-microvolt = <3300000>;
> > +		};
> > +	};
> > +};
> > +
> > -- 
> > 1.8.3.2
> > 

-- 
Carlo Caione
