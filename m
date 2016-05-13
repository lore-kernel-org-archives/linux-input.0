From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/2] HID: multitouch: enable the Surface 3 Type Cover to
 report multitouch data
Date: Fri, 13 May 2016 16:49:44 +0200
Message-ID: <20160513144927.GZ23234@mail.corp.redhat.com>
References: <1463062363-12405-1-git-send-email-benjamin.tissoires@redhat.com>
 <1463062363-12405-2-git-send-email-benjamin.tissoires@redhat.com>
 <1463149818.17131.349.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1463149818.17131.349.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On May 13 2016 or thereabouts, Andy Shevchenko wrote:
> On Thu, 2016-05-12 at 16:12 +0200, Benjamin Tissoires wrote:
> > There is no reasons to filter out keyboard and consumer control
> > collections
> > in hid-multitouch.
> > With the previous hid-input fix, there is now a full support of the
> > Type
> > Cover and we can remove all specific bits from hid-core and hid-
> > microsoft.
> >=20
> > hid-multitouch will automatically set HID_QUIRK_NO_INIT_REPORTS so =
we
> > can
> > also remove it from the list of ushbid quirks.
> >=20
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > ---
> >=20
> > Andy, would you mind checking if this series is sufficient to enabl=
e
> > the
> > TypeCover of the Surface Book?
>=20
> Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> Noticed little difference that there is no event for the device anymo=
re,
> just /dev/usb/hiddev0. Would it work properly under X?

Not sure what you mean.
I get 3 input nodes:
Microsoft Surface Type Cover Keyboard
Microsoft Surface Type Cover Consumer Control
Microsoft Surface Type Cover Touchpad

Each on this input device is properly assigned an event node and X work=
s
with them.

If there is no /dev/input/eventX created for your cover, then this is
not normal and needs to be investigated.

Cheers,
Benjamin

>=20
> >=20
> > Cheers,
> > Benjamin
> >=20
> > =C2=A0drivers/hid/hid-core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0| 2 --
> > =C2=A0drivers/hid/hid-ids.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0| 1 -
> > =C2=A0drivers/hid/hid-microsoft.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 2 =
--
> > =C2=A0drivers/hid/hid-multitouch.c=C2=A0=C2=A0=C2=A0=C2=A0| 4 +++-
> > =C2=A0drivers/hid/usbhid/hid-quirks.c | 1 -
> > =C2=A05 files changed, 3 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > index 8ea3a26..f055a68 100644
> > --- a/drivers/hid/hid-core.c
> > +++ b/drivers/hid/hid-core.c
> > @@ -727,7 +727,6 @@ static void hid_scan_collection(struct hid_pars=
er
> > *parser, unsigned type)
> > =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0(hid->product =3D=3D USB_DEVICE_ID_M=
S_TYPE_COVER_PRO_3 ||
> > =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hid->product =3D=3D USB_DEVICE=
_ID_MS_TYPE_COVER_PRO_3_2 ||
> > =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hid->product =3D=3D USB_DEVICE=
_ID_MS_TYPE_COVER_PRO_3_JP ||
> > -	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hid->product =3D=3D USB_DEVICE_ID_M=
S_TYPE_COVER_3 ||
> > =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hid->product =3D=3D USB_DEVICE=
_ID_MS_POWER_COVER) &&
> > =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0hid->group =3D=3D HID_GROUP_MULTITOU=
CH)
> > =C2=A0		hid->group =3D HID_GROUP_GENERIC;
> > @@ -1976,7 +1975,6 @@ static const struct hid_device_id
> > hid_have_special_driver[] =3D {
> > =C2=A0	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > USB_DEVICE_ID_MS_TYPE_COVER_PRO_3) },
> > =C2=A0	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2) },
> > =C2=A0	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP) },
> > -	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > USB_DEVICE_ID_MS_TYPE_COVER_3) },
> > =C2=A0	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > USB_DEVICE_ID_MS_DIGITAL_MEDIA_7K) },
> > =C2=A0	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > USB_DEVICE_ID_MS_DIGITAL_MEDIA_600) },
> > =C2=A0	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > USB_DEVICE_ID_MS_DIGITAL_MEDIA_3KV1) },
> > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > index 3eec09a1..99e9852 100644
> > --- a/drivers/hid/hid-ids.h
> > +++ b/drivers/hid/hid-ids.h
> > @@ -703,7 +703,6 @@
> > =C2=A0#define USB_DEVICE_ID_MS_TYPE_COVER_PRO_3=C2=A0=C2=A0=C2=A0=C2=
=A00x07dc
> > =C2=A0#define USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2=C2=A0=C2=A00x07e2
> > =C2=A0#define USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP 0x07dd
> > -#define USB_DEVICE_ID_MS_TYPE_COVER_3=C2=A0=C2=A0=C2=A0=C2=A00x07d=
e
> > =C2=A0#define USB_DEVICE_ID_MS_POWER_COVER=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A00x07da
> > =C2=A0
> > =C2=A0#define USB_VENDOR_ID_MOJO		0x8282
> > diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsof=
t.c
> > index e924d55..cf6920b 100644
> > --- a/drivers/hid/hid-microsoft.c
> > +++ b/drivers/hid/hid-microsoft.c
> > @@ -288,8 +288,6 @@ static const struct hid_device_id ms_devices[] =
=3D {
> > =C2=A0		.driver_data =3D MS_HIDINPUT },
> > =C2=A0	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP),
> > =C2=A0		.driver_data =3D MS_HIDINPUT },
> > -	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > USB_DEVICE_ID_MS_TYPE_COVER_3),
> > -		.driver_data =3D MS_HIDINPUT },
> > =C2=A0	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > USB_DEVICE_ID_MS_POWER_COVER),
> > =C2=A0		.driver_data =3D MS_HIDINPUT },
> > =C2=A0	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > USB_DEVICE_ID_MS_COMFORT_KEYBOARD),
> > diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-
> > multitouch.c
> > index c741f5e..ac35731 100644
> > --- a/drivers/hid/hid-multitouch.c
> > +++ b/drivers/hid/hid-multitouch.c
> > @@ -835,7 +835,9 @@ static int mt_input_mapping(struct hid_device
> > *hdev, struct hid_input *hi,
> > =C2=A0	if (!td->mtclass.export_all_inputs &&
> > =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0field->application !=3D HID_DG_TOUCH=
SCREEN &&
> > =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0field->application !=3D HID_DG_PEN &=
&
> > -	=C2=A0=C2=A0=C2=A0=C2=A0field->application !=3D HID_DG_TOUCHPAD)
> > +	=C2=A0=C2=A0=C2=A0=C2=A0field->application !=3D HID_DG_TOUCHPAD &=
&
> > +	=C2=A0=C2=A0=C2=A0=C2=A0field->application !=3D HID_GD_KEYBOARD &=
&
> > +	=C2=A0=C2=A0=C2=A0=C2=A0field->application !=3D HID_CP_CONSUMER_C=
ONTROL)
> > =C2=A0		return -1;
> > =C2=A0
> > =C2=A0	/*
> > diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/h=
id-
> > quirks.c
> > index b4b8c6a..baf2bad 100644
> > --- a/drivers/hid/usbhid/hid-quirks.c
> > +++ b/drivers/hid/usbhid/hid-quirks.c
> > @@ -98,7 +98,6 @@ static const struct hid_blacklist {
> > =C2=A0	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3=
,
> > HID_QUIRK_NO_INIT_REPORTS },
> > =C2=A0	{ USB_VENDOR_ID_MICROSOFT,
> > USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2, HID_QUIRK_NO_INIT_REPORTS },
> > =C2=A0	{ USB_VENDOR_ID_MICROSOFT,
> > USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP, HID_QUIRK_NO_INIT_REPORTS },
> > -	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3,
> > HID_QUIRK_NO_INIT_REPORTS },
> > =C2=A0	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER,
> > HID_QUIRK_NO_INIT_REPORTS },
> > =C2=A0	{ USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL,
> > HID_QUIRK_NO_INIT_REPORTS },
> > =C2=A0	{ USB_VENDOR_ID_NEXIO,
> > USB_DEVICE_ID_NEXIO_MULTITOUCH_PTI0750, HID_QUIRK_NO_INIT_REPORTS }=
,
>=20
> --=20
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy
>=20
