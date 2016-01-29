From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/3] input: touchscreen: ad7879: add device tree support
Date: Thu, 28 Jan 2016 21:00:32 -0600
Message-ID: <20160129030032.GA24144@rob-hp-laptop>
References: <1453777477-29706-1-git-send-email-stefan@agner.ch>
 <1453777477-29706-3-git-send-email-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58798 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751894AbcA2DAh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jan 2016 22:00:37 -0500
Content-Disposition: inline
In-Reply-To: <1453777477-29706-3-git-send-email-stefan@agner.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: dmitry.torokhov@gmail.com, michael.hennerich@analog.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, realmz6@gmail.com, broonie@kernel.org, jic23@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jan 25, 2016 at 07:04:37PM -0800, Stefan Agner wrote:
> Add device tree support for the I2C variant of AD7879 (AD7879-1). This
> allows to specify the touchscreen controller as a I2C client node.
> Most of the options available as platform data are also available as
> device tree properties. Exporting the GPIO is currently not possible
> through device tree.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  .../bindings/input/touchscreen/ad7879-i2c.txt      | 47 ++++++++++++++++
>  drivers/input/touchscreen/ad7879-i2c.c             | 63 +++++++++++++++++++++-
>  drivers/input/touchscreen/ad7879-spi.c             |  3 +-
>  drivers/input/touchscreen/ad7879.c                 |  2 +-
>  drivers/input/touchscreen/ad7879.h                 |  1 +
>  5 files changed, 113 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ad7879-i2c.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/ad7879-i2c.txt b/Documentation/devicetree/bindings/input/touchscreen/ad7879-i2c.txt
> new file mode 100644
> index 0000000..bf169a2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/ad7879-i2c.txt
> @@ -0,0 +1,47 @@
> +* Analog Devices AD7879-1/AD7889-1 touchscreen interface (I2C)
> +
> +Required properties:
> +- compatible: must be "adi,ad7879-1"
> +- reg: i2c slave address
> +- interrupt-parent: the phandle for the interrupt controller
> +- interrupts: touch controller interrupt
> +- resistance-plate-x		: total resistance of X-plate (for pressure
> +				  calculation)
> +- touchscreen-max-pressure	: maximum reported pressure
> +- touchscreen-swapped-x-y	: X and Y axis are swapped (boolean)
> +				  Swapping is done after inverting the axis
> +Optional properties:
> +- first-conversion-delay	: 0-12 in 128us steps (starting with 128us)
> +				  13: 2.560ms
> +				  14: 3.584ms
> +				  15: 4.096ms
> +- acquisition-time		: 0: 2us
> +				  1: 4us
> +				  2: 8us
> +				  3: 16us
> +- median-filter-size		: 0: disabled
> +				  1: 4 measurements
> +				  2: 8 measurements
> +				  3: 16 measurements
> +- averaging			: 0: 2 middle values (1 if median disabled)
> +				  1: 4 middle values
> +				  2: 8 middle values
> +				  3: 16 values
> +- conversion-interval:		: 0: convert one time only
> +				  1-255: 515us + val * 35us (up to 9.440ms)

These all should be prefixed with "adi,". Also, please state the sizes 
are 8-bit.

> +
> +Example:
> +
> +	ad7879@2c {
> +		compatible = "adi,ad7879-1";
> +		reg = <0x2c>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
> +		resistance-plate-x = <120>;
> +		touchscreen-max-pressure = <4096>;
> +		first-conversion-delay = /bits/ 8 <3>;
> +		acquisition-time = /bits/ 8 <1>;
> +		median-filter-size = /bits/ 8 <2>;
> +		averaging = /bits/ 8 <1>;
> +		conversion-interval = /bits/ 8 <255>;
> +	};
