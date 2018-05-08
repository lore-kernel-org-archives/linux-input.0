From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] Input: ili251x - add support for Ilitek ILI251x
 touchscreens
Date: Tue, 8 May 2018 12:51:36 -0500
Message-ID: <20180508175136.GA26802@rob-hp-laptop>
References: <20180507131823.28800-1-pp@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180507131823.28800-1-pp@emlix.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Puschmann <pp@emlix.com>
Cc: dmitry.torokhov@gmail.com, mark.rutland@arm.com, rydberg@bitmath.org, andi@etezian.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, May 07, 2018 at 03:18:23PM +0200, Philipp Puschmann wrote:
> The driver supports at least the ili2511 chipset but may support other
> Ilitek chipsets using Ilitek i2c protocol v3.x.
> 
> The tested ili2511-based touchscreen delivers garbage for more than 6
> fingers while it should support up to 10 fingers. The reason is still
> unclear and this remains a FIXME in the driver for now.
> 
> The usage of pressure is optional. Touchscreens may deliver constant
> and so useless pressure data.
> 
> Signed-off-by: Philipp Puschmann <pp@emlix.com>
> ---
>  .../bindings/input/touchscreen/ili251x.txt    |  35 ++

Please make the binding a separate patch.

>  drivers/input/touchscreen/Kconfig             |  12 +
>  drivers/input/touchscreen/Makefile            |   1 +
>  drivers/input/touchscreen/ili251x.c           | 350 ++++++++++++++++++
>  4 files changed, 398 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ili251x.txt
>  create mode 100644 drivers/input/touchscreen/ili251x.c
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/ili251x.txt b/Documentation/devicetree/bindings/input/touchscreen/ili251x.txt
> new file mode 100644
> index 000000000000..f21ad93d3bdd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/ili251x.txt
> @@ -0,0 +1,35 @@
> +Ilitek ili251x touchscreen driver

Bindings are not drivers.
> +
> +This driver uses protocol version 3 and should be compatible with other
> +Ilitek touch controllers that use protocol 3.x
> +
> +Required properties:
> + - compatible:  "ili251x"

Needs a vendor prefix.

Don't use wildcards in compatible strings. Maybe you want to incorporate 
the protocol version into the compatible string.

> + - reg:         I2C slave address of the chip (0x41)
> + - interrupt-parent: a phandle pointing to the interrupt controller
> +                     serving the interrupt for this chip
> + - interrupts:       interrupt specification for the touchdetect
> +                     interrupt
> +
> +Optional properties:
> + - reset-gpios: GPIO specification for the RESET input
> +
> + - pinctrl-names: should be "default"
> + - pinctrl-0:   a phandle pointing to the pin settings for the
> +                control gpios
> + - max-fingers: the maximum number of fingers to handle

We already have 'silead,max-fingers', so probably time for a common 
property.

> + - pressure: support pressure data

This should be implied by the compatible string.

> + - generic options	   : See touchscreen.txt
> +
> +Example:
> +
> +	ili251x@41 {

touchscreen@41

> +		compatible = "ili251x";
> +		reg = <0x41>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_touchpanel>;
> +		interrupt-parent = <&gpio5>;
> +		interrupts = <20 IRQ_TYPE_EDGE_FALLING>;
> +		reset-gpios = <&gpio5 18 GPIO_ACTIVE_HIGH>;
> +		max-fingers = <6>;
> +	};
