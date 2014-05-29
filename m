From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RESEND PATCH v4 2/2] Input: mcs5000_ts: use devm_* functions
Date: Thu, 29 May 2014 00:10:23 -0700
Message-ID: <20140529071021.GE11817@core.coreip.homeip.net>
References: <1401268396-23072-1-git-send-email-beomho.seo@samsung.com>
 <1401268396-23072-3-git-send-email-beomho.seo@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:56042 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753763AbaE2HKZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 May 2014 03:10:25 -0400
Received: by mail-pb0-f42.google.com with SMTP id md12so12625485pbc.29
        for <linux-input@vger.kernel.org>; Thu, 29 May 2014 00:10:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1401268396-23072-3-git-send-email-beomho.seo@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Beomho Seo <beomho.seo@samsung.com>
Cc: linux-input@vger.kernel.org, jy0922.shim@samsung.com, sachin.kamat@linaro.org, myungjoo.ham@samsung.com, jh80.chung@samsung.com, cw00.choi@samsung.com

On Wed, May 28, 2014 at 06:13:16PM +0900, Beomho Seo wrote:
> This patch use devm_* functions in mcs5000_ts driver.
> As, a result, error patch and remove() function is simplified.

Applied, thank you.

> 
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> ---
> Changes in v4:
> - None.
> Changes in v3:
> - None.
> Changes in v2:
> - Additionally use devm_kzalloc for mcs_ts_data struct.
> ---
>  drivers/input/touchscreen/mcs5000_ts.c |   42 +++++++++-----------------------
>  1 file changed, 12 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/mcs5000_ts.c b/drivers/input/touchscreen/mcs5000_ts.c
> index 647e36f..6b57e28 100644
> --- a/drivers/input/touchscreen/mcs5000_ts.c
> +++ b/drivers/input/touchscreen/mcs5000_ts.c
> @@ -196,12 +196,11 @@ static int mcs5000_ts_probe(struct i2c_client *client,
>  	if (!dev_get_platdata(&client->dev))
>  		return -EINVAL;
>  
> -	data = kzalloc(sizeof(struct mcs5000_ts_data), GFP_KERNEL);
> -	input_dev = input_allocate_device();
> +	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
> +	input_dev = devm_input_allocate_device(&client->dev);
>  	if (!data || !input_dev) {
>  		dev_err(&client->dev, "Failed to allocate memory\n");
> -		ret = -ENOMEM;
> -		goto err_free_mem;
> +		return -ENOMEM;
>  	}
>  
>  	data->client = client;
> @@ -223,40 +222,24 @@ static int mcs5000_ts_probe(struct i2c_client *client,
>  	if (data->platform_data->cfg_pin)
>  		data->platform_data->cfg_pin();
>  
> -	ret = request_threaded_irq(client->irq, NULL, mcs5000_ts_interrupt,
> -			IRQF_TRIGGER_LOW | IRQF_ONESHOT, "mcs5000_ts", data);
> -
> -	if (ret < 0) {
> +	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +			mcs5000_ts_interrupt, IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +			"mcs5000_ts", data);
> +	if (ret) {
>  		dev_err(&client->dev, "Failed to register interrupt\n");
> -		goto err_free_mem;
> +		return ret;
>  	}
>  
>  	ret = input_register_device(data->input_dev);
> -	if (ret < 0)
> -		goto err_free_irq;
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Failed to register input device\n");
> +		return ret;
> +	}
>  
>  	mcs5000_ts_phys_init(data);
>  	i2c_set_clientdata(client, data);
>  
>  	return 0;
> -
> -err_free_irq:
> -	free_irq(client->irq, data);
> -err_free_mem:
> -	input_free_device(input_dev);
> -	kfree(data);
> -	return ret;
> -}
> -
> -static int mcs5000_ts_remove(struct i2c_client *client)
> -{
> -	struct mcs5000_ts_data *data = i2c_get_clientdata(client);
> -
> -	free_irq(client->irq, data);
> -	input_unregister_device(data->input_dev);
> -	kfree(data);
> -
> -	return 0;
>  }
>  
>  #ifdef CONFIG_PM
> @@ -291,7 +274,6 @@ MODULE_DEVICE_TABLE(i2c, mcs5000_ts_id);
>  
>  static struct i2c_driver mcs5000_ts_driver = {
>  	.probe		= mcs5000_ts_probe,
> -	.remove		= mcs5000_ts_remove,
>  	.driver = {
>  		.name = "mcs5000_ts",
>  #ifdef CONFIG_PM
> -- 
> 1.7.9.5
> 

-- 
Dmitry
