From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 04/11] dt-bindings: input: add DT bindings for max77650
Date: Wed, 13 Feb 2019 14:50:23 -0600
Message-ID: <20190213205023.GA8340@bogus>
References: <20190213134335.10838-1-brgl@bgdev.pl>
 <20190213134335.10838-5-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190213134335.10838-5-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

On Wed, Feb 13, 2019 at 02:43:28PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Add the DT binding document for the onkey module of max77650.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  .../bindings/input/max77650-onkey.txt         | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/max77650-onkey.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/max77650-onkey.txt b/Documentation/devicetree/bindings/input/max77650-onkey.txt
> new file mode 100644
> index 000000000000..37c80898be4d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/max77650-onkey.txt
> @@ -0,0 +1,26 @@
> +Onkey driver for MAX77650 PMIC from Maxim Integrated.
> +
> +This module is part of the MAX77650 MFD device. For more details
> +see Documentation/devicetree/bindings/mfd/max77650.txt.
> +
> +The onkey controller is represented as a sub-node of the PMIC node on
> +the device tree.
> +
> +Required properties:
> +--------------------
> +- compatible:		Must be "maxim,max77650-onkey".
> +
> +Optional properties:
> +- linux,code:		The key-code to be reported when the key is pressed.
> +			Defaults to KEY_POWER.
> +- maxim,onkey-mode:	Must be "push" or "slide" depending on the type of
> +			button used by the system. Defaults to "push".

Perhaps just a boolean for 'slide' mode.

> +
> +Example:
> +--------
> +
> +	onkey {
> +		compatible = "maxim,max77650-onkey";
> +		linux,code = <KEY_END>;
> +		maxim,onkey-mode = "slide";
> +	};
> -- 
> 2.20.1
> 
