From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/9] Input: atmel_mxt_ts - move mxt_initialize after
 sysfs init
Date: Tue, 4 Aug 2015 17:00:41 -0700
Message-ID: <20150805000041.GA20765@dtor-ws>
References: <1438615397-17112-1-git-send-email-nick.dyer@itdev.co.uk>
 <1438615397-17112-5-git-send-email-nick.dyer@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:36592 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbbHEAAp (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Aug 2015 20:00:45 -0400
Received: by pdco4 with SMTP id o4so10431865pdc.3
        for <linux-input@vger.kernel.org>; Tue, 04 Aug 2015 17:00:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1438615397-17112-5-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: linux-input@vger.kernel.org, Alan Bowens <Alan.Bowens@atmel.com>

On Mon, Aug 03, 2015 at 04:23:12PM +0100, Nick Dyer wrote:
> An error in the sysfs init may otherwise interfere with the async return
> from the firmware loader

In this case I'd rather we blocked accessing the device via sysfs until
it is settled instead of returning intermittent -EINVAL.

Thanks.

> 
> Add guards for sysfs functions
> 
> Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 800ee0d..869dbb3 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -2092,6 +2092,10 @@ static ssize_t mxt_fw_version_show(struct device *dev,
>  {
>  	struct mxt_data *data = dev_get_drvdata(dev);
>  	struct mxt_info *info = &data->info;
> +
> +	if (!data->object_table)
> +		return -EINVAL;
> +
>  	return scnprintf(buf, PAGE_SIZE, "%u.%u.%02X\n",
>  			 info->version >> 4, info->version & 0xf, info->build);
>  }
> @@ -2102,6 +2106,10 @@ static ssize_t mxt_hw_version_show(struct device *dev,
>  {
>  	struct mxt_data *data = dev_get_drvdata(dev);
>  	struct mxt_info *info = &data->info;
> +
> +	if (!data->object_table)
> +		return -EINVAL;
> +
>  	return scnprintf(buf, PAGE_SIZE, "%u.%u\n",
>  			 info->family_id, info->variant_id);
>  }
> @@ -2134,6 +2142,9 @@ static ssize_t mxt_object_show(struct device *dev,
>  	int error;
>  	u8 *obuf;
>  
> +	if (!data->object_table)
> +		return -EINVAL;
> +
>  	/* Pre-allocate buffer large enough to hold max sized object. */
>  	obuf = kmalloc(256, GFP_KERNEL);
>  	if (!obuf)
> @@ -2603,22 +2614,19 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  
>  	disable_irq(client->irq);
>  
> -	error = mxt_initialize(data);
> -	if (error)
> -		goto err_free_irq;
> -
>  	error = sysfs_create_group(&client->dev.kobj, &mxt_attr_group);
>  	if (error) {
>  		dev_err(&client->dev, "Failure %d creating sysfs group\n",
>  			error);
> -		goto err_free_object;
> +		goto err_free_irq;
>  	}
>  
> +	error = mxt_initialize(data);
> +	if (error)
> +		goto err_free_irq;
> +
>  	return 0;
>  
> -err_free_object:
> -	mxt_free_input_device(data);
> -	mxt_free_object_table(data);
>  err_free_irq:
>  	free_irq(client->irq, data);
>  err_free_mem:
> -- 
> 2.4.6
> 

-- 
Dmitry
