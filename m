From: Antonio Borneo <borneo.antonio@gmail.com>
Subject: Re: [PATCH v5] serio: PS/2 gpio bit banging driver for serio bus
Date: Thu, 3 Aug 2017 18:15:37 +0200
Message-ID: <CAAj6DX0fruTSg0M3LFUVAHcXTNR+kiHGjGCFuWJdtyQsRKAjgg@mail.gmail.com>
References: <20170803154358.1303-1-danilokrummrich@dk-develop.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170803154358.1303-1-danilokrummrich@dk-develop.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Danilo Krummrich <danilokrummrich@dk-develop.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, dmitry.torokhov@gmail.com, linus.walleij@linaro.org, rdunlap@infradead.org, Antonio Borneo <borneo.antonio@gmail.com>
List-Id: linux-input@vger.kernel.org

Hi Danilo,

just two minor issues below

On Thu, Aug 3, 2017 at 5:43 PM, Danilo Krummrich
<danilokrummrich@dk-develop.de> wrote:
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
> ---
>  .../devicetree/bindings/serio/ps2-gpio.txt         |  22 +
>  Documentation/gpio/drivers-on-gpio.txt             |   5 +
>  drivers/input/serio/Kconfig                        |  11 +
>  drivers/input/serio/Makefile                       |   1 +
>  drivers/input/serio/ps2-gpio.c                     | 456 +++++++++++++++++++++
>  5 files changed, 495 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serio/ps2-gpio.txt
>  create mode 100644 drivers/input/serio/ps2-gpio.c
>
> diff --git a/Documentation/devicetree/bindings/serio/ps2-gpio.txt b/Documentation/devicetree/bindings/serio/ps2-gpio.txt
> new file mode 100644
> index 0000000..19d42ca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serio/ps2-gpio.txt
> @@ -0,0 +1,22 @@
> +Device-Tree bindings for ps2 gpio driver
> +
> +Required properties:
> +       - compatible = "ps2-gpio"
> +       - gpios: data and clock gpio
> +       - interrupts: Should trigger on the falling edge of the clock line.
> +
> +Optional properties:
> +       - ps2-gpio,write-enable: Indicates whether write function is provided
> +       to serio device. Possibly providing the write fn will not work, because
> +       of the tough timing requirements.
> +
> +Example nodes:
> +
> +ps2@0 {
> +       compatible = "ps2-gpio";
> +       interrupt-parent = <&gpio>;
> +       interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
> +       data-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
> +       clk-gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
> +       ps2-gpio,write-enable;
> +};
> diff --git a/Documentation/gpio/drivers-on-gpio.txt b/Documentation/gpio/drivers-on-gpio.txt
> index 3065132..97c8716 100644
> --- a/Documentation/gpio/drivers-on-gpio.txt
> +++ b/Documentation/gpio/drivers-on-gpio.txt
> @@ -84,6 +84,11 @@ hardware descriptions such as device tree or ACPI:
>    NAND flash MTD subsystem and provides chip access and partition parsing like
>    any other NAND driving hardware.
>
> +- ps2-gpio: drivers/input/serio/ps2-gpio.c is used to drive an PS/2 (IBM) serio

Should be "a PS/2"

> +  bus, data and clock line, by bit banging two GPIO lines. It will appear as
> +  any other serio bus to the system and makes it possible to connect drivers
> +  for e.g. keyboards and other PS/2 protocol based devices.
> +
>  Apart from this there are special GPIO drivers in subsystems like MMC/SD to
>  read card detect and write protect GPIO lines, and in the TTY serial subsystem
>  to emulate MCTRL (modem control) signals CTS/RTS by using two GPIO lines. The
> diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
> index c3d05b4..292d6e2 100644
> --- a/drivers/input/serio/Kconfig
> +++ b/drivers/input/serio/Kconfig
> @@ -292,6 +292,17 @@ config SERIO_SUN4I_PS2
>           To compile this driver as a module, choose M here: the
>           module will be called sun4i-ps2.
>
> +config SERIO_GPIO_PS2
> +       tristate "GPIO PS/2 bit banging driver"
> +       depends on GPIOLIB
> +       help
> +         Say Y here if you want PS/2 bit banging support via GPIO.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called gpio-ps2.

I think it is called ps2-gpio.

Regars,
Antonio
