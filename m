From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 02/12] Input: ad7879 - use managed devm_device_add_group
Date: Fri, 29 Sep 2017 16:48:18 -0700
Message-ID: <20170929234818.GM14362@dtor-ws>
References: <20170929203839.7010-1-andi@etezian.org>
 <20170929203839.7010-3-andi@etezian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33946 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752320AbdI2XsV (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 29 Sep 2017 19:48:21 -0400
Content-Disposition: inline
In-Reply-To: <20170929203839.7010-3-andi@etezian.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andi Shyti <andi@etezian.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>, Michael Hennerich <michael.hennerich@analog.com>

On Sat, Sep 30, 2017 at 05:38:29AM +0900, Andi Shyti wrote:
> Commit 57b8ff070f98 ("driver core: add devm_device_add_group()
> and friends") has added the the managed version for creating
> sysfs group files.
> 
> Use devm_device_add_group instead of sysfs_create_group and
> remove the action that cleans the sysfs file when exiting the
> driver.
> 
> CC: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Andi Shyti <andi@etezian.org>

Applied, thank you.

> ---
>  drivers/input/touchscreen/ad7879.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
> index 196028c45210..7d74a0ae2c94 100644
> --- a/drivers/input/touchscreen/ad7879.c
> +++ b/drivers/input/touchscreen/ad7879.c
> @@ -524,13 +524,6 @@ static int ad7879_parse_dt(struct device *dev, struct ad7879 *ts)
>  	return 0;
>  }
>  
> -static void ad7879_cleanup_sysfs(void *_ts)
> -{
> -	struct ad7879 *ts = _ts;
> -
> -	sysfs_remove_group(&ts->dev->kobj, &ad7879_attr_group);
> -}
> -
>  int ad7879_probe(struct device *dev, struct regmap *regmap,
>  		 int irq, u16 bustype, u8 devid)
>  {
> @@ -658,11 +651,7 @@ int ad7879_probe(struct device *dev, struct regmap *regmap,
>  
>  	__ad7879_disable(ts);
>  
> -	err = sysfs_create_group(&dev->kobj, &ad7879_attr_group);
> -	if (err)
> -		return err;
> -
> -	err = devm_add_action_or_reset(dev, ad7879_cleanup_sysfs, ts);
> +	err = devm_device_add_group(dev, &ad7879_attr_group);
>  	if (err)
>  		return err;
>  
> -- 
> 2.14.2
> 

-- 
Dmitry
