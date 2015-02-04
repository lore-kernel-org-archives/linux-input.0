From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 2/3] bfin_rotary: Move peripheral pinmux definition
 into platform data of bf527
Date: Wed, 4 Feb 2015 11:44:42 -0800
Message-ID: <20150204194442.GB15782@dtor-ws>
References: <1423036686-31891-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:58040 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932986AbbBDTor (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Feb 2015 14:44:47 -0500
Received: by mail-ie0-f169.google.com with SMTP id rl12so4778017iec.0
        for <linux-input@vger.kernel.org>; Wed, 04 Feb 2015 11:44:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1423036686-31891-1-git-send-email-sonic.adi@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sonic Zhang <sonic.adi@gmail.com>
Cc: linux-input@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>, adi-buildroot-devel@lists.sourceforge.net, Sonic Zhang <sonic.zhang@analog.com>

Hi Sonic,

On Wed, Feb 04, 2015 at 03:58:04PM +0800, Sonic Zhang wrote:
> @@ -102,7 +95,7 @@ static int bfin_rotary_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	error = peripheral_request_list(per_cnt, dev_name(&pdev->dev));
> +	error = peripheral_request_list(pdata->pin_list, dev_name(&pdev->dev));

I do not think the driver will be happy with pdata->oin_list == NULL
here.

>  	if (error) {
>  		dev_err(&pdev->dev, "requesting peripherals failed\n");
>  		return error;
> @@ -197,6 +190,7 @@ out1:
>  
>  static int bfin_rotary_remove(struct platform_device *pdev)
>  {
> +	struct bfin_rotary_platform_data *pdata = dev_get_platdata(&pdev->dev);

Why do you need this change?

>  	struct bfin_rot *rotary = platform_get_drvdata(pdev);
>  
>  	bfin_write_CNT_CONFIG(0);
> @@ -204,7 +198,7 @@ static int bfin_rotary_remove(struct platform_device *pdev)
>  
>  	free_irq(rotary->irq, pdev);
>  	input_unregister_device(rotary->input);
> -	peripheral_free_list(per_cnt);
> +	peripheral_free_list(pdata->pin_list);

Same here: NULL will cause severe indigestion.

Thanks.

-- 
Dmitry
