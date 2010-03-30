From: Alex Neblett <alexneblett01@yahoo.com>
Subject: Re: [PATCH] hid: Add NOGET quirk for Quanta usb optical touchscreen Pixart to prevent timeout
Date: Mon, 29 Mar 2010 18:09:22 -0700 (PDT)
Message-ID: <316912.47108.qm@web82001.mail.mud.yahoo.com>
References: <20100329162006.3f6e03b1@destiny.ordissimo> <alpine.LNX.2.00.1003291625100.24576@pobox.suse.cz> <20100329170353.437bab66@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from web82001.mail.mud.yahoo.com ([66.163.178.245]:37405 "HELO
	web82001.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753381Ab0C3BQF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Mar 2010 21:16:05 -0400
In-Reply-To: <20100329170353.437bab66@destiny.ordissimo>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Stephane Chatty <chatty@lii-enac.fr>

Anisse,

Sorry for being out of pocket. I had some health issues that I had to address.

The answer is that I have never encountered it. I would assume that it might be related to usb devices present, bios version and/or kernel configuration.

However, I am not surprised by your findings and appreciate your addressing your findings.

My son has an msi gaming laptop. Until we updated the bios and the camera bios to the latest version, he was unable to boot kernels > 2.6.32rc2 without the dreaded read/64 error -110. Even with the updates, restart produces the same error. As a result, he now does a shutdown and then powers up to restart...

I think that it is safe to assume that some users would have fared as I have and some would have faired as you have. Thanks for the great work.

Cheers,

Alex



----- Original Message ----
From: Anisse Astier <anisse@astier.eu>
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org; Stephane Chatty <chatty@lii-enac.fr>; Alex Neblett <alexneblett01@yahoo.com>
Sent: Mon, March 29, 2010 10:03:53 AM
Subject: Re: [PATCH] hid: Add NOGET quirk for Quanta usb optical touchscreen Pixart to prevent timeout

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
> >      { USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC, HID_QUIRK_NOGET },
> >      { USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_TS2700, HID_QUIRK_NOGET },
> >      { USB_VENDOR_ID_PRODIGE, USB_DEVICE_ID_PRODIGE_CORDLESS, HID_QUIRK_NOGET },
> > +    { USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_PIXART_IMAGING_INC_OPTICAL_TOUCH_SCREEN, HID_QUIRK_NOGET },
> >      { USB_VENDOR_ID_SUN, USB_DEVICE_ID_RARITAN_KVM_DONGLE, HID_QUIRK_NOGET },
> >      { USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_TURBOX_KEYBOARD, HID_QUIRK_NOGET },
> >      { USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_PF1209, HID_QUIRK_MULTI_INPUT },
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

