From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: trivial: fix typo in Kconfig help
Date: Mon, 12 May 2014 10:59:28 -0700
Message-ID: <20140512175928.GC16764@core.coreip.homeip.net>
References: <1399911842-28081-1-git-send-email-dforsi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:46793 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbaELR7b (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 May 2014 13:59:31 -0400
Received: by mail-pa0-f52.google.com with SMTP id fa1so4950790pad.25
        for <linux-input@vger.kernel.org>; Mon, 12 May 2014 10:59:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1399911842-28081-1-git-send-email-dforsi@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniele Forsi <dforsi@gmail.com>
Cc: Jiri Kosina <trivial@kernel.org>, linux-input@vger.kernel.org

On Mon, May 12, 2014 at 06:24:02PM +0200, Daniele Forsi wrote:
> s/Logictech/Logitech/
> 
> CC: Jiri Kosina <trivial@kernel.org>
> Signed-off-by: Daniele Forsi <dforsi@gmail.com>

Applied, thank you.

> ---
>  drivers/input/mouse/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
> index effa9c5..ff9b65d 100644
> --- a/drivers/input/mouse/Kconfig
> +++ b/drivers/input/mouse/Kconfig
> @@ -53,7 +53,7 @@ config MOUSE_PS2_LOGIPS2PP
>  	default y
>  	depends on MOUSE_PS2
>  	help
> -	  Say Y here if you have a Logictech PS/2++ mouse connected to
> +	  Say Y here if you have a Logitech PS/2++ mouse connected to
>  	  your system.
>  
>  	  If unsure, say Y.
> -- 
> 2.0.0.rc0
> 

-- 
Dmitry
