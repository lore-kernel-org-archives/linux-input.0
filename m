From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: wdt87xx_i2c - Add a scaling factor for
 TOUCH_MAJOR event
Date: Wed, 1 Jul 2015 11:34:35 -0700
Message-ID: <20150701183435.GC36579@dtor-ws>
References: <1435738717-15472-1-git-send-email-hn.chen@weidahitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:37505 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835AbbGASek (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Jul 2015 14:34:40 -0400
Content-Disposition: inline
In-Reply-To: <1435738717-15472-1-git-send-email-hn.chen@weidahitech.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: HungNien Chen <hn.chen@weidahitech.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jul 01, 2015 at 04:18:37PM +0800, HungNien Chen wrote:
> Get the scaling factor when it reads the sys params. The width value will
> multiple the factor and report the value in the TOUCH_MAJOR event.
> 
> Signed-off-by: HungNien Chen <hn.chen@weidahitech.com>

Applied, thank you, but I changed scl_fctr to scale_factor.

> ---
>  drivers/input/touchscreen/wdt87xx_i2c.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/wdt87xx_i2c.c b/drivers/input/touchscreen/wdt87xx_i2c.c
> index c073ea9..b958d18 100644
> --- a/drivers/input/touchscreen/wdt87xx_i2c.c
> +++ b/drivers/input/touchscreen/wdt87xx_i2c.c
> @@ -23,7 +23,7 @@
>  #include <asm/unaligned.h>
>  
>  #define WDT87XX_NAME		"wdt87xx_i2c"
> -#define WDT87XX_DRV_VER		"0.9.5"
> +#define WDT87XX_DRV_VER		"0.9.6"
>  #define WDT87XX_FW_NAME		"wdt87xx_fw.bin"
>  #define WDT87XX_CFG_NAME	"wdt87xx_cfg.bin"
>  
> @@ -83,6 +83,7 @@
>  #define CTL_PARAM_OFFSET_PHY_Y1		18
>  #define CTL_PARAM_OFFSET_PHY_W		22
>  #define CTL_PARAM_OFFSET_PHY_H		24
> +#define	CTL_PARAM_OFFSET_FACTOR		32
>  
>  /* Communication commands */
>  #define PACKET_SIZE			56
> @@ -161,6 +162,7 @@ struct wdt87xx_sys_param {
>  	u16	phy_ch_y;
>  	u16	phy_w;
>  	u16	phy_h;
> +	u16	scl_fctr;
>  	u32	max_x;
>  	u32	max_y;
>  };
> @@ -401,7 +403,7 @@ static int wdt87xx_get_sysparam(struct i2c_client *client,
>  	u8 buf[PKT_READ_SIZE];
>  	int error;
>  
> -	error = wdt87xx_get_string(client, STRIDX_PARAMETERS, buf, 32);
> +	error = wdt87xx_get_string(client, STRIDX_PARAMETERS, buf, 34);
>  	if (error) {
>  		dev_err(&client->dev, "failed to get parameters\n");
>  		return error;
> @@ -414,6 +416,9 @@ static int wdt87xx_get_sysparam(struct i2c_client *client,
>  	param->phy_w = get_unaligned_le16(buf + CTL_PARAM_OFFSET_PHY_W) / 10;
>  	param->phy_h = get_unaligned_le16(buf + CTL_PARAM_OFFSET_PHY_H) / 10;
>  
> +	/* Get the scaling factor of pixel to logcial coordinate */
> +	param->scl_fctr = get_unaligned_le16(buf + CTL_PARAM_OFFSET_FACTOR);
> +
>  	param->max_x = MAX_UNIT_AXIS;
>  	param->max_y = DIV_ROUND_CLOSEST(MAX_UNIT_AXIS * param->phy_h,
>  					 param->phy_w);
> @@ -905,8 +910,8 @@ static void wdt87xx_report_contact(struct input_dev *input,
>  				   u8 *buf)
>  {
>  	int finger_id;
> -	u32 x, y;
> -	u8 w, p;
> +	u32 x, y, w;
> +	u8 p;
>  
>  	finger_id = (buf[FINGER_EV_V1_OFFSET_ID] >> 3) - 1;
>  	if (finger_id < 0)
> @@ -917,6 +922,8 @@ static void wdt87xx_report_contact(struct input_dev *input,
>  		return;
>  
>  	w = buf[FINGER_EV_V1_OFFSET_W];
> +	w = w * param->scl_fctr;
> +
>  	p = buf[FINGER_EV_V1_OFFSET_P];
>  
>  	x = get_unaligned_le16(buf + FINGER_EV_V1_OFFSET_X);
> @@ -995,7 +1002,8 @@ static int wdt87xx_ts_create_input_device(struct wdt87xx_data *wdt)
>  	input_abs_set_res(input, ABS_MT_POSITION_X, res);
>  	input_abs_set_res(input, ABS_MT_POSITION_Y, res);
>  
> -	input_set_abs_params(input, ABS_MT_TOUCH_MAJOR, 0, 0xFF, 0, 0);
> +	input_set_abs_params(input, ABS_MT_TOUCH_MAJOR, 0,
> +			     wdt->param.max_x, 0, 0);
>  	input_set_abs_params(input, ABS_MT_PRESSURE, 0, 0xFF, 0, 0);
>  
>  	input_mt_init_slots(input, WDT_MAX_FINGER,
> -- 
> 1.9.1
> 

-- 
Dmitry
