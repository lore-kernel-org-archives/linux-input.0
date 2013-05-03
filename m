From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Subject: Re: [PATCH 2/9] Input: atmel-wm97xx - Remove redundant
 platform_set_drvdata()
Date: Fri, 3 May 2013 13:25:51 +0200
Message-ID: <20130503112551.GA17780@samfundet.no>
References: <1367576922-31459-1-git-send-email-sachin.kamat@linaro.org>
 <1367576922-31459-2-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassarossa.samfundet.no ([193.35.52.29]:55791 "EHLO
	cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753960Ab3ECLZy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 May 2013 07:25:54 -0400
Content-Disposition: inline
In-Reply-To: <1367576922-31459-2-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Mark Brown <broonie@kernel.org>

Around Fri 03 May 2013 15:58:35 +0530 or thereabout, Sachin Kamat wrote:
> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
> Cc: Mark Brown <broonie@kernel.org>

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

> ---
>  drivers/input/touchscreen/atmel-wm97xx.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/atmel-wm97xx.c b/drivers/input/touchscreen/atmel-wm97xx.c
> index 2c1e46b..268a35e 100644
> --- a/drivers/input/touchscreen/atmel-wm97xx.c
> +++ b/drivers/input/touchscreen/atmel-wm97xx.c
> @@ -372,7 +372,6 @@ static int __init atmel_wm97xx_probe(struct platform_device *pdev)
>  err_irq:
>  	free_irq(atmel_wm97xx->ac97c_irq, atmel_wm97xx);
>  err:
> -	platform_set_drvdata(pdev, NULL);
>  	kfree(atmel_wm97xx);
>  	return ret;
>  }
> @@ -386,7 +385,6 @@ static int __exit atmel_wm97xx_remove(struct platform_device *pdev)
>  	free_irq(atmel_wm97xx->ac97c_irq, atmel_wm97xx);
>  	del_timer_sync(&atmel_wm97xx->pen_timer);
>  	wm97xx_unregister_mach_ops(wm);
> -	platform_set_drvdata(pdev, NULL);
>  	kfree(atmel_wm97xx);
>  
>  	return 0;
-- 
mvh
Hans-Christian Egtvedt
