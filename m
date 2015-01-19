From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v8 1/6] mfd: AXP20x: Add bindings documentation
Date: Mon, 19 Jan 2015 09:37:18 +0000
Message-ID: <20150119093718.GH21886@x1>
References: <1419303194-3075-1-git-send-email-wens@csie.org>
 <1419303194-3075-2-git-send-email-wens@csie.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDA7X7F2WUEBBU5A6OSQKGQEEL2JIVY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1419303194-3075-2-git-send-email-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, 23 Dec 2014, Chen-Yu Tsai wrote:

> From: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
>=20
> Bindings documentation for the AXP20x driver. In this file also
> sub-nodes are documented.
>=20
> Signed-off-by: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
> Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> [wens-jdAy2FN1RRM@public.gmane.org: clarify interrupt source for the axp PMIC]
> [wens-jdAy2FN1RRM@public.gmane.org: explain dcdc-workmode in detail and trim lines to 80 char=
s]
> [wens-jdAy2FN1RRM@public.gmane.org: make regulator supplies optional if using unregulated inp=
ut]
> [wens-jdAy2FN1RRM@public.gmane.org: use cubieboard2 regulator nodes as example]
> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 97 ++++++++++++++++++=
++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/axp20x.txt
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documenta=
tion/devicetree/bindings/mfd/axp20x.txt
> new file mode 100644
> index 000000000000..b775d8ccbc7c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> @@ -0,0 +1,97 @@
> +AXP202/AXP209 device tree bindings
> +
> +The axp20x family current members :
> +axp202 (X-Powers)
> +axp209 (X-Powers)
> +
> +Required properties:
> +- compatible: "x-powers,axp202" or "x-powers,axp209"
> +- reg: The I2C slave address for the AXP chip
> +- interrupt-parent: The parent interrupt controller
> +- interrupts: SoC NMI / GPIO interrupt connected to the PMIC's IRQ pin
> +- interrupt-controller: axp20x has its own internal IRQs
> +- #interrupt-cells: Should be set to 1
> +- regulators: A node that houses a sub-node for each regulator. The regu=
lators
> +	      are bound using their name as listed here: dcdc2, dcdc3, ldo1,
> +	      ldo2, ldo3, ldo4, ldo5.  The bindings details of individual
> +	      regulator device can be found in:
> +	      Documentation/devicetree/bindings/regulator/regulator.txt with
> +	      the exception of x-powers,dcdc-freq. Regulators not used should
> +	      still be listed for completeness and that the regulator subsystem
> +	      properly registers them.
> +
> +- x-powers,dcdc-freq: defines the work frequency of DC-DC in KHz
> +		      (range: 750-1875). Default: 1.5MHz

I'm not keen on defining new properties when existing properties would
suffice.  How about using clock-frequency here instead?  Also it's not
common to issue this stuff using metric prefixes (KHz, MHz, etc).
Please use HZ.

> +Optional properties:
> +- regulator supplies - may be omitted if inputs are unregulated, such as=
 using
> +		       the IPSOUT output from the PMIC
> +  - acin-supply: The input supply for LDO1
> +  - vin2-supply: The input supply for DCDC2
> +  - vin3-supply: The input supply for DCDC3
> +  - ldo24in-supply: The input supply for LDO2, LDO4
> +  - ldo3in-supply: The input supply for LDO3
> +  - ldo5in-supply: The input supply for LDO5
> +
> +Optional properties for DCDC regulators:
> +- x-powers,dcdc-workmode: 1 for PWM mode, 0 for AUTO (PWM/PFM) mode

If there only two options, please use bool.

'x-powers,dcdc-workmode-pwm' and default to auto if it's not present.

> +			  Default: AUTO mode
> +			  The DCDC regulators work in a mixed PWM/PFM mode,
> +			  using PFM under light loads and switching to PWM
> +			  for heavier loads. Forcing PWM mode trades efficiency
> +			  under light loads for lower output noise. This
> +			  probably makes sense for HiFi audio related
> +			  applications that aren't battery constrained.
> +
> +Example:
> +
> +axp209: pmic@34 {
> +	compatible =3D "x-powers,axp209";
> +	reg =3D <0x34>;
> +	interrupt-parent =3D <&nmi_intc>;
> +	interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>;
> +	interrupt-controller;
> +	#interrupt-cells =3D <1>;
> +
> +	regulators {
> +		x-powers,dcdc-freq =3D <1500>;
> +
> +		vdd_cpu: dcdc2 {
> +			regulator-always-on;
> +			regulator-min-microvolt =3D <1000000>;
> +			regulator-max-microvolt =3D <1450000>;
> +			regulator-name =3D "vdd-cpu";
> +		};
> +
> +		vdd_int_dll: dcdc3 {
> +			regulator-always-on;
> +			regulator-min-microvolt =3D <1000000>;
> +			regulator-max-microvolt =3D <1400000>;
> +			regulator-name =3D "vdd-int-dll";
> +		};
> +
> +		vdd_rtc: ldo1 {
> +			regulator-always-on;
> +			regulator-min-microvolt =3D <1200000>;
> +			regulator-max-microvolt =3D <1400000>;
> +			regulator-name =3D "vdd-rtc";
> +		};
> +
> +		avcc: ldo2 {
> +			regulator-always-on;
> +			regulator-min-microvolt =3D <2700000>;
> +			regulator-max-microvolt =3D <3300000>;
> +			regulator-name =3D "avcc";
> +		};
> +
> +		ldo3 {
> +			/* unused */
> +		};

Does this need to be in the example?

> +		csi1_io_2v8: ldo4 {
> +			/* output on extension headers */
> +			regulator-name =3D "csi1-io-2v8";
> +		};
> +	};
> +};
> +

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
