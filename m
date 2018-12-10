From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH -next] input: keyboard: remove duplicated include from
 mtk-pmic-keys.c
Date: Mon, 10 Dec 2018 10:07:29 +0000
Message-ID: <20181210100729.GX26661@dell>
References: <20181209063440.27820-1-yuehaibing@huawei.com>
 <20181210061557.GL26661@dell>
 <4f1a67e5-b735-f8bd-88b8-3a1ca590eba2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4f1a67e5-b735-f8bd-88b8-3a1ca590eba2@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: dmitry.torokhov@gmail.com, matthias.bgg@gmail.com, chen.zhong@mediatek.com, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 10 Dec 2018, YueHaibing wrote:

> On 2018/12/10 14:15, Lee Jones wrote:
> > On Sun, 09 Dec 2018, YueHaibing wrote:
> > 
> >> Remove duplicated include.
> >>
> >> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> >> ---
> >>  drivers/input/keyboard/mtk-pmic-keys.c | 1 -
> >>  1 file changed, 1 deletion(-)
> >>
> >> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
> >> index 02c67a1..5027ebb 100644
> >> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> >> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> >> @@ -19,7 +19,6 @@
> >>  #include <linux/input.h>
> >>  #include <linux/interrupt.h>
> >>  #include <linux/platform_device.h>
> >> -#include <linux/kernel.h>
> >>  #include <linux/of.h>
> >>  #include <linux/of_device.h>
> >>  #include <linux/regmap.h>
> > 
> > You are removing the wrong one.
> 
> No, linux/kernel.h is a duplicated include indeed.

Actually both are not correct, but the first instance (at the top) is
even more incorrect.

> > Please convert this patch's main intent to alphabetise the header
> > files.  Then you can remove any obvious duplicates.
> 
> I can alphabetize it in v2 if need be.

Yes please.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
