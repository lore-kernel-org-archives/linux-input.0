From: Jiri Kosina <jiri.kosina@suse.com>
Subject: Re: [PATCH] usbhid: add another mouse that needs QUIRK_ALWAYS_POLL
Date: Wed, 1 Oct 2014 14:32:10 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1410011431100.26311@pobox.suse.cz>
References: <1412074496-4539-1-git-send-email-oneukum@suse.de>  <alpine.LNX.2.00.1410010921570.26311@pobox.suse.cz> <1412151243.4171.10.camel@linux-0dmf.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:39540 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbaJAMcR (ORCPT
	<rfc822;groupwise-linux-input@vger.kernel.org:0:0>);
	Wed, 1 Oct 2014 08:32:17 -0400
In-Reply-To: <1412151243.4171.10.camel@linux-0dmf.site>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-input@vger.kernel.org, johan@kernel.org

On Wed, 1 Oct 2014, Oliver Neukum wrote:

> > > --- a/drivers/hid/usbhid/hid-quirks.c
> > > +++ b/drivers/hid/usbhid/hid-quirks.c
> > > @@ -80,6 +80,8 @@ static const struct hid_blacklist {
> > >  	{ USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_PENMOUNT_1610, HID_QUIRK_NOGET },
> > >  	{ USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_PENMOUNT_1640, HID_QUIRK_NOGET },
> > >  	{ USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_USB_OPTICAL_MOUSE, HID_QUIRK_ALWAYS_POLL },
> > > +	/* OEM version same strings but different IDs */
> > > +	{ USB_VENDOR_ID_KYE, USB_DEVICE_ID_PIXART_USB_OPTICAL_MOUSE_ID2, HID_QUIRK_ALWAYS_POLL },
> > 
> > I don't like the added comment, it makes the list look ugly (as no other 
> > device has such a comment). The details are in the git changelog anyway.
> > 
> > Are you fine with me removing the comment before commiting the patch?
> 
> If you wish to remove it, please do so. 

Thanks, I removed it and applied.

> However, if people then complain that I mixed up vendor IDs, will you 
> handle that? ;)

I am pretty good at running git blame and looking into changelogs, no 
worries :)

Thanks,

-- 
Jiri Kosina
SUSE Labs
