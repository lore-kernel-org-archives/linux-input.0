From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7] serio: PS/2 gpio bit banging driver for serio bus
Date: Thu, 17 Aug 2017 10:43:36 -0500
Message-ID: <20170817154336.rv5uak6jujlgxybi@rob-hp-laptop>
References: <20170811131736.1027-1-danilokrummrich@dk-develop.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35103 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752587AbdHQPnl (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 17 Aug 2017 11:43:41 -0400
Content-Disposition: inline
In-Reply-To: <20170811131736.1027-1-danilokrummrich@dk-develop.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Danilo Krummrich <danilokrummrich@dk-develop.de>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linus.walleij@linaro.org, rdunlap@infradead.org, devicetree@vger.kernel.org

On Fri, Aug 11, 2017 at 03:17:36PM +0200, Danilo Krummrich wrote:
> This driver provides PS/2 serio bus support by implementing bit banging
> with the GPIO API. The GPIO pins, data and clock, can be configured with
> a node in the device tree or by generic device properties (GDP).
> 
> Writing to a device is supported as well, though it is possible timings
> can not be halt as they are tough and difficult to reach with bit banging.
> Therefore it can be configured (also in DT and GDP) whether the serio
> write function should be available for clients.
> 
> This driver is for development purposes and not recommended for productive
> use. However, this driver can be useful e.g. when no USB port is available
> or using old peripherals is desired as PS/2 controller chips getting rare.
> 
> This driver was tested on RPI1 and on Hikey960 and it worked well together
> with the atkbd and psmouse driver.
> 
> Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
> ---
> v2: Removed one verbose print statement, changed another one to dev_dbg.
> v3: - fixed compiler warning on blackfin
>     - depends on GPIOLIB
>     - clarify documentation
> v4: - fixed concurrent calls to ps2_gpio_write (serio->write)
>     - use gpiod API
>     - use generic device properties
>     - request irq separately, do not use gpiod_to_irq
>     - abort when gpio is connected via slow bus
>     - Fixed a bug where PS2_CMD_RESEND is always send after tx failed once.
>       The makes the write functionallity work better, tough timing is still
>       critical.
>     - disable irq initially until ps2_gpip_open (serio->open) is called
> v5: Checked again why timings are that hard to reach while in tx mode and
>     discovered that there is an extra clock pulse between stop bit sent from
>     host and acknowledgement from device. By just skipping this clock pulse
>     tx works fine now, though it still happens sometimes that the timing can
>     not be reached of course.
> v6: - fixed typos
>     - use of_match_ptr
> v7: remove unnecessary barriers
> 
> Sorry for resending, forgot der version tag in the subject.
> ---
>  .../devicetree/bindings/serio/ps2-gpio.txt         |  22 +

It's preferred to split bindings to separate patch.

>  Documentation/gpio/drivers-on-gpio.txt             |   5 +
>  drivers/input/serio/Kconfig                        |  11 +
>  drivers/input/serio/Makefile                       |   1 +
>  drivers/input/serio/ps2-gpio.c                     | 453 +++++++++++++++++++++
>  5 files changed, 492 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serio/ps2-gpio.txt
>  create mode 100644 drivers/input/serio/ps2-gpio.c
> 
> diff --git a/Documentation/devicetree/bindings/serio/ps2-gpio.txt b/Documentation/devicetree/bindings/serio/ps2-gpio.txt
> new file mode 100644
> index 000000000000..099dd6d46cb3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serio/ps2-gpio.txt
> @@ -0,0 +1,22 @@
> +Device-Tree bindings for ps/2 gpio driver

Bindings don't describe drivers.

> +
> +Required properties:
> +	- compatible = "ps2-gpio"
> +	- gpios: data and clock gpio
> +	- interrupts: Should trigger on the falling edge of the clock line.
> +
> +Optional properties:
> +	- ps2-gpio,write-enable: Indicates whether write function is provided

ps2-gpio is not a vendor prefix, so drop it.

> +	to serio device. Possibly providing the write fn will not work, because
> +	of the tough timing requirements.
> +
> +Example nodes:
> +
> +ps2@0 {
> +	compatible = "ps2-gpio";
> +	interrupt-parent = <&gpio>;
> +	interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
> +	data-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
> +	clk-gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
> +	ps2-gpio,write-enable;
> +};
