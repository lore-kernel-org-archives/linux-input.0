From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH RESEND] hid:Change vendor id for USB_DEVICE_ID_MS_TYPE_COVER_3
 to correct id in hid-ids.h
Date: Fri, 15 May 2015 12:47:44 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1505151247130.8186@pobox.suse.cz>
References: <1431666292-27622-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49402 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752739AbbEOKrq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 15 May 2015 06:47:46 -0400
In-Reply-To: <1431666292-27622-1-git-send-email-xerofoify@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nicholas Krause <xerofoify@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 15 May 2015, Nicholas Krause wrote:

> This fixes the bug,https://bugzilla.kernel.org/show_bug.cgi?id=97951 
> related to incorrecting using 0x07dc for the vendor id for 
> USB_DEVICE_ID_MS_TYPE_COVER_3 devices and instead changing in 
> to the correct vendor id of 0x07de.
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  drivers/hid/hid-ids.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 41f167e..2e51947 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -670,7 +670,7 @@
>  #define USB_DEVICE_ID_MS_SURFACE_PRO_2   0x0799
>  #define USB_DEVICE_ID_MS_TOUCH_COVER_2   0x07a7
>  #define USB_DEVICE_ID_MS_TYPE_COVER_2    0x07a9
> -#define USB_DEVICE_ID_MS_TYPE_COVER_3    0x07dc
> +#define USB_DEVICE_ID_MS_TYPE_COVER_3    0x07de
>  #define USB_DEVICE_ID_MS_TYPE_COVER_3_JP 0x07dd
>  
>  #define USB_VENDOR_ID_MOJO		0x8282

Why are you resending this without reacting to my original response to 
your mail?

	http://lkml.iu.edu/hypermail/linux/kernel/1505.1/01419.html

-- 
Jiri Kosina
SUSE Labs
