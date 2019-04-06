From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v8 02/11] dt-bindings: power: supply: add DT bindings for
 max77650
Date: Sat, 6 Apr 2019 02:07:46 -0500
Message-ID: <20190406070746.GA29624@bogus>
References: <20190403090108.24788-1-brgl@bgdev.pl>
 <20190403090108.24788-3-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190403090108.24788-3-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

On Wed, Apr 03, 2019 at 11:00:59AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Add the DT binding document for the battery charger module of max77650.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  .../power/supply/max77650-charger.txt         | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/max77650-charger.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/max77650-charger.txt b/Documentation/devicetree/bindings/power/supply/max77650-charger.txt
> new file mode 100644
> index 000000000000..fef188144386
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/max77650-charger.txt
> @@ -0,0 +1,27 @@
> +Battery charger driver for MAX77650 PMIC from Maxim Integrated.
> +
> +This module is part of the MAX77650 MFD device. For more details
> +see Documentation/devicetree/bindings/mfd/max77650.txt.
> +
> +The charger is represented as a sub-node of the PMIC node on the device tree.
> +
> +Required properties:
> +--------------------
> +- compatible:		Must be "maxim,max77650-charger"
> +
> +Optional properties:
> +--------------------
> +- min-microvolt:	Minimum CHGIN regulation voltage (in microvolts). Must be
> +			one of: 4000000, 4100000, 4200000, 4300000, 4400000,
> +			4500000, 4600000, 4700000.
> +- current-limit-microamp:	CHGIN input current limit (in microamps). Must
> +				be one of: 95000, 190000, 285000, 380000, 475000.

To repeat what I said on v6, these should be common properties IMO (and 
therefore documented as such).

> +
> +Example:
> +--------
> +
> +	charger {
> +		compatible = "maxim,max77650-charger";
> +		min-microvolt = <4200000>;
> +		curr-lim-microamp = <285000>;
> +	};
> -- 
> 2.21.0
> 
