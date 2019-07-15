From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 3/3] input: touchscreen mc13xxx: Add mc34708 support
Date: Mon, 15 Jul 2019 00:07:02 -0700
Message-ID: <20190715070702.GA153485@dtor-ws>
References: <20190711222346.5245-1-lukma@denx.de>
 <20190711222346.5245-4-lukma@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190711222346.5245-4-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <lukma@denx.de>
Cc: Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Enrico Weigelt <info@metux.net>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Lukasz,
 
On Fri, Jul 12, 2019 at 12:23:46AM +0200, Lukasz Majewski wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> The mc34708 has a different bit to enable pen detection. This
> adds the driver data and devtype necessary to probe the device
> and to distinguish between the mc13783 and the mc34708.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> 
> ---
> Changes for v2:
> - Change nested if statements to a single one (with cr0 > ...)
> - Replace hardcoded max resistance value (4080) with a generic driver data
>   value.
> - Introduce new include/linux/mfd/mc34708.h header file for mc34708 specific
>   defines
> - Define as driver data mask and value for accessing mc13xxx registers
> 
> Changes from the original patch:
> - Simplify the mcXXXXX_set_pen_detection functions
> - Fix checkpatch warnings
> ---
>  drivers/input/touchscreen/mc13783_ts.c | 59 +++++++++++++++++++++++++++++++---
>  1 file changed, 55 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/mc13783_ts.c b/drivers/input/touchscreen/mc13783_ts.c
> index edd49e44e0c9..8fd3d0e47f57 100644
> --- a/drivers/input/touchscreen/mc13783_ts.c
> +++ b/drivers/input/touchscreen/mc13783_ts.c
> @@ -10,6 +10,7 @@
>   */
>  #include <linux/platform_device.h>
>  #include <linux/mfd/mc13783.h>
> +#include <linux/mfd/mc34708.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/input.h>
> @@ -30,6 +31,8 @@ MODULE_PARM_DESC(sample_tolerance,
>  		"is supposed to be wrong and is discarded.  Set to 0 to "
>  		"disable this check.");
>  
> +struct mc13xxx_driver_data;

Why don't you define the structure here instead of sing forward
declaration? The structure is also commonly called as xxx_chip, so
struct mc13xxx_chip {
	...
};

> +
>  struct mc13783_ts_priv {
>  	struct input_dev *idev;
>  	struct mc13xxx *mc13xxx;
> @@ -37,6 +40,33 @@ struct mc13783_ts_priv {
>  	unsigned int sample[4];
>  	u8 ato;
>  	bool atox;
> +	struct mc13xxx_driver_data *drvdata;

const struct mc13xxx_chip *chip;

> +};
> +
> +enum mc13xxx_type {
> +	MC13XXX_TYPE_MC13783,
> +	MC13XXX_TYPE_MC34708,
> +};
> +
> +struct mc13xxx_driver_data {
> +	enum mc13xxx_type type;
> +	int max_resistance;
> +	u32 reg_mask;
> +	u32 reg_value;
> +};
> +
> +static struct mc13xxx_driver_data mc13783_driver_data = {
> +	.type = MC13XXX_TYPE_MC13783,
> 	.max_resistance = 4096,
> +	.reg_mask = MC13XXX_ADC0_TSMOD_MASK,
> +	.reg_value = MC13XXX_ADC0_TSMOD0,
> +};
> +
> +static struct mc13xxx_driver_data mc34708_driver_data = {
> +	.type = MC13XXX_TYPE_MC34708,
> +	.max_resistance = 4080,
> +	.reg_mask = MC34708_ADC0_TSMASK,
> +	.reg_value = MC34708_ADC0_TSPENDETEN,
>  };

Have these 2 closer to the ID table.

>  
>  static irqreturn_t mc13783_ts_handler(int irq, void *data)
> @@ -93,6 +123,10 @@ static void mc13783_ts_report_sample(struct mc13783_ts_priv *priv)
>  
>  	cr0 = (cr0 + cr1) / 2;
>  
> +	if (priv->drvdata->type == MC13XXX_TYPE_MC34708 &&
> +	    cr0 > priv->drvdata->max_resistance)
> +		cr0 = 0;

I would like to avoid the type comparisons. Given that both cr0 and cr1
can't be more than 4095 (because we limit them when parsing sampling
data) I think we can simply say

	if (cr0 > priv->chip->max_resistance)
		cr0 = 0;

Thanks.

-- 
Dmitry
