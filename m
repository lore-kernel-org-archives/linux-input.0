From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v1] Revert "Input: synaptics_rmi4 - use
 devm_device_add_group() for attributes in F01"
Date: Wed, 24 Jan 2018 13:47:06 -0800
Message-ID: <20180124214706.d5nqq4aiyot2fnb6@dtor-ws>
References: <1516829163-27534-1-git-send-email-nick@shmanahar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46128 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932474AbeAXVrJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 24 Jan 2018 16:47:09 -0500
Received: by mail-pf0-f196.google.com with SMTP id y5so4160460pff.13
        for <linux-input@vger.kernel.org>; Wed, 24 Jan 2018 13:47:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1516829163-27534-1-git-send-email-nick@shmanahar.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-input@vger.kernel.org, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>

On Wed, Jan 24, 2018 at 09:26:03PM +0000, Nick Dyer wrote:
> Since the sysfs attribute hangs off the RMI bus, which doesn't go away during
> firmware flash, it needs to be explictly removed, otherwise we would try and
> register the same attribute twice.
> 
> This reverts commit 36a44af5c176d619552d99697433261141dd1296.
> 
> Signed-off-by: Nick Dyer <nick@shmanahar.org>

Applied, thank you.

> ---
>  drivers/input/rmi4/rmi_f01.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
> index ae966e3..8a07ae1 100644
> --- a/drivers/input/rmi4/rmi_f01.c
> +++ b/drivers/input/rmi4/rmi_f01.c
> @@ -570,14 +570,19 @@ static int rmi_f01_probe(struct rmi_function *fn)
>  
>  	dev_set_drvdata(&fn->dev, f01);
>  
> -	error = devm_device_add_group(&fn->rmi_dev->dev, &rmi_f01_attr_group);
> +	error = sysfs_create_group(&fn->rmi_dev->dev.kobj, &rmi_f01_attr_group);
>  	if (error)
> -		dev_warn(&fn->dev,
> -			 "Failed to create attribute group: %d\n", error);
> +		dev_warn(&fn->dev, "Failed to create sysfs group: %d\n", error);
>  
>  	return 0;
>  }
>  
> +static void rmi_f01_remove(struct rmi_function *fn)
> +{
> +	/* Note that the bus device is used, not the F01 device */
> +	sysfs_remove_group(&fn->rmi_dev->dev.kobj, &rmi_f01_attr_group);
> +}
> +
>  static int rmi_f01_config(struct rmi_function *fn)
>  {
>  	struct f01_data *f01 = dev_get_drvdata(&fn->dev);
> @@ -717,6 +722,7 @@ struct rmi_function_handler rmi_f01_handler = {
>  	},
>  	.func		= 0x01,
>  	.probe		= rmi_f01_probe,
> +	.remove		= rmi_f01_remove,
>  	.config		= rmi_f01_config,
>  	.attention	= rmi_f01_attention,
>  	.suspend	= rmi_f01_suspend,
> -- 
> 2.7.4
> 

-- 
Dmitry
