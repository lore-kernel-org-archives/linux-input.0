From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: twl6040-vibra - use devm functions
Date: Fri, 25 Apr 2014 09:41:24 -0700
Message-ID: <20140425164124.GB12355@core.coreip.homeip.net>
References: <1398436708-3903-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:62187 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196AbaDYQl2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Apr 2014 12:41:28 -0400
Received: by mail-pd0-f171.google.com with SMTP id r10so3333441pdi.30
        for <linux-input@vger.kernel.org>; Fri, 25 Apr 2014 09:41:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398436708-3903-1-git-send-email-festevam@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: peter.ujfalusi@ti.com, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

Hi Fabio,

On Fri, Apr 25, 2014 at 11:38:28AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Using devm_regulator_bulk_get() and devm_input_allocate_device() can make the
> code cleaner and smaller as we do not need to call regulator_bulk_free() in the
> error and remove paths.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - Also use devm_input_allocate_device()
> 
>  drivers/input/misc/twl6040-vibra.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
> index 77dc23b..76aa602 100644
> --- a/drivers/input/misc/twl6040-vibra.c
> +++ b/drivers/input/misc/twl6040-vibra.c
> @@ -323,8 +323,9 @@ static int twl6040_vibra_probe(struct platform_device *pdev)
>  	 * When booted with Device tree the regulators are attached to the
>  	 * parent device (twl6040 MFD core)
>  	 */
> -	ret = regulator_bulk_get(twl6040_core_dev, ARRAY_SIZE(info->supplies),
> -				 info->supplies);
> +	ret = devm_regulator_bulk_get(twl6040_core_dev,
> +				      ARRAY_SIZE(info->supplies),
> +				      info->supplies);
>  	if (ret) {
>  		dev_err(info->dev, "couldn't get regulators %d\n", ret);
>  		return ret;
> @@ -336,7 +337,7 @@ static int twl6040_vibra_probe(struct platform_device *pdev)
>  		if (ret) {
>  			dev_err(info->dev, "failed to set VDDVIBL volt %d\n",
>  				ret);
> -			goto err_regulator;
> +			return ret;
>  		}
>  	}
>  
> @@ -346,17 +347,16 @@ static int twl6040_vibra_probe(struct platform_device *pdev)
>  		if (ret) {
>  			dev_err(info->dev, "failed to set VDDVIBR volt %d\n",
>  				ret);
> -			goto err_regulator;
> +			return ret;
>  		}
>  	}
>  
>  	INIT_WORK(&info->play_work, vibra_play_work);
>  
> -	info->input_dev = input_allocate_device();
> +	info->input_dev = devm_input_allocate_device(&pdev->dev);
>  	if (info->input_dev == NULL) {
>  		dev_err(info->dev, "couldn't allocate input device\n");
> -		ret = -ENOMEM;
> -		goto err_regulator;
> +		return -ENOMEM;
>  	}
>  
>  	input_set_drvdata(info->input_dev, info);
> @@ -370,7 +370,7 @@ static int twl6040_vibra_probe(struct platform_device *pdev)
>  	ret = input_ff_create_memless(info->input_dev, NULL, vibra_play);
>  	if (ret < 0) {
>  		dev_err(info->dev, "couldn't register vibrator to FF\n");
> -		goto err_ialloc;
> +		return ret;
>  	}
>  
>  	ret = input_register_device(info->input_dev);
> @@ -385,10 +385,6 @@ static int twl6040_vibra_probe(struct platform_device *pdev)
>  
>  err_iff:
>  	input_ff_destroy(info->input_dev);

This is not strictly needed (input_dev_release will clean it up
automatically).

> -err_ialloc:
> -	input_free_device(info->input_dev);
> -err_regulator:
> -	regulator_bulk_free(ARRAY_SIZE(info->supplies), info->supplies);
>  	return ret;
>  }
>  
> @@ -397,7 +393,6 @@ static int twl6040_vibra_remove(struct platform_device *pdev)
>  	struct vibra_info *info = platform_get_drvdata(pdev);
>  
>  	input_unregister_device(info->input_dev);

You do not need to call input_unregister_device() for managed input
devices.

I edited the patch a bit and applied it.

Thanks.

-- 
Dmitry
