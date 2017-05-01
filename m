From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2 v2] input: touchscreen: ar1021_i2c: use BIT to check
 for a bit
Date: Mon, 1 May 2017 12:39:17 -0700
Message-ID: <20170501193917.GC34444@dtor-ws>
References: <1493295756-17812-2-git-send-email-martin.kepplinger@ginzinger.com>
 <20170430193853.10958-1-martink@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33705 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbdEATjU (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 1 May 2017 15:39:20 -0400
Content-Disposition: inline
In-Reply-To: <20170430193853.10958-1-martink@posteo.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Martin Kepplinger <martink@posteo.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Apr 30, 2017 at 09:38:53PM +0200, Martin Kepplinger wrote:
> The MSB for the first byte of touch data transmission is always 1. Make
> it a little more obvious we're testing this bit by using BIT(7).
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>

Applied, thank you.

> ---
> 
> I'd still use the definition :) but otherwise I'd write the following.
> It really doesn't matter though.
> 
> thanks for the quick support Dmitry,
> 
>                     martin
> 
> 
>  drivers/input/touchscreen/ar1021_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/ar1021_i2c.c b/drivers/input/touchscreen/ar1021_i2c.c
> index eb1874fe52c2..8c76aa435903 100644
> --- a/drivers/input/touchscreen/ar1021_i2c.c
> +++ b/drivers/input/touchscreen/ar1021_i2c.c
> @@ -44,7 +44,7 @@ static irqreturn_t ar1021_i2c_irq(int irq, void *dev_id)
>  		goto out;
>  
>  	/* sync bit set ? */
> -	if ((data[0] & 0x80) == 0)
> +	if (!(data[0] & BIT(7)))
>  		goto out;
>  
>  	button = data[0] & BIT(0);
> -- 
> 2.11.0
> 

-- 
Dmitry
