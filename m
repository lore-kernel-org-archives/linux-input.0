From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: [PATCH v2 3/4] input: touchscreen: mxs-lradc: Add support for
 touchscreen
Date: Wed, 15 Jun 2016 23:26:18 +0200 (CEST)
Message-ID: <1443695961.58810.3de61248-4cae-4f94-b8a2-ef63c5c3ec1b.open-xchange@email.1und1.de>
References: <cover.1465396835.git.ksenija.stanojevic@gmail.com>
 <d5853a762d67f2036382d3cfa0cf1d294d6aa5f0.1465396835.git.ksenija.stanojevic@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <d5853a762d67f2036382d3cfa0cf1d294d6aa5f0.1465396835.git.ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, harald-95f8Dae0BrPYtjvyW6yDsg@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

unfortunately i still don't have a touchscreen to test this patch.

> Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> hat am 8. Juni 2016 um 16:48
> geschrieben:
> 
> 
> Add 4-wire/5-wire touchscreen controller.
> 
> Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> Changes in v2:
>  - do not change spacing in Kconfig
>  - remove dev.parent
>  - rename err_ts_register to error
>  - combine functions hw_stop and disable_ts so that mxs_lradc_ts_remove
>    could be deleted.
>  - add spinlock in struct mxs_lradc_ts to enable locking in interrupt handler.
>  - only grab irqs that are relevant to touchscreen
>  - use direct return instead assigning error to touch_ret in probe function.
>  - change licence to GPL
>  - add copyright
> 
>  drivers/input/touchscreen/Kconfig        |  10 +
>  drivers/input/touchscreen/Makefile       |   1 +
>  drivers/input/touchscreen/mxs-lradc-ts.c | 726
> +++++++++++++++++++++++++++++++
>  3 files changed, 737 insertions(+)
>  create mode 100644 drivers/input/touchscreen/mxs-lradc-ts.c
> 
> diff --git a/drivers/input/touchscreen/mxs-lradc-ts.c
> b/drivers/input/touchscreen/mxs-lradc-ts.c
> new file mode 100644
> index 0000000..778bb61
> --- /dev/null
> +++ b/drivers/input/touchscreen/mxs-lradc-ts.c
> @@ -0,0 +1,726 @@
> +/*
> + * Freescale MXS LRADC driver

touchscreen driver

> + *
> + * Copyright (c) 2012 DENX Software Engineering, GmbH.
> + * Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> + * Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> ...
> +
> +static struct platform_driver mxs_lradc_ts_driver = {
> +	.driver	= {
> +		.name = DRIVER_NAME_TS,
> +	},
> +	.probe	= mxs_lradc_ts_probe,
> +};
> +module_platform_driver(mxs_lradc_ts_driver);
> +

MODULE_DESCRIPTION ?
MODULE_AUTHOR ?

> +MODULE_LICENSE("GPL");
> -- 
> 1.9.1
>
