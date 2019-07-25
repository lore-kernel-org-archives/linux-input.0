From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 1/3] mfd: mc13xxx: Add mc34708 adc support
Date: Thu, 25 Jul 2019 13:36:41 +0100
Message-ID: <20190725123641.GJ23883@dell>
References: <20190717222602.2912-1-lukma@denx.de>
 <20190717222602.2912-2-lukma@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190717222602.2912-2-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <lukma@denx.de>
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Enrico Weigelt <info@metux.net>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 18 Jul 2019, Lukasz Majewski wrote:

> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> The mc34708 has an improved adc. The older variants will always convert
> a fixed order of channels. The mc34708 can do up to eight conversions
> in arbitrary channel order. Currently this extended feature is not
> supported. We only support touchscreen conversions now, which will
> be sampled in a data format compatible to the older chips in order
> to keep the API between the mfd and the touchscreen driver.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> 
> ---
> Changes for v4:
> - None
> 
> Changes for v3:
> - None
> 
> Changes for v2:
> - Change the return code patch when the mc13xxx ADC is performing conversion
> - Introduce new include/linux/mfd/mc34708.h header file for mc34708 specific
>   defines
> 
> Changes from the original patches:
> - ADC conversion functions prototypes added to fix build error
> - Adjustments to make checkpatch clean (-ENOSYS, line over 80 char)
> 
> This patch applies on top of v5.2 - SHA1: 0ecfebd2b52404ae0c54a878c872bb93363ada36
> ---
>  drivers/mfd/mc13xxx-core.c  | 102 +++++++++++++++++++++++++++++++++++++++++++-
>  drivers/mfd/mc13xxx.h       |   3 ++
>  include/linux/mfd/mc34708.h |  37 ++++++++++++++++
>  3 files changed, 141 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/mfd/mc34708.h
> 
> diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
> index 1abe7432aad8..01473d6fda21 100644
> --- a/drivers/mfd/mc13xxx-core.c
> +++ b/drivers/mfd/mc13xxx-core.c
> @@ -12,6 +12,7 @@
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/mfd/core.h>
> +#include <linux/mfd/mc34708.h>
>  
>  #include "mc13xxx.h"
>  
> @@ -45,6 +46,8 @@
>  
>  #define MC13XXX_ADC2		45
>  
> +#define MC13XXX_ADC_WORKING		(1 << 0)

BIT(0) ?

>  void mc13xxx_lock(struct mc13xxx *mc13xxx)
>  {
>  	if (!mutex_trylock(&mc13xxx->lock)) {
> @@ -198,22 +201,30 @@ static void mc34708_print_revision(struct mc13xxx *mc13xxx, u32 revision)
>  			maskval(revision, MC34708_REVISION_FAB));
>  }
>  
> +static int mc13xxx_adc_conversion(struct mc13xxx *, unsigned int,
> +				  unsigned int, u8, bool, unsigned int *);
> +static int mc34708_adc_conversion(struct mc13xxx *, unsigned int,
> +				  unsigned int, u8, bool, unsigned int *);
> +
>  /* These are only exported for mc13xxx-i2c and mc13xxx-spi */
>  struct mc13xxx_variant mc13xxx_variant_mc13783 = {
>  	.name = "mc13783",
>  	.print_revision = mc13xxx_print_revision,
> +	.adc_do_conversion = mc13xxx_adc_conversion,
>  };
>  EXPORT_SYMBOL_GPL(mc13xxx_variant_mc13783);

I'd prefer to keep the call-back functions as close to zero as
possible.

It would be better to turn mc13xxx_adc_conversion() in to the catch
function choose an execution route based on some platform matching.

If you could do the same for print_revision too, that would be even
better.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
