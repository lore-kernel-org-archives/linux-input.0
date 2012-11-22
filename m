From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 2/2] input: usb: hid: Add quirk for Freescale i.MX28 ROM recovery
Date: Fri, 23 Nov 2012 00:02:14 +0100
Message-ID: <201211230002.14889.marex@denx.de>
References: <1344203835-8308-1-git-send-email-marex@denx.de> <201211211630.38238.marex@denx.de> <alpine.LNX.2.00.1211222346300.4609@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:37095 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854Ab2KVXCS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Nov 2012 18:02:18 -0500
In-Reply-To: <alpine.LNX.2.00.1211222346300.4609@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Chen Peter <B29397@freescale.com>, Greg KH <greg@kroah.com>

Dear Jiri Kosina,

> On Wed, 21 Nov 2012, Marek Vasut wrote:
> > > > > diff --git a/drivers/hid/usbhid/hid-quirks.c
> > > > > b/drivers/hid/usbhid/hid-quirks.c index 903eef3..6a09570 100644
> > > > > --- a/drivers/hid/usbhid/hid-quirks.c
> > > > > +++ b/drivers/hid/usbhid/hid-quirks.c
> > > > > @@ -101,6 +101,7 @@ static const struct hid_blacklist {
> > > > > 
> > > > >  	{ USB_VENDOR_ID_SIGMA_MICRO, USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD,
> > > > > 
> > > > > HID_QUIRK_NO_INIT_REPORTS }, { USB_VENDOR_ID_KYE,
> > > > > USB_DEVICE_ID_KYE_MOUSEPEN_I608X, HID_QUIRK_MULTI_INPUT }, {
> > > > > USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M610X,
> > > > > HID_QUIRK_MULTI_INPUT }, +	{ USB_VENDOR_ID_FREESCALE,
> > > > > USB_DEVICE_ID_FREESCALE_MX28,
> > > > > HID_QUIRK_NOGET }, { 0, 0 }
> > > > 
> > > > OT: btw. the comment mentioned the list should be sorted, yet it's
> > > > not so for a while. Maybe a sorting patch would be favored?
> > > 
> > > I have fixed the ordering and applied. Thanks,
> > 
> > Can we possibly include these changes into -stable releases too ? I'm not
> > exactly sure how it works for linux-input, they might be applied already,
> > if that's the case, sorry for the noise.
> 
> I have just submitted it for stable, thanks for the reminder.

Thanks!

Can we push this one too?
[PATCH 1/2] input: usb: hid: Bump maximum global item tag report size to 128 
bytes

Best regards,
Marek Vasut
