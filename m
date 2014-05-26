From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/2] Input: mcs_touchkey: use devm_* functions
Date: Mon, 26 May 2014 13:36:02 -0700
Message-ID: <20140526203602.GA5484@core.coreip.homeip.net>
References: <1401110952-25602-1-git-send-email-beomho.seo@samsung.com>
 <1401110952-25602-2-git-send-email-beomho.seo@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:44656 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218AbaEZUgF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 May 2014 16:36:05 -0400
Received: by mail-pa0-f46.google.com with SMTP id kq14so7997954pab.19
        for <linux-input@vger.kernel.org>; Mon, 26 May 2014 13:36:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1401110952-25602-2-git-send-email-beomho.seo@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Beomho Seo <beomho.seo@samsung.com>
Cc: linux-input@vger.kernel.org, jy0922.shim@samsung.com, sachin.kamat@linaro.org, myungjoo.ham@samsung.com, jh80.chung@samsung.com, cw00.choi@samsung.com

Hi Beomho,

On Mon, May 26, 2014 at 10:29:11PM +0900, Beomho Seo wrote:
> This patch use devm_* funtions in mcs_touchkey driver.
> As a result, error path and remove() funtion is simplified.
> 
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> ---
> Changes in v2:
> - Additionally use devm_kzalloc for mcs_touchkey_data struct.
> ---
>  drivers/input/keyboard/mcs_touchkey.c |   53 +++++++++------------------------
>  1 file changed, 14 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/input/keyboard/mcs_touchkey.c b/drivers/input/keyboard/mcs_touchkey.c
> index 1da8e0b..455bd62 100644
> --- a/drivers/input/keyboard/mcs_touchkey.c
> +++ b/drivers/input/keyboard/mcs_touchkey.c
> @@ -103,7 +103,6 @@ static int mcs_touchkey_probe(struct i2c_client *client,
>  	struct mcs_touchkey_data *data;
>  	struct input_dev *input_dev;
>  	unsigned int fw_reg;
> -	int fw_ver;
>  	int error;
>  	int i;
>  
> @@ -113,14 +112,11 @@ static int mcs_touchkey_probe(struct i2c_client *client,
>  		return -EINVAL;
>  	}
>  
> -	data = kzalloc(sizeof(struct mcs_touchkey_data) +
> -			sizeof(data->keycodes[0]) * (pdata->key_maxval + 1),
> -			GFP_KERNEL);
> -	input_dev = input_allocate_device();
> +	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
> +	input_dev = devm_input_allocate_device(&client->dev);
>  	if (!data || !input_dev) {
>  		dev_err(&client->dev, "Failed to allocate memory\n");
> -		error = -ENOMEM;
> -		goto err_free_mem;
> +		return -ENOMEM;
>  	}
>  
>  	data->client = client;
> @@ -139,13 +135,12 @@ static int mcs_touchkey_probe(struct i2c_client *client,
>  		fw_reg = MCS5080_TOUCHKEY_FW;
>  	}
>  
> -	fw_ver = i2c_smbus_read_byte_data(client, fw_reg);
> -	if (fw_ver < 0) {
> -		error = fw_ver;
> +	error = i2c_smbus_read_byte_data(client, fw_reg);

You are not reading error code, you are reading firmware version. I am
not sure why you are changing this code.

> +	if (error < 0) {
>  		dev_err(&client->dev, "i2c read error[%d]\n", error);
> -		goto err_free_mem;
> -	}
> -	dev_info(&client->dev, "Firmware version: %d\n", fw_ver);
> +		return error;
> +	} else
> +		dev_info(&client->dev, "Firmware version: %d\n", error);
>  
>  	input_dev->name = "MELPAS MCS Touchkey";
>  	input_dev->id.bustype = BUS_I2C;
> @@ -176,40 +171,21 @@ static int mcs_touchkey_probe(struct i2c_client *client,
>  		data->poweron(true);
>  	}
>  
> -	error = request_threaded_irq(client->irq, NULL, mcs_touchkey_interrupt,
> -				     IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> -				     client->dev.driver->name, data);
> +	error = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +			mcs_touchkey_interrupt,	IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +			dev_name(&client->dev), data);

The original code was attaching driver name to the IRQ, now you are
attaching device name. Why? I am not against it per se, but it needs to
be a separate patch with its own justification.

>  	if (error) {
>  		dev_err(&client->dev, "Failed to register interrupt\n");
> -		goto err_free_mem;
> +		return error;
>  	}
>  
>  	error = input_register_device(input_dev);
>  	if (error)
> -		goto err_free_irq;
> +		dev_err(&client->dev, "Failed to register input device\n");
> +		return error;
>  
>  	i2c_set_clientdata(client, data);
>  	return 0;
> -
> -err_free_irq:
> -	free_irq(client->irq, data);
> -err_free_mem:
> -	input_free_device(input_dev);
> -	kfree(data);
> -	return error;
> -}
> -
> -static int mcs_touchkey_remove(struct i2c_client *client)
> -{
> -	struct mcs_touchkey_data *data = i2c_get_clientdata(client);
> -
> -	free_irq(client->irq, data);
> -	if (data->poweron)
> -		data->poweron(false);

Why aren't you powering down the chip anymore?

> -	input_unregister_device(data->input_dev);
> -	kfree(data);
> -
> -	return 0;
>  }
>  
>  static void mcs_touchkey_shutdown(struct i2c_client *client)
> @@ -269,7 +245,6 @@ static struct i2c_driver mcs_touchkey_driver = {
>  		.pm	= &mcs_touchkey_pm_ops,
>  	},
>  	.probe		= mcs_touchkey_probe,
> -	.remove		= mcs_touchkey_remove,
>  	.shutdown       = mcs_touchkey_shutdown,
>  	.id_table	= mcs_touchkey_id,
>  };
> -- 
> 1.7.9.5
> 

Thanks.

-- 
Dmitry
