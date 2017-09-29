From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 06/12] Input: elants_i2c - use managed
 devm_device_add_group
Date: Fri, 29 Sep 2017 16:38:02 -0700
Message-ID: <20170929233802.GC14362@dtor-ws>
References: <20170929203839.7010-1-andi@etezian.org>
 <20170929203839.7010-7-andi@etezian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170929203839.7010-7-andi@etezian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Shyti <andi@etezian.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>
List-Id: linux-input@vger.kernel.org

On Sat, Sep 30, 2017 at 05:38:33AM +0900, Andi Shyti wrote:
> Commit 57b8ff070f98 ("driver core: add devm_device_add_group()
> and friends") has added the the managed version for creating
> sysfs group files.
> 
> Use devm_device_add_group instead of sysfs_create_group and
> remove the action that cleans the sysfs file when exiting the
> driver.
> 
> Signed-off-by: Andi Shyti <andi@etezian.org>

Applied, thank you.

> ---
>  drivers/input/touchscreen/elants_i2c.c | 19 +------------------
>  1 file changed, 1 insertion(+), 18 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
> index 0f4cda7282a2..e102d7764bc2 100644
> --- a/drivers/input/touchscreen/elants_i2c.c
> +++ b/drivers/input/touchscreen/elants_i2c.c
> @@ -1070,13 +1070,6 @@ static const struct attribute_group elants_attribute_group = {
>  	.attrs = elants_attributes,
>  };
>  
> -static void elants_i2c_remove_sysfs_group(void *_data)
> -{
> -	struct elants_data *ts = _data;
> -
> -	sysfs_remove_group(&ts->client->dev.kobj, &elants_attribute_group);
> -}
> -
>  static int elants_i2c_power_on(struct elants_data *ts)
>  {
>  	int error;
> @@ -1289,23 +1282,13 @@ static int elants_i2c_probe(struct i2c_client *client,
>  	if (!client->dev.of_node)
>  		device_init_wakeup(&client->dev, true);
>  
> -	error = sysfs_create_group(&client->dev.kobj, &elants_attribute_group);
> +	error = devm_device_add_group(&client->dev, &elants_attribute_group);
>  	if (error) {
>  		dev_err(&client->dev, "failed to create sysfs attributes: %d\n",
>  			error);
>  		return error;
>  	}
>  
> -	error = devm_add_action(&client->dev,
> -				elants_i2c_remove_sysfs_group, ts);
> -	if (error) {
> -		elants_i2c_remove_sysfs_group(ts);
> -		dev_err(&client->dev,
> -			"Failed to add sysfs cleanup action: %d\n",
> -			error);
> -		return error;
> -	}
> -
>  	return 0;
>  }
>  
> -- 
> 2.14.2
> 

-- 
Dmitry
