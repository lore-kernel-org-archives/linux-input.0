From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 5/7] input: Add keycodes used by Lenovo Carbon X1 2014
Date: Fri, 20 Feb 2015 19:54:27 +0100
Message-ID: <1424458467.22910.35.camel@hadess.net>
References: <1424443473.22910.17.camel@hadess.net>
	 <CAN+gG=HxwAA=f2a-vS6-voCRNQO-2pwnK64qz0L_b6-R2bScvQ@mail.gmail.com>
	 <20150220184000.GB20060@dtor-glaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:41574 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754302AbbBTSz7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Feb 2015 13:55:59 -0500
In-Reply-To: <20150220184000.GB20060@dtor-glaptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Darren Hart <dvhart@infradead.org>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Hey Dmitry,

On Fri, 2015-02-20 at 10:40 -0800, Dmitry Torokhov wrote:
> On Fri, Feb 20, 2015 at 10:04:04AM -0500, Benjamin Tissoires wrote:
> > On Fri, Feb 20, 2015 at 9:44 AM, Bastien Nocera <hadess@hadess.net> wrote:
> > > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > > ---
> > >  include/uapi/linux/input.h | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> > > index b0a8130..affe40e 100644
> > > --- a/include/uapi/linux/input.h
> > > +++ b/include/uapi/linux/input.h
> > > @@ -740,6 +740,16 @@ struct input_keymap_entry {
> > >  #define KEY_BRIGHTNESS_MIN             0x250   /* Set Brightness to Minimum */
> > >  #define KEY_BRIGHTNESS_MAX             0x251   /* Set Brightness to Maximum */
> > >
> > > +#define KEY_CLIPPING_TOOL              0x252   /* Screenshot clipping tool */
> 
> Do we have users for this?

Bearing in mind that most of those keys won't be usable in X11, but
should be in Wayland, it might take a little while to actually get used,
but I would add support for this "clipping tool" key in GNOME. Most
likely to start a screenshoting tool in selection mode.

> > > +#define KEY_CLOUD                      0x253   /* Cloud Settings */
> 
> Just no. What is cloud settings? Use KEY_VENDOR if you must for this vendor
> "added value" junk they come up on keyboards year after year. It used to be
> WWW, not cloud, I bet in 2016 someone will come up with "IoT"-dedicated key.

The button actually looks like a Cloud, see page 46 of this guide:
http://www.lenovo.com/shop/americas/content/user_guides/x1carbon_2_ug_en.pdf

In GNOME, I would make this start the "Online Accounts" configuration.
I'm fine with renaming it, but I would prefer something more precise
than KEY_VENDOR. KEY_WWW would be fine by me.

> > > +#define KEY_CAMERA_GESTURES            0x254   /* Toggle Camera gestures */

This wouldn't get used directly in GNOME.

> > > +#define KEY_NEW_TAB                    0x255   /* Open a new tab */

This would get used.

> > > +#define KEY_MICUP                      0x256   /* Microphone Up */
> > > +#define KEY_MICDOWN                    0x257   /* Microphone Down */

Those would get used as well.

> > > +#define KEY_MICCANCEL_MODE             0x258   /* Toggle Microphone cancellation mode */
> > > +#define KEY_CAMERA_ZOOM_MODE           0x259   /* Toggle camera zoom mode */

These 2 wouldn't get used directly in GNOME.

> > > +#define KEY_ROTATE_DISPLAY             0x25a   /* Rotate screen by 90 degrees */
> > > +
> > 
> > This one should be acked by Dmitry (in CC)
> > 
> 
> Some of these (like microphone volume up/down) are generic and reasonable, but
> I need to know if there will be any users for these newly defined keys.

Answers to this in-line above. I'm fine with replacing the keycodes for
those keys with something that more or less corresponds to the
pictograms, especially the "Toggle voice-recognition" and "Toggle
camera-gestures function" are present in all the keyboard modes.

Cheers

