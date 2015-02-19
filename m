From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH]  Input: pwm-beeper - Use devm functions
Date: Thu, 19 Feb 2015 09:12:39 -0800
Message-ID: <20150219171239.GA11113@dtor-glaptop>
References: <1424345162-17260-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:34451 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbbBSRMn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Feb 2015 12:12:43 -0500
Received: by pdjg10 with SMTP id g10so1106271pdj.1
        for <linux-input@vger.kernel.org>; Thu, 19 Feb 2015 09:12:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1424345162-17260-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: linux-input@vger.kernel.org, lars@metafoo.de

Hi Fabio,

On Thu, Feb 19, 2015 at 09:26:02AM -0200, Fabio Estevam wrote:
> By using devm functions the code can be simplified a bit.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/input/misc/pwm-beeper.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
> index a28ee70..c5ccaee 100644
> --- a/drivers/input/misc/pwm-beeper.c
> +++ b/drivers/input/misc/pwm-beeper.c
> @@ -72,11 +72,11 @@ static int pwm_beeper_probe(struct platform_device *pdev)
>  	struct pwm_beeper *beeper;
>  	int error;
>  
> -	beeper = kzalloc(sizeof(*beeper), GFP_KERNEL);
> +	beeper = devm_kzalloc(&pdev->dev, sizeof(*beeper), GFP_KERNEL);
>  	if (!beeper)
>  		return -ENOMEM;
>  
> -	beeper->pwm = pwm_get(&pdev->dev, NULL);
> +	beeper->pwm = devm_pwm_get(&pdev->dev, NULL);
>  	if (IS_ERR(beeper->pwm)) {
>  		dev_dbg(&pdev->dev, "unable to request PWM, trying legacy API\n");
>  		beeper->pwm = pwm_request(pwm_id, "pwm beeper");

This is not managed resource anymore, what will free it?

> @@ -85,14 +85,13 @@ static int pwm_beeper_probe(struct platform_device *pdev)
>  	if (IS_ERR(beeper->pwm)) {
>  		error = PTR_ERR(beeper->pwm);
>  		dev_err(&pdev->dev, "Failed to request pwm device: %d\n", error);
> -		goto err_free;
> +		return error;
>  	}
>  
> -	beeper->input = input_allocate_device();
> +	beeper->input = devm_input_allocate_device(&pdev->dev);
>  	if (!beeper->input) {
>  		dev_err(&pdev->dev, "Failed to allocate input device\n");
> -		error = -ENOMEM;
> -		goto err_pwm_free;
> +		return -ENOMEM;
>  	}
>  	beeper->input->dev.parent = &pdev->dev;
>  
> @@ -122,10 +121,6 @@ static int pwm_beeper_probe(struct platform_device *pdev)
>  
>  err_input_free:
>  	input_free_device(beeper->input);
> -err_pwm_free:
> -	pwm_free(beeper->pwm);
> -err_free:
> -	kfree(beeper);
>  
>  	return error;
>  }
> @@ -137,9 +132,6 @@ static int pwm_beeper_remove(struct platform_device *pdev)
>  	input_unregister_device(beeper->input);
>  
>  	pwm_disable(beeper->pwm);

If you solve the issue above, then if you move pwm_disable() into new
pwm_beeper_close() then you can get rid of pwm_beeper_remove() altogether.

> -	pwm_free(beeper->pwm);
> -
> -	kfree(beeper);
>  
>  	return 0;
>  }
> -- 
> 1.9.1
> 

Thanks.

-- 
Dmitry
