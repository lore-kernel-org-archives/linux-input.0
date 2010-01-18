From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCHes] Apple IR receiver driver
Date: Mon, 18 Jan 2010 14:51:11 +0000
Message-ID: <1263826271.20565.2769.camel@localhost.localdomain>
References: <1263824065.20565.2730.camel@localhost.localdomain>
	 <20100118143412.GA9831@mac.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58467 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751775Ab0AROvV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jan 2010 09:51:21 -0500
In-Reply-To: <20100118143412.GA9831@mac.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tino Keitel <tino.keitel@tikei.de>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Matthew Garrett <mjg@redhat.com>, Tino Keitel <tino.keitel@gmx.de>

On Mon, 2010-01-18 at 15:34 +0100, Tino Keitel wrote:
> On Mon, Jan 18, 2010 at 14:14:25 +0000, Bastien Nocera wrote:
> 
> [...]
> 
> > --- a/drivers/hid/hid-core.c
> > +++ b/drivers/hid/hid-core.c
> > @@ -1540,6 +1540,8 @@ static const struct hid_device_id hid_ignore_list[] = {
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_AIPTEK, USB_DEVICE_ID_AIPTEK_24) },
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_AIRCABLE, USB_DEVICE_ID_AIRCABLE1) },
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_ALCOR, USB_DEVICE_ID_ALCOR_USBRS232) },
> > +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_IRCONTROL) },
> > +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_IRCONTROL4) },
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUS, USB_DEVICE_ID_ASUS_LCM)},
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUS, USB_DEVICE_ID_ASUS_LCM2)},
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_AVERMEDIA, USB_DEVICE_ID_AVER_FM_MR800) },
> 
> My impression is that this would break existing lirc setups that use
> the macmini lirc userspace driver which relies on a HID device, right?

Yes, which I mentioned could be worked around using usbhid.quirks on
boot (if you need the extra key definitions), or using lirc's uinput
driver (if you're using the stock hardware).

