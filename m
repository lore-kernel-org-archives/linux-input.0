From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH 2/2] input: usb: hid: Add quirk for Freescale i.MX28 ROM
 recovery
Date: Thu, 22 Nov 2012 23:46:51 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1211222346300.4609@pobox.suse.cz>
References: <1344203835-8308-1-git-send-email-marex@denx.de> <201208052359.26938.marex@denx.de> <alpine.LNX.2.00.1208151036130.7026@pobox.suse.cz> <201211211630.38238.marex@denx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201211211630.38238.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chen Peter <B29397-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, 21 Nov 2012, Marek Vasut wrote:

> > > > diff --git a/drivers/hid/usbhid/hid-quirks.c
> > > > b/drivers/hid/usbhid/hid-quirks.c index 903eef3..6a09570 100644
> > > > --- a/drivers/hid/usbhid/hid-quirks.c
> > > > +++ b/drivers/hid/usbhid/hid-quirks.c
> > > > @@ -101,6 +101,7 @@ static const struct hid_blacklist {
> > > > 
> > > >  	{ USB_VENDOR_ID_SIGMA_MICRO, USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD,
> > > > 
> > > > HID_QUIRK_NO_INIT_REPORTS }, { USB_VENDOR_ID_KYE,
> > > > USB_DEVICE_ID_KYE_MOUSEPEN_I608X, HID_QUIRK_MULTI_INPUT }, {
> > > > USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M610X,
> > > > HID_QUIRK_MULTI_INPUT }, +	{ USB_VENDOR_ID_FREESCALE,
> > > > USB_DEVICE_ID_FREESCALE_MX28,
> > > > HID_QUIRK_NOGET }, { 0, 0 }
> > > 
> > > OT: btw. the comment mentioned the list should be sorted, yet it's not so
> > > for a while. Maybe a sorting patch would be favored?
> > 
> > I have fixed the ordering and applied. Thanks,
> 
> Can we possibly include these changes into -stable releases too ? I'm not 
> exactly sure how it works for linux-input, they might be applied already, if 
> that's the case, sorry for the noise.

I have just submitted it for stable, thanks for the reminder.

-- 
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
