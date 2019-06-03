From: Pedro Vanzella <pedro@pedrovanzella.com>
Subject: Re: [PATCH] HID: hid-logitech-hidpp: detect wireless lightspeed
 devices
Date: Mon, 3 Jun 2019 17:44:38 -0400
Message-ID: <20190603214438.2cnmrx7g2sakjdr4@Fenrir>
References: <20190528162924.32754-1-pedro@pedrovanzella.com>
 <CAO-hwJ+zAvDizJRpykky+D3pf1M1NhFGWztwyA4mJEv8C+nO-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="il23bg2tbeerivkt"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAO-hwJ+zAvDizJRpykky+D3pf1M1NhFGWztwyA4mJEv8C+nO-w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org


--il23bg2tbeerivkt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05/28, Benjamin Tissoires wrote:
> On Tue, May 28, 2019 at 6:30 PM Pedro Vanzella <pedro@pedrovanzella.com> =
wrote:
> >
> > Send a low device index when the device is connected via the lightspeed
> > receiver so that the receiver will pass the message along to the device
> > instead of responding. If we don't do that, we end up thinking it's a
> > hidpp10 device and miss out on all new features available to newer devi=
ces.
> >
> > This will enable correct detection of the following models:
> > G603, GPro, G305, G613, G900 and G903, and possibly others.
>=20
> Thanks for the patch.
Thanks for reviewing it :)

> However, there is already support for this receiver in Linus' tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/drivers/hid/hid-logitech-dj.c?id=3Df5fb57a74e88bd1788f57bf77d587c91d4dc9d57
>=20
> With kernel 5.2-rc1, the connected device should already be handled by
> hid-logitech-hidpp :)
Why are the wireless receivers handled by hid-logitech-dj and the wired
mice handled by hid-logitech-hidpp? They are, in the end, all hidpp
devices, and having them all handled by the -hidpp driver with a quirk
class would allow us to check for support for the battery voltage
feature, as it seems to be an either-or scenario here.

- Pedro
>=20
> Cheers,
> Benjamin
>=20
> >
> > Signed-off-by: Pedro Vanzella <pedro@pedrovanzella.com>
> > ---
> >  drivers/hid/hid-logitech-hidpp.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitec=
h-hidpp.c
> > index 72fc9c0566db..621fce141d9f 100644
> > --- a/drivers/hid/hid-logitech-hidpp.c
> > +++ b/drivers/hid/hid-logitech-hidpp.c
> > @@ -62,6 +62,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
> >  #define HIDPP_QUIRK_CLASS_K400                 BIT(2)
> >  #define HIDPP_QUIRK_CLASS_G920                 BIT(3)
> >  #define HIDPP_QUIRK_CLASS_K750                 BIT(4)
> > +#define HIDPP_QUIRK_CLASS_LIGHTSPEED           BIT(5)
> >
> >  /* bits 2..20 are reserved for classes */
> >  /* #define HIDPP_QUIRK_CONNECT_EVENTS          BIT(21) disabled */
> > @@ -236,7 +237,11 @@ static int __hidpp_send_report(struct hid_device *=
hdev,
> >          * set the device_index as the receiver, it will be overwritten=
 by
> >          * hid_hw_request if needed
> >          */
> > -       hidpp_report->device_index =3D 0xff;
> > +       if (hidpp->quirks & HIDPP_QUIRK_CLASS_LIGHTSPEED) {
> > +               hidpp_report->device_index =3D 0x01;
> > +       } else {
> > +               hidpp_report->device_index =3D 0xff;
> > +       }
> >
> >         if (hidpp->quirks & HIDPP_QUIRK_FORCE_OUTPUT_REPORTS) {
> >                 ret =3D hid_hw_output_report(hdev, (u8 *)hidpp_report, =
fields_count);
> > @@ -3753,6 +3758,9 @@ static const struct hid_device_id hidpp_devices[]=
 =3D {
> >           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC06B) },
> >         { /* Logitech G900 Gaming Mouse over USB */
> >           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC081) },
> > +       { /* Logitech Gaming Mice over Lightspeed Receiver */
> > +         HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC539),
> > +         .driver_data =3D HIDPP_QUIRK_CLASS_LIGHTSPEED },
> >         { /* Logitech G920 Wheel over USB */
> >           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH=
_G920_WHEEL),
> >                 .driver_data =3D HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_F=
ORCE_OUTPUT_REPORTS},
> > --
> > 2.21.0
> >

--=20
Pedro Vanzella
pedrovanzella.com
#include <paranoia.h>
Don't Panic

--il23bg2tbeerivkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEXrNKwhI/eDFBCGo3v5huqi4pBxkFAlz1lLUACgkQv5huqi4p
Bxk2IRAAhZ/xJZ8uT7NGw8Ix8cOQJ4kqLzZbTv/jr2a9FAs8y4tj22VBKoo1zNwo
hyQuvToImgP6Tnql+l/SyTWoG14n6GBnmCv2CUy6rNpt7yBlr1w2UuYzIw+bHsN4
DEwjNg0RjM5o5fNHGDUzRz1+WuZDNVDmGYdWeg4PLw1aK3TXbqTQBXaqq5xHZTLx
MF1ZxwGD1+Cyp4gCwn/Rns50/hM9iDg1mUg9L2VrlSkuSHWWhD2WEprovd2fe2xD
ELV/fu88M8Y2SF2HqWD57hQCGnqG0nsRCdcCV7wC7n1mjqvQFIBnPkx5dm2RJYan
ubarZ3Qt/B0F9bfC3S2b74YNCUxFMtm+iWcg+4SI2g4uDCBA64HfJtsL67mb5IbA
q4JW7wyJH83stHNFwFNgWio3q4jmrlEaB06xQ7joeT+w/79Gs/Y0zRWiGLBX3PGT
yZWNojwJU7T3wLwlm/yASFFXmg1HiG2VuQkzJGamsbil1XnEIXxPR1O41zN50cym
IlS4T4ciBfymVhYNOwPpUwxRVLW1EG3aurBurx9QAssKKc9ho4LbnZP5o9xlPowl
TflW78Cr9ga4AJUZZzxW0ptxeqM0HHxYAX1eBfn2MsWnQjW4TI3gw9yOXtQk7sA3
96uiUjrYY3PNzKAhc5x00v4QbtGO7npEnCm9XHedEc/RaVHvilo=
=fbNq
-----END PGP SIGNATURE-----

--il23bg2tbeerivkt--
