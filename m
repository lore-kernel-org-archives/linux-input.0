From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [RFC PATCH 2/11] input: RMI4 core bus and sensor drivers.
Date: Mon, 02 Jan 2012 12:08:15 +0530
Message-ID: <4F0150D7.2010600@ti.com>
References: <1324519802-23894-1-git-send-email-cheiny@synaptics.com> <1324519802-23894-3-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1324519802-23894-3-git-send-email-cheiny@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <khali@linux-fr.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
List-Id: linux-input@vger.kernel.org

Hi Christopher,

On Thursday 22 December 2011 07:39 AM, Christopher Heiny wrote:
> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Linus Walleij <linus.walleij@stericsson.com>
> Cc: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
> Cc: Joeri de Gram <j.de.gram@gmail.com>
>
> ---
>
>  drivers/input/rmi4/rmi_bus.c    |  436 ++++++++++++
>  drivers/input/rmi4/rmi_driver.c | 1488 +++++++++++++++++++++++++++++++++++++++
>  drivers/input/rmi4/rmi_driver.h |   97 +++
>  3 files changed, 2021 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
> new file mode 100644
> index 0000000..e32d4ad
> --- /dev/null
> +++ b/drivers/input/rmi4/rmi_bus.c
> @@ -0,0 +1,436 @@
> +/*
> + * Copyright (c) 2011 Synaptics Incorporated
> + * Copyright (c) 2011 Unixphere
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +#include <linux/kernel.h>
> +#include <linux/device.h>
> +#include <linux/pm.h>
> +#include <linux/slab.h>
> +#include <linux/list.h>
> +#include <linux/rmi.h>
> +
> +DEFINE_MUTEX(rmi_bus_mutex);
> +
> +static struct rmi_function_list {
> +	struct list_head list;
> +	struct rmi_function_handler *fh;
> +} rmi_supported_functions;
> +
> +static struct rmi_character_driver_list {
> +	struct list_head list;
> +	struct rmi_char_driver *cd;
> +} rmi_character_drivers;
> +
> +static int physical_device_count;
> +
> +static int rmi_bus_match(struct device *dev, struct device_driver *driver)
> +{
> +	struct rmi_driver *rmi_driver;
> +	struct rmi_device *rmi_dev;
> +	struct rmi_device_platform_data *pdata;
> +
> +	rmi_driver = to_rmi_driver(driver);
> +	rmi_dev = to_rmi_device(dev);
> +	pdata = to_rmi_platform_data(rmi_dev);
> +	dev_dbg(dev, "Matching %s.\n", pdata->sensor_name);
> +
> +	if (!strcmp(pdata->driver_name, rmi_driver->driver.name)) {
> +		rmi_dev->driver = rmi_driver;
> +		dev_dbg(dev, "%s: Match %s to %s succeeded.\n", __func__,
> +			pdata->driver_name, rmi_driver->driver.name);
> +		return 1;
> +	}
> +
> +	dev_err(dev, "%s: Match %s to %s failed.\n", __func__,
> +		pdata->driver_name, rmi_driver->driver.name);
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int rmi_bus_suspend(struct device *dev)
> +{
> +#ifdef GENERIC_SUBSYS_PM_OPS
> +	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> +
> +	if (pm && pm->suspend)
> +		return pm->suspend(dev);
If driver-pm- suspend is not there should you not fall back to . suspend ?

> +#endif
> +
> +	return 0;
> +}
> +
> +static int rmi_bus_resume(struct device *dev)
> +{
> +#ifdef GENERIC_SUBSYS_PM_OPS
> +	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> +
> +	if (pm && pm->resume)
> +		return pm->resume(dev);
same here?
> +#endif
> +
> +	return 0;
> +}
> +#endif
> +
> +static int rmi_bus_probe(struct device *dev)
