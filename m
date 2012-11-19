From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] Input: add appleir USB driver
Date: Mon, 19 Nov 2012 16:44:20 +0100
Message-ID: <1353339860.2075.8.camel@localhost.localdomain>
References: <1353003229.4112.14.camel@localhost.localdomain>
	 <CAN+gG=FUDDd4TyN=7jp0zb1_kvURSVc3F+U9nujoj5fRf4+skA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:43998 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328Ab2KSPoY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Nov 2012 10:44:24 -0500
In-Reply-To: <CAN+gG=FUDDd4TyN=7jp0zb1_kvURSVc3F+U9nujoj5fRf4+skA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Fabien =?ISO-8859-1?Q?Andr=E9?= <fabien.andre@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jarod Wilson <jarod@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Mon, 2012-11-19 at 16:32 +0100, Benjamin Tissoires wrote:
> Hi Bastien,
> 
> (adding the input and HID maintainers to the recipient list).
> 
> On Thu, Nov 15, 2012 at 7:13 PM, Bastien Nocera <hadess@hadess.net> wrote:
> >
> > This driver was originally written by James McKenzie, updated by
> > Greg Kroah-Hartman, further updated by myself, with suspend support
> > added.
> >
> > More recent versions of the IR receiver are also supported through
> > a patch by Alex Karpenko. The patch also adds support for the 2nd
> > and 5th generation of the controller, and the menu key on newer
> > brushed metal remotes.
> >
> > Tested on a MacbookAir1,1
> >
> > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > ---
> >
> > Resend, as the original patch never made it. I cleaned up the patch a
> > bit further, and test compiled it, but didn't have a chance to test it
> > as I don't have a machine with that hardware available anymore.
> 
> Fabien, in CC, gracefully accepted to test and to try to adapt this
> patch depending on the reviews. So we can ask for tests and changes!

\o/

> > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > index 9d7a428..a4af9a9 100644
> > --- a/drivers/hid/hid-ids.h
> > +++ b/drivers/hid/hid-ids.h
> > @@ -137,8 +137,11 @@
> >  #define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ISO   0x0256
> >  #define USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY   0x030a
> >  #define USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY    0x030b
> > -#define USB_DEVICE_ID_APPLE_ATV_IRCONTROL      0x8241
> 
> not sure we should change this define to an undocumented one.

I don't understand the comment here. The name is an artifact of where
the receiver was first seen and the Apple TV receiver is actually just
another model of this same receiver. So it makes sense to consolidate
below.

> > +#define USB_DEVICE_ID_APPLE_IRCONTROL  0x8240
> > +#define USB_DEVICE_ID_APPLE_IRCONTROL2 0x1440
> > +#define USB_DEVICE_ID_APPLE_IRCONTROL3 0x8241
> >  #define USB_DEVICE_ID_APPLE_IRCONTROL4 0x8242
> > +#define USB_DEVICE_ID_APPLE_IRCONTROL5 0x8243


> > +struct appleir {
> > +       struct input_dev *input_dev;
> > +       unsigned short keymap[ARRAY_SIZE(appleir_key_table)];
> 
> why this keymap is embedded in the struct? It's basically just a copy
> of appleir_key_table and it's not modified anytime.

It would be modified if you change the keymap.

Cheers

