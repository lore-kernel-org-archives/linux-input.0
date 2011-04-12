From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: atmel_mxt_ts - Support 12bit resolution
Date: Mon, 11 Apr 2011 23:57:46 -0700
Message-ID: <20110412065746.GC9566@core.coreip.homeip.net>
References: <1302241446-29201-1-git-send-email-jy0922.shim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44161 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122Ab1DLG5v (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Apr 2011 02:57:51 -0400
Received: by iyb14 with SMTP id 14so6346384iyb.19
        for <linux-input@vger.kernel.org>; Mon, 11 Apr 2011 23:57:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1302241446-29201-1-git-send-email-jy0922.shim@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: linux-input@vger.kernel.org, iiro.valkonen@atmel.com, kyungmin.park@samsung.com

On Fri, Apr 08, 2011 at 02:44:06PM +0900, Joonyoung Shim wrote:
> Atmel touchscreen chip can support 12bit resolution and this patch
> modifies to get maximum x and y size from platform data.
> 
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>

Iiro, can I have your Acked-by for this please?

> ---
> v2: Fix absinfo->maximum value of x and y
> 
>  drivers/input/touchscreen/atmel_mxt_ts.c |   53 ++++++++++++++++++++++--------
>  1 files changed, 39 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 4012436..a97905a 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -196,9 +196,12 @@
>  #define MXT_PRESS		(1 << 6)
>  #define MXT_DETECT		(1 << 7)
>  
> +/* Touch orient bits */
> +#define MXT_XY_SWITCH		(1 << 0)
> +#define MXT_X_INVERT		(1 << 1)
> +#define MXT_Y_INVERT		(1 << 2)
> +
>  /* Touchscreen absolute values */
> -#define MXT_MAX_XC		0x3ff
> -#define MXT_MAX_YC		0x3ff
>  #define MXT_MAX_AREA		0xff
>  
>  #define MXT_MAX_FINGER		10
> @@ -246,6 +249,8 @@ struct mxt_data {
>  	struct mxt_info info;
>  	struct mxt_finger finger[MXT_MAX_FINGER];
>  	unsigned int irq;
> +	unsigned int max_x;
> +	unsigned int max_y;
>  };
>  
>  static bool mxt_object_readable(unsigned int type)
> @@ -549,8 +554,13 @@ static void mxt_input_touchevent(struct mxt_data *data,
>  	if (!(status & (MXT_PRESS | MXT_MOVE)))
>  		return;
>  
> -	x = (message->message[1] << 2) | ((message->message[3] & ~0x3f) >> 6);
> -	y = (message->message[2] << 2) | ((message->message[3] & ~0xf3) >> 2);
> +	x = (message->message[1] << 4) | ((message->message[3] >> 4) & 0xf);
> +	y = (message->message[2] << 4) | ((message->message[3] & 0xf));
> +	if (data->max_x < 1024)
> +		x = x >> 2;
> +	if (data->max_y < 1024)
> +		y = y >> 2;
> +
>  	area = message->message[4];
>  
>  	dev_dbg(dev, "[%d] %s x: %d, y: %d, area: %d\n", id,
> @@ -845,6 +855,20 @@ static int mxt_initialize(struct mxt_data *data)
>  	return 0;
>  }
>  
> +static void mxt_calc_resolution(struct mxt_data *data)
> +{
> +	unsigned int max_x = data->pdata->x_size - 1;
> +	unsigned int max_y = data->pdata->y_size - 1;
> +
> +	if (data->pdata->orient & MXT_XY_SWITCH) {
> +		data->max_x = max_y;
> +		data->max_y = max_x;
> +	} else {
> +		data->max_x = max_x;
> +		data->max_y = max_y;
> +	}
> +}
> +
>  static ssize_t mxt_object_show(struct device *dev,
>  				    struct device_attribute *attr, char *buf)
>  {
> @@ -1052,31 +1076,32 @@ static int __devinit mxt_probe(struct i2c_client *client,
>  	input_dev->open = mxt_input_open;
>  	input_dev->close = mxt_input_close;
>  
> +	data->client = client;
> +	data->input_dev = input_dev;
> +	data->pdata = pdata;
> +	data->irq = client->irq;
> +
> +	mxt_calc_resolution(data);
> +
>  	__set_bit(EV_ABS, input_dev->evbit);
>  	__set_bit(EV_KEY, input_dev->evbit);
>  	__set_bit(BTN_TOUCH, input_dev->keybit);
>  
>  	/* For single touch */
>  	input_set_abs_params(input_dev, ABS_X,
> -			     0, MXT_MAX_XC, 0, 0);
> +			     0, data->max_x, 0, 0);
>  	input_set_abs_params(input_dev, ABS_Y,
> -			     0, MXT_MAX_YC, 0, 0);
> +			     0, data->max_y, 0, 0);
>  
>  	/* For multi touch */
>  	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR,
>  			     0, MXT_MAX_AREA, 0, 0);
>  	input_set_abs_params(input_dev, ABS_MT_POSITION_X,
> -			     0, MXT_MAX_XC, 0, 0);
> +			     0, data->max_x, 0, 0);
>  	input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
> -			     0, MXT_MAX_YC, 0, 0);
> +			     0, data->max_y, 0, 0);
>  
>  	input_set_drvdata(input_dev, data);
> -
> -	data->client = client;
> -	data->input_dev = input_dev;
> -	data->pdata = pdata;
> -	data->irq = client->irq;
> -
>  	i2c_set_clientdata(client, data);
>  
>  	error = mxt_initialize(data);
> -- 
> 1.7.0.4
> 

-- 
Dmitry
