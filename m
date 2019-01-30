From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH v2 05/13] dt-bindings: leds: add DT bindings for max77650
Date: Wed, 30 Jan 2019 20:58:26 +0100
Message-ID: <0c9e7c6c-d1c0-8acc-88cb-16b01f75e134@gmail.com>
References: <20190129133545.1931-1-brgl@bgdev.pl>
 <20190129133545.1931-7-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190129133545.1931-7-brgl@bgdev.pl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

Hi Bartosz,

Thank you for addressing my remarks.

On 1/29/19 2:35 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Add the DT binding document for the LEDs module of max77650.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   .../bindings/leds/leds-max77650.txt           | 57 +++++++++++++++++++
>   1 file changed, 57 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/leds/leds-max77650.txt
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-max77650.txt b/Documentation/devicetree/bindings/leds/leds-max77650.txt
> new file mode 100644
> index 000000000000..b2fac8e719a6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-max77650.txt
> @@ -0,0 +1,57 @@
> +LED driver for MAX77650 PMIC from Maxim Integrated.
> +
> +This module is part of the MAX77650 MFD device. For more details
> +see Documentation/devicetree/bindings/mfd/max77650.txt.
> +
> +The LED controller is represented as a sub-node of the PMIC node on
> +the device tree.
> +
> +This device has three current sinks.
> +
> +Required properties:
> +--------------------
> +- compatible:		Must be "maxim,max77650-led"
> +- #address-cells:	Must be <1>.
> +- #size-cells:		Must be <0>.
> +
> +Each LED is represented as a sub-node of the LED-controller node. Up to
> +three sub-nodes can be defined.
> +
> +Required properties of the sub-node:
> +------------------------------------
> +
> +- reg:			Must be <0>, <1> or <2>.
> +
> +Optional properties of the sub-node:
> +------------------------------------
> +
> +- label:		See Documentation/devicetree/bindings/leds/common.txt
> +- linux,default-trigger: See Documentation/devicetree/bindings/leds/common.txt
> +
> +For more details, please refer to the generic GPIO DT binding document
> +<devicetree/bindings/gpio/gpio.txt>.
> +
> +Example:
> +--------
> +
> +	leds {
> +		compatible = "maxim,max77650-leds";

s/leds/led/

With that:

Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>

> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		led@0 {
> +			reg = <0>;
> +			label = "blue:usr0";
> +		};
> +
> +		led@1 {
> +			reg = <1>;
> +			label = "red:usr1";
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		led@2 {
> +			reg = <2>;
> +			label = "green:usr2";
> +		};
> +	};
> 

-- 
Best regards,
Jacek Anaszewski
