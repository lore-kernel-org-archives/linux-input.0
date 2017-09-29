From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 07/12] Input: ili210x - use managed devm_device_add_group
Date: Fri, 29 Sep 2017 16:45:38 -0700
Message-ID: <20170929234538.GJ14362@dtor-ws>
References: <20170929203839.7010-1-andi@etezian.org>
 <20170929203839.7010-8-andi@etezian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35548 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752320AbdI2Xpl (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 29 Sep 2017 19:45:41 -0400
Content-Disposition: inline
In-Reply-To: <20170929203839.7010-8-andi@etezian.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andi Shyti <andi@etezian.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>

On Sat, Sep 30, 2017 at 05:38:34AM +0900, Andi Shyti wrote:
> Commit 57b8ff070f98 ("driver core: add devm_device_add_group()
> and friends") has added the the managed version for creating
> sysfs group files.
> 
> Use devm_device_add_group instead of sysfs_create_group and
> remove the relative sysfs_remove_group and goto label.
> 
> Signed-off-by: Andi Shyti <andi@etezian.org>
> ---
>  drivers/input/touchscreen/ili210x.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ili210x.c b/drivers/input/touchscreen/ili210x.c
> index 6f76eeedf465..03a6aca2941f 100644
> --- a/drivers/input/touchscreen/ili210x.c
> +++ b/drivers/input/touchscreen/ili210x.c
> @@ -266,7 +266,7 @@ static int ili210x_i2c_probe(struct i2c_client *client,
>  		goto err_free_mem;
>  	}
>  
> -	error = sysfs_create_group(&dev->kobj, &ili210x_attr_group);
> +	error = devm_device_add_group(dev, &ili210x_attr_group);
>  	if (error) {
>  		dev_err(dev, "Unable to create sysfs attributes, err: %d\n",
>  			error);
> @@ -276,7 +276,7 @@ static int ili210x_i2c_probe(struct i2c_client *client,
>  	error = input_register_device(priv->input);
>  	if (error) {
>  		dev_err(dev, "Cannot register input device, err: %d\n", error);
> -		goto err_remove_sysfs;
> +		goto err_free_irq;
>  	}
>  
>  	device_init_wakeup(dev, 1);
> @@ -287,8 +287,6 @@ static int ili210x_i2c_probe(struct i2c_client *client,
>  
>  	return 0;
>  
> -err_remove_sysfs:
> -	sysfs_remove_group(&dev->kobj, &ili210x_attr_group);
>  err_free_irq:
>  	free_irq(client->irq, priv);
>  err_free_mem:
> @@ -301,7 +299,6 @@ static int ili210x_i2c_remove(struct i2c_client *client)
>  {
>  	struct ili210x *priv = i2c_get_clientdata(client);
>  
> -	sysfs_remove_group(&client->dev.kobj, &ili210x_attr_group);

Wrong ordering, the sysfs attributes will be removed only after device
has been town down.

>  	free_irq(priv->client->irq, priv);
>  	cancel_delayed_work_sync(&priv->dwork);
>  	input_unregister_device(priv->input);
> -- 
> 2.14.2
> 

-- 
Dmitry
