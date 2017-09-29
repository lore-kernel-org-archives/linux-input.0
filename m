From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 10/12] Input: rohm_bu21023 - use managed
 devm_device_add_group
Date: Fri, 29 Sep 2017 16:39:56 -0700
Message-ID: <20170929233956.GF14362@dtor-ws>
References: <20170929203839.7010-1-andi@etezian.org>
 <20170929203839.7010-11-andi@etezian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33533 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752505AbdI2Xj7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 29 Sep 2017 19:39:59 -0400
Content-Disposition: inline
In-Reply-To: <20170929203839.7010-11-andi@etezian.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andi Shyti <andi@etezian.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>

On Sat, Sep 30, 2017 at 05:38:37AM +0900, Andi Shyti wrote:
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
>  drivers/input/touchscreen/rohm_bu21023.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/rohm_bu21023.c b/drivers/input/touchscreen/rohm_bu21023.c
> index eeaf6ff03597..bda0500c9b57 100644
> --- a/drivers/input/touchscreen/rohm_bu21023.c
> +++ b/drivers/input/touchscreen/rohm_bu21023.c
> @@ -1103,13 +1103,6 @@ static void rohm_ts_close(struct input_dev *input_dev)
>  	ts->initialized = false;
>  }
>  
> -static void rohm_ts_remove_sysfs_group(void *_dev)
> -{
> -	struct device *dev = _dev;
> -
> -	sysfs_remove_group(&dev->kobj, &rohm_ts_attr_group);
> -}
> -
>  static int rohm_bu21023_i2c_probe(struct i2c_client *client,
>  				  const struct i2c_device_id *id)
>  {
> @@ -1180,20 +1173,12 @@ static int rohm_bu21023_i2c_probe(struct i2c_client *client,
>  		return error;
>  	}
>  
> -	error = sysfs_create_group(&dev->kobj, &rohm_ts_attr_group);
> +	error = devm_device_add_group(dev, &rohm_ts_attr_group);
>  	if (error) {
>  		dev_err(dev, "failed to create sysfs group: %d\n", error);
>  		return error;
>  	}
>  
> -	error = devm_add_action(dev, rohm_ts_remove_sysfs_group, dev);
> -	if (error) {
> -		rohm_ts_remove_sysfs_group(dev);
> -		dev_err(dev, "Failed to add sysfs cleanup action: %d\n",
> -			error);
> -		return error;
> -	}
> -
>  	return error;
>  }
>  
> -- 
> 2.14.2
> 

-- 
Dmitry
