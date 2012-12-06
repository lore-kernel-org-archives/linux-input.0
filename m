From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 1/3] input: increase struct ps2dev cmdbuf[] to 8 bytes
Date: Wed, 5 Dec 2012 23:51:56 -0800
Message-ID: <20121206075156.GA25921@core.coreip.homeip.net>
References: <1354752976-27257-1-git-send-email-kamal@canonical.com>
 <1354752976-27257-2-git-send-email-kamal@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:56563 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209Ab2LFHwA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Dec 2012 02:52:00 -0500
Content-Disposition: inline
In-Reply-To: <1354752976-27257-2-git-send-email-kamal@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kamal Mostafa <kamal@canonical.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>, Dudley Du <dudl@cypress.com>, David Solda <dso@cypress.com>, Troy Abercrombia <ta@cypress.com>, Kyle Fazzari <git@status.e4ward.com>, Mario Limonciello <mario_limonciello@dell.com>, Tim Gardner <tim.gardner@canonical.com>, Herton Krzesinski <herton.krzesinski@canonical.com>

Hi Kamal,

On Wed, Dec 05, 2012 at 04:16:14PM -0800, Kamal Mostafa wrote:
> Cypress PS/2 Trackpad (drivers/input/mouse/cypress_ps2.c) needs
> this larger cmdbuf[] to handle 8-byte packet responses.
> 
> Signed-off-by: Kamal Mostafa <kamal@canonical.com>

I will apply this patch so you do not need to resend it with cypress_ps2
patches.

Thanks!

> ---
>  include/linux/libps2.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/libps2.h b/include/linux/libps2.h
> index 79603a6..4ad06e8 100644
> --- a/include/linux/libps2.h
> +++ b/include/linux/libps2.h
> @@ -36,7 +36,7 @@ struct ps2dev {
>  	wait_queue_head_t wait;
>  
>  	unsigned long flags;
> -	unsigned char cmdbuf[6];
> +	unsigned char cmdbuf[8];
>  	unsigned char cmdcnt;
>  	unsigned char nak;
>  };
> -- 
> 1.7.10.4
> 

-- 
Dmitry
