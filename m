From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v6 2/8] ARM: dt: Binding documentation for imx25 GCQ
Date: Wed, 04 Feb 2015 16:48:32 +0000
Message-ID: <54D24D60.2030009@kernel.org>
References: <1422540556-14828-1-git-send-email-mpa@pengutronix.de> <1422540556-14828-3-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60591 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161776AbbBDSku (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Feb 2015 13:40:50 -0500
In-Reply-To: <1422540556-14828-3-git-send-email-mpa@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Fabio Estevam <festevam@gmail.com>, Peter Meerwald <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>
Cc: Denis Carikli <denis@eukrea.com>, =?windows-1252?Q?Eric_B=E9nard?= <eric@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>

On 29/01/15 14:09, Markus Pargmann wrote:
> The documentation describes the bindings for the imx25 GCQ unit which is
> essentially a generic conversion queue using the imx25 ADC.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
> 
> Notes:
>     Changes in v6:
>      - Moved the raw_read code out to a different function to cleanup the code
To be picky, that's in a later patch rather than this one...
>      - Changed bindings to use adc-refp and adc-refn. Also a bit of cleanup in the
>        setup routine.
>      - Added defines for a complete list of references in the dt binding macros
>     
>     Changes in v5:
>      - Fixed locking
>      - Removed module owner
> 
>  .../devicetree/bindings/iio/adc/fsl,imx25-gcq.txt  | 54 ++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt b/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt
> new file mode 100644
> index 000000000000..9f7c08990034
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt
> @@ -0,0 +1,54 @@
> +Freescale i.MX25 ADC GCQ device
> +
> +This is a generic conversion queue device that can convert any of the
> +analog inputs using the ADC unit of the i.MX25.
> +
> +Required properties:
> + - compatible: Should be "fsl,imx25-gcq".
> + - reg: Should be the register range of the module.
> + - interrupts: Should be the interrupt number of the module.
> +   Typically this is <1>.
> + - interrupt-parent: phandle to the tsadc module of the i.MX25.
> + - #address-cells: Should be <1> (setting for the subnodes)
> + - #size-cells: Should be <0> (setting for the subnodes)
> +
> +Optional properties:
> + - vref-supply: The regulator supplying the ADC reference voltage.
> +   Required when at least one subnode uses the external reference.
Note, as commented on next patch, the regulator request should reflect
this dependency.
> +
> +Sub-nodes:
> +Optionally you can define subnodes which define the reference voltage
> +for the analog inputs.
> +
> +Required properties for subnodes:
> + - reg: Should be the number of the analog input.
> +     0: xp
> +     1: yp
> +     2: xn
> +     3: yn
> +     4: wiper
> +     5: inaux0
> +     6: inaux1
> +     7: inaux2
> +Optional properties for subnodes:
> + - fsl,adc-refp: specifies the positive reference input as defined in
> +     <dt-bindings/iio/adc/fsl-imx25-gcq.h>
> + - fsl,adc-refn: specifies the negative reference input as defined in
> +     <dt-bindings/iio/adc/fsl-imx25-gcq.h>
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
> +			fsl,adc-refp = <MX25_ADC_REF_INT>;
> +			fsl,adc-refn = <MX25_ADC_REF_NGND>;
> +		};
> +	};
> 

