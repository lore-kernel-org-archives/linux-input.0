From: Andi Shyti <andi.shyti@samsung.com>
Subject: Re: [PATCH] touchscreen: mms114: add support for mms152
Date: Tue, 19 Dec 2017 15:22:52 +0900
Message-ID: <20171219062252.GC25647@gangnam.samsung>
References: <CGME20171218124955epcas3p3d776375b0dadbc3e0291da6ffb0eb6b6@epcas3p3.samsung.com>
        <20171218124933.1803-1-simon@lineageos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:17938 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932842AbdLSGWz (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 19 Dec 2017 01:22:55 -0500
Content-disposition: inline
In-reply-to: <20171218124933.1803-1-simon@lineageos.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Shields <simon@lineageos.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org

Hi Simon,

> +	if (data->pdata->type == TYPE_MMS152) {
> +		/* MMS152 has no configuration or power on registers */
> +		return 0;
> +	}
> +

Please drop the brackets here accorting to the
Documentation/process/coding-style.rst file.

> +	pdata->type = (enum mms_type)of_device_get_match_data(dev);
> +
>  	if (of_property_read_u32(np, "x-size", &pdata->x_size)) {
>  		dev_err(dev, "failed to get x-size property\n");
>  		return NULL;
> @@ -411,6 +437,7 @@ static struct mms114_platform_data *mms114_parse_dt(struct device *dev)
>  	if (of_find_property(np, "y-invert", NULL))
>  		pdata->y_invert = true;
>  
> +

Please do not add extra lines

>  	return pdata;
>  }
>  #else
> @@ -456,7 +483,15 @@ static int mms114_probe(struct i2c_client *client,
>  	data->input_dev = input_dev;
>  	data->pdata = pdata;
>  
> -	input_dev->name = "MELFAS MMS114 Touchscreen";
> +	switch (pdata->type) {
> +	case TYPE_MMS114:
> +		input_dev->name = "MELFAS MMS114 Touchscreen";
> +		break;
> +	case TYPE_MMS152:
> +		input_dev->name = "MELFAS MMS152 Touchscreen";
> +		break;
> +	}
> +
>  	input_dev->id.bustype = BUS_I2C;
>  	input_dev->dev.parent = &client->dev;
>  	input_dev->open = mms114_input_open;
> @@ -569,7 +604,13 @@ MODULE_DEVICE_TABLE(i2c, mms114_id);
>  
>  #ifdef CONFIG_OF
>  static const struct of_device_id mms114_dt_match[] = {
> -	{ .compatible = "melfas,mms114" },
> +	{
> +		.compatible = "melfas,mms114",
> +		.data = (void *)TYPE_MMS114,
> +	}, {
> +		.compatible = "melfas,mms152",
> +		.data = (void *)TYPE_MMS152,

You are not documenting the new "melfas,mms152" compatible in
Documentation/devicetree/bindings/input/touchscreen/mms114.txt

Andi
