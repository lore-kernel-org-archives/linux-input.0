From: "Valkonen, Iiro" <iiro.valkonen@atmel.com>
Subject: Re: [PATCH v2] Input: atmel_mxt_ts - Support 12bit resolution
Date: Tue, 12 Apr 2011 15:54:33 +0100
Message-ID: <F619927BD5260540BACE9E197A0F2A69013A4CFD@hammb01.corp.atmel.com>
References: <1302241446-29201-1-git-send-email-jy0922.shim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:1308 "EHLO sjogate2.atmel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757163Ab1DLOyr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Apr 2011 10:54:47 -0400
Content-class: urn:content-classes:message
In-Reply-To: <1302241446-29201-1-git-send-email-jy0922.shim@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, kyungmin.park@samsung.com

On 04/08/2011 08:44 AM, Joonyoung Shim wrote:
> Atmel touchscreen chip can support 12bit resolution and this patch
> modifies to get maximum x and y size from platform data.
> 
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>

Acked-by: Iiro Valkonen <iiro.valkonen@atmel.com>

Thanks,
Iiro

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


