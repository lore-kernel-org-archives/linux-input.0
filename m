From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Driver drv260x.c - fix bug of adding wrong device
 parent
Date: Mon, 12 Dec 2016 14:05:00 -0800
Message-ID: <20161212220500.GA27357@dtor-ws>
References: <1481578627-56391-1-git-send-email-jkwang@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33346 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932322AbcLLWFE (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 12 Dec 2016 17:05:04 -0500
Received: by mail-pg0-f67.google.com with SMTP id 3so2210882pgd.0
        for <linux-input@vger.kernel.org>; Mon, 12 Dec 2016 14:05:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1481578627-56391-1-git-send-email-jkwang@google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jingkui Wang <jkwang@google.com>
Cc: linux-input@vger.kernel.org, Dan Murphy <dmurphy@ti.com>

On Mon, Dec 12, 2016 at 01:37:07PM -0800, Jingkui Wang wrote:
> Fix the bug of adding wrong parent to the input_dev created by the
> driver. The bug will be triggered if rmmod is called for this driver
> module.
> 
> Signed-off-by: Jingkui Wang <jkwang@google.com>

Applied and marked for stable, thank you.

> ---
>  drivers/input/misc/drv260x.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
> index 4f448ba..885c140 100644
> --- a/drivers/input/misc/drv260x.c
> +++ b/drivers/input/misc/drv260x.c
> @@ -565,7 +565,6 @@ static int drv260x_probe(struct i2c_client *client,
>  	}
>  
>  	haptics->input_dev->name = "drv260x:haptics";
> -	haptics->input_dev->dev.parent = client->dev.parent;
>  	haptics->input_dev->close = drv260x_close;
>  	input_set_drvdata(haptics->input_dev, haptics);
>  	input_set_capability(haptics->input_dev, EV_FF, FF_RUMBLE);
> -- 
> 2.6.6
> 

-- 
Dmitry
