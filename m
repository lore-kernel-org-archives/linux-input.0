From: Nick Dyer <nick@shmanahar.org>
Subject: Re: [PATCH v2 1/2] Input: synaptics-rmi4 - add support for F55
 sensor tuning
Date: Tue, 15 Nov 2016 22:38:23 +0000
Message-ID: <20161115223823.GA19433@lava.h.shmanahar.org>
References: <1479188378-19379-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avasout05.plus.net ([84.93.230.250]:50977 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932783AbcKOWii (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 15 Nov 2016 17:38:38 -0500
Content-Disposition: inline
In-Reply-To: <1479188378-19379-1-git-send-email-linux@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chris Healy <cphealy@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Nov 14, 2016 at 09:39:37PM -0800, Guenter Roeck wrote:
> Sensor tuning support is needed to determine the number of enabled
> tx and rx electrodes for use in F54 functions.
> 
> The number of enabled electrodes is not identical to the total number
> of electrodes as reported with F55:Query0 and F55:Query1. It has to be
> calculated by analyzing F55:Ctrl1 (sensor receiver assignment) and
> F55:Ctrl2 (sensor transmitter assignment).
> 
> Support for additional sensor tuning functions may be added later.
> 
> Fixes: 3a762dbd5347 ("[media] Input: synaptics-rmi4 - add support for F54 ...")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Hi Guenter-

I've tested this patch on s7813 and it works correctly.

Tested-by: Nick Dyer <nick@shmanahar.org>

> ---
> v2: Drop unnecessary include files
>     Only read required number of query elements
>     Added Fixes: tag (both patch 1 and 2 are needed)
> 
>  drivers/input/rmi4/Kconfig      |   9 +++
>  drivers/input/rmi4/Makefile     |   1 +
>  drivers/input/rmi4/rmi_bus.c    |   3 +
>  drivers/input/rmi4/rmi_driver.h |   1 +
>  drivers/input/rmi4/rmi_f55.c    | 124 ++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 138 insertions(+)
>  create mode 100644 drivers/input/rmi4/rmi_f55.c
> 
> diff --git a/drivers/input/rmi4/Kconfig b/drivers/input/rmi4/Kconfig
> index 4c8a55857e00..11ede43c9936 100644
> --- a/drivers/input/rmi4/Kconfig
> +++ b/drivers/input/rmi4/Kconfig
> @@ -72,3 +72,12 @@ config RMI4_F54
>  
>  	  Function 54 provides access to various diagnostic features in certain
>  	  RMI4 touch sensors.
> +
> +config RMI4_F55
> +	bool "RMI4 Function 55 (Sensor tuning)"
> +	depends on RMI4_CORE
> +	help
> +	  Say Y here if you want to add support for RMI4 function 55
> +
> +	  Function 55 provides access to the RMI4 touch sensor tuning
> +	  mechanism.
> diff --git a/drivers/input/rmi4/Makefile b/drivers/input/rmi4/Makefile
> index 0bafc8502c4b..96f8e0c21e3b 100644
> --- a/drivers/input/rmi4/Makefile
> +++ b/drivers/input/rmi4/Makefile
> @@ -8,6 +8,7 @@ rmi_core-$(CONFIG_RMI4_F11) += rmi_f11.o
>  rmi_core-$(CONFIG_RMI4_F12) += rmi_f12.o
>  rmi_core-$(CONFIG_RMI4_F30) += rmi_f30.o
>  rmi_core-$(CONFIG_RMI4_F54) += rmi_f54.o
> +rmi_core-$(CONFIG_RMI4_F55) += rmi_f55.o
>  
>  # Transports
>  obj-$(CONFIG_RMI4_I2C) += rmi_i2c.o
> diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
> index ef8c747c35e7..82b7d4960858 100644
> --- a/drivers/input/rmi4/rmi_bus.c
> +++ b/drivers/input/rmi4/rmi_bus.c
> @@ -314,6 +314,9 @@ static struct rmi_function_handler *fn_handlers[] = {
>  #ifdef CONFIG_RMI4_F54
>  	&rmi_f54_handler,
>  #endif
> +#ifdef CONFIG_RMI4_F55
> +	&rmi_f55_handler,
> +#endif
>  };
>  
>  static void __rmi_unregister_function_handlers(int start_idx)
> diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
> index 8dfbebe9bf86..a65cf70f61e2 100644
> --- a/drivers/input/rmi4/rmi_driver.h
> +++ b/drivers/input/rmi4/rmi_driver.h
> @@ -103,4 +103,5 @@ extern struct rmi_function_handler rmi_f11_handler;
>  extern struct rmi_function_handler rmi_f12_handler;
>  extern struct rmi_function_handler rmi_f30_handler;
>  extern struct rmi_function_handler rmi_f54_handler;
> +extern struct rmi_function_handler rmi_f55_handler;
>  #endif
> diff --git a/drivers/input/rmi4/rmi_f55.c b/drivers/input/rmi4/rmi_f55.c
> new file mode 100644
> index 000000000000..2d221cc97391
> --- /dev/null
> +++ b/drivers/input/rmi4/rmi_f55.c
> @@ -0,0 +1,124 @@
> +/*
> + * Copyright (c) 2012-2015 Synaptics Incorporated
> + * Copyright (C) 2016 Zodiac Inflight Innovations
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/kernel.h>
> +#include <linux/rmi.h>
> +#include <linux/slab.h>
> +#include "rmi_driver.h"
> +
> +#define F55_NAME		"rmi4_f55"
> +
> +/* F55 data offsets */
> +#define F55_NUM_RX_OFFSET	0
> +#define F55_NUM_TX_OFFSET	1
> +#define F55_PHYS_CHAR_OFFSET	2
> +
> +/* Only read required query registers */
> +#define F55_QUERY_LEN		3
> +
> +/* F55 capabilities */
> +#define F55_CAP_SENSOR_ASSIGN	BIT(0)
> +
> +struct f55_data {
> +	struct rmi_function *fn;
> +
> +	u8 qry[F55_QUERY_LEN];
> +	u8 num_rx_electrodes;
> +	u8 cfg_num_rx_electrodes;
> +	u8 num_tx_electrodes;
> +	u8 cfg_num_tx_electrodes;
> +};
> +
> +static int rmi_f55_detect(struct rmi_function *fn)
> +{
> +	struct f55_data *f55;
> +	int error;
> +
> +	f55 = dev_get_drvdata(&fn->dev);
> +
> +	error = rmi_read_block(fn->rmi_dev, fn->fd.query_base_addr,
> +			       &f55->qry, sizeof(f55->qry));
> +	if (error) {
> +		dev_err(&fn->dev, "%s: Failed to query F55 properties\n",
> +			__func__);
> +		return error;
> +	}
> +
> +	f55->num_rx_electrodes = f55->qry[F55_NUM_RX_OFFSET];
> +	f55->num_tx_electrodes = f55->qry[F55_NUM_TX_OFFSET];
> +
> +	f55->cfg_num_rx_electrodes = f55->num_rx_electrodes;
> +	f55->cfg_num_tx_electrodes = f55->num_rx_electrodes;
> +
> +	if (f55->qry[F55_PHYS_CHAR_OFFSET] & F55_CAP_SENSOR_ASSIGN) {
> +		int i, total;
> +		u8 buf[256];
> +
> +		/*
> +		 * Calculate the number of enabled receive and transmit
> +		 * electrodes by reading F55:Ctrl1 (sensor receiver assignment)
> +		 * and F55:Ctrl2 (sensor transmitter assignment). The number of
> +		 * enabled electrodes is the sum of all field entries with a
> +		 * value other than 0xff.
> +		 */
> +		error = rmi_read_block(fn->rmi_dev,
> +				       fn->fd.control_base_addr + 1,
> +				       buf, f55->num_rx_electrodes);
> +		if (!error) {
> +			total = 0;
> +			for (i = 0; i < f55->num_rx_electrodes; i++) {
> +				if (buf[i] != 0xff)
> +					total++;
> +			}
> +			f55->cfg_num_rx_electrodes = total;
> +		}
> +
> +		error = rmi_read_block(fn->rmi_dev,
> +				       fn->fd.control_base_addr + 2,
> +				       buf, f55->num_tx_electrodes);
> +		if (!error) {
> +			total = 0;
> +			for (i = 0; i < f55->num_tx_electrodes; i++) {
> +				if (buf[i] != 0xff)
> +					total++;
> +			}
> +			f55->cfg_num_tx_electrodes = total;
> +		}
> +	}
> +
> +	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "F55 num_rx_electrodes: %d (raw %d)\n",
> +		f55->cfg_num_rx_electrodes, f55->num_rx_electrodes);
> +	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "F55 num_tx_electrodes: %d (raw %d)\n",
> +		f55->cfg_num_tx_electrodes, f55->num_tx_electrodes);
> +
> +	return 0;
> +}
> +
> +static int rmi_f55_probe(struct rmi_function *fn)
> +{
> +	struct f55_data *f55;
> +
> +	f55 = devm_kzalloc(&fn->dev, sizeof(struct f55_data), GFP_KERNEL);
> +	if (!f55)
> +		return -ENOMEM;
> +
> +	f55->fn = fn;
> +	dev_set_drvdata(&fn->dev, f55);
> +
> +	return rmi_f55_detect(fn);
> +}
> +
> +struct rmi_function_handler rmi_f55_handler = {
> +	.driver = {
> +		.name = F55_NAME,
> +	},
> +	.func = 0x55,
> +	.probe = rmi_f55_probe,
> +};
> -- 
> 2.5.0
> 
