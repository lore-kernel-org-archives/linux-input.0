From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/4] input: sirfsoc-onkey - use dev_get_drvdata instead
 of platform_get_drvdata
Date: Wed, 12 Feb 2014 23:24:59 -0800
Message-ID: <20140213072459.GB23392@core.coreip.homeip.net>
References: <1392273624-22920-1-git-send-email-21cnbao@gmail.com>
 <1392273624-22920-4-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:43046 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbaBMHZC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Feb 2014 02:25:02 -0500
Received: by mail-pa0-f45.google.com with SMTP id lf10so10379472pab.4
        for <linux-input@vger.kernel.org>; Wed, 12 Feb 2014 23:25:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1392273624-22920-4-git-send-email-21cnbao@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: linux-input@vger.kernel.org, workgroup.linux@csr.com, Xianglong Du <Xianglong.Du@csr.com>, Barry Song <Baohua.Song@csr.com>

On Thu, Feb 13, 2014 at 02:40:23PM +0800, Barry Song wrote:
> From: Xianglong Du <Xianglong.Du@csr.com>
> 
> In resume entry, use dev_get_drvdata() instead of to_platform_device(dev) +
> platform_get_drvdata(pdev).
> 
> Signed-off-by: Xianglong Du <Xianglong.Du@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  drivers/input/misc/sirfsoc-onkey.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/misc/sirfsoc-onkey.c b/drivers/input/misc/sirfsoc-onkey.c
> index 097c10a..8e45bf11 100644
> --- a/drivers/input/misc/sirfsoc-onkey.c
> +++ b/drivers/input/misc/sirfsoc-onkey.c
> @@ -157,8 +157,7 @@ static int sirfsoc_pwrc_remove(struct platform_device *pdev)
>  #ifdef CONFIG_PM_SLEEP
>  static int sirfsoc_pwrc_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct sirfsoc_pwrc_drvdata *pwrcdrv = platform_get_drvdata(pdev);
> +	struct sirfsoc_pwrc_drvdata *pwrcdrv = dev_get_drvdata(dev);

I believe we should use accessors matching the object type. Currently
dev_get_drvdata and platform_get_drvdata return the same object, but
they do not have to.

IOW I prefer the original code.

Thanks.

-- 
Dmitry
