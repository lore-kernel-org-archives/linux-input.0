From: Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: Re: [PATCH v2 1/2] Input: add regulator haptic driver
Date: Wed, 26 Nov 2014 11:01:43 +0530
Message-ID: <547565BF.3040304@samsung.com>
References: <1416840651-17141-1-git-send-email-jaewon02.kim@samsung.com>
 <1416840651-17141-2-git-send-email-jaewon02.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:22204 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbaKZFcE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Nov 2014 00:32:04 -0500
In-reply-to: <1416840651-17141-2-git-send-email-jaewon02.kim@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaewon Kim <jaewon02.kim@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dan Murphy <dmurphy@ti.com>, Chanwoo Choi <cw00.choi@samsung.com>, Hyunhee Kim <hyunhee.kim@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>

Hi Jaewon,

On Monday 24 November 2014 08:20 PM, Jaewon Kim wrote:
> This patch adds support for haptic driver controlled by
> voltage of regulator. And this driver support for
> Force Feedback interface from input framework
>
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> Signed-off-by: Hyunhee Kim <hyunhee.kim@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>   .../devicetree/bindings/input/regulator-haptic.txt |   24 ++
>   drivers/input/misc/Kconfig                         |   11 +
>   drivers/input/misc/Makefile                        |    1 +
>   drivers/input/misc/regulator-haptic.c              |  247 ++++++++++++++++++++
>   include/linux/input/regulator-haptic.h             |   30 +++
>   5 files changed, 313 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/input/regulator-haptic.txt
>   create mode 100644 drivers/input/misc/regulator-haptic.c
>   create mode 100644 include/linux/input/regulator-haptic.h
>
> diff --git a/Documentation/devicetree/bindings/input/regulator-haptic.txt b/Documentation/devicetree/bindings/input/regulator-haptic.txt
> new file mode 100644
> index 0000000..5a44e8f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/regulator-haptic.txt
> @@ -0,0 +1,24 @@
> +* Requlator Haptic Device Tree Bindings

Nit: %s/Requlator/Regulator

> +
> +The regulator haptic driver controlled by voltage of regulator.
> +This driver implemented via Force Feedback interface.
> +

[Snip]

> diff --git a/include/linux/input/regulator-haptic.h b/include/linux/input/regulator-haptic.h
> new file mode 100644
> index 0000000..15a629c
> --- /dev/null
> +++ b/include/linux/input/regulator-haptic.h
> @@ -0,0 +1,30 @@
> +/*
> + * Regulator Haptic Platform Data
> + *
> + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
> + * Author: Jaewon Kim <jaewon02.kim@samsung.com>
> + * Author: Hyunhee Kim <hyunhee.kim@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef _REGULATOR_HAPTIC_H
> +

Please define _REGULATOR_HAPTIC_H here as:
#define _REGULATOR_HAPTIC_H

> +/*
> + * struct regulator_haptic_data - Platform device data
> + *
> + * @regulator: Power supply to the haptic motor
> + * @max_volt: maximum voltage value supplied to the haptic motor.
> + * 		<The unit of the voltage is a micro>
> + * @min_volt: minimum voltage value supplied to the haptic motor.
> + * 		<The unit of the voltage is a micro>
> + */
> +struct regulator_haptic_data {
> +	struct regulator *regulator;
> +	unsigned int max_volt;
> +	unsigned int min_volt;
> +};
> +
> +#endif /* _REGULATOR_HAPTIC_H */
>

With these two minor fixes please feel free to add:

Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>


Thanks,
Pankaj Dubey
