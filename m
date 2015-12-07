From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v9 3/8] ARM: dt: Binding documentation for imx25
 touchscreen controller
Date: Mon, 7 Dec 2015 14:45:46 -0600
Message-ID: <20151207204546.GA30936@rob-hp-laptop>
References: <1449431542-1892-1-git-send-email-mpa@pengutronix.de>
 <1449431542-1892-4-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42765 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933065AbbLGUpx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 7 Dec 2015 15:45:53 -0500
Content-Disposition: inline
In-Reply-To: <1449431542-1892-4-git-send-email-mpa@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee.jones@linaro.org>, Denis Carikli <denis@eukrea.com>, Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Hartmut Knaack <knaack.h@gmx.de>, Fabio Estevam <festevam@gmail.com>

On Sun, Dec 06, 2015 at 08:52:16PM +0100, Markus Pargmann wrote:
> This is the touchscreen conversion queue binding documentation. It uses
> the shared imx25 ADC.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
> 
> Notes:
>     Changes in v9:
>      - Updated binding descriptions
>     
>     Changes in v5:
>      - Fix signed/unsigned comparison
>      - Fix unused variable settling_time by putting it in the correct argument list
>      - Use continous conversion queue with the repeat feature and a proper
>        repeat-wait. Previously the touchscreen caused massive number of interrupts.
> 
>  .../bindings/input/touchscreen/fsl-mx25-tcq.txt    | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt b/Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt
> new file mode 100644
> index 000000000000..d45e50872114
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt
> @@ -0,0 +1,35 @@
> +Freescale mx25 TS conversion queue module
> +
> +mx25 touchscreen conversion queue module which controls the ADC unit of the
> +mx25 for attached touchscreens.
> +
> +Required properties:
> + - compatible: Should be "fsl,imx25-tcq".
> + - reg: Memory range of the device.
> + - interrupts: Should be the interrupt number associated with this module within
> +   the tscadc unit (<0>).
> + - interrupt-parent: Should be a phandle to the tscadc unit.
> + - fsl,wires: Should be '<4>' or '<5>'
> +
> +Optional properties:
> + - fsl,pen-debounce: Pen debounce time in nanoseconds.

This and ...

> + - fsl,pen-threshold: Pen-down threshold for the touchscreen. This is a value
> +   between 1 and 4096. It is the ratio between the internal reference voltage
> +   and the measured voltage after the plate was precharged. Resistence between
> +   plates and therefore the voltage decreases with pressure so that a smaller
> +   value is equivalent to a higher pressure.
> + - fsl,settling-time: Settling time in nanoseconds. The settling time is before
> +   the actual touch detection to wait for an even charge distribution in the
> +   plate.

... this still need units (-ns) appended to the property name.

> +
> +This device includes two conversion queues which can be added as subnodes.
> +The first queue is for the touchscreen, the second for general purpose ADC.
> +
> +Example:
> +	tsc: tcq@50030400 {
> +		compatible = "fsl,imx25-tcq";
> +		reg = <0x50030400 0x60>;
> +		interrupt-parent = <&tscadc>;
> +		interrupts = <0>;
> +		fsl,wires = <4>;
> +	};
> -- 
> 2.6.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
