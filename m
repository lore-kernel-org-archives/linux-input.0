From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: adxl34x - avoid int-in-bool-context warning
Date: Wed, 20 Sep 2017 12:13:39 -0700
Message-ID: <20170920191339.GB6770@dtor-ws>
References: <20170918154357.2949-1-steven@joruk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33171 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751572AbdITTNm (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 20 Sep 2017 15:13:42 -0400
Received: by mail-pg0-f65.google.com with SMTP id i130so2134208pgc.0
        for <linux-input@vger.kernel.org>; Wed, 20 Sep 2017 12:13:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170918154357.2949-1-steven@joruk.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Steven Joruk <steven@joruk.com>
Cc: michael.hennerich@analog.com, linux-input@vger.kernel.org

On Mon, Sep 18, 2017 at 04:43:57PM +0100, Steven Joruk wrote:
> The code is fine, but make it clear to the compiler.
> 
> drivers/input/misc/adxl34x.c:134:35: warning: ‘<<’ in boolean context
> 
> Signed-off-by: Steven Joruk <steven@joruk.com>
> ---
>  drivers/input/misc/adxl34x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/adxl34x.c b/drivers/input/misc/adxl34x.c
> index 2b2d02f408bb..e0caaa0de454 100644
> --- a/drivers/input/misc/adxl34x.c
> +++ b/drivers/input/misc/adxl34x.c
> @@ -796,7 +796,7 @@ struct adxl34x *adxl34x_probe(struct device *dev, int irq,
>  
>  	if (pdata->watermark) {
>  		ac->int_mask |= WATERMARK;
> -		if (!FIFO_MODE(pdata->fifo_mode))
> +		if (FIFO_MODE(pdata->fifo_mode) == 0)

This has been NAKed before:

https://www.spinics.net/lists/linux-ide/msg54485.html

I'll pick up the V2 from Arnd that is better.

>  			ac->pdata.fifo_mode |= FIFO_STREAM;
>  	} else {
>  		ac->int_mask |= DATA_READY;
> -- 
> 2.14.1
> 

Thanks.

-- 
Dmitry
