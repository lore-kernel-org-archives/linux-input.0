From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v10 6/8] Input: goodix - add support for ESD
Date: Wed, 18 Nov 2015 15:26:39 -0600
Message-ID: <20151118212639.GA1524@rob-hp-laptop>
References: <1447864301-1261-1-git-send-email-irina.tirdea@intel.com>
 <1447864301-1261-7-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1447864301-1261-7-git-send-email-irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Karsten Merker <merker-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, Nov 18, 2015 at 06:31:39PM +0200, Irina Tirdea wrote:
> Add ESD (Electrostatic Discharge) protection mechanism.
> 
> The driver enables ESD protection in HW and checks a register
> to determine if ESD occurred. If ESD is signalled by the HW,
> the driver will reset the device.
> 
> The ESD poll time (in ms) can be set through the sysfs property
> esd_timeout. If it is set to 0, ESD protection is disabled.
> Recommended value is 2000 ms. The initial value for ESD timeout
> can be set through esd-recovery-timeout-ms ACPI/DT property.
> If there is no such property defined, ESD protection is disabled.
> For ACPI 5.1, the property can be specified using _DSD properties:
>  Device (STAC)
>  {
>      Name (_HID, "GDIX1001")
>      ...
> 
>      Name (_DSD,  Package ()
>      {
>          ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>          Package ()
>          {
>              Package (2) { "esd-recovery-timeout-ms", Package(1) { 2000 }},
>              ...
>          }
>      })
>  }
> 
> The ESD protection mechanism is only available if the gpio pins
> are properly initialized from ACPI/DT.
> 
> This is based on Goodix datasheets for GT911 and GT9271 and on Goodix
> driver gt9xx.c for Android (publicly available in Android kernel
> trees for various devices).
> 
> Signed-off-by: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  .../bindings/input/touchscreen/goodix.txt          |   6 +

For the binding:

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

>  drivers/input/touchscreen/goodix.c                 | 160 ++++++++++++++++++++-
>  2 files changed, 161 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> index 7137881..4db3393 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> @@ -14,6 +14,12 @@ Required properties:
>   - interrupts		: Interrupt to which the chip is connected
>   - irq-gpio		: GPIO pin used for IRQ
>   - reset-gpio		: GPIO pin used for reset
> +Optional properties:
> +
> + - esd-recovery-timeout-ms : ESD poll time (in milli seconds) for the driver to
> +                            check if ESD occurred and in that case reset the
> +                            device. ESD is disabled if this property is not set
> +                            or is set to 0.
>  
>  Example:
>  
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
