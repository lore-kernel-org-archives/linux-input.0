From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 -next] input: keyboard: remove duplicated include from
 mtk-pmic-keys.c
Date: Fri, 21 Dec 2018 00:46:40 -0800
Message-ID: <20181221084640.GI211587@dtor-ws>
References: <20181211093200.18140-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181211093200.18140-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: matthias.bgg@gmail.com, lee.jones@linaro.org, chen.zhong@mediatek.com, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Dec 11, 2018 at 05:32:00PM +0800, YueHaibing wrote:
> alphabetise the header files and remove duplicated include
> file linux/kernel.h
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thank you.

> ---
> v2: alphabetise the header files
> ---
>  drivers/input/keyboard/mtk-pmic-keys.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
> index 02c67a1..8e6ebab 100644
> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> @@ -14,18 +14,17 @@
>   *
>   */
>  
> -#include <linux/module.h>
> -#include <linux/kernel.h>
>  #include <linux/input.h>
>  #include <linux/interrupt.h>
> -#include <linux/platform_device.h>
>  #include <linux/kernel.h>
> -#include <linux/of.h>
> -#include <linux/of_device.h>
> -#include <linux/regmap.h>
>  #include <linux/mfd/mt6323/registers.h>
> -#include <linux/mfd/mt6397/registers.h>
>  #include <linux/mfd/mt6397/core.h>
> +#include <linux/mfd/mt6397/registers.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
>  
>  #define MTK_PMIC_PWRKEY_RST_EN_MASK	0x1
>  #define MTK_PMIC_PWRKEY_RST_EN_SHIFT	6
> -- 
> 2.7.4
> 
> 

-- 
Dmitry
