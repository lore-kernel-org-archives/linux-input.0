From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] Input: ili210x - switch to using devm_device_add_group()
Date: Sat, 9 Feb 2019 11:16:29 +0100
Message-ID: <434984d5-69e1-edef-fa9c-e658c4e4a407@denx.de>
References: <20190207062746.GA30406@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190207062746.GA30406@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 2/7/19 7:27 AM, Dmitry Torokhov wrote:
> By switching to devm_device_add_group() we can complete driver conversion
> to using managed resources and get rid of ili210x_i2c_remove().
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/touchscreen/ili210x.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ili210x.c b/drivers/input/touchscreen/ili210x.c
> index 6cfe463ac118..af1dd9cff12a 100644
> --- a/drivers/input/touchscreen/ili210x.c
> +++ b/drivers/input/touchscreen/ili210x.c
> @@ -376,7 +376,7 @@ static int ili210x_i2c_probe(struct i2c_client *client,
>  		return error;
>  	}
>  
> -	error = sysfs_create_group(&dev->kobj, &ili210x_attr_group);
> +	error = devm_device_add_group(dev, &ili210x_attr_group);
>  	if (error) {
>  		dev_err(dev, "Unable to create sysfs attributes, err: %d\n",
>  			error);
> @@ -386,7 +386,7 @@ static int ili210x_i2c_probe(struct i2c_client *client,
>  	error = input_register_device(priv->input);
>  	if (error) {
>  		dev_err(dev, "Cannot register input device, err: %d\n", error);
> -		goto err_remove_sysfs;
> +		return error;
>  	}
>  
>  	device_init_wakeup(dev, 1);
> @@ -396,17 +396,6 @@ static int ili210x_i2c_probe(struct i2c_client *client,
>  		client->irq, firmware.id, firmware.major, firmware.minor);
>  
>  	return 0;
> -
> -err_remove_sysfs:
> -	sysfs_remove_group(&dev->kobj, &ili210x_attr_group);
> -	return error;
> -}
> -
> -static int ili210x_i2c_remove(struct i2c_client *client)
> -{
> -	sysfs_remove_group(&client->dev.kobj, &ili210x_attr_group);
> -
> -	return 0;
>  }
>  
>  static int __maybe_unused ili210x_i2c_suspend(struct device *dev)
> @@ -454,7 +443,6 @@ static struct i2c_driver ili210x_ts_driver = {
>  	},
>  	.id_table = ili210x_i2c_id,
>  	.probe = ili210x_i2c_probe,
> -	.remove = ili210x_i2c_remove,
>  };
>  
>  module_i2c_driver(ili210x_ts_driver);
> 

Reviewed-by: Marek Vasut <marex@denx.de>
On ILI251x
Tested-by: Marek Vasut <marex@denx.de>

-- 
Best regards,
Marek Vasut
