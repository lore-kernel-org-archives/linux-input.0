From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] input: keyboard: mtk-pmic-keys: add MT6392 support
Date: Thu, 23 May 2019 15:55:36 -0700
Message-ID: <20190523225536.GE176265@dtor-ws>
References: <20190513142120.6527-1-fparent@baylibre.com>
 <20190513142120.6527-2-fparent@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190513142120.6527-2-fparent@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabien Parent <fparent@baylibre.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, matthias.bgg@gmail.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, May 13, 2019 at 04:21:20PM +0200, Fabien Parent wrote:
> Add support for MT6392 PMIC's keys.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Apparently this depends on not-yet merged MT6392 support in MFD, so
please merge through MFD tree with the rest of it.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/input/keyboard/mtk-pmic-keys.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
> index 8e6ebab05ab4..aaf68cbf7e5b 100644
> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> @@ -18,6 +18,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/mfd/mt6323/registers.h>
> +#include <linux/mfd/mt6392/registers.h>
>  #include <linux/mfd/mt6397/core.h>
>  #include <linux/mfd/mt6397/registers.h>
>  #include <linux/module.h>
> @@ -83,6 +84,16 @@ static const struct mtk_pmic_regs mt6323_regs = {
>  	.pmic_rst_reg = MT6323_TOP_RST_MISC,
>  };
>  
> +static const struct mtk_pmic_regs mt6392_regs = {
> +	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
> +		MTK_PMIC_KEYS_REGS(MT6392_CHRSTATUS,
> +		0x2, MT6392_INT_MISC_CON, 0x10),
> +	.keys_regs[MTK_PMIC_HOMEKEY_INDEX] =
> +		MTK_PMIC_KEYS_REGS(MT6392_CHRSTATUS,
> +		0x4, MT6392_INT_MISC_CON, 0x8),
> +	.pmic_rst_reg = MT6392_TOP_RST_MISC,
> +};
> +
>  struct mtk_pmic_keys_info {
>  	struct mtk_pmic_keys *keys;
>  	const struct mtk_pmic_keys_regs *regs;
> @@ -238,6 +249,9 @@ static const struct of_device_id of_mtk_pmic_keys_match_tbl[] = {
>  	}, {
>  		.compatible = "mediatek,mt6323-keys",
>  		.data = &mt6323_regs,
> +	}, {
> +		.compatible = "mediatek,mt6392-keys",
> +		.data = &mt6392_regs,
>  	}, {
>  		/* sentinel */
>  	}
> -- 
> 2.20.1
> 

-- 
Dmitry
