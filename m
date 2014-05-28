From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RESEND PATCH v4 1/2] Input: mcs_touchkey: use devm_* functions
Date: Wed, 28 May 2014 09:37:02 -0700
Message-ID: <20140528163702.GB6043@core.coreip.homeip.net>
References: <1401268396-23072-1-git-send-email-beomho.seo@samsung.com>
 <1401268396-23072-2-git-send-email-beomho.seo@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:57531 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282AbaE1QhG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 May 2014 12:37:06 -0400
Received: by mail-pb0-f42.google.com with SMTP id md12so11455591pbc.15
        for <linux-input@vger.kernel.org>; Wed, 28 May 2014 09:37:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1401268396-23072-2-git-send-email-beomho.seo@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Beomho Seo <beomho.seo@samsung.com>
Cc: linux-input@vger.kernel.org, jy0922.shim@samsung.com, sachin.kamat@linaro.org, myungjoo.ham@samsung.com, jh80.chung@samsung.com, cw00.choi@samsung.com

On Wed, May 28, 2014 at 06:13:15PM +0900, Beomho Seo wrote:
> This patch use devm_* funtions in mcs_touchkey driver.
> As a result, error path and remove() funtion is simplified.
> 
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> ---
> Changes in v4:
> - free_irq are back again for equivalent transformation.
> Changes in v3:
> - Some codes are back again. use fw_version, driver name and poweron.
> Changes in v2:
> - Additionally use devm_kzalloc for mcs_touchkey_data struct.
> ---
>  drivers/input/keyboard/mcs_touchkey.c |   34 ++++++++++++---------------------
>  1 file changed, 12 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/input/keyboard/mcs_touchkey.c b/drivers/input/keyboard/mcs_touchkey.c
> index 1da8e0b..48a341c 100644
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
> @@ -176,27 +173,22 @@ static int mcs_touchkey_probe(struct i2c_client *client,
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
> -	if (error)
> -		goto err_free_irq;
> +	if (error) {
> +		dev_err(&client->dev, "Failed to register input device\n");
> +		return error;
> +	}
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
> @@ -206,8 +198,6 @@ static int mcs_touchkey_remove(struct i2c_client *client)
>  	free_irq(client->irq, data);

No, you can not use free_irq() on managed IRQ. If you want to do devm
conversion I'd rather you used devm_add_action() to schedule call to
data->poweron(false).

Thanks.

>  	if (data->poweron)
>  		data->poweron(false);
> -	input_unregister_device(data->input_dev);
> -	kfree(data);
>  
>  	return 0;
>  }
> -- 
> 1.7.9.5
> 

-- 
Dmitry
