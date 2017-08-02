From: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/4] input: Add MediaTek PMIC keys support
Date: Wed, 2 Aug 2017 12:33:08 +0200
Message-ID: <a6b77a6e-00bb-8aa1-86fe-f158bd96abbc@gmail.com>
References: <1501643840-21485-1-git-send-email-chen.zhong@mediatek.com>
 <1501643840-21485-4-git-send-email-chen.zhong@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1501643840-21485-4-git-send-email-chen.zhong-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chen Zhong <chen.zhong-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org



On 08/02/2017 05:17 AM, Chen Zhong wrote:
> This patch add support to handle MediaTek PMIC MT6397/MT6323 key
> interrupts including pwrkey and homekey, also add setting for
> long press key shutdown behavior.
> 
> Signed-off-by: Chen Zhong <chen.zhong-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>   drivers/input/keyboard/mtk-pmic-keys.c |  320 ++++++++++++++++++++++++++++++++
>   1 file changed, 320 insertions(+)
>   create mode 100644 drivers/input/keyboard/mtk-pmic-keys.c
> 
> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
> new file mode 100644
> index 0000000..0ea7d17
> --- /dev/null
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> @@ -0,0 +1,320 @@
> +/*
> + * Copyright (C) 2017 MediaTek, Inc.
> + *
> + * Author: Chen Zhong <chen.zhong-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/ioctl.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/mt6323/registers.h>
> +#include <linux/mfd/mt6397/registers.h>
> +#include <linux/mfd/mt6397/core.h>
> +#include <linux/slab.h>
> +#include <linux/irqdomain.h>
> +
> +#define PWRKEY_RST_EN_MASK  0x1
> +#define PWRKEY_RST_EN_SHIFT  6
> +#define HOMEKEY_RST_EN_MASK  0x1
> +#define HOMEKEY_RST_EN_SHIFT  5
> +#define RST_DU_MASK  0x3
> +#define RST_DU_SHIFT  8
> +
> +struct pmic_keys_regs {
> +	u32 deb_reg;
> +	u32 deb_mask;
> +	u32 intsel_reg;
> +	u32 intsel_mask;
> +};
> +
> +#define PMIC_KEYS_REGS(_deb_reg, _deb_mask, _intsel_reg, _intsel_mask)	\
> +{									\
> +	.deb_reg		= _deb_reg,				\
> +	.deb_mask		= _deb_mask,				\
> +	.intsel_reg		= _intsel_reg,				\
> +	.intsel_mask		= _intsel_mask,				\
> +}
> +
> +struct pmic_regs {
> +	const struct pmic_keys_regs pwrkey_regs;
> +	const struct pmic_keys_regs homekey_regs;
> +	u32 pmic_rst_reg;
> +};
> +
> +static const struct pmic_regs mt6397_regs = {
> +	.pwrkey_regs = PMIC_KEYS_REGS(MT6397_CHRSTATUS,
> +		0x8, MT6397_INT_RSV, 0x10),
> +	.homekey_regs = PMIC_KEYS_REGS(MT6397_OCSTATUS2,
> +		0x10, MT6397_INT_RSV, 0x8),
> +	.pmic_rst_reg = MT6397_TOP_RST_MISC,
> +};
> +
> +static const struct pmic_regs mt6323_regs = {
> +	.pwrkey_regs = PMIC_KEYS_REGS(MT6323_CHRSTATUS,
> +		0x2, MT6323_INT_MISC_CON, 0x10),
> +	.homekey_regs = PMIC_KEYS_REGS(MT6323_CHRSTATUS,
> +		0x4, MT6323_INT_MISC_CON, 0x8),
> +	.pmic_rst_reg = MT6323_TOP_RST_MISC,
> +};

Where are this MTxxxx_CHRSTATUS defined?

Regards,
Matthias
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
