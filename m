From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: s3c2410_ts: Make s3c_ts_pmops const
Date: Fri, 31 Aug 2012 07:51:10 -0700
Message-ID: <20120831145109.GB26858@core.coreip.homeip.net>
References: <1346406437-19213-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60558 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753710Ab2HaOvO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Aug 2012 10:51:14 -0400
Received: by pbbrr13 with SMTP id rr13so4964271pbb.19
        for <linux-input@vger.kernel.org>; Fri, 31 Aug 2012 07:51:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1346406437-19213-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-input@vger.kernel.org, patches@linaro.org

On Fri, Aug 31, 2012 at 03:17:17PM +0530, Sachin Kamat wrote:
> Fixes the following warning:
> WARNING: struct dev_pm_ops should normally be const
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Applied, thanks Sachin.

> ---
>  drivers/input/touchscreen/s3c2410_ts.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
> index bf1a064..b3c66d4 100644
> --- a/drivers/input/touchscreen/s3c2410_ts.c
> +++ b/drivers/input/touchscreen/s3c2410_ts.c
> @@ -406,7 +406,7 @@ static int s3c2410ts_resume(struct device *dev)
>  	return 0;
>  }
>  
> -static struct dev_pm_ops s3c_ts_pmops = {
> +static const struct dev_pm_ops s3c_ts_pmops = {
>  	.suspend	= s3c2410ts_suspend,
>  	.resume		= s3c2410ts_resume,
>  };
> -- 
> 1.7.4.1
> 

-- 
Dmitry
