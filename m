From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] Input: add bu21029 touch driver
Date: Mon, 26 Mar 2018 17:24:26 -0500
Message-ID: <20180326222426.wbdjlyfy7yyan7fc@rob-hp-laptop>
References: <1521651874-15379-1-git-send-email-mark.jonas@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1521651874-15379-1-git-send-email-mark.jonas@de.bosch.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Jonas <mark.jonas@de.bosch.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, hs@denx.de, Zhu Yi <yi.zhu5@cn.bosch.com>
List-Id: linux-input@vger.kernel.org

On Wed, Mar 21, 2018 at 06:04:34PM +0100, Mark Jonas wrote:
> From: Zhu Yi <yi.zhu5@cn.bosch.com>
> 
> Add the ROHM BU21029 resistive touch panel controller
> support with i2c interface.
> 
> Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
> Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
> Reviewed-by: Heiko Schocher <hs@denx.de>
> ---
>  .../bindings/input/touchscreen/bu21029.txt         |  30 ++
>  drivers/input/touchscreen/Kconfig                  |  12 +
>  drivers/input/touchscreen/Makefile                 |   1 +
>  drivers/input/touchscreen/bu21029_ts.c             | 456 +++++++++++++++++++++
>  4 files changed, 499 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/bu21029.txt
>  create mode 100644 drivers/input/touchscreen/bu21029_ts.c
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/bu21029.txt b/Documentation/devicetree/bindings/input/touchscreen/bu21029.txt
> new file mode 100644
> index 0000000..7b61602
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/bu21029.txt
> @@ -0,0 +1,30 @@
> +* Rohm BU21029 Touch Screen Controller
> +
> +Required properties:
> + - compatible              : must be "rohm,bu21029"
> + - reg                     : i2c device address of the chip

What the valid value(s)?

> + - interrupt-parent        : the phandle for the gpio controller
> + - interrupts              : (gpio) interrupt to which the chip is connected
> + - reset-gpios             : gpio pin to reset the chip

Active high or low?

> + - rohm,x-plate-ohms       : x-plate resistance in ohms

IIRC, we have a standard touchscreen property for this?

> +
> +Optional properties:
> + - touchscreen-max-pressure: maximum pressure value
> +
> +Example:
> +
> +	&i2c1 {
> +		/* ... */
> +
> +		bu21029: bu21029@40 {
> +			compatible = "rohm,bu21029";
> +			reg = <0x40>;
> +			interrupt-parent = <&gpio1>;
> +			interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
> +			reset-gpios = <&gpio6 16 GPIO_ACTIVE_LOW>;
> +			rohm,x-plate-ohms = <600>;
> +			touchscreen-max-pressure = <4095>;
> +		};
> +
> +		/* ... */
> +	};
