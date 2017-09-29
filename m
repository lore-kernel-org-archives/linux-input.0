From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 05/12] Input: edt-ft5x06 - use managed
 devm_device_add_group
Date: Fri, 29 Sep 2017 16:42:43 -0700
Message-ID: <20170929234243.GH14362@dtor-ws>
References: <20170929203839.7010-1-andi@etezian.org>
 <20170929203839.7010-6-andi@etezian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170929203839.7010-6-andi@etezian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Shyti <andi@etezian.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>
List-Id: linux-input@vger.kernel.org

On Sat, Sep 30, 2017 at 05:38:32AM +0900, Andi Shyti wrote:
> Commit 57b8ff070f98 ("driver core: add devm_device_add_group()
> and friends") has added the the managed version for creating
> sysfs group files.
> 
> Use devm_device_add_group instead of sysfs_create_group and
> remove the relative sysfs_remove_group and goto label.
> 
> Signed-off-by: Andi Shyti <andi@etezian.org>

Applied, thank you.

> ---
>  drivers/input/touchscreen/edt-ft5x06.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> index 5bf63f76ddda..f879d14f7ffc 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -998,13 +998,13 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
>  		return error;
>  	}
>  
> -	error = sysfs_create_group(&client->dev.kobj, &edt_ft5x06_attr_group);
> +	error = devm_device_add_group(&client->dev, &edt_ft5x06_attr_group);
>  	if (error)
>  		return error;
>  
>  	error = input_register_device(input);
>  	if (error)
> -		goto err_remove_attrs;
> +		return error;
>  
>  	edt_ft5x06_ts_prepare_debugfs(tsdata, dev_driver_string(&client->dev));
>  	device_init_wakeup(&client->dev, 1);
> @@ -1016,10 +1016,6 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
>  		tsdata->reset_gpio ? desc_to_gpio(tsdata->reset_gpio) : -1);
>  
>  	return 0;
> -
> -err_remove_attrs:
> -	sysfs_remove_group(&client->dev.kobj, &edt_ft5x06_attr_group);
> -	return error;
>  }
>  
>  static int edt_ft5x06_ts_remove(struct i2c_client *client)
> @@ -1027,7 +1023,6 @@ static int edt_ft5x06_ts_remove(struct i2c_client *client)
>  	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
>  
>  	edt_ft5x06_ts_teardown_debugfs(tsdata);
> -	sysfs_remove_group(&client->dev.kobj, &edt_ft5x06_attr_group);
>  
>  	return 0;
>  }
> -- 
> 2.14.2
> 

-- 
Dmitry
