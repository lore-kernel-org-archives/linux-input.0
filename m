From: Chen Zhong <chen.zhong-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 3/4] input: Add MediaTek PMIC keys support
Date: Wed, 2 Aug 2017 21:46:42 +0800
Message-ID: <1501681602.28466.2.camel@mhfsdcap03>
References: <1501643840-21485-1-git-send-email-chen.zhong@mediatek.com>
 <1501643840-21485-4-git-send-email-chen.zhong@mediatek.com>
 <a6b77a6e-00bb-8aa1-86fe-f158bd96abbc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <a6b77a6e-00bb-8aa1-86fe-f158bd96abbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, 2017-08-02 at 12:33 +0200, Matthias Brugger wrote:
> 
> On 08/02/2017 05:17 AM, Chen Zhong wrote:
> > This patch add support to handle MediaTek PMIC MT6397/MT6323 key
> > interrupts including pwrkey and homekey, also add setting for
> > long press key shutdown behavior.
> > 
> > Signed-off-by: Chen Zhong <chen.zhong-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >   drivers/input/keyboard/mtk-pmic-keys.c |  320 ++++++++++++++++++++++++++++++++
> >   1 file changed, 320 insertions(+)
> >   create mode 100644 drivers/input/keyboard/mtk-pmic-keys.c
> > 
> > diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
> > new file mode 100644
> > index 0000000..0ea7d17
> > --- /dev/null
> > +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> > @@ -0,0 +1,320 @@
> > +/*
> > + * Copyright (C) 2017 MediaTek, Inc.
> > + *
> > + * Author: Chen Zhong <chen.zhong-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > + *
> > + * This software is licensed under the terms of the GNU General Public
> > + * License version 2, as published by the Free Software Foundation, and
> > + * may be copied, distributed, and modified under those terms.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + */
> > +
> > +#include <linux/ioctl.h>
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/input.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/kernel.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/mfd/mt6323/registers.h>
> > +#include <linux/mfd/mt6397/registers.h>
> > +#include <linux/mfd/mt6397/core.h>
> > +#include <linux/slab.h>
> > +#include <linux/irqdomain.h>
> > +
> > +#define PWRKEY_RST_EN_MASK  0x1
> > +#define PWRKEY_RST_EN_SHIFT  6
> > +#define HOMEKEY_RST_EN_MASK  0x1
> > +#define HOMEKEY_RST_EN_SHIFT  5
> > +#define RST_DU_MASK  0x3
> > +#define RST_DU_SHIFT  8
> > +
> > +struct pmic_keys_regs {
> > +	u32 deb_reg;
> > +	u32 deb_mask;
> > +	u32 intsel_reg;
> > +	u32 intsel_mask;
> > +};
> > +
> > +#define PMIC_KEYS_REGS(_deb_reg, _deb_mask, _intsel_reg, _intsel_mask)	\
> > +{									\
> > +	.deb_reg		= _deb_reg,				\
> > +	.deb_mask		= _deb_mask,				\
> > +	.intsel_reg		= _intsel_reg,				\
> > +	.intsel_mask		= _intsel_mask,				\
> > +}
> > +
> > +struct pmic_regs {
> > +	const struct pmic_keys_regs pwrkey_regs;
> > +	const struct pmic_keys_regs homekey_regs;
> > +	u32 pmic_rst_reg;
> > +};
> > +
> > +static const struct pmic_regs mt6397_regs = {
> > +	.pwrkey_regs = PMIC_KEYS_REGS(MT6397_CHRSTATUS,
> > +		0x8, MT6397_INT_RSV, 0x10),
> > +	.homekey_regs = PMIC_KEYS_REGS(MT6397_OCSTATUS2,
> > +		0x10, MT6397_INT_RSV, 0x8),
> > +	.pmic_rst_reg = MT6397_TOP_RST_MISC,
> > +};
> > +
> > +static const struct pmic_regs mt6323_regs = {
> > +	.pwrkey_regs = PMIC_KEYS_REGS(MT6323_CHRSTATUS,
> > +		0x2, MT6323_INT_MISC_CON, 0x10),
> > +	.homekey_regs = PMIC_KEYS_REGS(MT6323_CHRSTATUS,
> > +		0x4, MT6323_INT_MISC_CON, 0x8),
> > +	.pmic_rst_reg = MT6323_TOP_RST_MISC,
> > +};
> 
> Where are this MTxxxx_CHRSTATUS defined?

Hi Matthias,

They are defined in "linux/mfd/mt63xx/registers.h".

> 
> Regards,
> Matthias
