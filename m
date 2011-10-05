From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] This adds support for keyboards on mid-2011 MacBook
 Airs
Date: Wed, 5 Oct 2011 11:04:09 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1110051103140.31654@pobox.suse.cz>
References: <efc66984043a292faa31fee381945d18@jefferai.org> <20111005090735.GA6840@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57050 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933622Ab1JEJEM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 5 Oct 2011 05:04:12 -0400
In-Reply-To: <20111005090735.GA6840@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jeff Mitchell <jeff@jefferai.org>, linux-input@vger.kernel.org, jvdillon@gmail.com, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>


[ adding Nobuhiro to CC ]

On Wed, 5 Oct 2011, Henrik Rydberg wrote:

> Hi Jeff,
> 
> > This patch adds proper keyboard support for both MacBook Air 4,1 and
> > 4,2 models (11" and 13" mid-2011 releases). It is based mostly on
> > work by Joshua Dillon.
> > 
> > This fixes the issues with the previously-submitted patch by
> > Pieter-Augustijn Van Malleghem (subject: [PATCH] Add MacBookAir4,1
> > keyboard support), namely using an incorrect table, and also
> > contains support for both the 4,1 and 4,2 models instead of just the
> > 4,1 model.
> 
> This patch makes no changes to the table logic at all - is that how it
> is supposed to be?
> 
> Jiri, it seems the bcm5974 part for these devices has already landed,
> meaning (some version of) the below is needed in order to have a
> functional touchpad. Any chance of squeezing it in?

Guys,

please check what is in my hid tree (included in linux-next as well) and 
let me know whether there is anything that need to be applied on top of 
that. I believe all the HID-related 4,1 and 4,2 bits are already in there.

> Thanks,
> Henrik
> 
> > From e0f31e3d1a89831239676baa9bb244feee153133 Mon Sep 17 00:00:00 2001
> > From: Jeff Mitchell <jeff@jefferai.org>
> > Date: Wed, 21 Sep 2011 18:20:06 -0400
> > Subject: [PATCH] This adds support for keyboards on mid-2011 MacBook Airs
> >  (both the 11" 4,1 and 13" 4,2 models). Confusingly, 4,1
> >  corresponds to WELLSPRING6A and 4,2 corresponds to
> >  WELLSPRING6.
> > 
> > The patch is a cleaned up version of that created by Josh Dillon (jvdillon@gmail.com).
> > 
> > Signed-off-by: Jeff Mitchell <jeff@jefferai.org>
> > ---
> >  drivers/hid/hid-apple.c |   12 ++++++++++++
> >  drivers/hid/hid-core.c  |    6 ++++++
> >  drivers/hid/hid-ids.h   |    6 ++++++
> >  3 files changed, 24 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> > index 18b3bc6..03e6fb0 100644
> > --- a/drivers/hid/hid-apple.c
> > +++ b/drivers/hid/hid-apple.c
> > @@ -493,6 +493,18 @@ static const struct hid_device_id apple_devices[] = {
> >  		.driver_data = APPLE_HAS_FN | APPLE_ISO_KEYBOARD },
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5_JIS),
> >  		.driver_data = APPLE_HAS_FN | APPLE_RDESC_JIS },
> > +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING6A_ANSI),
> > +		.driver_data = APPLE_HAS_FN },
> > +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING6A_ISO),
> > +		.driver_data = APPLE_HAS_FN | APPLE_ISO_KEYBOARD },
> > +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING6A_JIS),
> > +		.driver_data = APPLE_HAS_FN | APPLE_RDESC_JIS },
> > +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING6_ANSI),
> > +		.driver_data = APPLE_HAS_FN },
> > +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING6_ISO),
> > +		.driver_data = APPLE_HAS_FN | APPLE_ISO_KEYBOARD },
> > +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING6_JIS),
> > +		.driver_data = APPLE_HAS_FN | APPLE_RDESC_JIS },
> >  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ANSI),
> >  		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
> >  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_ISO),
> > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > index 242353d..96344ff0 100644
> > --- a/drivers/hid/hid-core.c
> > +++ b/drivers/hid/hid-core.c
> > @@ -1340,6 +1340,12 @@ static const struct hid_device_id hid_have_special_driver[] = {
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5_ANSI) },
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5_ISO) },
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING5_JIS) },
> > +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING6A_ANSI) },
> > +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING6A_ISO) },
> > +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING6A_JIS) },
> > +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING6_ANSI) },
> > +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING6_ISO) },
> > +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING6_JIS) },
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_REVB_ANSI) },
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_REVB_ISO) },
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_REVB_JIS) },
> > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > index 7484e1b..8b37036 100644
> > --- a/drivers/hid/hid-ids.h
> > +++ b/drivers/hid/hid-ids.h
> > @@ -109,6 +109,12 @@
> >  #define USB_DEVICE_ID_APPLE_WELLSPRING5_ANSI	0x0245
> >  #define USB_DEVICE_ID_APPLE_WELLSPRING5_ISO	0x0246
> >  #define USB_DEVICE_ID_APPLE_WELLSPRING5_JIS	0x0247
> > +#define USB_DEVICE_ID_APPLE_WELLSPRING6A_ANSI	0x0249
> > +#define USB_DEVICE_ID_APPLE_WELLSPRING6A_ISO	0x024a
> > +#define USB_DEVICE_ID_APPLE_WELLSPRING6A_JIS	0x024b
> > +#define USB_DEVICE_ID_APPLE_WELLSPRING6_ANSI	0x024c
> > +#define USB_DEVICE_ID_APPLE_WELLSPRING6_ISO	0x024d
> > +#define USB_DEVICE_ID_APPLE_WELLSPRING6_JIS	0x024e
> >  #define USB_DEVICE_ID_APPLE_ALU_REVB_ANSI	0x024f
> >  #define USB_DEVICE_ID_APPLE_ALU_REVB_ISO	0x0250
> >  #define USB_DEVICE_ID_APPLE_ALU_REVB_JIS	0x0251
> > -- 
> > 1.7.6.2
> > 
> 

-- 
Jiri Kosina
SUSE Labs
