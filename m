From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH v4 2/3] input: Add DT binding documentation for Colibri
 VF50 touchscreen
Date: Sat, 22 Aug 2015 18:36:54 -0700
Message-ID: <24b47f359d019e8871887777372b442b@agner.ch>
References: <cover.1440162473.git.maitysanchayan@gmail.com>
 <8446d6df4b39f0b0acdc37afd4d66dbcca4d09ba.1440162473.git.maitysanchayan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kmu-office.ch ([178.209.48.109]:40714 "EHLO
	mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbbHWBhJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 22 Aug 2015 21:37:09 -0400
In-Reply-To: <8446d6df4b39f0b0acdc37afd4d66dbcca4d09ba.1440162473.git.maitysanchayan@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sanchayan Maity <maitysanchayan@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, shawnguo@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 2015-08-21 06:26, Sanchayan Maity wrote:
> This adds device tree binding documentation for the Colibri VF50
> touchscreen driver.
> 
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> ---
>  .../bindings/input/touchscreen/colibri-vf50-ts.txt | 36 ++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/input/touchscreen/colibri-vf50-ts.txt
> 
> diff --git
> a/Documentation/devicetree/bindings/input/touchscreen/colibri-vf50-ts.txt
> b/Documentation/devicetree/bindings/input/touchscreen/colibri-vf50-ts.txt
> new file mode 100644
> index 0000000..e615aa9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/colibri-vf50-ts.txt
> @@ -0,0 +1,36 @@
> +* Toradex Colibri VF50 Touchscreen driver
> +
> +Required Properties:
> +- compatible must be toradex,vf50-touchscreen
> +- io-channels: adc channels being used by the Colibri VF50 module
> +- xp-gpios: FET gate driver for input of X+
> +- xm-gpios: FET gate driver for input of X-
> +- yp-gpios: FET gate driver for input of Y+
> +- ym-gpios: FET gate driver for input of Y-
> +- interrupt-parent: phandle for the interrupt controller
> +- interrupts: pen irq interrupt for touch detection

I like the use of the interrupt interface for the touch detection pin.
Maybe you can mention here that this is (typically) a GPIO...

> +- pinctrl-names: "idle", "default", "gpios"
> +- pinctrl-0: pinctrl node for idle state gpio pinmux
> +- pinctrl-1: pinctrl node for touch detection state pinmux

"touch detection" for default is rather confusing or even wrong. The
Idle state is used for pen/touch detection, default is used for X/Y and
Pressure measurement (maybe better described as touch measurement).

> +- pinctrl-2: pinctrl node for gpios functioning as FET gate drivers
> +- vf50-ts-min-pressure: pressure level at which to stop measuring X/Y values
> +
> +Example:
> +
> +	touchctrl: vf50_touchctrl {
> +		compatible = "toradex,vf50-touchscreen";
> +		io-channels = <&adc1 0>,<&adc0 0>,
> +				<&adc0 1>,<&adc1 2>;
> +		xp-gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
> +		xm-gpios = <&gpio2 29 GPIO_ACTIVE_HIGH>;
> +		yp-gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
> +		ym-gpios = <&gpio0 4 GPIO_ACTIVE_HIGH>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "idle","default","gpios";
> +		pinctrl-0 = <&pinctrl_touchctrl_idle>;
> +		pinctrl-1 = <&pinctrl_touchctrl_default>;
> +		pinctrl-2 = <&pinctrl_touchctrl_gpios>;
> +		vf50-ts-min-pressure = <200>;
> +		status = "disabled";
> +	};

Otherwise I agree with 1 and 2:

Acked-by: Stefan Agner <stefan@agner.ch>

--
Stefan

