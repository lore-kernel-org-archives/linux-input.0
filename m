From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 9/9] Input: rotary_encoder - Remove redundant platform_set_drvdata()
Date: Mon, 06 May 2013 12:12:45 +0200
Message-ID: <5187821D.8020909@gmail.com>
References: <1367679118-2980-1-git-send-email-sachin.kamat@linaro.org> <1367679118-2980-9-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50]:55825 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016Ab3EFKMd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 May 2013 06:12:33 -0400
Received: by mail-bk0-f50.google.com with SMTP id ik5so1521839bkc.37
        for <linux-input@vger.kernel.org>; Mon, 06 May 2013 03:12:31 -0700 (PDT)
In-Reply-To: <1367679118-2980-9-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Daniel Mack <daniel@caiaq.de>

On 04.05.2013 16:51, Sachin Kamat wrote:
> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Daniel Mack <daniel@caiaq.de>

Acked-by: Daniel Mack <zonque@gmail.com>

> ---
>  drivers/input/misc/rotary_encoder.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
> index aff47b2..5b1aff8 100644
> --- a/drivers/input/misc/rotary_encoder.c
> +++ b/drivers/input/misc/rotary_encoder.c
> @@ -317,8 +317,6 @@ static int rotary_encoder_remove(struct platform_device *pdev)
>  	if (!dev_get_platdata(&pdev->dev))
>  		kfree(pdata);
>  
> -	platform_set_drvdata(pdev, NULL);
> -
>  	return 0;
>  }
>  
> 

