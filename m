From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] input: cyapa: add of match device support and
 description document
Date: Thu, 30 Jul 2015 11:33:21 -0700
Message-ID: <20150730183321.GI13165@dtor-ws>
References: <1437714359-2484-1-git-send-email-dudl@cypress.com>
 <1437714359-2484-3-git-send-email-dudl@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1437714359-2484-3-git-send-email-dudl-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dudley Du <dudl-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bleung-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, jmmahler-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, Jul 24, 2015 at 01:05:58PM +0800, Dudley Du wrote:
> Add of_match_device mechanism support for Cypress trackpad device, and
> add the sample description document on how to adding the trackpad device node
> in the device tree.
> 
> Signed-off-by: Dudley Du <dudl-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>

Applied, thank you.

> ---
>  .../devicetree/bindings/input/cypress,cyapa.txt    | 44 ++++++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>  drivers/input/mouse/cyapa.c                        | 10 +++++
>  3 files changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/cypress,cyapa.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/cypress,cyapa.txt b/Documentation/devicetree/bindings/input/cypress,cyapa.txt
> new file mode 100644
> index 0000000..9be2b44
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/cypress,cyapa.txt
> @@ -0,0 +1,44 @@
> +Cypress I2C Touchpad
> +
> +Required properties:
> +- compatible: must be "cypress,cyapa".
> +- reg: I2C address of the chip.
> +- interrupt-parent: a phandle for the interrupt controller (see interrupt
> +  binding[0]).
> +- interrupts: interrupt to which the chip is connected (see interrupt
> +  binding[0]).
> +
> +Optional properties:
> +- wakeup-source: touchpad can be used as a wakeup source.
> +- pinctrl-names: should be "default" (see pinctrl binding [1]).
> +- pinctrl-0: a phandle pointing to the pin settings for the device (see
> +  pinctrl binding [1]).
> +- vcc-supply: a phandle for the regulator supplying 3.3V power.
> +
> +[0]: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> +[1]: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> +
> +Example:
> +	&i2c0 {
> +		/* ... */
> +
> +		/* Cypress Gen3 touchpad */
> +		touchpad@67 {
> +			compatible = "cypress,cyapa";
> +			reg = <0x24>;
> +			interrupt-parent = <&gpio>;
> +			interrupts = <2 IRQ_TYPE_EDGE_FALLING>;	/* GPIO 2 */
> +			wakeup-source;
> +		};
> +
> +		/* Cypress Gen5 and later touchpad */
> +		touchpad@24 {
> +			compatible = "cypress,cyapa";
> +			reg = <0x24>;
> +			interrupt-parent = <&gpio>;
> +			interrupts = <2 IRQ_TYPE_EDGE_FALLING>;	/* GPIO 2 */
> +			wakeup-source;
> +		};
> +
> +		/* ... */
> +	};
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index d444757..57c0f5f 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -54,6 +54,7 @@ cortina	Cortina Systems, Inc.
>  cosmic	Cosmic Circuits
>  crystalfontz	Crystalfontz America, Inc.
>  cubietech	Cubietech, Ltd.
> +cypress	Cypress Semiconductor Corporation
>  dallas	Maxim Integrated Products (formerly Dallas Semiconductor)
>  davicom	DAVICOM Semiconductor, Inc.
>  delta	Delta Electronics, Inc.
> diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
> index 2159c5e..3431510 100644
> --- a/drivers/input/mouse/cyapa.c
> +++ b/drivers/input/mouse/cyapa.c
> @@ -25,6 +25,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/acpi.h>
> +#include <linux/of.h>
>  #include "cyapa.h"
>  
>  
> @@ -1486,11 +1487,20 @@ static const struct acpi_device_id cyapa_acpi_id[] = {
>  MODULE_DEVICE_TABLE(acpi, cyapa_acpi_id);
>  #endif
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id cyapa_of_match[] = {
> +	{ .compatible = "cypress,cyapa" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, cyapa_of_match);
> +#endif
> +
>  static struct i2c_driver cyapa_driver = {
>  	.driver = {
>  		.name = "cyapa",
>  		.pm = &cyapa_pm_ops,
>  		.acpi_match_table = ACPI_PTR(cyapa_acpi_id),
> +		.of_match_table = of_match_ptr(cyapa_of_match),
>  	},
>  
>  	.probe = cyapa_probe,
> -- 
> 1.9.1
> 
> 
> ---------------------------------------------------------------
> This message and any attachments may contain Cypress (or its
> subsidiaries) confidential information. If it has been received
> in error, please advise the sender and immediately delete this
> message.
> ---------------------------------------------------------------
> 

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
