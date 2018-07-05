From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v9 2/2] mfd: bd71837: Devicetree bindings for ROHM
 BD71837 PMIC
Date: Thu, 5 Jul 2018 10:24:44 +0100
Message-ID: <20180705092444.GL496@dell>
References: <cover.1530776326.git.matti.vaittinen@fi.rohmeurope.com>
 <87cc68c82c3c95e82797e0ce3d401a4f1d6daf25.1530776326.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87cc68c82c3c95e82797e0ce3d401a4f1d6daf25.1530776326.git.matti.vaittinen@fi.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org, mazziesaccount@gmail.com, arnd@arndb.de, dmitry.torokhov@gmail.com, sre@kernel.org, chenjh@rock-chips.com, andrew.smirnov@gmail.com, linus.walleij@linaro.org, kstewart@linuxfoundation.org, heiko@sntech.de, gregkh@linuxfoundation.org, eballetbo@gmail.com, sboyd@kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
List-Id: linux-input@vger.kernel.org

On Thu, 05 Jul 2018, Matti Vaittinen wrote:

> Document devicetree bindings for ROHM BD71837 PMIC MFD.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  | 67 ++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
> new file mode 100644
> index 000000000000..67f2616288d9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
> @@ -0,0 +1,67 @@
> +* ROHM BD71837 Power Management Integrated Circuit bindings
> +
> +BD71837MWV is a programmable Power Management IC for powering single-core,
> +dual-core, and quad-core SoC’s such as NXP-i.MX 8M. It is optimized for

Nit: s/SOC's/SOCs/

> +low BOM cost and compact solution footprint. It integrates 8 Buck
> +egulators and 7 LDO’s to provide all the power rails required by the SoC and

Nit: s/LDO's/LDOs/

> +the commonly used peripherals.
> +
> +Datasheet for PMIC is available at:
> +https://www.rohm.com/datasheet/BD71837MWV/bd71837mwv-e
> +
> +Required properties:
> + - compatible		: Should be "rohm,bd71837".
> + - reg			: I2C slave address.
> + - interrupt-parent	: Phandle to the parent interrupt controller.
> + - interrupts		: The interrupt line the device is connected to.
> + - clocks		: The parent clock connected to PMIC. If this is missng

s/missng/missing/

> +			  32768 KHz clock is assumed.
> + - #clock-cells		: Should be 0
> + - regulators:		: List of child nodes that specify the regulators

By your convention, the bottom two entries are missing '.'s.

> +			  Please see ../regulator/rohm,bd71837-regulator.txt
> +
> +Optional properties:
> +- clock-output-names	: Should contain name for output clock.
> +
> +Example:
> +
> +	/* external oscillator node */

Uppercase character to start a sentence.

> +	osc: oscillator {
> +		compatible = "fixed-clock";
> +		#clock-cells = <1>;
> +		clock-frequency  = <32768>;
> +		clock-output-names = "osc";
> +	};
> +
> +	/* PMIC node */

Is this comment really necessary?  The node is called "pmic".

> +	pmic: pmic@4b {
> +		compatible = "rohm,bd71837";
> +		reg = <0x4b>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <29 GPIO_ACTIVE_LOW>;
> +		interrupt-names = "irq";
> +		#clock-cells = <0>;
> +		clocks = <&osc 0>;
> +		clock-output-names = "bd71837-32k-out";
> +
> +		regulators {
> +			buck1: BUCK1 {
> +				regulator-name = "buck1";
> +				regulator-min-microvolt = <700000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-boot-on;
> +				regulator-ramp-delay = <1250>;
> +			};
> +			/* ... */
> +		};
> +	};
> +
> +	/* Clock consumer node */
> +
> +	foo@0 {
> +		compatible = "bar,foo";
> +		/* ... */

No need for this line.  Additional properties are always expected.

> +		clock-names = "my-clock";
> +		clocks = <&pmic>;
> +	};

Do you have a real example to give?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
