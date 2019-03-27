From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: input: add GPIO controllable vibrator
Date: Wed, 27 Mar 2019 14:43:19 -0500
Message-ID: <20190327194319.GA20142@bogus>
References: <20190302141132.21160-1-luca@z3ntu.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190302141132.21160-1-luca@z3ntu.xyz>
Sender: linux-kernel-owner@vger.kernel.org
To: Luca Weiss <luca@z3ntu.xyz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sat, Mar 02, 2019 at 03:11:30PM +0100, Luca Weiss wrote:
> Provide a simple driver for GPIO controllable vibrators.
> It will be used by the Fairphone 2.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  .../devicetree/bindings/input/gpio-vibrator.txt  | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/gpio-vibrator.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/gpio-vibrator.txt b/Documentation/devicetree/bindings/input/gpio-vibrator.txt
> new file mode 100644
> index 000000000000..9e2e9acf497b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/gpio-vibrator.txt
> @@ -0,0 +1,16 @@
> +* GPIO vibrator device tree bindings
> +
> +Registers a GPIO device as vibrator, where the vibration motor just has the capability to turn on or off. If the device is connected to a pwm, you should use the pwm-vibrator driver instead.

Need to wrap line.

> +
> +Required properties:
> +- compatible: should contain "gpio-vibrator"
> +- enable-gpios: Should contain a GPIO handle
> +- vcc-supply: Phandle for the regulator supplying power

This should probably be optional. There may not be a s/w controllable 
supply.

> +
> +Example from Fairphone 2:
> +
> +vibrator {
> +	compatible = "gpio-vibrator";
> +	enable-gpios = <&msmgpio 86 GPIO_ACTIVE_HIGH>;
> +	vcc-supply = <&pm8941_l18>;
> +};
> -- 
> 2.21.0
> 
