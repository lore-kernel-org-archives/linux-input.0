From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 3/7] mfd: AXP20x: Add bindings documentation
Date: Wed, 18 Jun 2014 10:06:16 +0100
Message-ID: <20140618090616.GA23945@lee--X1>
References: <1400528868-5971-1-git-send-email-carlo@caione.org>
 <1400528868-5971-4-git-send-email-carlo@caione.org>
 <539FED44.1050904@free-electrons.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDA7X7F2WUEBBDVNQWOQKGQEBAZ4IAI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <539FED44.1050904-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
To: Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-input@vger.kernel.org

> On 19/05/2014 21:47, Carlo Caione wrote:
> > Bindings documentation for the AXP20x driver. In this file also
> > sub-nodes are documented.
>=20
> I think this patch has been forgotten (I didn't find it in linus' tree
> or linux-next tree).

This patch-set became confusing.  Some of the patches were applied in
v5 and were still submitted for v6.  I need Carlo to rebase on top of
v3.16-rc1+ and re-submit with the Acks he's collected so far.

> > Signed-off-by: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
> > Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > ---
> >  Documentation/devicetree/bindings/mfd/axp20x.txt | 93 ++++++++++++++++=
++++++++
> >  1 file changed, 93 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/axp20x.txt
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documen=
tation/devicetree/bindings/mfd/axp20x.txt
> > new file mode 100644
> > index 0000000..cc9e01b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> > @@ -0,0 +1,93 @@
> > +AXP202/AXP209 device tree bindings
> > +
> > +The axp20x family current members :-
> > +axp202 (X-Powers)
> > +axp209 (X-Powers)
> > +
> > +Required properties:
> > +- compatible: "x-powers,axp202" or "x-powers,axp209"
> > +- reg: The I2C slave address for the AXP chip
> > +- interrupt-parent: The parent interrupt controller
> > +- interrupts: Interrupt specifiers for interrupt sources
> > +- interrupt-controller: axp20x has its own internal IRQs
> > +- #interrupt-cells: Should be set to 1
> > +- acin-supply: The input supply for LDO1
> > +- vin2-supply: The input supply for DCDC2
> > +- vin3-supply: The input supply for DCDC3
> > +- ldo24in-supply: The input supply for LDO2, LDO4
> > +- ldo3in-supply: The input supply for LDO3
> > +- ldo5in-supply: The input supply for LDO5
> > +
> > +- regulators: A node that houses a sub-node for each regulator. The re=
gulators are
> > +	      bound using their name as listed here: dcdc2, dcdc3, ldo1, ldo2=
,
> > +	      ldo3, ldo4, ldo5.  The bindings details of individual regulator
> > +	      device can be found in:
> > +	      Documentation/devicetree/bindings/regulator/regulator.txt with
> > +	      the exception of x-powers,dcdc-freq
> > +- x-powers,dcdc-freq: defines the work frequency of DC-DC in KHz
> > +		      (range: 750-1875). Default: 1.5MHz
> > +
> > +Optional properties for DCDCs:
> > +- x-powers,dcdc-workmode: 1 for PWM mode, 0 for AUTO mode
> > +			  Default: AUTO mode
> > +
> > +Example:
> > +
> > +axp209: pmic@34 {
> > +	compatible =3D "x-powers,axp209";
> > +	reg =3D <0x34>;
> > +	interrupt-parent =3D <&nmi_intc>;
> > +	interrupts =3D <0 8>;
> > +
> > +	interrupt-controller;
> > +	#interrupt-cells =3D <1>;
> > +
> > +	acin-supply =3D <&axp_ipsout_reg>;
> > +	vin2-supply =3D <&axp_ipsout_reg>;
> > +	vin3-supply =3D <&axp_ipsout_reg>;
> > +	ldo24in-supply =3D <&axp_ipsout_reg>;
> > +	ldo3in-supply =3D <&axp_ipsout_reg>;
> > +	ldo5in-supply =3D <&axp_ipsout_reg>;
> > +
> > +	regulators {
> > +		x-powers,dcdc-freq =3D <1500>;
> > +
> > +		axp_vcore_reg: dcdc2 {
> > +			regulator-min-microvolt =3D <700000>;
> > +			regulator-max-microvolt =3D <2275000>;
> > +			regulator-always-on;
> > +		};
> > +
> > +		axp_ddr_reg: dcdc3 {
> > +			regulator-min-microvolt =3D <700000>;
> > +			regulator-max-microvolt =3D <3500000>;
> > +			regulator-always-on;
> > +		};
> > +
> > +		axp_rtc_reg: ldo1 {
> > +			regulator-always-on;
> > +		};
> > +
> > +		axp_analog_reg: ldo2 {
> > +			regulator-min-microvolt =3D <1800000>;
> > +			regulator-max-microvolt =3D <3300000>;
> > +			regulator-always-on;
> > +		};
> > +
> > +		axp_pll_reg: ldo3 {
> > +			regulator-min-microvolt =3D <700000>;
> > +			regulator-max-microvolt =3D <3500000>;
> > +		};
> > +
> > +		axp_hdmi_reg: ldo4 {
> > +			regulator-min-microvolt =3D <1250000>;
> > +			regulator-max-microvolt =3D <3300000>;
> > +		};
> > +
> > +		axp_mic_reg: ldo5 {
> > +			regulator-min-microvolt =3D <1800000>;
> > +			regulator-max-microvolt =3D <3300000>;
> > +		};
> > +	};
> > +};
> > +
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
