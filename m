From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH] HID: quirks: Add no_init_reports for AKAI midi
 controller
Date: Thu, 28 Jan 2016 10:15:48 +0100
Message-ID: <1453972548.8073.1.camel@suse.com>
References: <1453903777-11790-1-git-send-email-shorne@gmail.com>
	 <alpine.LNX.2.00.1601272230070.21446@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36454 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966118AbcA1JSP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jan 2016 04:18:15 -0500
In-Reply-To: <alpine.LNX.2.00.1601272230070.21446@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Stafford Horne <shorne@gmail.com>, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

On Wed, 2016-01-27 at 22:31 +0100, Jiri Kosina wrote:
> On Wed, 27 Jan 2016, Stafford Horne wrote:
> 
> > The midi controller times-out while initializing reports, this
> > causes boot to take an extra 10 seconds. The device descriptor
> > advertises that it has an internal HID device but seems to not
> > actually do anything useful.
> > 
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> >  drivers/hid/hid-ids.h           | 3 +++
> >  drivers/hid/usbhid/hid-quirks.c | 1 +
> >  2 files changed, 4 insertions(+)
> > 
> > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > index b6ff6e7..3dfb166 100644
> > --- a/drivers/hid/hid-ids.h
> > +++ b/drivers/hid/hid-ids.h
> > @@ -61,6 +61,9 @@
> >  #define USB_VENDOR_ID_AIREN		0x1a2c
> >  #define USB_DEVICE_ID_AIREN_SLIMPLUS	0x0002
> >  
> > +#define USB_VENDOR_ID_AKAI              0x2011
> > +#define USB_DEVICE_ID_AKAI_MPKMINI2     0x0715
> > +
> >  #define USB_VENDOR_ID_ALCOR		0x058f
> >  #define USB_DEVICE_ID_ALCOR_USBRS232	0x9720
> >  
> > diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
> > index 7dd0953..055e740 100644
> > --- a/drivers/hid/usbhid/hid-quirks.c
> > +++ b/drivers/hid/usbhid/hid-quirks.c
> > @@ -55,6 +55,7 @@ static const struct hid_blacklist {
> >  	{ USB_VENDOR_ID_TOUCHPACK, USB_DEVICE_ID_TOUCHPACK_RTS, HID_QUIRK_MULTI_INPUT },
> >  
> >  	{ USB_VENDOR_ID_AIREN, USB_DEVICE_ID_AIREN_SLIMPLUS, HID_QUIRK_NOGET },
> > +	{ USB_VENDOR_ID_AKAI, USB_DEVICE_ID_AKAI_MPKMINI2, HID_QUIRK_NO_INIT_REPORTS },
> 
> If the (proclaimed) HID device is completely silent, wouldn't 
> HID_QUIRK_IGNORE be more appropriate?

If it really is impossible to use the device.
That quirk would preclude any use you are not aware of with almost
no added benefit. I would take the patch as is.

	Regards
		Oliver



