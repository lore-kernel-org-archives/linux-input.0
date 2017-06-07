From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/2] Documentation: DT: bindings: input: Add
 documentation for cyttsp5
Date: Wed, 7 Jun 2017 15:26:03 -0500
Message-ID: <20170607202603.f7qh46gjkjrxx3cp@rob-hp-laptop>
References: <20170529144538.29187-1-mylene.josserand@free-electrons.com>
 <20170529144538.29187-3-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:34280 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbdFGU0F (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Jun 2017 16:26:05 -0400
Content-Disposition: inline
In-Reply-To: <20170529144538.29187-3-mylene.josserand@free-electrons.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>
Cc: dmitry.torokhov@gmail.com, fery@cypress.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, thomas.petazzoni@free-electrons.com, maxime.ripard@free-electrons.com

On Mon, May 29, 2017 at 04:45:38PM +0200, Mylène Josserand wrote:
> Add the Cypress TrueTouch Generation 5 touchscreen device tree bindings
> documentation. It can use I2C or SPI bus.
> This touchscreen can handle some defined zone that are designed and
> sent as button. To be able to customize the keycode sent, the
> "linux,code" property in a "button" sub-node can be used.

"documentation" twice in the subject makes for a long subject. 
The preferred subject prefix is "dt-bindings: input: ..."

> 
> Signed-off-by: Mylène Josserand <mylene.josserand@free-electrons.com>
> ---
>  .../bindings/input/touchscreen/cyttsp5.txt         | 55 ++++++++++++++++++++++

cypress,cyttsp5.txt matching the compatible is preferred.

>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cyttsp5.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/cyttsp5.txt b/Documentation/devicetree/bindings/input/touchscreen/cyttsp5.txt
> new file mode 100644
> index 000000000000..713a377b5039
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/cyttsp5.txt
> @@ -0,0 +1,55 @@
> +* Cypress cyttsp touchscreen controller, generation 5
> +
> +Required properties:
> + - compatible		: must be "cypress,cyttsp5"
> + - reg			: Device I2C address or SPI chip select number
> + - interrupt-parent	: the phandle for the gpio controller
> +			  (see interrupt binding[0]).
> + - interrupts		: (gpio) interrupt to which the chip is connected
> +			  (see interrupt binding[0]).
> +
> +Optional properties (many of them coming from touchscreen binding[1]):
> + - reset-gpios		: the reset gpio the chip is connected to
> +			  (see GPIO binding[2] for more details).
> + - touchscreen-size-x	: horizontal resolution of touchscreen (in pixels)

Just "see ./touchscreen.txt" is enough description.

> + - touchscreen-size-y	: vertical resolution of touchscreen (in pixels)
> + - touchscreen-fuzz-x	: horizontal noise value of the absolute input device
> +			  (in pixels)
> + - touchscreen-fuzz-y	: vertical noise value of the absolute input device
> +			  (in pixels)
> +
> +This touchscreen can handle some buttons that are touchscreen's defined zones.
> +Each button's event can be customized using a sub-node properties:
> +	- linux,code: Keycode to emit.
> +
> +[0]: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> +[1]: Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
> +[2]: Documentation/devicetree/bindings/gpio/gpio.txt
> +
> +Example:
> +&i2c0 {
> +	[...]
> +
> +	tsc@24 {

touchscreen@24

> +		compatible = "cypress,cyttsp5";
> +		reg = <0x24>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&tp_reset_ds203>;
> +		interrupt-parent = <&pio>;
> +		interrupts = <1 5 IRQ_TYPE_LEVEL_LOW>;
> +		reset-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>;
> +
> +		button@0 {

unit addresses need a reg property. If 0,1,2 are meaningful numbers for 
the hardware, then it makes sense to add here.

> +			linux,code = <KEY_HOMEPAGE>;
> +		};
> +
> +		button@1 {
> +			linux,code = <KEY_MENU>;
> +		};
> +
> +		button@2 {
> +			linux,code = <KEY_BACK>;
> +		};
> +	};
> +};
> -- 
> 2.11.0
> 
