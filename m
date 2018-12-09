From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 1/3] Input: atmel_mxt_ts: Add support for  optional
 regulators
Date: Sat, 8 Dec 2018 20:26:12 -0800
Message-ID: <20181209042612.GD211094@dtor-ws>
References: <20181207142857.15818-1-pawel.mikolaj.chmiel@gmail.com>
 <20181207142857.15818-2-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181207142857.15818-2-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc: nick@shmanahar.org, robh+dt@kernel.org, mark.rutland@arm.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Dec 07, 2018 at 03:28:55PM +0100, Paweł Chmiel wrote:
> This patch adds optional regulators, which can be used to power
> up touchscreen. After enabling regulators, we need to wait 150msec.
> This value is taken from official driver.
> 
> It was tested on Samsung Galaxy i9000 (based on Samsung S5PV210 SOC).
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
> Changes from v3:
>   - Fix checkpatch issues
>   - Drop sentence punctuation from subject of one of patches
> 
> Changes from v2:
>   - Move code enabling regulators into separate method,
>     to make code more readable.
> 
> Changes from v1:
>   - Enable regulators only if reset_gpio is present.
>   - Switch from devm_regulator_get_optional to devm_regulator_get
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 65 +++++++++++++++++++++---
>  1 file changed, 59 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index d3aacd534e9c..1dc8ad0da5af 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -27,6 +27,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/of.h>
>  #include <linux/property.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  #include <linux/gpio/consumer.h>
>  #include <asm/unaligned.h>
> @@ -194,10 +195,10 @@ enum t100_type {
>  
>  /* Delay times */
>  #define MXT_BACKUP_TIME		50	/* msec */
> -#define MXT_RESET_GPIO_TIME	20	/* msec */
>  #define MXT_RESET_INVALID_CHG	100	/* msec */
>  #define MXT_RESET_TIME		200	/* msec */
>  #define MXT_RESET_TIMEOUT	3000	/* msec */
> +#define MXT_REGULATOR_DELAY	150	/* msec */
>  #define MXT_CRC_TIMEOUT		1000	/* msec */
>  #define MXT_FW_RESET_TIME	3000	/* msec */
>  #define MXT_FW_CHG_TIMEOUT	300	/* msec */
> @@ -323,6 +324,8 @@ struct mxt_data {
>  	struct t7_config t7_cfg;
>  	struct mxt_dbg dbg;
>  	struct gpio_desc *reset_gpio;
> +	struct regulator *vdd_reg;
> +	struct regulator *avdd_reg;
>  
>  	/* Cached parameters from object table */
>  	u16 T5_address;
> @@ -3038,6 +3041,38 @@ static const struct dmi_system_id chromebook_T9_suspend_dmi[] = {
>  	{ }
>  };
>  
> +static int mxt_regulator_enable(struct mxt_data *data)
> +{
> +	int error;
> +
> +	if (data->reset_gpio) {
> +		error = regulator_enable(data->vdd_reg);
> +		if (error) {
> +			dev_err(&data->client->dev,
> +				"Failed to enable vdd regulator: %d\n", error);
> +			return error;
> +		}
> +
> +		error = regulator_enable(data->avdd_reg);
> +		if (error) {
> +			dev_err(&data->client->dev,
> +				"Failed to enable avdd regulator: %d\n", error);

This leaves vdd regulator enabled.

Thanks.

-- 
Dmitry
