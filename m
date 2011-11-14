From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH 1/6] Input: ucb1400_ts - convert to use dev_pm_ops
Date: Mon, 14 Nov 2011 11:39:17 +0100
Message-ID: <201111141139.17997.marek.vasut@gmail.com>
References: <1321259771-10925-1-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43539 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754950Ab1KNKjW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 05:39:22 -0500
Received: by fagn18 with SMTP id n18so2852947fag.19
        for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 02:39:21 -0800 (PST)
In-Reply-To: <1321259771-10925-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

> Instead of using legacy PM interfaces switch to using dev_pm_ops.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>  drivers/input/touchscreen/ucb1400_ts.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ucb1400_ts.c
> b/drivers/input/touchscreen/ucb1400_ts.c index 3b5b5df..ead7123 100644
> --- a/drivers/input/touchscreen/ucb1400_ts.c
> +++ b/drivers/input/touchscreen/ucb1400_ts.c
> @@ -428,10 +428,10 @@ static int ucb1400_ts_remove(struct platform_device
> *dev) return 0;
>  }
> 
> -#ifdef CONFIG_PM
> -static int ucb1400_ts_resume(struct platform_device *dev)
> +#ifdef CONFIG_PM_SLEEP
> +static int ucb1400_ts_resume(struct device *dev)
>  {
> -	struct ucb1400_ts *ucb = dev->dev.platform_data;
> +	struct ucb1400_ts *ucb = dev->platform_data;
> 
>  	if (ucb->ts_task) {
>  		/*
> @@ -444,16 +444,16 @@ static int ucb1400_ts_resume(struct platform_device
> *dev) }
>  	return 0;
>  }
> -#else
> -#define ucb1400_ts_resume NULL
>  #endif
> 
> +static SIMPLE_DEV_PM_OPS(ucb1400_ts_pm_ops, NULL, ucb1400_ts_resume);
> +
>  static struct platform_driver ucb1400_ts_driver = {
>  	.probe	= ucb1400_ts_probe,
>  	.remove	= ucb1400_ts_remove,
> -	.resume	= ucb1400_ts_resume,
>  	.driver	= {
>  		.name	= "ucb1400_ts",
> +		.pm	= &ucb1400_ts_pm_ops,
>  	},
>  };

Hi,

I went through the patchset, but didn't test it. Though the changes look 
reasonable. I'll have time to test this sometimes next week MAYBE, or it MIGHT 
tell someone else to test, I can't promise anything here though.

Please add to all patches my:

Reviewed-by: Marek Vasut <marek.vasut@gmail.com>
