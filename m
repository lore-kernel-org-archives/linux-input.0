From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/3] Input: cyttsp - add device tree support
Date: Wed, 6 Jan 2016 09:02:56 -0600
Message-ID: <20160106150256.GA27683@rob-hp-laptop>
References: <cover.1451997697.git.oreste.salerno@tomtom.com>
 <97cd8c1d98d7406347e4e48f4c7383a394a2ae93.1451997697.git.oreste.salerno@tomtom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46102 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751605AbcAFPDB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 6 Jan 2016 10:03:01 -0500
Content-Disposition: inline
In-Reply-To: <97cd8c1d98d7406347e4e48f4c7383a394a2ae93.1451997697.git.oreste.salerno@tomtom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oreste Salerno <oreste.salerno@tomtom.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, fery@cypress.com, dmitry.torokhov@gmail.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org

On Tue, Jan 05, 2016 at 01:59:14PM +0100, Oreste Salerno wrote:
> Add support for retrieving the platform data from the device
> tree.

Converting platform data to DT as is is typically not the right thing to 
do. There's some overlap, but it is not typically 1-1.

> Signed-off-by: Oreste Salerno <oreste.salerno@tomtom.com>
> ---
>  .../bindings/input/touchscreen/cyttsp.txt          |  73 ++++++++++++++
>  drivers/input/touchscreen/cyttsp_core.c            | 108 +++++++++++++++++++--
>  include/linux/input/cyttsp.h                       |   3 +
>  3 files changed, 177 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cyttsp.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/cyttsp.txt b/Documentation/devicetree/bindings/input/touchscreen/cyttsp.txt
> new file mode 100644
> index 0000000..8e0bcc73
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/cyttsp.txt
> @@ -0,0 +1,73 @@
> +* Cypress cyttsp touchscreen controller
> +
> +Required properties:
> +- compatible		: must be "cypress,cyttsp-i2c" or "cypress,cyttsp-spi"
> +- reg			: Device address

...or SPI chip select number

> +- spi-max-frequency 	: Maximum SPI clocking speed of the device (for cyttsp-spi)
> +- interrupt-parent	: the phandle for the gpio controller
> +			  (see interrupt binding[0]).
> +- interrupts		: (gpio) interrupt to which the chip is connected
> +			  (see interrupt binding[0]).
> +- reset-gpios		: the reset gpio the chip is connected to
> +			  (see GPIO binding[1] for more details).
> +- maxx			: horizontal resolution of touchscreen (in pixels)
> +- maxy			: vertical resolution of touchscreen (in pixels)

IIRC, we have standard properties for these. Touchscreens don't really 
have pixels...

> +- bootloader-key	: the bootloader key used to exit bootloader mode

I don't understand what this is.

> +
> +Optional properties:
> +- use_hndshk		: enable handshake bit
> +- act_dist		: active distance
> +- act_intrvl		: active refresh interval in ms

Is this sampling frequency?

> +- tch_tmout		: active touch timeout in ms
> +- lp_intrvl		: low power refresh interval in ms

Look whether other touchscreens bindings have similar properties already 
and copy those. These need better definitions in general.

Don't use '_' in property names and append units to the name of 
properties that have units (e.g. ms).

> +Example:
> +	&i2c1 {
> +		/* ... */
> +		cyttsp@a {
> +			compatible = "cypress,cyttsp-i2c";
> +			reg = <0xa>;
> +			interrupt-parent = <&msm_gpio>;
> +			interrupts = <13 0x2008>;
> +			reset-gpios = <&msm_gpio 12 0x00>;
> +
> +			maxx = <800>;
> +			maxy = <480>;
> +			bootloader-key = /bits/ 8 <0x01 0x02 0x03 0x04 0x05 0x06 0x07 0x08>;
> +
> +			use_hndshk;
> +			act_dist = /bits/ 8 <0xF8>;
> +			act_intrvl = /bits/ 8 <0x00>;
> +			tch_tmout = /bits/ 8 <0xFF>;
> +			lp_intrvl = /bits/ 8 <0x0A>;

If the size is not 32-bits, you need to state that in the description. 
There is not really much point in making these 8-bit though.

Rob
