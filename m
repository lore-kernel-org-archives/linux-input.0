From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] HID: multitouch: enable touchpad on Surface Book
Date: Tue, 10 May 2016 19:06:41 +0300
Message-ID: <1462896401.17131.307.camel@linux.intel.com>
References: <1462805821-73087-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20160510142132.GP23234@mail.corp.redhat.com>
	 <1462892648.17131.303.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:48296 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752341AbcEJQFh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 10 May 2016 12:05:37 -0400
In-Reply-To: <1462892648.17131.303.camel@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Tue, 2016-05-10 at 18:04 +0300, Andy Shevchenko wrote:
> On Tue, 2016-05-10 at 16:21 +0200, Benjamin Tissoires wrote:
> >=20
> > Hi Andy,
> >=20
> > On May 09 2016 or thereabouts, Andy Shevchenko wrote:
> > >=20
> > >=20
> > > Microsoft Surface Book has HID multitouch connected device. Enabl=
e
> > > it here.
> > >=20
> > > The change has been tested on bare metal by reading raw data from
> > > /dev/input/event4.
> > >=20
> > > The patch uses HID device ID submitted earlier here:
> > > http://marc.info/?l=3Dlinux-input&m=3D146280544721389&w=3D2
> > >=20
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com=
>
> > > ---
> > > =C2=A0drivers/hid/hid-multitouch.c | 5 +++++
> > > =C2=A01 file changed, 5 insertions(+)
> > >=20
> > > diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-
> > > multitouch.c
> > > index c741f5e..c3df02d 100644
> > > --- a/drivers/hid/hid-multitouch.c
> > > +++ b/drivers/hid/hid-multitouch.c
> > > @@ -1377,6 +1377,11 @@ static const struct hid_device_id
> > > mt_devices[] =3D {
> > > =C2=A0		MT_USB_DEVICE(USB_VENDOR_ID_ILITEK,
> > > =C2=A0			USB_DEVICE_ID_ILITEK_MULTITOUCH) },
> > > =C2=A0
> > > +	/* Microsoft Surface Book */
> > > +	{ .driver_data =3D MT_CLS_EXPORT_ALL_INPUTS,
> > > +		MT_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > > +			USB_DEVICE_ID_MS_SURFACE_BOOK) },
> > > +
> > I am a little bit lost here. In your previous patch, you unset the
> > group
> > MULTITOUCH to the USB_DEVICE_ID_MS_SURFACE_BOOK. But here, you bind
> > a
> > device to it which will never been present according to
> > http://marc.info/?l=3Dlinux-input&m=3D146280544721389&w=3D2
> Yes, that line is redundant. So, the first hunk of that patch should
> be
> removed.

Okay, it seems I have to resend these two as one without mentioned hunk=
=2E

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
