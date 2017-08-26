From: Chen Zhong <chen.zhong-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v3 0/5] Add MediaTek PMIC keys support
Date: Sat, 26 Aug 2017 10:30:39 +0800
Message-ID: <1503714639.3340.14.camel@mhfsdcap03>
References: <1503642753-12385-1-git-send-email-chen.zhong@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1503642753-12385-1-git-send-email-chen.zhong-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jaechul Lee <jcsing.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rtc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Sorry for missing the change history.

Changes since v2:
- use standard properties for keycodes and debounce time
- change to use platform_get_irq in leaf drivers
- use better ways to define IRQ resources

Changes since v1:
- create irq mappings in mfd core driver instead of leaf drivers
- remove some unused parts in mtk-pmic-keys driver

On Fri, 2017-08-25 at 14:32 +0800, Chen Zhong wrote:
> MediaTek PMIC are multi-function devices that can handle key interrupts,
> typically there are two keys attached to PMIC, which called pwrkey
> and homekey. PWRKEY usually used to wake up system from sleep. Homekey
> can used as volume down key due to board design. Long press keys can
> shutdown PMIC, the mode can be choose to be one key only or two keys
> together.
> This series add support for key functions for MediaTek PMIC MT6397/MT6323.
> 
> Chen Zhong (5):
>   mfd: mt6397: create irq mappings in mfd core driver
>   dt-bindings: input: Add document bindings for mtk-pmic-keys
>   dt-bindings: mfd: Add bindings for the keys as subnode of PMIC
>   input: Add MediaTek PMIC keys support
>   mfd: mt6397: Add PMIC keys support to MT6397 driver
> 
>  .../devicetree/bindings/input/mtk-pmic-keys.txt    |  38 +++
>  Documentation/devicetree/bindings/mfd/mt6397.txt   |   6 +
>  drivers/input/keyboard/Kconfig                     |   9 +
>  drivers/input/keyboard/Makefile                    |   1 +
>  drivers/input/keyboard/mtk-pmic-keys.c             | 308 +++++++++++++++++++++
>  drivers/mfd/mt6397-core.c                          |  26 +-
>  drivers/rtc/rtc-mt6397.c                           |   7 +-
>  7 files changed, 388 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
>  create mode 100644 drivers/input/keyboard/mtk-pmic-keys.c
> 


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
