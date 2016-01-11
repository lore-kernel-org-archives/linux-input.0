From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/3] Input: cyttsp - add device tree bindings
Date: Sun, 10 Jan 2016 21:01:56 -0600
Message-ID: <20160111030156.GA18656@rob-hp-laptop>
References: <cover.1452447124.git.oreste.salerno@tomtom.com>
 <dd329fe3420fba4049c353a9a092ff9c45c5a252.1452447124.git.oreste.salerno@tomtom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36625 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757904AbcAKDCB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Jan 2016 22:02:01 -0500
Content-Disposition: inline
In-Reply-To: <dd329fe3420fba4049c353a9a092ff9c45c5a252.1452447124.git.oreste.salerno@tomtom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oreste Salerno <oreste.salerno@tomtom.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, fery@cypress.com, dmitry.torokhov@gmail.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org

On Sun, Jan 10, 2016 at 06:36:08PM +0100, Oreste Salerno wrote:
> Signed-off-by: Oreste Salerno <oreste.salerno@tomtom.com>
> ---
>  .../bindings/input/touchscreen/cyttsp.txt          |  82 +++++++++++++
>  drivers/input/touchscreen/cyttsp_core.c            | 134 +++++++++++++++++++--
>  include/linux/input/cyttsp.h                       |   3 +
>  3 files changed, 212 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cyttsp.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/cyttsp.txt b/Documentation/devicetree/bindings/input/touchscreen/cyttsp.txt
> new file mode 100644
> index 0000000..2dc5c65
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/cyttsp.txt
> @@ -0,0 +1,82 @@
> +* Cypress cyttsp touchscreen controller
> +
> +Required properties:
> +- compatible		: must be "cypress,cyttsp-i2c" or "cypress,cyttsp-spi"
> +- reg			: Device I2C address or SPI chip select number
> +- spi-max-frequency 	: Maximum SPI clocking speed of the device (for cyttsp-spi)
> +- interrupt-parent	: the phandle for the gpio controller
> +			  (see interrupt binding[0]).
> +- interrupts		: (gpio) interrupt to which the chip is connected
> +			  (see interrupt binding[0]).
> +- reset-gpios		: the reset gpio the chip is connected to
> +			  (see GPIO binding[1] for more details).
> +- touchscreen-size-x	: horizontal resolution of touchscreen (in pixels)
> +- touchscreen-size-y	: vertical resolution of touchscreen (in pixels)
> +- bootloader-key	: the 8-byte bootloader key that is required to switch
> +			  the chip from bootloader mode (default mode) to
> +			  application mode.
> +			  This property has to be specified as an array of 8
> +			  '/bits/ 8' values.
> +
> +Optional properties:
> +- active-distance	: the distance in pixels beyond which a touch must move
> +			  before movement is detected and reported by the device.
> +			  Valid values: 0-15.

Wouldn't this be the same as touchscreen-fuzz-(x|y) which is the 
replacement for the deprecated moving-threshold? 

> +- active-interval-ms	: the minimum period in ms between consecutive
> +			  scanning/processing cycles when the chip is in active mode.
> +			  Valid values: 0-255.
> +- lowpower-interval-ms	: the minimum period in ms between consecutive
> +			  scanning/processing cycles when the chip is in low-power mode.
> +			  Valid values: 0-2550
> +- touch-timeout-ms	: minimum time in ms spent in the active power state while no
> +			  touches are detected before entering low-power mode.
> +			  Valid values: 0-2550
> +

Otherwise, looks fine.
