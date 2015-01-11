From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH v8 1/6] mfd: AXP20x: Add bindings documentation
Date: Sun, 11 Jan 2015 10:02:45 +0800
Message-ID: <CAGb2v65nTA1WCY0gR7-WPV13+od-kJo2cLdD0BS8pq762qEbDw@mail.gmail.com>
References: <1419303194-3075-1-git-send-email-wens@csie.org> <1419303194-3075-2-git-send-email-wens@csie.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCMILY6JWQBBBW5TY6SQKGQE42Q5F3I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1419303194-3075-2-git-send-email-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tue, Dec 23, 2014 at 10:53 AM, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org> wrote:
> From: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
>
> Bindings documentation for the AXP20x driver. In this file also
> sub-nodes are documented.
>
> Signed-off-by: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
> Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> [wens-jdAy2FN1RRM@public.gmane.org: clarify interrupt source for the axp PMIC]
> [wens-jdAy2FN1RRM@public.gmane.org: explain dcdc-workmode in detail and trim lines to 80 chars]
> [wens-jdAy2FN1RRM@public.gmane.org: make regulator supplies optional if using unregulated input]
> [wens-jdAy2FN1RRM@public.gmane.org: use cubieboard2 regulator nodes as example]
> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 97 ++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/axp20x.txt
>
> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
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
> +- regulators: A node that houses a sub-node for each regulator. The regulators
> +             are bound using their name as listed here: dcdc2, dcdc3, ldo1,
> +             ldo2, ldo3, ldo4, ldo5.  The bindings details of individual
> +             regulator device can be found in:
> +             Documentation/devicetree/bindings/regulator/regulator.txt with
> +             the exception of x-powers,dcdc-freq. Regulators not used should
> +             still be listed for completeness and that the regulator subsystem
> +             properly registers them.
> +
> +- x-powers,dcdc-freq: defines the work frequency of DC-DC in KHz
> +                     (range: 750-1875). Default: 1.5MHz
> +
> +Optional properties:
> +- regulator supplies - may be omitted if inputs are unregulated, such as using
> +                      the IPSOUT output from the PMIC
> +  - acin-supply: The input supply for LDO1
> +  - vin2-supply: The input supply for DCDC2
> +  - vin3-supply: The input supply for DCDC3
> +  - ldo24in-supply: The input supply for LDO2, LDO4
> +  - ldo3in-supply: The input supply for LDO3
> +  - ldo5in-supply: The input supply for LDO5
> +
> +Optional properties for DCDC regulators:
> +- x-powers,dcdc-workmode: 1 for PWM mode, 0 for AUTO (PWM/PFM) mode
> +                         Default: AUTO mode
> +                         The DCDC regulators work in a mixed PWM/PFM mode,
> +                         using PFM under light loads and switching to PWM
> +                         for heavier loads. Forcing PWM mode trades efficiency
> +                         under light loads for lower output noise. This
> +                         probably makes sense for HiFi audio related
> +                         applications that aren't battery constrained.

Hi Mark,

You raised some questions during v7 about the regulator bits, specifically
about the "x-powers,dcdc-workmode" property. I've expanded the regulator
parts of the DT bindings doc.

Is the current version clear enough for you? I'd like to get this merged.


Thank You
ChenYu

> +
> +Example:
> +
> +axp209: pmic@34 {
> +       compatible = "x-powers,axp209";
> +       reg = <0x34>;
> +       interrupt-parent = <&nmi_intc>;
> +       interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +       interrupt-controller;
> +       #interrupt-cells = <1>;
> +
> +       regulators {
> +               x-powers,dcdc-freq = <1500>;
> +
> +               vdd_cpu: dcdc2 {
> +                       regulator-always-on;
> +                       regulator-min-microvolt = <1000000>;
> +                       regulator-max-microvolt = <1450000>;
> +                       regulator-name = "vdd-cpu";
> +               };
> +
> +               vdd_int_dll: dcdc3 {
> +                       regulator-always-on;
> +                       regulator-min-microvolt = <1000000>;
> +                       regulator-max-microvolt = <1400000>;
> +                       regulator-name = "vdd-int-dll";
> +               };
> +
> +               vdd_rtc: ldo1 {
> +                       regulator-always-on;
> +                       regulator-min-microvolt = <1200000>;
> +                       regulator-max-microvolt = <1400000>;
> +                       regulator-name = "vdd-rtc";
> +               };
> +
> +               avcc: ldo2 {
> +                       regulator-always-on;
> +                       regulator-min-microvolt = <2700000>;
> +                       regulator-max-microvolt = <3300000>;
> +                       regulator-name = "avcc";
> +               };
> +
> +               ldo3 {
> +                       /* unused */
> +               };
> +
> +               csi1_io_2v8: ldo4 {
> +                       /* output on extension headers */
> +                       regulator-name = "csi1-io-2v8";
> +               };
> +       };
> +};
> +
> --
> 2.1.4
>
