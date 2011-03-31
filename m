From: Iiro Valkonen <iiro.valkonen@atmel.com>
Subject: Re: [PATCH 2/4] Input: atmel_mxt_ts - Support 12bit resolution
Date: Thu, 31 Mar 2011 16:43:40 +0300
Message-ID: <4D94850C.1020301@atmel.com>
References: <1299487335-24139-1-git-send-email-jy0922.shim@samsung.com> <1299487335-24139-2-git-send-email-jy0922.shim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:15750 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757845Ab1CaOG7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Mar 2011 10:06:59 -0400
Received: from hnosmtp01.atmel.com ([10.161.100.237])
	by sjogate2.atmel.com (8.13.6/8.13.6) with ESMTP id p2VE41XT003725
	for <linux-input@vger.kernel.org>; Thu, 31 Mar 2011 07:04:02 -0700 (PDT)
In-Reply-To: <1299487335-24139-2-git-send-email-jy0922.shim@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, kyungmin.park@samsung.com

Hi Joonyoung,

my comments below. They a bit late, but looks like the patch is not applied yet.

On 03/07/2011 10:42 AM, Joonyoung Shim wrote:
> Atmel touchscreen chip can support 12bit resolution and this patch
> modifies to get maximum x and y size from platform data.
> 
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c |   50 +++++++++++++++++++++--------
>  1 files changed, 36 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 0986fa4..0ed0b1f 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -192,9 +192,12 @@
>  #define MXT_PRESS              (1 << 6)
>  #define MXT_DETECT             (1 << 7)
> 
> +/* Touch orient bits */
> +#define MXT_XY_SWITCH          (1 << 0)
> +#define MXT_X_INVERT           (1 << 1)
> +#define MXT_Y_INVERT           (1 << 2)
> +
>  /* Touchscreen absolute values */
> -#define MXT_MAX_XC             0x3ff
> -#define MXT_MAX_YC             0x3ff
>  #define MXT_MAX_AREA           0xff
> 
>  #define MXT_MAX_FINGER         10
> @@ -242,6 +245,8 @@ struct mxt_data {
>         struct mxt_info info;
>         struct mxt_finger finger[MXT_MAX_FINGER];
>         unsigned int irq;
> +       unsigned int x_size;
> +       unsigned int y_size;
>  };
> 
>  static bool mxt_object_readable(unsigned int type)
> @@ -541,8 +546,13 @@ static void mxt_input_touchevent(struct mxt_data *data,
>         if (!(status & (MXT_PRESS | MXT_MOVE)))
>                 return;
> 
> -       x = (message->message[1] << 2) | ((message->message[3] & ~0x3f) >> 6);
> -       y = (message->message[2] << 2) | ((message->message[3] & ~0xf3) >> 2);
> +       x = (message->message[1] << 4) | ((message->message[3] >> 4) & 0xf);
> +       y = (message->message[2] << 4) | ((message->message[3] & 0xf));
> +       if (data->x_size - 1 < 1024)
> +               x = x >> 2;
> +       if (data->y_size - 1 < 1024)
> +               y = y >> 2;
> +

Not a big deal, but I would just store x_max_value instead of x_size to avoid
the subtraction. Same for y.

>         area = message->message[4];
> 
>         dev_dbg(dev, "[%d] %s x: %d, y: %d, area: %d\n", id,
> @@ -837,6 +847,17 @@ static int mxt_initialize(struct mxt_data *data)
>         return 0;
>  }
> 
> +static void mxt_calc_resolution(struct mxt_data *data)
> +{
> +       if (data->pdata->orient & MXT_XY_SWITCH) {
> +               data->x_size = data->pdata->y_size;
> +               data->y_size = data->pdata->x_size;
> +       } else {
> +               data->x_size = data->pdata->x_size;
> +               data->y_size = data->pdata->y_size;
> +       }
> +}
> +

What's the reason for this? If we have set the x/y switch in the config, then 
we probably want to swap the axes. Or is this axis swap something that should be
done on upper layers? Even so, then we shouldn't have the MXT_XY_SWITCH bit set
in the config, and we could just say "data->x_max_value = data->pdata->xsize - 1"
(and same for y) in the probe function. We wouldn't need Touch orient bit defines
either.

>  static ssize_t mxt_object_show(struct device *dev,
>                                     struct device_attribute *attr, char *buf)
>  {
> @@ -1044,31 +1065,32 @@ static int __devinit mxt_probe(struct i2c_client *client,
>         input_dev->open = mxt_input_open;
>         input_dev->close = mxt_input_close;
> 
> +       data->client = client;
> +       data->input_dev = input_dev;
> +       data->pdata = pdata;
> +       data->irq = client->irq;
> +
> +       mxt_calc_resolution(data);
> +
>         __set_bit(EV_ABS, input_dev->evbit);
>         __set_bit(EV_KEY, input_dev->evbit);
>         __set_bit(BTN_TOUCH, input_dev->keybit);
> 
>         /* For single touch */
>         input_set_abs_params(input_dev, ABS_X,
> -                            0, MXT_MAX_XC, 0, 0);
> +                            0, data->x_size, 0, 0);
>         input_set_abs_params(input_dev, ABS_Y,
> -                            0, MXT_MAX_YC, 0, 0);
> +                            0, data->y_size, 0, 0);
> 
>         /* For multi touch */
>         input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR,
>                              0, MXT_MAX_AREA, 0, 0);
>         input_set_abs_params(input_dev, ABS_MT_POSITION_X,
> -                            0, MXT_MAX_XC, 0, 0);
> +                            0, data->x_size, 0, 0);
>         input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
> -                            0, MXT_MAX_YC, 0, 0);
> +                            0, data->y_size, 0, 0);
> 

Should these be "data->x_size - 1"? Or if we store max_x_value like suggested
above, this too will be fixed.

>         input_set_drvdata(input_dev, data);
> -
> -       data->client = client;
> -       data->input_dev = input_dev;
> -       data->pdata = pdata;
> -       data->irq = client->irq;
> -
>         i2c_set_clientdata(client, data);
> 
>         error = mxt_initialize(data);
> --
> 1.7.0.4
> 

Thanks,

-- 
Iiro
