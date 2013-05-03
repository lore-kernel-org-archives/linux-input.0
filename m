From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Subject: Re: [PATCH 3/3] Input: gpio_mouse - Remove redundant
 platform_set_drvdata()
Date: Fri, 3 May 2013 13:27:13 +0200
Message-ID: <20130503112713.GC17780@samfundet.no>
References: <1367577742-14712-1-git-send-email-sachin.kamat@linaro.org>
 <1367577742-14712-3-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassarossa.samfundet.no ([193.35.52.29]:55310 "EHLO
	cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762139Ab3ECL1O (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 May 2013 07:27:14 -0400
Content-Disposition: inline
In-Reply-To: <1367577742-14712-3-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

Around Fri 03 May 2013 16:12:22 +0530 or thereabout, Sachin Kamat wrote:
> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

> ---
>  drivers/input/mouse/gpio_mouse.c |    3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/input/mouse/gpio_mouse.c b/drivers/input/mouse/gpio_mouse.c
> index 532eaca..6b44413 100644
> --- a/drivers/input/mouse/gpio_mouse.c
> +++ b/drivers/input/mouse/gpio_mouse.c
> @@ -138,7 +138,6 @@ static int gpio_mouse_probe(struct platform_device *pdev)
>  
>   out_free_polldev:
>  	input_free_polled_device(input_poll);
> -	platform_set_drvdata(pdev, NULL);
>  
>   out_free_gpios:
>  	while (--i >= 0) {
> @@ -165,8 +164,6 @@ static int gpio_mouse_remove(struct platform_device *pdev)
>  			gpio_free(pin);
>  	}
>  
> -	platform_set_drvdata(pdev, NULL);
> -
>  	return 0;
>  }
>  
-- 
mvh
Hans-Christian Egtvedt
