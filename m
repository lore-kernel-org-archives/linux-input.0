From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 04/12] Input: atmel_mxt_ts - use managed
 devm_device_add_group
Date: Fri, 29 Sep 2017 16:46:01 -0700
Message-ID: <20170929234601.GK14362@dtor-ws>
References: <20170929203839.7010-1-andi@etezian.org>
 <20170929203839.7010-5-andi@etezian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36919 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752320AbdI2XqF (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 29 Sep 2017 19:46:05 -0400
Content-Disposition: inline
In-Reply-To: <20170929203839.7010-5-andi@etezian.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andi Shyti <andi@etezian.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>, Nick Dyer <nick@shmanahar.org>

On Sat, Sep 30, 2017 at 05:38:31AM +0900, Andi Shyti wrote:
> Commit 57b8ff070f98 ("driver core: add devm_device_add_group()
> and friends") has added the the managed version for creating
> sysfs group files.
> 
> Use devm_device_add_group instead of sysfs_create_group.
> 
> CC: Nick Dyer <nick@shmanahar.org>
> Signed-off-by: Andi Shyti <andi@etezian.org>
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 7659bc48f1db..e5968f136f08 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -3170,7 +3170,7 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	if (error)
>  		return error;
>  
> -	error = sysfs_create_group(&client->dev.kobj, &mxt_attr_group);
> +	error = devm_device_add_group(&client->dev, &mxt_attr_group);
>  	if (error) {
>  		dev_err(&client->dev, "Failure %d creating sysfs group\n",
>  			error);
> @@ -3190,7 +3190,6 @@ static int mxt_remove(struct i2c_client *client)
>  	struct mxt_data *data = i2c_get_clientdata(client);
>  
>  	disable_irq(data->irq);
> -	sysfs_remove_group(&client->dev.kobj, &mxt_attr_group);

Wrong ordering.

>  	mxt_free_input_device(data);
>  	mxt_free_object_table(data);
>  
> -- 
> 2.14.2
> 

-- 
Dmitry
