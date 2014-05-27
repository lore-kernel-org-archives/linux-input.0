From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 1/2] Input: mcs_touchkey: use devm_* functions
Date: Tue, 27 May 2014 08:31:04 -0700
Message-ID: <20140527153104.GA11385@core.coreip.homeip.net>
References: <1401188787-32173-1-git-send-email-beomho.seo@samsung.com>
 <1401188787-32173-2-git-send-email-beomho.seo@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:35704 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402AbaE0PbK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 May 2014 11:31:10 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so9324448pbb.8
        for <linux-input@vger.kernel.org>; Tue, 27 May 2014 08:31:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1401188787-32173-2-git-send-email-beomho.seo@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Beomho Seo <beomho.seo@samsung.com>
Cc: linux-input@vger.kernel.org, jy0922.shim@samsung.com, sachin.kamat@linaro.org, myungjoo.ham@samsung.com, jh80.chung@samsung.com, cw00.choi@samsung.com

On Tue, May 27, 2014 at 08:06:25PM +0900, Beomho Seo wrote:
> This patch use devm_* funtions in mcs_touchkey driver.
> As a result, error path and remove() funtion is simplified.
> 
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> ---
> Changes in v3:
> - Some codes are back again. use fw_version, driver name and poweron.
> Changes in v2:
> - Additionally use devm_kzalloc for mcs_touchkey_data struct.
> ---
>  drivers/input/keyboard/mcs_touchkey.c |   32 ++++++++++----------------------
>  1 file changed, 10 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/input/keyboard/mcs_touchkey.c b/drivers/input/keyboard/mcs_touchkey.c
> index 1da8e0b..bf2f785 100644
> --- a/drivers/input/keyboard/mcs_touchkey.c
> +++ b/drivers/input/keyboard/mcs_touchkey.c
> @@ -113,14 +113,11 @@ static int mcs_touchkey_probe(struct i2c_client *client,
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
> @@ -143,7 +140,7 @@ static int mcs_touchkey_probe(struct i2c_client *client,
>  	if (fw_ver < 0) {
>  		error = fw_ver;
>  		dev_err(&client->dev, "i2c read error[%d]\n", error);
> -		goto err_free_mem;
> +		return error;
>  	}
>  	dev_info(&client->dev, "Firmware version: %d\n", fw_ver);
>  
> @@ -176,38 +173,29 @@ static int mcs_touchkey_probe(struct i2c_client *client,
>  		data->poweron(true);
>  	}
>  
> -	error = request_threaded_irq(client->irq, NULL, mcs_touchkey_interrupt,
> -				     IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> -				     client->dev.driver->name, data);
> +	error = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +				mcs_touchkey_interrupt,	IRQF_TRIGGER_FALLING |
> +				IRQF_ONESHOT, client->dev.driver->name, data);
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
>  }
>  
>  static int mcs_touchkey_remove(struct i2c_client *client)
>  {
>  	struct mcs_touchkey_data *data = i2c_get_clientdata(client);
>  
> -	free_irq(client->irq, data);
>  	if (data->poweron)
>  		data->poweron(false);

This is not an equivalent transformation - in the original code IRQ was
freed first and then platform-specific power off action was taken. Now
the order is reversed.

> -	input_unregister_device(data->input_dev);
> -	kfree(data);
>  
>  	return 0;
>  }
> -- 
> 1.7.9.5
> 

Thanks.

-- 
Dmitry
