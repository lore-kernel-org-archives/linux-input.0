From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 5/5] i8042: Add i8042_dt.h glue for DT support
Date: Tue, 3 Feb 2015 11:52:50 +0000
Message-ID: <20150203115249.GB30866@leverpostej>
References: <1422913730-12663-1-git-send-email-v1ron@v1ros.org>
 <1422913730-12663-5-git-send-email-v1ron@v1ros.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1422913730-12663-5-git-send-email-v1ron-oLhuKTjYqW/YtjvyW6yDsg@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roman Volkov <v1ron-oLhuKTjYqW/YtjvyW6yDsg@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Roman Volkov <v1ron-JGs/UdohzUI@public.gmane.org>, Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon, Feb 02, 2015 at 09:48:50PM +0000, Roman Volkov wrote:
> This header file designed to be similar to other glue layers found
> for i8042. The difference is that interrupt numbers, device address,
> and other information should be retrieved from the device tree.
> 
> Signed-off-by: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
> Signed-off-by: Roman Volkov <v1ron-oLhuKTjYqW/YtjvyW6yDsg@public.gmane.org>
> ---
>  drivers/input/serio/i8042-dt.h | 112 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
>  create mode 100644 drivers/input/serio/i8042-dt.h
> 
> diff --git a/drivers/input/serio/i8042-dt.h b/drivers/input/serio/i8042-dt.h
> new file mode 100644
> index 0000000..0d1a344
> --- /dev/null
> +++ b/drivers/input/serio/i8042-dt.h
> @@ -0,0 +1,112 @@
> +#ifndef _I8042_DT_H
> +#define _I8042_DT_H
> +
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +
> +/*
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */
> +
> +static void __iomem *i8042_base;
> +static unsigned int i8042_command_reg;
> +static unsigned int i8042_status_reg;
> +static unsigned int i8042_data_reg;
> +#define I8042_COMMAND_REG i8042_command_reg
> +#define I8042_STATUS_REG i8042_status_reg
> +#define I8042_DATA_REG i8042_data_reg
> +
> +/*
> + * Names.
> + */
> +
> +static const char *i8042_kbd_phys_desc;
> +static const char *i8042_aux_phys_desc;
> +static const char *i8042_mux_phys_desc;
> +#define I8042_KBD_PHYS_DESC i8042_kbd_phys_desc
> +#define I8042_AUX_PHYS_DESC i8042_aux_phys_desc
> +#define I8042_MUX_PHYS_DESC i8042_mux_phys_desc
> +
> +/*
> + * IRQs.
> + */
> +static int i8042_kbd_irq;
> +static int i8042_aux_irq;
> +#define I8042_KBD_IRQ i8042_kbd_irq
> +#define I8042_AUX_IRQ i8042_aux_irq

That's a lot of static values. Surely nothing physically prevents the
use of multiple i8042 chips?

> +
> +static inline int i8042_read_data(void)
> +{
> +	return readb(i8042_base + i8042_data_reg);
> +}
> +
> +static inline int i8042_read_status(void)
> +{
> +	return readb(i8042_base + i8042_status_reg);
> +}
> +
> +static inline void i8042_write_data(int val)
> +{
> +	writeb(val, i8042_base + i8042_data_reg);
> +}
> +
> +static inline void i8042_write_command(int val)
> +{
> +	writeb(val, i8042_base + i8042_command_reg);
> +}
> +
> +static inline int i8042_platform_init(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	int status;
> +
> +	i8042_base = of_iomap(np, 0);
> +	if (!i8042_base)
> +		return -ENOMEM;
> +
> +	status = of_property_read_u32(np, "command-reg", &i8042_command_reg);
> +	if (status)
> +		return status;
> +
> +	status = of_property_read_u32(np, "status-reg", &i8042_status_reg);
> +	if (status)
> +		return status;
> +
> +	status = of_property_read_u32(np, "data-reg", &i8042_data_reg);
> +	if (status)
> +		return status;

You should probably validate that these are within the range provided in
the reg property.

You also need to clean up if you fail. It looks like here and below we
leak the i8042_base mapping if we decide to fail.

> +
> +	i8042_kbd_irq = irq_of_parse_and_map(np, 0);
> +	i8042_aux_irq = irq_of_parse_and_map(np, 1);

You can use platform_get_irq(pdev, N) here, the IRQ will already have
been parsed by the core.

> +	status = of_property_read_string(np, "linux,kbd_phys_desc",
> +						&i8042_kbd_phys_desc);
> +	if (status)
> +		i8042_kbd_phys_desc = "i8042/serio0";
> +
> +	status = of_property_read_string(np, "linux,aux_phys_desc",
> +						&i8042_aux_phys_desc);
> +	if (status)
> +		i8042_aux_phys_desc = "i8042/serio1";
> +
> +	status = of_property_read_string(np, "linux,mux_phys_desc",
> +						&i8042_mux_phys_desc);
> +	if (status)
> +		i8042_mux_phys_desc = "i8042/serio%d";

User-provided values as format strings? Not a good idea.

What exactly are these used for?

> +
> +	if (of_get_property(np, "init-reset", NULL))
> +		i8042_reset = true;

Use of_property_read_bool.

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
