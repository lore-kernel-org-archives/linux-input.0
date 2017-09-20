From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: adxl34x - add support for adxl343
Date: Wed, 20 Sep 2017 12:12:44 -0700
Message-ID: <20170920191244.GA6770@dtor-ws>
References: <20170916110517.31972-1-steven@joruk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38584 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751773AbdITTMs (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 20 Sep 2017 15:12:48 -0400
Received: by mail-pf0-f196.google.com with SMTP id a7so1538745pfj.5
        for <linux-input@vger.kernel.org>; Wed, 20 Sep 2017 12:12:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170916110517.31972-1-steven@joruk.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Steven Joruk <steven@joruk.com>
Cc: michael.hennerich@analog.com, linux-input@vger.kernel.org

On Sat, Sep 16, 2017 at 12:05:17PM +0100, Steven Joruk wrote:
> The 343 has identical behaviour to the 345, other than having a
> different ID.
> 
> Signed-off-by: Steven Joruk <steven@joruk.com>

Applied, thank you.

> ---
>  drivers/input/misc/adxl34x.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/input/misc/adxl34x.c b/drivers/input/misc/adxl34x.c
> index 2b2d02f408bb..fe76878c5c76 100644
> --- a/drivers/input/misc/adxl34x.c
> +++ b/drivers/input/misc/adxl34x.c
> @@ -57,6 +57,7 @@
>  #define ORIENT		0x3C	/* R   Orientation status */
>  
>  /* DEVIDs */
> +#define ID_ADXL343	0xFB
>  #define ID_ADXL345	0xE5
>  #define ID_ADXL346	0xE6
>  
> @@ -734,6 +735,9 @@ struct adxl34x *adxl34x_probe(struct device *dev, int irq,
>  	revid = AC_READ(ac, DEVID);
>  
>  	switch (revid) {
> +	case ID_ADXL343:
> +		ac->model = 343;
> +		break;
>  	case ID_ADXL345:
>  		ac->model = 345;
>  		break;
> -- 
> 2.14.1
> 

-- 
Dmitry
