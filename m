From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] drivers/input/misc/adxl34x: Fix bug in definition of
 ADXL346_2D_ORIENT
Date: Mon, 9 Dec 2013 22:14:00 -0800
Message-ID: <20131210061359.GB12524@core.coreip.homeip.net>
References: <1386588910-4604-1-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:35117 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab3LJGOF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Dec 2013 01:14:05 -0500
Received: by mail-pb0-f54.google.com with SMTP id un15so6908981pbc.41
        for <linux-input@vger.kernel.org>; Mon, 09 Dec 2013 22:14:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1386588910-4604-1-git-send-email-michael.hennerich@analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: michael.hennerich@analog.com
Cc: linux-input@vger.kernel.org

On Mon, Dec 09, 2013 at 12:35:10PM +0100, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Coverity report pointet out by Dmitry
> 
> Reported-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>


Applied, thank you.

> ---
>  drivers/input/misc/adxl34x.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/adxl34x.c b/drivers/input/misc/adxl34x.c
> index 0735de3..1cb1da2 100644
> --- a/drivers/input/misc/adxl34x.c
> +++ b/drivers/input/misc/adxl34x.c
> @@ -158,7 +158,7 @@
>  
>  /* ORIENT ADXL346 only */
>  #define ADXL346_2D_VALID		(1 << 6)
> -#define ADXL346_2D_ORIENT(x)		(((x) & 0x3) >> 4)
> +#define ADXL346_2D_ORIENT(x)		(((x) & 0x30) >> 4)
>  #define ADXL346_3D_VALID		(1 << 3)
>  #define ADXL346_3D_ORIENT(x)		((x) & 0x7)
>  #define ADXL346_2D_PORTRAIT_POS		0	/* +X */
> -- 
> 1.7.9.5
> 
> 

-- 
Dmitry
