From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: gpio-keys: Move the gpio-keys bindings
 documentation
Date: Mon, 12 May 2014 10:58:06 -0700
Message-ID: <20140512175806.GB16764@core.coreip.homeip.net>
References: <1399905224-1273-1-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1399905224-1273-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-input@vger.kernel.org

On Mon, May 12, 2014 at 11:33:44AM -0300, Ezequiel Garcia wrote:
> This is an input driver and belongs to input not gpio.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Fine by me, will DT guys pick the patch or shoudl I do it?

Thanks!

> ---
>  .../devicetree/bindings/gpio/gpio_keys.txt         | 36 ----------------------
>  .../devicetree/bindings/input/gpio-keys.txt        | 36 ++++++++++++++++++++++
>  2 files changed, 36 insertions(+), 36 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/gpio/gpio_keys.txt
>  create mode 100644 Documentation/devicetree/bindings/input/gpio-keys.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio_keys.txt b/Documentation/devicetree/bindings/gpio/gpio_keys.txt
> deleted file mode 100644
> index 5c2c021..0000000
> --- a/Documentation/devicetree/bindings/gpio/gpio_keys.txt
> +++ /dev/null
> @@ -1,36 +0,0 @@
> -Device-Tree bindings for input/gpio_keys.c keyboard driver
> -
> -Required properties:
> -	- compatible = "gpio-keys";
> -
> -Optional properties:
> -	- autorepeat: Boolean, Enable auto repeat feature of Linux input
> -	  subsystem.
> -
> -Each button (key) is represented as a sub-node of "gpio-keys":
> -Subnode properties:
> -
> -	- gpios: OF device-tree gpio specification.
> -	- label: Descriptive name of the key.
> -	- linux,code: Keycode to emit.
> -
> -Optional subnode-properties:
> -	- linux,input-type: Specify event type this button/key generates.
> -	  If not specified defaults to <1> == EV_KEY.
> -	- debounce-interval: Debouncing interval time in milliseconds.
> -	  If not specified defaults to 5.
> -	- gpio-key,wakeup: Boolean, button can wake-up the system.
> -
> -Example nodes:
> -
> -	gpio_keys {
> -			compatible = "gpio-keys";
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			autorepeat;
> -			button@21 {
> -				label = "GPIO Key UP";
> -				linux,code = <103>;
> -				gpios = <&gpio1 0 1>;
> -			};
> -			...
> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Documentation/devicetree/bindings/input/gpio-keys.txt
> new file mode 100644
> index 0000000..5c2c021
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
> @@ -0,0 +1,36 @@
> +Device-Tree bindings for input/gpio_keys.c keyboard driver
> +
> +Required properties:
> +	- compatible = "gpio-keys";
> +
> +Optional properties:
> +	- autorepeat: Boolean, Enable auto repeat feature of Linux input
> +	  subsystem.
> +
> +Each button (key) is represented as a sub-node of "gpio-keys":
> +Subnode properties:
> +
> +	- gpios: OF device-tree gpio specification.
> +	- label: Descriptive name of the key.
> +	- linux,code: Keycode to emit.
> +
> +Optional subnode-properties:
> +	- linux,input-type: Specify event type this button/key generates.
> +	  If not specified defaults to <1> == EV_KEY.
> +	- debounce-interval: Debouncing interval time in milliseconds.
> +	  If not specified defaults to 5.
> +	- gpio-key,wakeup: Boolean, button can wake-up the system.
> +
> +Example nodes:
> +
> +	gpio_keys {
> +			compatible = "gpio-keys";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			autorepeat;
> +			button@21 {
> +				label = "GPIO Key UP";
> +				linux,code = <103>;
> +				gpios = <&gpio1 0 1>;
> +			};
> +			...
> -- 
> 1.9.1
> 

-- 
Dmitry
