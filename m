From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] keyboard/mtk-pmic-keys.c: Remove duplicate header
Date: Sun, 13 Jan 2019 22:53:16 -0800
Message-ID: <20190114065316.GC217283@dtor-ws>
References: <20190105050907.GA2525@hp-pavilion-15-notebook-pc-brajeswar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190105050907.GA2525@hp-pavilion-15-notebook-pc-brajeswar>
Sender: linux-kernel-owner@vger.kernel.org
To: Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc: matthias.bgg@gmail.com, lee.jones@linaro.org, chen.zhong@mediatek.com, jrdr.linux@gmail.com, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, Jan 05, 2019 at 10:39:07AM +0530, Brajeswar Ghosh wrote:
> Remove linux/kernel.h which is included more than once
> 
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>

Applied, thank you.

> ---
>  drivers/input/keyboard/mtk-pmic-keys.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
> index 02c67a1749fc..5027ebb7b4e8 100644
> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> @@ -19,7 +19,6 @@
>  #include <linux/input.h>
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
> -#include <linux/kernel.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/regmap.h>
> -- 
> 2.17.1
> 

-- 
Dmitry
