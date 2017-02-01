From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH v2] Input: gpio_keys - add dt abs/rel button support
Date: Wed, 1 Feb 2017 11:25:31 -0600
Message-ID: <20170201172531.cdhjrl4rfidgouul@rob-hp-laptop>
References: <20170131075516.GA4462@Gaia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170131075516.GA4462@Gaia>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans Holmberg <hans@pixelmunchies.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Guenter Roeck <linux@roeck-us.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Jan 31, 2017 at 08:55:19AM +0100, Hans Holmberg wrote:
> This change adds support for specifying device tree buttons emitting
> abs/rel events.
> 
> ABS events were previously supported, but only via platform data, so add
> the missing device tree property to allow axis values to be emitted with
> abs/rel events.
> 
> Also emit 0 on button releases for REL and ABS keys. This is a must-have
> for supporting digital joysticks, and aligns the driver whith
> gpio-keys-polled.
> 
> Finally, report min/max values for abs axes to the input framework.
> 
> Signed-off-by: Hans Holmberg <hans@pixelmunchies.com>
> ---
> 
> RFC because it alters the behaviour of abs-buttons making them
> un-sticky, reporting 0 on button releases - just like gpio-keys-polled.
> 
> FWIW, i've looked through the in-tree board files and not found a
> single occurence of abs gpio-buttons.
> 
> Changes since v1:
> * Corrected cc list - now the mailing lists are looped in.
> 
>  .../devicetree/bindings/input/gpio-keys.txt        | 50 +++++++++++++++++++++-
>  drivers/input/keyboard/gpio_keys.c                 | 29 +++++++++++--
>  2 files changed, 75 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Documentation/devicetree/bindings/input/gpio-keys.txt
> index a949404..1b53eed 100644
> --- a/Documentation/devicetree/bindings/input/gpio-keys.txt
> +++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
> @@ -22,6 +22,13 @@ both at the same time. Specifying both properties is allowed.
>  Optional subnode-properties:
>  	- linux,input-type: Specify event type this button/key generates.
>  	  If not specified defaults to <1> == EV_KEY.
> +	- linux,input-value: If linux,input-type is EV_ABS or EV_REL then this
> +	  value is sent for events this button generates when pressed.
> +	  EV_ABS/EV_REL axis will generate an event with a value of 0 when
> +	  all buttons with linux,input-type == type and linux,code == axis
> +	  are released. This value is interpreted as a signed 32 bit value,
> +	  e.g. to make a button generate a value of -1 use:
> +	  linux,input-value = <0xffffffff>; /* -1 */
>  	- debounce-interval: Debouncing interval time in milliseconds.
>  	  If not specified defaults to 5.
>  	- wakeup-source: Boolean, button can wake-up the system.
> @@ -47,4 +54,45 @@ Example nodes:
>  				linux,code = <108>;
>  				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
>  			};
> -			...
> +	...
> +
> +	gpio-joystick: {

Why do we need a whole new example?

> +			compatible = "gpio-keys";
> +
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&my_pins>;
> +
> +			up {
> +				gpios = <&gpio 26 1>;
> +				linux,input-type = <EV_ABS>;
> +				linux,code = <ABS_Y>;
> +				linux,input-value = <0xffffffff>;
> +			};
> +
> +			down {
> +				gpios = <&gpio 13 1>;
> +				linux,input-type = <EV_ABS>;
> +				linux,code = <ABS_Y>;
> +				linux,input-value = <1>;
> +			};
> +
> +			left {
> +				gpios = <&gpio 6 1>;
> +				linux,input-type = <EV_ABS>;
> +				linux,code = <ABS_X>;
> +				linux,input-value = <0xffffffff>;
> +			};
> +
> +			right {
> +				gpios = <&gpio 5 1>;
> +				linux,input-type = <EV_ABS>;
> +				linux,code = <ABS_X>;
> +				linux,input-value = <0x1>;
> +			};
> +
> +			trigger_button {
> +				gpios = <&gpio 12 1>;
> +				linux,code = <BTN_TRIGGER>;
> +			};
> +	};
> +	...
