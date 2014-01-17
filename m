From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: wacom - Fix wacom->shared guards for dual input
 devices
Date: Thu, 16 Jan 2014 16:28:58 -0800
Message-ID: <20140117002858.GC837@core.coreip.homeip.net>
References: <1389823457-3649-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:38137 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722AbaAQA3B (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jan 2014 19:29:01 -0500
Received: by mail-pb0-f52.google.com with SMTP id jt11so1306665pbb.11
        for <linux-input@vger.kernel.org>; Thu, 16 Jan 2014 16:29:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1389823457-3649-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Wed, Jan 15, 2014 at 02:04:17PM -0800, Ping Cheng wrote:
> features->quirks can have multiple bits set. For dual input, we only
> need to check WACOM_QUIRK_MULTI_INPUT.
> 
> Reviewed-by: Jason Gerecke <killertofu@gmail.com>
> Signed-off-by: Ping Cheng <pingc@wacom.com>

Applied, thank you.

> ---
>  drivers/input/tablet/wacom_wac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
> index 048e5b3..0bcc7a6 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -331,7 +331,7 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
>  
>  	/* Enter report */
>  	if ((data[1] & 0xfc) == 0xc0) {
> -		if (features->quirks == WACOM_QUIRK_MULTI_INPUT)
> +		if (features->quirks & WACOM_QUIRK_MULTI_INPUT)
>  			wacom->shared->stylus_in_proximity = true;
>  
>  		/* serial number of the tool */
> @@ -436,7 +436,7 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
>  
>  	/* Exit report */
>  	if ((data[1] & 0xfe) == 0x80) {
> -		if (features->quirks == WACOM_QUIRK_MULTI_INPUT)
> +		if (features->quirks & WACOM_QUIRK_MULTI_INPUT)
>  			wacom->shared->stylus_in_proximity = false;
>  
>  		/*
> -- 
> 1.8.3.2
> 

-- 
Dmitry
