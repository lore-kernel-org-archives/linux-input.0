From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 12/12] Input: wdt87xx_i2c - use managed
 devm_device_add_group
Date: Fri, 29 Sep 2017 16:41:16 -0700
Message-ID: <20170929234116.GG14362@dtor-ws>
References: <20170929203839.7010-1-andi@etezian.org>
 <20170929203839.7010-13-andi@etezian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38147 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752320AbdI2XlT (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 29 Sep 2017 19:41:19 -0400
Content-Disposition: inline
In-Reply-To: <20170929203839.7010-13-andi@etezian.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andi Shyti <andi@etezian.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>

On Sat, Sep 30, 2017 at 05:38:39AM +0900, Andi Shyti wrote:
> Commit 57b8ff070f98 ("driver core: add devm_device_add_group()
> and friends") has added the the managed version for creating
> sysfs group files.
> 
> Use devm_device_add_group instead of sysfs_create_group and
> remove the relative sysfs_remove_group.
> 
> Signed-off-by: Andi Shyti <andi@etezian.org>

Applied, thank you.

> ---
>  drivers/input/touchscreen/wdt87xx_i2c.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/wdt87xx_i2c.c b/drivers/input/touchscreen/wdt87xx_i2c.c
> index a9132603ab34..b866cc88d942 100644
> --- a/drivers/input/touchscreen/wdt87xx_i2c.c
> +++ b/drivers/input/touchscreen/wdt87xx_i2c.c
> @@ -1106,7 +1106,7 @@ static int wdt87xx_ts_probe(struct i2c_client *client,
>  		return error;
>  	}
>  
> -	error = sysfs_create_group(&client->dev.kobj, &wdt87xx_attr_group);
> +	error = devm_device_add_group(&client->dev, &wdt87xx_attr_group);
>  	if (error) {
>  		dev_err(&client->dev, "create sysfs failed: %d\n", error);
>  		return error;
> @@ -1117,8 +1117,6 @@ static int wdt87xx_ts_probe(struct i2c_client *client,
>  
>  static int wdt87xx_ts_remove(struct i2c_client *client)
>  {
> -	sysfs_remove_group(&client->dev.kobj, &wdt87xx_attr_group);
> -
>  	return 0;
>  }
>  
> -- 
> 2.14.2
> 

-- 
Dmitry
