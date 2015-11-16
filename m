From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v8 2/8] ARM: dt: Binding documentation for imx25 GCQ
Date: Mon, 16 Nov 2015 09:12:55 -0600
Message-ID: <20151116151255.GA8302@rob-hp-laptop>
References: <1447675269-8831-1-git-send-email-mpa@pengutronix.de>
 <1447675269-8831-3-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46728 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750865AbbKPPNB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Nov 2015 10:13:01 -0500
Content-Disposition: inline
In-Reply-To: <1447675269-8831-3-git-send-email-mpa@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee.jones@linaro.org>, Denis Carikli <denis@eukrea.com>, Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Hartmut Knaack <knaack.h@gmx.de>, Fabio Estevam <festevam@gmail.com>

On Mon, Nov 16, 2015 at 01:01:03PM +0100, Markus Pargmann wrote:
> The documentation describes the bindings for the imx25 GCQ unit which is
> essentially a generic conversion queue using the imx25 ADC.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
> 
> Notes:
>     Changes in v6:
>      - Changed bindings to use adc-refp and adc-refn. Also a bit of cleanup in the
>        setup routine.
>     
>     Changes in v5:
>      - Fixed locking
>      - Removed module owner
> 
>  .../devicetree/bindings/iio/adc/fsl,imx25-gcq.txt  | 58 ++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt b/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt
> new file mode 100644
> index 000000000000..b0866d36a307
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt


> +Optional properties for subnodes:
> + - fsl,adc-refp: specifies the positive reference input as defined in
> +     <dt-bindings/iio/adc/fsl-imx25-gcq.h>
> + - fsl,adc-refn: specifies the negative reference input as defined in
> +     <dt-bindings/iio/adc/fsl-imx25-gcq.h>

This header should be part of this commit.

> +
> +Example:
> +
> +	adc: adc@50030800 {
> +		compatible = "fsl,imx25-gcq";
> +		reg = <0x50030800 0x60>;
> +		interrupt-parent = <&tscadc>;
> +		interrupts = <1>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		inaux@5 {
> +			reg = <5>;
> +			fsl,adc-refp = <MX25_ADC_REFP_INT>;
> +			fsl,adc-refn = <MX25_ADC_REFN_NGND>;
> +		};
> +	};
> -- 
> 2.6.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
