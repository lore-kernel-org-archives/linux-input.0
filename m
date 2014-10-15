From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] Input: misc: max77693-haptic - fix active state check in
 disable()
Date: Wed, 15 Oct 2014 13:17:47 +0900
Message-ID: <543DF56B.2080009@samsung.com>
References: <1413342978-30349-1-git-send-email-jaewon02.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:22317 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbaJOERv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Oct 2014 00:17:51 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NDG0021RX9P8GB0@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Wed, 15 Oct 2014 13:17:49 +0900 (KST)
In-reply-to: <1413342978-30349-1-git-send-email-jaewon02.kim@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaewon Kim <jaewon02.kim@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hi Jaewon,

I think you better to use ':' instead of '-'.
- before: Input: misc: max77693-haptic - 
- after : Input: misc: max77693-haptic: 

On 10/15/2014 12:16 PM, Jaewon Kim wrote:
> In order to avoid duplicated execution, max77693_haptic_disable()
> check disable state. But it was reversed. this patch fix it.
> 
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> ---
>  drivers/input/misc/max77693-haptic.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/max77693-haptic.c b/drivers/input/misc/max77693-haptic.c
> index d605db4..7b1fde9 100644
> --- a/drivers/input/misc/max77693-haptic.c
> +++ b/drivers/input/misc/max77693-haptic.c
> @@ -152,7 +152,7 @@ static void max77693_haptic_disable(struct max77693_haptic *haptic)
>  {
>  	int error;
>  
> -	if (haptic->enabled)
> +	if (!haptic->enabled)
>  		return;
>  
>  	error = max77693_haptic_configure(haptic, false);
> 

If you modify patch name, Looks good to me.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi
