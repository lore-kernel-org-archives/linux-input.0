From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/5] HID: move pantherlord FF processing
Date: Wed, 17 Sep 2008 19:03:09 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0809171900030.19221@pegasus.suse.cz>
References: <1220533187-21848-1-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:52034 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754329AbYIQRC7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Sep 2008 13:02:59 -0400
In-Reply-To: <1220533187-21848-1-git-send-email-jirislaby@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-input@vger.kernel.org, Anssi Hannula <anssi.hannula@gmail.com>, linux-kernel@vger.kernel.org

On Thu, 4 Sep 2008, Jiri Slaby wrote:

> Move the force feedback precessing into a separate module.
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 0784a09..a4d9695 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -373,6 +373,8 @@
>  #define USB_DEVICE_ID_QUAD_USB_JOYPAD	0x8800
>  #define USB_DEVICE_ID_DUAL_USB_JOYPAD	0x8866
>  
> +#define USB_VENDOR_ID_GREENASIA		0x0e8f
> +
>  #define USB_VENDOR_ID_WISEGROUP_LTD	0x6666
>  #define USB_VENDOR_ID_WISEGROUP_LTD2	0x6677
>  #define USB_DEVICE_ID_SMARTJOY_DUAL_PLUS 0x8802

Could we please preserve alphabetical ordering in hid-ids.h file?

Otherwise the series looks good to me, and Anssi didn't complain as well. 
Could you please rebase it on top of the current HID tree, fix the 
ordering, and send it to me again, I will apply it?

Thanks,

-- 
Jiri Kosina
SUSE Labs
