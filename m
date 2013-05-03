From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Subject: Re: [PATCH 2/3] Input: at32psif - Remove redundant
 platform_set_drvdata()
Date: Fri, 3 May 2013 13:26:32 +0200
Message-ID: <20130503112632.GB17780@samfundet.no>
References: <1367577400-9527-1-git-send-email-sachin.kamat@linaro.org>
 <1367577400-9527-2-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassarossa.samfundet.no ([193.35.52.29]:43707 "EHLO
	cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763179Ab3ECL0d (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 May 2013 07:26:33 -0400
Content-Disposition: inline
In-Reply-To: <1367577400-9527-2-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

Around Fri 03 May 2013 16:06:39 +0530 or thereabout, Sachin Kamat wrote:
> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

> ---
>  drivers/input/serio/at32psif.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/input/serio/at32psif.c b/drivers/input/serio/at32psif.c
> index 190ce35..3290b28 100644
> --- a/drivers/input/serio/at32psif.c
> +++ b/drivers/input/serio/at32psif.c
> @@ -314,8 +314,6 @@ static int __exit psif_remove(struct platform_device *pdev)
>  	clk_put(psif->pclk);
>  	kfree(psif);
>  
> -	platform_set_drvdata(pdev, NULL);
> -
>  	return 0;
>  }
>  
-- 
mvh
Hans-Christian Egtvedt
