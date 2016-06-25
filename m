From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH 2/4] input: touchscreen: crtouch_ts: Add driver
Date: Sat, 25 Jun 2016 13:40:14 -0700
Message-ID: <5e849f79b5804ac03ab9e4ce0264f19d@agner.ch>
References: <1466797486-31558-1-git-send-email-tony.felice@timesys.com>
 <1466797486-31558-3-git-send-email-tony.felice@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kmu-office.ch ([178.209.48.109]:38102 "EHLO
	mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbcFYUof (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 25 Jun 2016 16:44:35 -0400
In-Reply-To: <1466797486-31558-3-git-send-email-tony.felice@timesys.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anthony Felice <tony.felice@timesys.com>
Cc: dri-devel@lists.freedesktop.org, shawnguo@kernel.org, dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, kernel@pengutronix.de, linux@armlinux.org.uk, fabio.estevam@nxp.com, geert@linux-m68k.org, mwelling@ieee.org, sre@kernel.org, damien.riegel@savoirfairelinux.com, maitysanchayan@gmail.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 2016-06-24 12:44, Anthony Felice wrote:
> Add driver for the Vybrid Tower CRTouch-based touchscreen. This is
> required for the touchscreen on the TWR-LCD-RGB to work on the Vybrid
> Tower platform.
> 
> There is a known issue with this driver: rarely, SW1 on the TWR-LCD-RGB
> module needs to be pressed in order for the touchscreen to begin
> functioning.
> 
> Signed-off-by: Anthony Felice <tony.felice@timesys.com>
> ---
>  .../bindings/input/touchscreen/crtouch_ts.txt      |  14 ++
>  drivers/input/touchscreen/Kconfig                  |  10 +
>  drivers/input/touchscreen/Makefile                 |   1 +
>  drivers/input/touchscreen/crtouch_ts.c             | 279 +++++++++++++++++++++
>  4 files changed, 304 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/input/touchscreen/crtouch_ts.txt
>  create mode 100644 drivers/input/touchscreen/crtouch_ts.c
> 
> diff --git
> a/Documentation/devicetree/bindings/input/touchscreen/crtouch_ts.txt
> b/Documentation/devicetree/bindings/input/touchscreen/crtouch_ts.txt
> new file mode 100644
> index 0000000..cfb966c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/crtouch_ts.txt
> @@ -0,0 +1,14 @@
> +* Freescale CRTOUCH based touchscreen
> +
> +Required Properties:
> +- compatible must be fsl,crtouch_ts

Compatible strings usually use a dash instead of underline.


> +- reg: I2C address of the touchscreen
> +- irq-gpio: GPIO to use as event IRQ
> +
> +Example:
> +
> +	touch: crtouch@49 {
> +		compatible = "fsl,crtouch_ts";
> +		reg = <0x49>;
> +		irq-gpio = <&gpio0 21 GPIO_ACTIVE_HIGH>;
> +	};
> diff --git a/drivers/input/touchscreen/Kconfig
> b/drivers/input/touchscreen/Kconfig
> index 8ecdc38..799e342 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -1155,4 +1155,14 @@ config TOUCHSCREEN_ROHM_BU21023
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called bu21023_ts.
>  
> +config TOUCHSCREEN_CRTOUCH
> +	tristate "Freescale CRTOUCH based touchscreen"
> +	depends on I2C

You probably also need to add OF here.

> +	help
> +	  Say Y here if you have a CRTOUCH based touchscreen
> +	  controller.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called crtouch_ts.
> +
>  endif
> diff --git a/drivers/input/touchscreen/Makefile
> b/drivers/input/touchscreen/Makefile
> index f42975e..8cb0a7a 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -95,3 +95,4 @@ obj-$(CONFIG_TOUCHSCREEN_TPS6507X)	+= tps6507x-ts.o
>  obj-$(CONFIG_TOUCHSCREEN_ZFORCE)	+= zforce_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_COLIBRI_VF50)	+= colibri-vf50-ts.o
>  obj-$(CONFIG_TOUCHSCREEN_ROHM_BU21023)	+= rohm_bu21023.o
> +obj-$(CONFIG_TOUCHSCREEN_CRTOUCH)	+= crtouch_ts.o
> diff --git a/drivers/input/touchscreen/crtouch_ts.c
> b/drivers/input/touchscreen/crtouch_ts.c
> new file mode 100644
> index 0000000..bb87a8e
> --- /dev/null
> +++ b/drivers/input/touchscreen/crtouch_ts.c
> @@ -0,0 +1,279 @@
> +/*
> + * Driver for Freescale Semiconductor CRTOUCH - A Resistive and Capacitive
> + * touch device with i2c interface
> + *
> + * Copyright 2012 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/input.h>
> +#include <linux/input/mt.h>
> +#include <linux/slab.h>
> +#include <linux/bitops.h>
> +#include <linux/gpio.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
> +
> +/* Resistive touch sense status registers */
> +#define RES_STA_ERROR			0x00
> +#define RES_STA_STATUS1			0x01
> +#define	RES_STA_STATUS2			0x02

Nit: there is a tab between define and RES_STA_STATUS2, all other lines
have spaces.

--
Stefan

<snip>
