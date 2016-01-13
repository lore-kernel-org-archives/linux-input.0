From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: Quanta touchscreen 0408:3003 does not work with hid-multitouch
Date: Wed, 13 Jan 2016 15:47:04 +0100
Message-ID: <20160113144704.GF19287@mail.corp.redhat.com>
References: <CACcJrhR8iv0FKRrH7V2nbefZBLfhmr_Kn9ctg4O4bhzd_3oFnA@mail.gmail.com>
 <20151219174154.GC27255@dtor-ws>
 <20160104091034.GA20222@mail.corp.redhat.com>
 <CACcJrhQ6NsE1Rm4NtNHWf2-HWL+P5MoOhruDS1njkbWb7-ubUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44170 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751424AbcAMOrJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jan 2016 09:47:09 -0500
Content-Disposition: inline
In-Reply-To: <CACcJrhQ6NsE1Rm4NtNHWf2-HWL+P5MoOhruDS1njkbWb7-ubUQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jim lovell <jimlovell777@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Jan 13 2016 or thereabouts, Jim lovell wrote:
> I can confirm the patch does work to allow single touch interactions.
> Multi-touch gestures do not work. I cannot pinch to zoom for example.

Thanks for the tests.
There are huge chances that you already have multitouch from the kernel
but those gestures not supported in your desktop environment.

Jiri, would you mind picking this patch (sent in this thread or in
http://thread.gmane.org/gmane.linux.kernel.input/46706/focus=3D47509). =
I
can resend it if you prefer.

Cheers,
Benjamin

> On Jan 4, 2016 3:10 AM, "Benjamin Tissoires" <benjamin.tissoires@redh=
at.com>
> wrote:
>=20
> > On Dec 19 2015 or thereabouts, Dmitry Torokhov wrote:
> > > On Tue, Nov 10, 2015 at 10:21:15PM -0600, Jim lovell wrote:
> > > > [1.] 0408:3003 Quanta Computer, Inc. Touchscreen Controller Det=
ected
> > > > But Doesn't Work
> > > >
> > > > [2.] Booting my computer using the newest mainline kernel, the
> > > > built-in USB 0408:3003 Quanta Computer, Inc. touchscreen contro=
ller is
> > > > detected but doesn't work. The touchscreen controller is detect=
ed but
> > > > no touches are acknowleged. Using "xinput [id] test" no output =
is
> > > > generated while single or multi touching the screen.
> > >
> > > ...
> > >
> > > >
> > > > [X.] Launchpad Bug Report
> > > > https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1514310
> > > >     Workaround that 70% of the time allows single touches to wo=
rk
> > > > until the system is rebooted.
> > > >     xinput set-mode [id] RELATIVE
> > > >     xinput set-mode [id] ABSOLUTE
> > > >     sudo rmmod hid-multitouch
> > > >     sudo modprobe hid-multitouch
> > > >
> > > >     xinput --list
> > > >         =E2=86=B3 Quanta Computer OpticalTouchScreen id=3D12 [s=
lave pointer (2)]
> > > >     lsusb
> > > >             Bus 001 Device 005: ID 0408:3003 Quanta Computer, I=
nc.
> > > >     lsmod
> > > >         hid 118784 7
> > hid_multitouch,usbhid,hid_logitech_dj,hid_logitech_hidpp
> > > >     dmesg (most recent output after many attempts following
> > elmarikon's "fix")
> > > >         input: Quanta Computer OpticalTouchScreen as
> > > >
> > /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.6/1-1.6:1.0/0003:0408=
:3003.0007/input/input16
> > > >         hid-multitouch 0003:0408:3003.0007: input,hiddev0,hidra=
w4: USB
> > > > HID v1.10 Mouse [Quanta Computer OpticalTouchScreen] on
> > > > usb-0000:00:1a.0-1.6/input0
> > > >         hid-multitouch 0003:0408:3003.0007: usb_submit_urb(ctrl=
)
> > failed: -1
> > > >         hid-multitouch 0003:0408:3003.0007: usb_submit_urb(ctrl=
)
> > failed: -1
> > >
> > > Benjamin, any ideas?
> > >
> >
> > dmesg shows a lot of:
> > [   12.304314] hid-multitouch 0003:0408:3003.0007: usb_submit_urb(c=
trl)
> > failed: -1
> > [   12.304384] hid-multitouch 0003:0408:3003.0007: timeout initiali=
zing
> > reports
> >
> > And the other Quanta devices has a quirk NO_GET to work around this=
=2E
> >
> > Jim, does the following patch helps:
> >
> >
> > m 729b779256296e68b2079b813ccb61354f8c77d7 Mon Sep 17 00:00:00 2001
> > From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > Date: Mon, 4 Jan 2016 10:08:54 +0100
> > Subject: [PATCH] HID: add HID_QUIRK_NOGET to Quanta 3003 too
> >
> > dmesg shows a lot of:
> > [ 1374.890348] hid-multitouch 0003:0408:3003.0007: usb_submit_urb(c=
trl)
> > failed: -1
> > [ 1384.916388] hid-multitouch 0003:0408:3003.0007: usb_submit_urb(c=
trl)
> > failed: -1
> > [ 1384.916432] hid-multitouch 0003:0408:3003.0007: timeout initiali=
zing
> > reports
> >
> > Add the quirk and make the touchscreen happy.
> >
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > ---
> >  drivers/hid/hid-ids.h           | 1 +
> >  drivers/hid/usbhid/hid-quirks.c | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > index ac1feea..4561a9e 100644
> > --- a/drivers/hid/hid-ids.h
> > +++ b/drivers/hid/hid-ids.h
> > @@ -801,6 +801,7 @@
> >  #define USB_VENDOR_ID_QUANTA           0x0408
> >  #define USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH             0x3000
> >  #define USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3001                0x3=
001
> > +#define USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3003                0x3=
003
> >  #define USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3008                0x3=
008
> >
> >  #define USB_VENDOR_ID_RAZER            0x1532
> > diff --git a/drivers/hid/usbhid/hid-quirks.c
> > b/drivers/hid/usbhid/hid-quirks.c
> > index 94bb137..8910f79 100644
> > --- a/drivers/hid/usbhid/hid-quirks.c
> > +++ b/drivers/hid/usbhid/hid-quirks.c
> > @@ -109,6 +109,7 @@ static const struct hid_blacklist {
> >         { USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_MOUSE_4D22,
> > HID_QUIRK_ALWAYS_POLL },
> >         { USB_VENDOR_ID_PRODIGE, USB_DEVICE_ID_PRODIGE_CORDLESS,
> > HID_QUIRK_NOGET },
> >         { USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_=
3001,
> > HID_QUIRK_NOGET },
> > +       { USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_=
3003,
> > HID_QUIRK_NOGET },
> >         { USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_=
3008,
> > HID_QUIRK_NOGET },
> >         { USB_VENDOR_ID_REALTEK, USB_DEVICE_ID_REALTEK_READER,
> > HID_QUIRK_NO_INIT_REPORTS },
> >         { USB_VENDOR_ID_SENNHEISER, USB_DEVICE_ID_SENNHEISER_BTD500=
USB,
> > HID_QUIRK_NOGET },
> > --
> > 2.5.0
> >
> > Cheers,
> > Benjamin
> >
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
