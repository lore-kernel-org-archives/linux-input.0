From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: multitouch: enable the Surface 4 Type Cover Pro
 (not JP versions) to report multitouch data
Date: Tue, 10 Jan 2017 22:22:55 +0100
Message-ID: <20170110212254.GI2299@mail.corp.redhat.com>
References: <20170110193931.8310-1-daniel.keller@gcd.de>
 <20170110212132.GH2299@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752682AbdAJVW7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 10 Jan 2017 16:22:59 -0500
Content-Disposition: inline
In-Reply-To: <20170110212132.GH2299@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Keller <daniel.keller@gcd.de>
Cc: jikos@kernel.org, linux-input@vger.kernel.org

On Jan 10 2017 or thereabouts, Benjamin Tissoires wrote:
> On Jan 10 2017 or thereabouts, Daniel Keller wrote:
> > Nearly identical to the patch "multitouch: enable the Surface 4 Type Cover Pro (JP) to report multitouch data"
> > 
> > We can now remove the support of the Surface 4 Type Cover Pro (not JP versions) from hid-microsoft so it can properly report multi touch from the touchpad.
> > 
> > Signed-off-by: Daniel Keller <daniel.keller@gcd.de>
> > ---
> 
> Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Looks like you forgot to add linux-input in CC... Fixing this.

> 
> >  drivers/hid/hid-core.c          | 4 ----
> >  drivers/hid/hid-ids.h           | 2 --
> >  drivers/hid/hid-microsoft.c     | 4 ----
> >  drivers/hid/usbhid/hid-quirks.c | 2 --
> >  4 files changed, 12 deletions(-)
> > 
> > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > index cff060b56da9..445d7f0a998f 100644
> > --- a/drivers/hid/hid-core.c
> > +++ b/drivers/hid/hid-core.c
> > @@ -727,8 +727,6 @@ static void hid_scan_collection(struct hid_parser *parser, unsigned type)
> >  	    (hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_3 ||
> >  	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2 ||
> >  	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP ||
> > -	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_4 ||
> > -	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_2 ||
> >  	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_JP ||
> >  	     hid->product == USB_DEVICE_ID_MS_POWER_COVER) &&
> >  	    hid->group == HID_GROUP_MULTITOUCH)
> > @@ -1988,8 +1986,6 @@ static const struct hid_device_id hid_have_special_driver[] = {
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3) },
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2) },
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP) },
> > -	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4) },
> > -	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_2) },
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_JP) },
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_7K) },
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_600) },
> > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > index 54bd22dc1411..7c6d69ce1437 100644
> > --- a/drivers/hid/hid-ids.h
> > +++ b/drivers/hid/hid-ids.h
> > @@ -725,8 +725,6 @@
> >  #define USB_DEVICE_ID_MS_TYPE_COVER_PRO_3    0x07dc
> >  #define USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2  0x07e2
> >  #define USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP 0x07dd
> > -#define USB_DEVICE_ID_MS_TYPE_COVER_PRO_4 0x07e4
> > -#define USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_2 0x07e8
> >  #define USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_JP 0x07e9
> >  #define USB_DEVICE_ID_MS_POWER_COVER     0x07da
> >  
> > diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
> > index 74b7b84a0420..ba02667beb80 100644
> > --- a/drivers/hid/hid-microsoft.c
> > +++ b/drivers/hid/hid-microsoft.c
> > @@ -280,10 +280,6 @@ static const struct hid_device_id ms_devices[] = {
> >  		.driver_data = MS_HIDINPUT },
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP),
> >  		.driver_data = MS_HIDINPUT },
> > -	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4),
> > -		.driver_data = MS_HIDINPUT },
> > -	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_2),
> > -		.driver_data = MS_HIDINPUT },
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_JP),
> >  		.driver_data = MS_HIDINPUT },
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER),
> > diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
> > index e9d6cc7cdfc5..a6af728a0e2b 100644
> > --- a/drivers/hid/usbhid/hid-quirks.c
> > +++ b/drivers/hid/usbhid/hid-quirks.c
> > @@ -105,8 +105,6 @@ static const struct hid_blacklist {
> >  	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3, HID_QUIRK_NO_INIT_REPORTS },
> >  	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2, HID_QUIRK_NO_INIT_REPORTS },
> >  	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP, HID_QUIRK_NO_INIT_REPORTS },
> > -	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4, HID_QUIRK_NO_INIT_REPORTS },
> > -	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_2, HID_QUIRK_NO_INIT_REPORTS },
> >  	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_JP, HID_QUIRK_NO_INIT_REPORTS },
> >  	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER, HID_QUIRK_NO_INIT_REPORTS },
> >  	{ USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL, HID_QUIRK_NO_INIT_REPORTS },
> > -- 
> > 2.11.0
