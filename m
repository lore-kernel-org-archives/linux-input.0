From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 11/12] Input: tsc200x-core - use managed
 devm_device_add_group
Date: Fri, 29 Sep 2017 16:44:39 -0700
Message-ID: <20170929234439.GI14362@dtor-ws>
References: <20170929203839.7010-1-andi@etezian.org>
 <20170929203839.7010-12-andi@etezian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33694 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752320AbdI2Xom (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 29 Sep 2017 19:44:42 -0400
Content-Disposition: inline
In-Reply-To: <20170929203839.7010-12-andi@etezian.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andi Shyti <andi@etezian.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>

On Sat, Sep 30, 2017 at 05:38:38AM +0900, Andi Shyti wrote:
> Commit 57b8ff070f98 ("driver core: add devm_device_add_group()
> and friends") has added the the managed version for creating
> sysfs group files.
> 
> Use devm_device_add_group instead of sysfs_create_group and
> remove the relative sysfs_remove_group and goto label.
> 
> Signed-off-by: Andi Shyti <andi@etezian.org>
> ---
>  drivers/input/touchscreen/tsc200x-core.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/tsc200x-core.c b/drivers/input/touchscreen/tsc200x-core.c
> index 88ea5e1b72ae..caec24265d78 100644
> --- a/drivers/input/touchscreen/tsc200x-core.c
> +++ b/drivers/input/touchscreen/tsc200x-core.c
> @@ -559,7 +559,7 @@ int tsc200x_probe(struct device *dev, int irq, const struct input_id *tsc_id,
>  		return error;
>  
>  	dev_set_drvdata(dev, ts);
> -	error = sysfs_create_group(&dev->kobj, &tsc200x_attr_group);
> +	error = devm_device_add_group(dev, &tsc200x_attr_group);
>  	if (error) {
>  		dev_err(dev,
>  			"Failed to create sysfs attributes, err: %d\n", error);
> @@ -570,14 +570,12 @@ int tsc200x_probe(struct device *dev, int irq, const struct input_id *tsc_id,
>  	if (error) {
>  		dev_err(dev,
>  			"Failed to register input device, err: %d\n", error);
> -		goto err_remove_sysfs;
> +		goto disable_regulator;
>  	}
>  
>  	irq_set_irq_wake(irq, 1);
>  	return 0;
>  
> -err_remove_sysfs:
> -	sysfs_remove_group(&dev->kobj, &tsc200x_attr_group);
>  disable_regulator:
>  	regulator_disable(ts->vio);
>  	return error;
> @@ -588,8 +586,6 @@ int tsc200x_remove(struct device *dev)
>  {
>  	struct tsc200x *ts = dev_get_drvdata(dev);
>  
> -	sysfs_remove_group(&dev->kobj, &tsc200x_attr_group);
> -

Wrong ordering now, you do not want to be accessing the device when it
is powered down.

>  	regulator_disable(ts->vio);
>  
>  	return 0;
> -- 
> 2.14.2
> 

Thanks.

-- 
Dmitry
