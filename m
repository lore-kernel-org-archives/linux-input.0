From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] joystick/zhenhua: remove zhenhua_bitreverse()
Date: Thu, 20 Aug 2015 17:43:07 -0700
Message-ID: <20150821004307.GB24710@localhost>
References: <A2697706-7925-4923-B024-3E6F01117AF2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34495 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753162AbbHUAnN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Aug 2015 20:43:13 -0400
Content-Disposition: inline
In-Reply-To: <A2697706-7925-4923-B024-3E6F01117AF2@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: yalin wang <yalin.wang2010@gmail.com>
Cc: linux-input@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On Tue, Aug 11, 2015 at 01:49:34PM +0800, yalin wang wrote:
> This change remove zhenhua_bitreverse() function, use generic
> bitrev8() function instead.
> 
> Signed-off-by: yalin wang <yalin.wang2010@gmail.com>

Applied, thank you.

> ---
>  drivers/input/joystick/zhenhua.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/input/joystick/zhenhua.c b/drivers/input/joystick/zhenhua.c
> index 30af2e8..4a8258b 100644
> --- a/drivers/input/joystick/zhenhua.c
> +++ b/drivers/input/joystick/zhenhua.c
> @@ -47,6 +47,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> +#include <linux/bitrev.h>
>  #include <linux/input.h>
>  #include <linux/serio.h>
>  
> @@ -72,16 +73,6 @@ struct zhenhua {
>  	char phys[32];
>  };
>  
> -
> -/* bits in all incoming bytes needs to be "reversed" */
> -static int zhenhua_bitreverse(int x)
> -{
> -	x = ((x & 0xaa) >> 1) | ((x & 0x55) << 1);
> -	x = ((x & 0xcc) >> 2) | ((x & 0x33) << 2);
> -	x = ((x & 0xf0) >> 4) | ((x & 0x0f) << 4);
> -	return x;
> -}
> -
>  /*
>   * zhenhua_process_packet() decodes packets the driver receives from the
>   * RC transmitter. It updates the data accordingly.
> @@ -120,7 +111,7 @@ static irqreturn_t zhenhua_interrupt(struct serio *serio, unsigned char data, un
>  		return IRQ_HANDLED;	/* wrong MSB -- ignore this byte */
>  
>  	if (zhenhua->idx < ZHENHUA_MAX_LENGTH)
> -		zhenhua->data[zhenhua->idx++] = zhenhua_bitreverse(data);
> +		zhenhua->data[zhenhua->idx++] = bitrev8(data);
>  
>  	if (zhenhua->idx == ZHENHUA_MAX_LENGTH) {
>  		zhenhua_process_packet(zhenhua);
> -- 
> 1.9.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Dmitry
