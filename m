From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1] Add support for the ektf2127 touchscreencontroller
Date: Tue, 5 Jul 2016 11:13:47 -0500
Message-ID: <20160705161347.GA17009@rob-hp-laptop>
References: <1467624545-3455-1-git-send-email-siebren.vroegindeweij@gmail.com>
 <1467624545-3455-2-git-send-email-siebren.vroegindeweij@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36327 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbcGEQOj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2016 12:14:39 -0400
Content-Disposition: inline
In-Reply-To: <1467624545-3455-2-git-send-email-siebren.vroegindeweij@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Siebren Vroegindeweij <siebren.vroegindeweij@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Michel Verlaan <michel.verl@gmail.com>, Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>

On Mon, Jul 04, 2016 at 11:29:05AM +0200, Siebren Vroegindeweij wrote:
> From: Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>
> 
> The ELAN eKTF2127 driver is written for the ELAN series of
> touchscreencontrollers. This version is especially written for the
space        ^

> eKTF2127 controller. The driver communicates to the controller over i2c.
> The additional screen specifications can be read from the devicetree file.
> The driver has also the ability to read the screen height and width from
> the controller. When the screen is pressed, a interrupt is generated.
> The interrupt wil be handled by a function that request a data string from
> the controller. This string is then modified so that the right number of touches
> and their x and y coordinates are available and given to userspace through
> the input subsystem.
> 
> Signed-off-by: Michel Verlaan <michel.verl@gmail.com>
> Signed-off-by: Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>
> ---
>  .../bindings/input/touchscreen/ektf2127.txt        |  40 +++
>  drivers/input/touchscreen/Kconfig                  |  11 +
>  drivers/input/touchscreen/Makefile                 |   1 +
>  drivers/input/touchscreen/ektf2127.c               | 351 +++++++++++++++++++++
>  4 files changed, 403 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ektf2127.txt
>  create mode 100644 drivers/input/touchscreen/ektf2127.c
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/ektf2127.txt b/Documentation/devicetree/bindings/input/touchscreen/ektf2127.txt
> new file mode 100644
> index 0000000..a774336
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/ektf2127.txt
> @@ -0,0 +1,40 @@
> +* Elan eKTF2127 I2C touchscreen controller
> +
> +Required properties:
> + - compatible		  : "elan,ektf2127"
> + - reg			  : I2C slave address of the chip (0x40)
> + - interrupt-parent	  : a phandle pointing to the interrupt controller
> +			    serving the interrupt for this chip
> + - interrupts		  : interrupt specification for the eKTF2127 interrupt
> + - wake-gpios		  : GPIO specification for the WAKE input

Please state the active state and make it clear this is input to the 
touch controller (or host?).

> +
> +Optional properties:
> + - touchscreen-size-x	  : horizontal resolution of touchscreen (in pixels)
> + - touchscreen-size-y	  : vertical resolution of touchscreen (in pixels)
> + - touchscreen-fuzz-x	  : horizontal noise value of the absolute input
> +			    device (in pixels)
> + - touchscreen-fuzz-y	  : vertical noise value of the absolute input
> +			    device (in pixels)
> + - touchscreen-inverted-x : X axis is inverted (boolean)
> + - touchscreen-inverted-y : Y axis is inverted (boolean)
> + - touchscreen-swapped-x-y	  : X and Y axis are swapped (boolean)
> +			    Swapping is done after inverting the axis

Just state "See touchscreen.txt" for each of these.

> +
> +Example:
> +
> +i2c@00000000 {
> +
> +	ektf2127: touchscreen@40 {
> +		compatible = "elan,ektf2127";
> +		reg = <0x40>;
> +		interrupt-parent = <&pio>;
> +		interrupts = <6 11 IRQ_TYPE_EDGE_FALLING>
> +		/* pinctrl-names = "default";
> +		pinctrl-0 = <&ts_wake_pin_p66>; */

Not documented.

> +		power-gpios = <&pio 1 3 GPIO_ACTIVE_HIGH>;

Not documented.

> +		touchscreen-inverted-x;
> +		touchscreen-swapped-x-y;
> +	};
> +
> +};
> +
