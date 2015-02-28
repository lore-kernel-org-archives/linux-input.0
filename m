From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH v6 3/5] power: max77843_battery: Add Max77843 fuel gauge
 device driver
Date: Sat, 28 Feb 2015 21:00:26 +0100
Message-ID: <1425153626.24292.62.camel@x220>
References: <1424741348-8728-1-git-send-email-jaewon02.kim@samsung.com>
	 <1424741348-8728-4-git-send-email-jaewon02.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1424741348-8728-4-git-send-email-jaewon02.kim@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
To: Jaewon Kim <jaewon02.kim@samsung.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, SangBae Lee <sangbae90.lee@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, Beomho Seo <beomho.seo@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

On Tue, 2015-02-24 at 10:29 +0900, Jaewon Kim wrote:
> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> index 994793d..555e436 100644
> --- a/drivers/power/Kconfig
> +++ b/drivers/power/Kconfig
> @@ -212,6 +212,15 @@ config BATTERY_MAX17042
>  	  with MAX17042. This driver also supports max17047/50 chips which are
>  	  improved version of max17042.
>  
> +config BATTERY_MAX77843
> +	tristate "Maxim MAX77843 Fuel Gauge"
> +	depends on MFD_MAX77843
> +	help
> +	  This adds support for battery fuel gauge in Maxim MAX77843. It is
> +	  fuel-gauge for a lithium-ion batteries with a single cell and can be
> +	  found in portable devices. The MAX17040 is configured to operate with

Could MAX17040 be a copy/paste error?

> +	  a single lithium cell.
> +
>  config BATTERY_Z2
>  	tristate "Z2 battery driver"
>  	depends on I2C && MACH_ZIPIT2

[...]

> diff --git a/drivers/power/max77843_battery.c b/drivers/power/max77843_battery.c
> new file mode 100644
> index 0000000..0c59a16
> --- /dev/null
> +++ b/drivers/power/max77843_battery.c
> @@ -0,0 +1,286 @@
> +/*
> + * Fuel gauge driver for Maxim MAX77843
> + *
> + * Copyright (C) 2015 Samsung Electronics, Co., Ltd.
> + * Author: Beomho Seo <beomho.seo@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published bythe Free Software Foundation.
> + */

I did
    git grep "bythe Free" next-20150227

and it returned five hits. This would be the sixth.

Anyhow, this states that this file is licensed GPL v2.

[...]

> +MODULE_LICENSE("GPL");

So this should probably be
    MODULE_LICENSE("GPL v2");


Paul Bolle

