From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 5/9] input: goodix: reset device at init
Date: Thu, 28 May 2015 14:19:34 +0100
Message-ID: <20150528131934.GH23176@leverpostej>
References: <1432817265-23891-1-git-send-email-irina.tirdea@intel.com>
 <1432817265-23891-6-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1432817265-23891-6-git-send-email-irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi,

On Thu, May 28, 2015 at 01:47:41PM +0100, Irina Tirdea wrote:
> After power on, it is recommended that the driver resets the device.
> For reset the driver needs to control the interrupt and
> reset gpio pins (configured through ACPI/device tree).

Why is it necessary to mess with the GPIO the interrupts is wired up to?
What exactly does the device expect at reset w.r.t. the interrupt line?

> 
> Signed-off-by: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  .../bindings/input/touchscreen/goodix.txt          |  5 ++
>  drivers/input/touchscreen/goodix.c                 | 99 ++++++++++++++++++++++
>  2 files changed, 104 insertions(+)
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
> + - reset-gpio		: GPIO pin used for reset
>  
>  Example:
>  
> @@ -23,6 +25,9 @@ Example:
>  			reg = <0x5d>;
>  			interrupt-parent = <&gpio>;
>  			interrupts = <0 0>;
> +
> +			irq-gpio = <&gpio1 0 0>;
> +			reset-gpio = <&gpio1 1 0>;
>  		};
>  
>  		/* ... */
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> index 9e7d215..4405c55 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -26,6 +26,7 @@
>  #include <linux/acpi.h>
>  #include <linux/of.h>
>  #include <asm/unaligned.h>
> +#include <linux/gpio.h>

Nit: weird include ordering.

Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
