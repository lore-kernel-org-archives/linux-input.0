From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v10 2/8] Input: goodix - reset device at init
Date: Wed, 18 Nov 2015 15:24:22 -0600
Message-ID: <20151118212422.GA31164@rob-hp-laptop>
References: <1447864301-1261-1-git-send-email-irina.tirdea@intel.com>
 <1447864301-1261-3-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1447864301-1261-3-git-send-email-irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Karsten Merker <merker-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, Nov 18, 2015 at 06:31:35PM +0200, Irina Tirdea wrote:
> After power on, it is recommended that the driver resets the device.
> The reset procedure timing is described in the datasheet and is used
> at device init (before writing device configuration) and
> for power management. It is a sequence of setting the interrupt
> and reset pins high/low at specific timing intervals. This procedure
> also includes setting the slave address to the one specified in the
> ACPI/device tree.
> 
> This is based on Goodix datasheets for GT911 and GT9271 and on Goodix
> driver gt9xx.c for Android (publicly available in Android kernel
> trees for various devices).
> 
> For reset the driver needs to control the interrupt and
> reset gpio pins (configured through ACPI/device tree). For devices
> that do not have the gpio pins properly declared, the functionality
> depending on these pins will not be available, but the device can still
> be used with basic functionality.
> 
> For both device tree and ACPI, the interrupt gpio pin configuration is
> read from the "irq-gpio" property and the reset pin configuration is
> read from the "reset-gpio" property. For ACPI 5.1, named properties
> can be specified using the _DSD section. This functionality will not be
> available for devices that use indexed gpio pins declared in the _CRS
> section (we need to provide backward compatibility with devices
> that do not support using the interrupt gpio pin as output).
> 
> For ACPI, the pins can be specified using ACPI 5.1:
> Device (STAC)
> {
>     Name (_HID, "GDIX1001")
>     ...
> 
>     Method (_CRS, 0, Serialized)
>     {
>         Name (RBUF, ResourceTemplate ()
>         {
>             I2cSerialBus (0x0014, ControllerInitiated, 0x00061A80,
>                 AddressingMode7Bit, "\\I2C0",
>                 0x00, ResourceConsumer, ,
>                 )
> 
>             GpioInt (Edge, ActiveHigh, Exclusive, PullNone, 0x0000,
>                 "\\I2C0", 0x00, ResourceConsumer, ,
>                  )
>                  {   // Pin list
>                      0
>                  }
> 
>             GpioIo (Exclusive, PullDown, 0x0000, 0x0000,
>                 IoRestrictionOutputOnly, "\\I2C0", 0x00,
>                 ResourceConsumer, ,
>                 )
>                 {
>                      1
>                 }
>         })
>         Return (RBUF)
>     }
> 
>     Name (_DSD,  Package ()
>     {
>         ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>         Package ()
>         {
>             Package (2) {"irq-gpio", Package() {^STAC, 0, 0, 0 }},
>             Package (2) {"reset-gpio", Package() {^STAC, 1, 0, 0 }},
>             ...
>         }
>     }
> 
> Signed-off-by: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  .../bindings/input/touchscreen/goodix.txt          |   5 +
>  drivers/input/touchscreen/Kconfig                  |   1 +
>  drivers/input/touchscreen/goodix.c                 | 101 +++++++++++++++++++++
>  3 files changed, 107 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> index 8ba98ee..7137881 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> @@ -12,6 +12,8 @@ Required properties:
>   - reg			: I2C address of the chip. Should be 0x5d or 0x14
>   - interrupt-parent	: Interrupt controller to which the chip is connected
>   - interrupts		: Interrupt to which the chip is connected
> + - irq-gpio		: GPIO pin used for IRQ

Please note here why you need this in addition to just "interrupts". 
Also, it should be irq-gpios instead.

> + - reset-gpio		: GPIO pin used for reset

Should be reset-gpios instead.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
