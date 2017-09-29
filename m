From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 08/12] Input: melfas_mip4 - use managed
 devm_device_add_group
Date: Fri, 29 Sep 2017 16:38:45 -0700
Message-ID: <20170929233845.GD14362@dtor-ws>
References: <20170929203839.7010-1-andi@etezian.org>
 <20170929203839.7010-9-andi@etezian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35668 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752505AbdI2Xis (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 29 Sep 2017 19:38:48 -0400
Content-Disposition: inline
In-Reply-To: <20170929203839.7010-9-andi@etezian.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andi Shyti <andi@etezian.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>, Sangwon Jee <jeesw@melfas.com>

On Sat, Sep 30, 2017 at 05:38:35AM +0900, Andi Shyti wrote:
> Commit 57b8ff070f98 ("driver core: add devm_device_add_group()
> and friends") has added the the managed version for creating
> sysfs group files.
> 
> Use devm_device_add_group instead of sysfs_create_group and
> remove the action that cleans the sysfs file when exiting the
> driver.
> 
> CC: Sangwon Jee <jeesw@melfas.com>
> Signed-off-by: Andi Shyti <andi@etezian.org>

Applied, thank you.

> ---
>  drivers/input/touchscreen/melfas_mip4.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/melfas_mip4.c b/drivers/input/touchscreen/melfas_mip4.c
> index 05108c2fea93..6892f0e28918 100644
> --- a/drivers/input/touchscreen/melfas_mip4.c
> +++ b/drivers/input/touchscreen/melfas_mip4.c
> @@ -1433,13 +1433,6 @@ static const struct attribute_group mip4_attr_group = {
>  	.attrs = mip4_attrs,
>  };
>  
> -static void mip4_sysfs_remove(void *_data)
> -{
> -	struct mip4_ts *ts = _data;
> -
> -	sysfs_remove_group(&ts->client->dev.kobj, &mip4_attr_group);
> -}
> -
>  static int mip4_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  {
>  	struct mip4_ts *ts;
> @@ -1535,21 +1528,13 @@ static int mip4_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  		return error;
>  	}
>  
> -	error = sysfs_create_group(&client->dev.kobj, &mip4_attr_group);
> +	error = devm_device_add_group(&client->dev, &mip4_attr_group);
>  	if (error) {
>  		dev_err(&client->dev,
>  			"Failed to create sysfs attribute group: %d\n", error);
>  		return error;
>  	}
>  
> -	error = devm_add_action(&client->dev, mip4_sysfs_remove, ts);
> -	if (error) {
> -		mip4_sysfs_remove(ts);
> -		dev_err(&client->dev,
> -			"Failed to install sysfs remoce action: %d\n", error);
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
