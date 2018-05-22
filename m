From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH v7 7/9] dt-bindings: iio: adc: at91-sama5d2_adc: add
 channel specific consumer info
Date: Tue, 22 May 2018 14:23:19 +0200
Message-ID: <20180522122319.GN22971@rfolt0960.corp.atmel.com>
References: <1526975559-18966-1-git-send-email-eugen.hristev@microchip.com>
 <1526975559-18966-8-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1526975559-18966-8-git-send-email-eugen.hristev@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: jic23@kernel.org, ludovic.desroches@microchip.com, alexandre.belloni@bootlin.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, nicolas.ferre@microchip.com, dmitry.torokhov@gmail.com, robh@kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, May 22, 2018 at 10:52:37AM +0300, Eugen Hristev wrote:
> Added defines for channel consumer device-tree binding
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

> ---
>  .../devicetree/bindings/iio/adc/at91-sama5d2_adc.txt     |  9 +++++++++
>  include/dt-bindings/iio/adc/at91-sama5d2_adc.h           | 16 ++++++++++++++++
>  2 files changed, 25 insertions(+)
>  create mode 100644 include/dt-bindings/iio/adc/at91-sama5d2_adc.h
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> index 6469a4c..4a3c1d4 100644
> --- a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> @@ -21,6 +21,14 @@ Optional properties:
>    - dmas: Phandle to dma channel for the ADC.
>    - dma-names: Must be "rx" when dmas property is being used.
>    See ../../dma/dma.txt for details.
> +  - #io-channel-cells: in case consumer drivers are attached, this must be 1.
> +  See <Documentation/devicetree/bindings/iio/iio-bindings.txt> for details.
> +
> +Properties for consumer drivers:
> +  - Consumer drivers can be connected to this producer device, as specified
> +  in <Documentation/devicetree/bindings/iio/iio-bindings.txt>
> +  - Channels exposed are specified in:
> +  <dt-bindings/iio/adc/at91-sama5d2_adc.txt>
>  
>  Example:
>  
> @@ -38,4 +46,5 @@ adc: adc@fc030000 {
>  	atmel,trigger-edge-type = <IRQ_TYPE_EDGE_BOTH>;
>  	dmas = <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) | AT91_XDMAC_DT_PERID(25))>;
>  	dma-names = "rx";
> +	#io-channel-cells = <1>;
>  }
> diff --git a/include/dt-bindings/iio/adc/at91-sama5d2_adc.h b/include/dt-bindings/iio/adc/at91-sama5d2_adc.h
> new file mode 100644
> index 0000000..70f99db
> --- /dev/null
> +++ b/include/dt-bindings/iio/adc/at91-sama5d2_adc.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * This header provides constants for configuring the AT91 SAMA5D2 ADC
> + */
> +
> +#ifndef _DT_BINDINGS_IIO_ADC_AT91_SAMA5D2_ADC_H
> +#define _DT_BINDINGS_IIO_ADC_AT91_SAMA5D2_ADC_H
> +
> +/* X relative position channel index */
> +#define AT91_SAMA5D2_ADC_X_CHANNEL		24
> +/* Y relative position channel index */
> +#define AT91_SAMA5D2_ADC_Y_CHANNEL		25
> +/* pressure channel index */
> +#define AT91_SAMA5D2_ADC_P_CHANNEL		26
> +
> +#endif
> -- 
> 2.7.4
> 
