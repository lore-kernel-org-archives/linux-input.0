From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3 v3] Input: atmel_mxt_ts - Make wait-after-reset
 period compatible with all chips
Date: Thu, 7 Jul 2011 07:43:35 -0700
Message-ID: <20110707144335.GJ7658@core.coreip.homeip.net>
References: <4E145128.9060404@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63250 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755742Ab1GGOnm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jul 2011 10:43:42 -0400
Received: by iyb12 with SMTP id 12so919922iyb.19
        for <linux-input@vger.kernel.org>; Thu, 07 Jul 2011 07:43:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E145128.9060404@atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Iiro Valkonen <iiro.valkonen@atmel.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, linux-input@vger.kernel.org

On Wed, Jul 06, 2011 at 03:12:24PM +0300, Iiro Valkonen wrote:
> The delay before the chip can be accessed after reset varies between different
> chips in maXTouch family. Waiting for 200ms and then monitoring the CHG (chip
> is ready when the line is low) is guaranteed to work with all chips.
> 
> v3: Add a check for NULL read_chg() function, and add the read_chg() to platform
>     files using this driver (currently only mach-goni.c)
> v2: At Dmitry's suggestion, add a timeout so we are not stuck looping
>     endlessly in case the CHG is not going low. 
> 
> Signed-off-by: Iiro Valkonen <iiro.valkonen@atmel.com>
> ---
>  arch/arm/mach-s5pv210/mach-goni.c        |    6 ++++++
>  drivers/input/touchscreen/atmel_mxt_ts.c |   14 +++++++++++++-
>  include/linux/i2c/atmel_mxt_ts.h         |    1 +
>  3 files changed, 20 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
> index 31d5aa7..196e92c 100644
> --- a/arch/arm/mach-s5pv210/mach-goni.c
> +++ b/arch/arm/mach-s5pv210/mach-goni.c
> @@ -225,6 +225,11 @@ static void __init goni_radio_init(void)
>  	gpio_direction_output(gpio, 1);
>  }
>  
> +static u8 read_chg(void)
> +{
> +	return gpio_get_value(S5PV210_GPJ0(5));
> +}
> +
>  /* TSP */
>  static struct mxt_platform_data qt602240_platform_data = {
>  	.x_line		= 17,
> @@ -236,6 +241,7 @@ static struct mxt_platform_data qt602240_platform_data = {
>  	.voltage	= 2800000,              /* 2.8V */
>  	.orient		= MXT_DIAGONAL,
>  	.irqflags	= IRQF_TRIGGER_FALLING,
> +	.read_chg	= &read_chg,
>  };
>  
>  static struct s3c2410_platform_i2c i2c2_data __initdata = {
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 1e61387..99df3b7 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -170,7 +170,8 @@
>  #define MXT_BOOT_VALUE		0xa5
>  #define MXT_BACKUP_VALUE	0x55
>  #define MXT_BACKUP_TIME		25	/* msec */
> -#define MXT_RESET_TIME		65	/* msec */
> +#define MXT_RESET_TIME		200	/* msec */

Can't we really start polling before 200msecs are up? Woudl it be
possible to leave the initial wait at 65 (or maybe increase it to 100
msecs)?

> +#define MXT_RESET_NOCHGREAD     400     /* msec */
>  
>  #define MXT_FWRESET_TIME	175	/* msec */
>  
> @@ -792,6 +793,7 @@ static int mxt_initialize(struct mxt_data *data)
>  	struct i2c_client *client = data->client;
>  	struct mxt_info *info = &data->info;
>  	int error;
> +	int reset_timeout = 0;
>  	u8 val;
>  
>  	error = mxt_get_info(data);
> @@ -828,6 +830,16 @@ static int mxt_initialize(struct mxt_data *data)
>  	mxt_write_object(data, MXT_GEN_COMMAND,
>  			MXT_COMMAND_RESET, 1);
>  	msleep(MXT_RESET_TIME);
> +	if (data->pdata->read_chg == NULL) {
> +		msleep(MXT_RESET_NOCHGREAD);

This means that without read_chg we are waiting for 600ms now... It is
eternity. Can we wait for MXT_RESET_NOCHGREAD total?

> +	} else {
> +		while ((reset_timeout++ <= 100) && data->pdata->read_chg())
> +			msleep(2);
> +		if (reset_timeout >= 100) {
> +			dev_err(&client->dev, "No response after reset!\n");
> +			return -EIO;
> +		}
> +	}
>  
>  	/* Update matrix size at info struct */
>  	error = mxt_read_reg(client, MXT_MATRIX_X_SIZE, &val);
> diff --git a/include/linux/i2c/atmel_mxt_ts.h b/include/linux/i2c/atmel_mxt_ts.h
> index f027f7a..ef59c22 100644
> --- a/include/linux/i2c/atmel_mxt_ts.h
> +++ b/include/linux/i2c/atmel_mxt_ts.h
> @@ -39,6 +39,7 @@ struct mxt_platform_data {
>  	unsigned int voltage;
>  	unsigned char orient;
>  	unsigned long irqflags;
> +	u8(*read_chg) (void);
>  };
>  
>  #endif /* __LINUX_ATMEL_MXT_TS_H */
> -- 
> 1.7.0.4

-- 
Dmitry
