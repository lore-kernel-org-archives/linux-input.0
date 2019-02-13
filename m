From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 01/11] dt-bindings: mfd: add DT bindings for max77650
Date: Wed, 13 Feb 2019 14:43:28 -0600
Message-ID: <20190213204328.GA26408@bogus>
References: <20190213134335.10838-1-brgl@bgdev.pl>
 <20190213134335.10838-2-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190213134335.10838-2-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

On Wed, Feb 13, 2019 at 02:43:25PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Add a DT binding document for max77650 ultra-low power PMIC. This
> describes the core mfd device and the GPIO module.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  .../devicetree/bindings/mfd/max77650.txt      | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/max77650.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/max77650.txt b/Documentation/devicetree/bindings/mfd/max77650.txt
> new file mode 100644
> index 000000000000..0a40e9c6aab8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/max77650.txt
> @@ -0,0 +1,47 @@
> +MAX77650 ultra low-power PMIC from Maxim Integrated.
> +
> +Required properties:
> +-------------------
> +- compatible:		Must be "maxim,max77650"
> +- reg:			I2C device address.
> +- interrupts:		The interrupt on the parent the controller is
> +			connected to.
> +- interrupt-parent:	phandle of the parent interrupt controller.

This is implied (and may be in a parent node), so remove it.

> +- interrupt-controller: Marks the device node as an interrupt controller.
> +- #interrupt-cells:	Must be <2>.
> +
> +- gpio-controller : 	Marks the device node as a gpio controller.
> +- #gpio-cells : 	Must be <2>. The first cell is the pin number and

Some space before tabs here.

> +			the second cell is used to specify the gpio active
> +			state.
> +
> +Optional properties:
> +--------------------
> +gpio-line-names:	Single string containing the name of the GPIO line.
> +
> +The GPIO-controller module is represented as part of the top-level PMIC
> +node. The device exposes a single GPIO line.
> +
> +For device-tree bindings of other sub-modules (regulator, power supply,
> +LEDs and onkey) refer to the binding documents under the respective
> +sub-system directories.
> +
> +For more details on GPIO bindings, please refer to the generic GPIO DT
> +binding document <devicetree/bindings/gpio/gpio.txt>.
> +
> +Example:
> +--------
> +
> +	pmic: max77650@48 {

Hopefully some day this will stop.

pmic@48

> +		compatible = "maxim,max77650";
> +		reg = <0x48>;
> +
> +		interrupt-controller;
> +		interrupt-parent = <&gpio2>;
> +		#interrupt-cells = <2>;
> +		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		gpio-line-names = "max77650-charger";
> +	};
> -- 
> 2.20.1
> 
