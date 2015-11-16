From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v8 3/8] ARM: dt: Binding documentation for imx25
 touchscreen controller
Date: Mon, 16 Nov 2015 08:16:09 -0600
Message-ID: <20151116141609.GA6167@rob-hp-laptop>
References: <1447675269-8831-1-git-send-email-mpa@pengutronix.de>
 <1447675269-8831-4-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42996 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600AbbKPOQR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Nov 2015 09:16:17 -0500
Content-Disposition: inline
In-Reply-To: <1447675269-8831-4-git-send-email-mpa@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee.jones@linaro.org>, Denis Carikli <denis@eukrea.com>, Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Hartmut Knaack <knaack.h@gmx.de>, Fabio Estevam <festevam@gmail.com>

On Mon, Nov 16, 2015 at 01:01:04PM +0100, Markus Pargmann wrote:
> This is the touchscreen conversion queue binding documentation. It uses
> the shared imx25 ADC.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
> 
> Notes:
>     Changes in v5:
>      - Fix signed/unsigned comparison
>      - Fix unused variable settling_time by putting it in the correct argument list
>      - Use continous conversion queue with the repeat feature and a proper
>        repeat-wait. Previously the touchscreen caused massive number of interrupts.
> 
>  .../bindings/input/touchscreen/fsl-mx25-tcq.txt    | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt b/Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt
> new file mode 100644
> index 000000000000..89ab47a3acc1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt
> @@ -0,0 +1,29 @@
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
> + - fsl,pen-threshold: Pen-down threshold for the touchscreen.
> + - fsl,settling-time: Settling time in nanoseconds.

Don't we have standard properties for these? If not, these should have 
units.

I don't understand the difference between debounce and settling times. 
Please make that clear in the doc.

Rob

