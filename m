From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH RESEND] hid:Change vendor id for USB_DEVICE_ID_MS_TYPE_COVER_3
 to correct id in hid-ids.h
Date: Wed, 20 May 2015 16:27:56 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1505201627070.8186@pobox.suse.cz>
References: <1431666292-27622-1-git-send-email-xerofoify@gmail.com> <alpine.LNX.2.00.1505151247130.8186@pobox.suse.cz> <8032D262-870E-4071-9B32-767239EB8E31@gmail.com> <555C97CF.3040502@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53937 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753515AbbETO16 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 20 May 2015 10:27:58 -0400
In-Reply-To: <555C97CF.3040502@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: nick <xerofoify@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 20 May 2015, nick wrote:

> >>> This fixes the bug,https://bugzilla.kernel.org/show_bug.cgi?id=97951 
> >>> related to incorrecting using 0x07dc for the vendor id for 
> >>> USB_DEVICE_ID_MS_TYPE_COVER_3 devices and instead changing in 
> >>> to the correct vendor id of 0x07de.
> >>>
> >>> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> >>> ---
> >>>  drivers/hid/hid-ids.h | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> >>> index 41f167e..2e51947 100644
> >>> --- a/drivers/hid/hid-ids.h
> >>> +++ b/drivers/hid/hid-ids.h
> >>> @@ -670,7 +670,7 @@
> >>>  #define USB_DEVICE_ID_MS_SURFACE_PRO_2   0x0799
> >>>  #define USB_DEVICE_ID_MS_TOUCH_COVER_2   0x07a7
> >>>  #define USB_DEVICE_ID_MS_TYPE_COVER_2    0x07a9
> >>> -#define USB_DEVICE_ID_MS_TYPE_COVER_3    0x07dc
> >>> +#define USB_DEVICE_ID_MS_TYPE_COVER_3    0x07de
> >>>  #define USB_DEVICE_ID_MS_TYPE_COVER_3_JP 0x07dd
> >>>  
> >>>  #define USB_VENDOR_ID_MOJO		0x8282
> >>
> >> Why are you resending this without reacting to my original response to 
> >> your mail?
> >>
> > This has been discussed as Alan stated the device he has comes with the American and not the Japanese vendor ID . If you still don't believe me I will quote his exact words. 
> > Nick 
> >> 	http://lkml.iu.edu/hypermail/linux/kernel/1505.1/01419.html
> > 
> Jiri, I have not heard a respond about this patch being accepted. If you 
> can get another to replying to me this week about it that would be 
> great.

I still haven't received any pointer or reason why we don't want both 
(i.e. how come that 0x07dc was initially submitted and all of a sudden 
it's not needed).

-- 
Jiri Kosina
SUSE Labs
