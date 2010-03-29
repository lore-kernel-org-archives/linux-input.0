From: Anisse Astier <anisse@astier.eu>
Subject: Re: [PATCH] hid: Add NOGET quirk for Quanta usb optical touchscreen
 Pixart to prevent timeout
Date: Mon, 29 Mar 2010 17:03:53 +0200
Message-ID: <20100329170353.437bab66@destiny.ordissimo>
References: <20100329162006.3f6e03b1@destiny.ordissimo>
	<alpine.LNX.2.00.1003291625100.24576@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:61386 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441Ab0C2PEE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Mar 2010 11:04:04 -0400
Received: by pva18 with SMTP id 18so2528916pva.19
        for <linux-input@vger.kernel.org>; Mon, 29 Mar 2010 08:04:03 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1003291625100.24576@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Stephane Chatty <chatty@lii-enac.fr>, Alex Neblett <alexneblett01@yahoo.com>

On Mon, 29 Mar 2010 16:25:31 +0200 (CEST), Jiri Kosina <jkosina@suse.cz> wrote :

> On Mon, 29 Mar 2010, Anisse Astier wrote:
> 
> > 
> > Add the NOGET quirk for the Quanta optical touchscreen present on MSI AE2220,
> > Otherwise, the hid-quanta driver timeouts at load time:
> > 
> > drivers/hid/usbhid/hid-core.c: usb_submit_urb(ctrl) failed
> > quanta-touch 0003:0408:3001.0003: timeout initializing reports
> > input: PixArt Imaging Inc. Optical Touch Screen as /class/input/input7
> > quanta-touch 0003:0408:3001.0003: input: USB HID v1.10 Device [PixArt Imaging Inc. Optical Touch Screen] on usb-0000:00:06.0-2/input0
> > 
> > Signed-off-by: Anisse Astier <anisse@astier.eu>
> > ---
> >  drivers/hid/usbhid/hid-quirks.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
> > index 928943c..e71e005 100644
> > --- a/drivers/hid/usbhid/hid-quirks.c
> > +++ b/drivers/hid/usbhid/hid-quirks.c
> > @@ -60,6 +60,7 @@ static const struct hid_blacklist {
> >  	{ USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC, HID_QUIRK_NOGET },
> >  	{ USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_TS2700, HID_QUIRK_NOGET },
> >  	{ USB_VENDOR_ID_PRODIGE, USB_DEVICE_ID_PRODIGE_CORDLESS, HID_QUIRK_NOGET },
> > +	{ USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_PIXART_IMAGING_INC_OPTICAL_TOUCH_SCREEN, HID_QUIRK_NOGET },
> >  	{ USB_VENDOR_ID_SUN, USB_DEVICE_ID_RARITAN_KVM_DONGLE, HID_QUIRK_NOGET },
> >  	{ USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_TURBOX_KEYBOARD, HID_QUIRK_NOGET },
> >  	{ USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_PF1209, HID_QUIRK_MULTI_INPUT },
> 
> I have applied the patch, but I wonder why Alex (who added this device ID 
> initially) wasn't seeing it?
Good question indeed, that's why I included him in the Cc. I just assumed that
he saw it but didn't bother, since this problem is not critical: the driver
just works correctly after the timeout, and we can receive the touchscreen
events.

Maybe I'm wrong, Alex?

Regards,

Anisse
