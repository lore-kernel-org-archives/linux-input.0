From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH] usbhid: add another mouse that needs QUIRK_ALWAYS_POLL
Date: Wed, 01 Oct 2014 10:14:03 +0200
Message-ID: <1412151243.4171.10.camel@linux-0dmf.site>
References: <1412074496-4539-1-git-send-email-oneukum@suse.de>
	 <alpine.LNX.2.00.1410010921570.26311@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55207 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290AbaJAINw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 1 Oct 2014 04:13:52 -0400
In-Reply-To: <alpine.LNX.2.00.1410010921570.26311@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jiri.kosina@suse.com>
Cc: linux-input@vger.kernel.org, johan@kernel.org

On Wed, 2014-10-01 at 09:23 +0200, Jiri Kosina wrote:
> On Tue, 30 Sep 2014, Oliver Neukum wrote:
> 
> > There is a second mouse sharing the same vendor strings
> > but different IDs.
> > 
> > Signed-off-by: Oliver Neukum <oneukum@suse.de>
> > ---
> >  drivers/hid/hid-ids.h           | 1 +
> >  drivers/hid/usbhid/hid-quirks.c | 2 ++
> >  2 files changed, 3 insertions(+)
> > 
> > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > index b303a62..5a7072d 100644
> > --- a/drivers/hid/hid-ids.h
> > +++ b/drivers/hid/hid-ids.h
> > @@ -733,6 +733,7 @@
> >  #define USB_DEVICE_ID_PI_ENGINEERING_VEC_USB_FOOTPEDAL	0xff
> >  
> >  #define USB_VENDOR_ID_PIXART				0x093a
> > +#define USB_DEVICE_ID_PIXART_USB_OPTICAL_MOUSE_ID2	0x0137
> >  #define USB_DEVICE_ID_PIXART_USB_OPTICAL_MOUSE		0x2510
> >  #define USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN	0x8001
> >  #define USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN1	0x8002
> > diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
> > index 79f94ae..ce27c62 100644
> > --- a/drivers/hid/usbhid/hid-quirks.c
> > +++ b/drivers/hid/usbhid/hid-quirks.c
> > @@ -80,6 +80,8 @@ static const struct hid_blacklist {
> >  	{ USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_PENMOUNT_1610, HID_QUIRK_NOGET },
> >  	{ USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_PENMOUNT_1640, HID_QUIRK_NOGET },
> >  	{ USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_USB_OPTICAL_MOUSE, HID_QUIRK_ALWAYS_POLL },
> > +	/* OEM version same strings but different IDs */
> > +	{ USB_VENDOR_ID_KYE, USB_DEVICE_ID_PIXART_USB_OPTICAL_MOUSE_ID2, HID_QUIRK_ALWAYS_POLL },
> 
> I don't like the added comment, it makes the list look ugly (as no other 
> device has such a comment). The details are in the git changelog anyway.
> 
> Are you fine with me removing the comment before commiting the patch?

If you wish to remove it, please do so. However, if people then complain
that I mixed up vendor IDs, will you handle that? ;)

	Regards
		Oliver



