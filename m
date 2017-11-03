From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/5] Input: ad7897 - use managed devm_device_add_group
Date: Thu, 2 Nov 2017 17:02:13 -0700
Message-ID: <20171103000213.eitzgrh6tb5e4zt7@dtor-ws>
References: <20171102150136.1476-1-andi@etezian.org>
 <20171102150136.1476-5-andi@etezian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:49487 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932201AbdKCACR (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 2 Nov 2017 20:02:17 -0400
Content-Disposition: inline
In-Reply-To: <20171102150136.1476-5-andi@etezian.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andi Shyti <andi@etezian.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>

Hi Andi,

On Thu, Nov 02, 2017 at 05:01:35PM +0200, Andi Shyti wrote:
> Commit 57b8ff070f98 ("driver core: add devm_device_add_group()
> and friends") has added the the managed version for creating
> sysfs group files.
> 
> Use devm_device_add_group instead of sysfs_create_group and
> remove the relative sysfs_remove_group and goto label.
> 
> CC: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Andi Shyti <andi@etezian.org>
> ---
>  drivers/input/touchscreen/ad7877.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
> index 3a4230219b23..c8a143db8681 100644
> --- a/drivers/input/touchscreen/ad7877.c
> +++ b/drivers/input/touchscreen/ad7877.c
> @@ -780,28 +780,17 @@ static int ad7877_probe(struct spi_device *spi)
>  		return err;
>  	}
>  
> -	err = sysfs_create_group(&spi->dev.kobj, &ad7877_attr_group);
> +	err = devm_device_add_group(&spi->dev, &ad7877_attr_group);
>  	if (err)
>  		return err;
>  
> -	err = input_register_device(input_dev);
> -	if (err)
> -		goto err_remove_attr_group;
> -
> -	return 0;
> -
> -err_remove_attr_group:
> -	sysfs_remove_group(&spi->dev.kobj, &ad7877_attr_group);
> -
> -	return err;
> +	return input_register_device(input_dev);
>  }
>  
>  static int ad7877_remove(struct spi_device *spi)
>  {
>  	struct ad7877 *ts = spi_get_drvdata(spi);
>  
> -	sysfs_remove_group(&spi->dev.kobj, &ad7877_attr_group);
> -
>  	ad7877_disable(ts);

Can we have ad7877_disable(ts) invoked via devm_add_action_or_reset()
and get rid of ad7877_remove() completely.

I also do not see a benefit of splitting conversion of each individual
resource to a managed variant into a separate patch. Logically it is all
one operation, going from unmanaged to managed resources, and it would
be easier to review at once.

Thanks!

>  
>  	dev_dbg(&spi->dev, "unregistered touchscreen\n");
> -- 
> 2.15.0
> 

-- 
Dmitry
