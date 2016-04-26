From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: byd: don't wipe dynamically allocated memory twice
Date: Tue, 26 Apr 2016 09:50:47 -0700
Message-ID: <20160426165047.GC30010@dtor-ws>
References: <1461268697-30735-1-git-send-email-vz@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34229 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661AbcDZQuu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Apr 2016 12:50:50 -0400
Received: by mail-pf0-f170.google.com with SMTP id y69so8984288pfb.1
        for <linux-input@vger.kernel.org>; Tue, 26 Apr 2016 09:50:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1461268697-30735-1-git-send-email-vz@mleia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Richard Pospesel <pospeselr@gmail.com>, Chris Diamand <chris@diamand.org>, linux-input@vger.kernel.org

On Thu, Apr 21, 2016 at 10:58:17PM +0300, Vladimir Zapolskiy wrote:
> Since memory for a private data is allocated by kzalloc() there is no
> need to fill it with zeroes immediately after the allocation.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>

Applied, thank you.

> ---
>  drivers/input/mouse/byd.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/byd.c b/drivers/input/mouse/byd.c
> index fdc243c..ec73f75 100644
> --- a/drivers/input/mouse/byd.c
> +++ b/drivers/input/mouse/byd.c
> @@ -473,9 +473,8 @@ int byd_init(struct psmouse *psmouse)
>  	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	memset(priv, 0, sizeof(*priv));
>  	setup_timer(&priv->timer, byd_clear_touch, (unsigned long) psmouse);
>  
>  	psmouse->private = priv;
>  	psmouse->disconnect = byd_disconnect;
> -- 
> 2.1.4
> 

-- 
Dmitry
