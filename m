From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject: Re: ET1602 Touchscreen doesn't work
Date: Thu, 9 Jun 2011 10:39:44 -0300
Message-ID: <20110609133943.GA2439@nautilus.holoscopio.com>
References: <BANLkTikX9njth-jP6PpQuwL9sTUciu1nQA@mail.gmail.com>
 <20110602144146.GB3508@nautilus.holoscopio.com>
 <BANLkTimen=6OXOTww48CAn-ULaRVP_7zUw@mail.gmail.com>
 <20110603124428.GA2379@nautilus.holoscopio.com>
 <BANLkTimw2pV2Cv6pG2HJiD5AGrqJpOCXjw@mail.gmail.com>
 <BANLkTikiX4X2OEET5qmejdWhs1XY7e3HWw@mail.gmail.com>
 <20110608125758.GA2465@nautilus.holoscopio.com>
 <BANLkTin1YhxCE5J9suR93eWcWEtviFNLtg@mail.gmail.com>
 <20110608153146.GG2465@nautilus.holoscopio.com>
 <BANLkTin3MyXsDHOK+BgdXvKO5YBH=Cv5DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from liberdade2.minaslivre.org ([74.50.53.203]:55312 "EHLO
	liberdade.minaslivre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757800Ab1FINkj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jun 2011 09:40:39 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTin3MyXsDHOK+BgdXvKO5YBH=Cv5DA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chih-Wei Huang <cwhuang@android-x86.org>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 09, 2011 at 07:26:58PM +0800, Chih-Wei Huang wrote:
> 2011/6/8 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>:
> > I was referring to Benjamin's multi-touch solution, perhaps, reverting
> > the multi-device patch already. By the way, did you test it without the
> > multi-device patch and did it work, or did you test it only with 2.6.32?
>=20
> I'm not sure if I understood you correctly.
> I did these:
> * remove the quirk for touchpack in hid-quirks.c
> * change hid-multitouch.c as suggested by Benjamin.
>=20
> Test results:
> * The touchscreen is detected by hid-core.
>   (only one device is detected)
> * Manually modprobe hid-multitouch,
>   it didn't detect the touch device.
> * The android framework correctly recognized
>   the touchscreen and it works well.
>=20

Nice. That was one of the tests. But have you tested without the quirck
in hid-quirks and without the suggested change by Benjamin? Considering
the device would indicate it supports RX and Z axis, but not X and Y
axis, it should not work either in Android.

Regards,
Cascardo.

> The whole patch shows as below:
>=20
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 0c5e9c3..fab373a 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -713,6 +713,11 @@ static const struct hid_device_id mt_devices[] =3D {
>                 HID_USB_DEVICE(USB_VENDOR_ID_TOUCH_INTL,
>                         USB_DEVICE_ID_TOUCH_INTL_MULTI_TOUCH) },
>=20
> +       /* TouchPack touchscreen */
> +       { .driver_data =3D MT_CLS_DEFAULT,
> +               HID_USB_DEVICE(USB_VENDOR_ID_TOUCHPACK,
> +                       USB_DEVICE_ID_TOUCHPACK_RTS) },
> +
>         /* Unitec panels */
>         { .driver_data =3D MT_CLS_DEFAULT,
>                 HID_USB_DEVICE(USB_VENDOR_ID_UNITEC,
> diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-qui=
rks.c
> index 9a94b64..727f363 100644
> --- a/drivers/hid/usbhid/hid-quirks.c
> +++ b/drivers/hid/usbhid/hid-quirks.c
> @@ -49,7 +49,7 @@ static const struct hid_blacklist {
>         { USB_VENDOR_ID_ETURBOTOUCH, USB_DEVICE_ID_ETURBOTOUCH,
> HID_QUIRK_MULTI_INPUT },
>         { USB_VENDOR_ID_PANTHERLORD,
> USB_DEVICE_ID_PANTHERLORD_TWIN_USB_JOYSTICK, HID_QUIRK_MULTI_INPUT |
> HID_QUIRK_SKIP_OUTPUT_REPORTS },
>         { USB_VENDOR_ID_PLAYDOTCOM,
> USB_DEVICE_ID_PLAYDOTCOM_EMS_USBII, HID_QUIRK_MULTI_INPUT },
> -       { USB_VENDOR_ID_TOUCHPACK, USB_DEVICE_ID_TOUCHPACK_RTS,
> HID_QUIRK_MULTI_INPUT },
> +//     { USB_VENDOR_ID_TOUCHPACK, USB_DEVICE_ID_TOUCHPACK_RTS,
> HID_QUIRK_MULTI_INPUT },
>=20
>         { USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_UC100KM, HID_QUIRK_NOGET=
 },
>         { USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_CS124U, HID_QUIRK_NOGET =
},
>=20
>=20
> --=20
> Chih-Wei
> Android-x86 project
> http://www.android-x86.org

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJN8M0fAAoJEEWxSg7udFZIBd0P/jKskzN8XjgTSX7pGEdBcx8y
qjaUQSy/WeQMlmDr/HngLjklD0C5X/Vu+cg2AIzctjSTFdtdaDowKgufqL6iG2sq
1f2T7IAmT3wOAGgNeG6Dx0gkasc2sciUO+1MqcImqe+Xbk3Kt/cQev4CY0vIggrm
e44WmX316J/kLxofWW0JbyBK7oVIvIcAQcnlPBx/PZNSihyGMO/p8StwpflJGrIC
R3DnrMwVyQXDr89UxHDNj/X+iLmwGC2vtVnPX8k5X30Ey0KIypX4c1ODsVMr+N3U
HPbv4A71ytj6LfEghWP6o0ij7t/AxEUIR4AFoKnjr/Q6MAoC88E3H46QioXI6j0g
BxLDcgE3xxuF5dgjaVsjVEOX4xlroWdyyu6D3jq438ugymMFIGQt2TF7ehAkhhoB
0b/bjUnMNnRV2DrOn7UOhC6S2AgHNCPXV9qKeEetxoQjdXiEis1l+LK5Xw+/frgB
fNw78OoSJiS6FQnUGERfxl4HQ9eJt+EsAXLaMvumi0WjkGaJ7PdmuuG7Zwrtx2EW
DCVfmEMr0TS649oKvHlE7OvHb0XALAoPsJ4EpPczmzBN9UgwZMdJ4064uSOaSNmc
Y5prZ47pan2hk0BQDTNGlieMyDdOM1frskeKgtDVPc6u6R0ieJqK8lpnl4osdf7Y
MUwzEyMLjfkNIChzbNZB
=iDOC
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
