From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject: Re: ET1602 Touchscreen doesn't work
Date: Wed, 8 Jun 2011 09:57:59 -0300
Message-ID: <20110608125758.GA2465@nautilus.holoscopio.com>
References: <BANLkTikX9njth-jP6PpQuwL9sTUciu1nQA@mail.gmail.com>
 <20110602144146.GB3508@nautilus.holoscopio.com>
 <BANLkTimen=6OXOTww48CAn-ULaRVP_7zUw@mail.gmail.com>
 <20110603124428.GA2379@nautilus.holoscopio.com>
 <BANLkTimw2pV2Cv6pG2HJiD5AGrqJpOCXjw@mail.gmail.com>
 <BANLkTikiX4X2OEET5qmejdWhs1XY7e3HWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from liberdade2.minaslivre.org ([74.50.53.203]:37503 "EHLO
	liberdade.minaslivre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220Ab1FHM6I (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Jun 2011 08:58:08 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTikiX4X2OEET5qmejdWhs1XY7e3HWw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Chih-Wei Huang <cwhuang@android-x86.org>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 08, 2011 at 01:31:26PM +0200, Benjamin Tissoires wrote:
> Hi Chih-Wei and Cascardo,
>=20
> Sorry for coming late in the discussion, but I think I can add some ideas=
 to it.
>=20
> Most of the time, when we (the multitouch guys) saw a device that
> sends ABS_Z and ABS_RX, and that the problem is worked around by
> adding the MULTI_INPUT quirk, that means to us that the device is a
> multitouch Win7 compatible one. So hid-multitouch must be able to
> handle it.
>=20
> Chih-Wei, if you are running android-x86 2.6.38 kernel, then removing
> the quirk should tell the generic hid layer not to handle it.
> Then adding it to the list of the devices handled by hid-multitouch
> should do the job: insert in mt_device the following
>=20
>=20
> +	/* TouchPack touchscreen */
> +	{ .driver_data =3D MT_CLS_DEFAULT,
> +		HID_USB_DEVICE(USB_VENDOR_ID_TOUCHPACK,
> +			USB_DEVICE_ID_TOUCHPACK_RTS) },
> +
>=20
> For a proper kernel integration, we'll also need to add it to the
> hid_have_special_driver list in hid-core, but android-x86 kernel
> doesn't need it currently.
>=20
> On Wed, Jun 8, 2011 at 12:33, Chih-Wei Huang <cwhuang@android-x86.org> wr=
ote:
> > 2011/6/3 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>:
> >> You should use the device capabilities, like what events it does
> >> generate. If it does generate X and Y axis events, that's the right
> >> device.
> >
> > Did you mean ABS_X and ABS_Y? Actually it is.
> > The android framework detects the touch device by:
> >
> > =C2=A0 =C2=A0// Is this an old style single-touch driver?
> > =C2=A0 =C2=A0 if (test_bit(BTN_TOUCH, key_bitmask)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 && test_bit(ABS_X, abs_bitmas=
k) && test_bit(ABS_Y, abs_bitmask)) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 device->classes |=3D CLASS_TOUCHSCREEN;
> > =C2=A0 =C2=A0 }
> >
> > However, the output of getevent -p shows
> >
> > add device 2: /dev/input/event7
> > =C2=A0name: =C2=A0 =C2=A0 "HID TOUCH HID Touch Panel"
> > =C2=A0events:
> > =C2=A0 =C2=A0SYN (0000): 0000 =C2=A00001 =C2=A00003 =C2=A00004
> > =C2=A0 =C2=A0KEY (0001): 0110 =C2=A00111 =C2=A00112
> > =C2=A0 =C2=A0ABS (0003): 0000 =C2=A0value 1428, min 0, max 4095, fuzz 0=
 flat 0
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00001 =C2=A0value=
 1066, min 0, max 4095, fuzz 0 flat 0
> > =C2=A0 =C2=A0MSC (0004): 0004
> >
> > add device 3: /dev/input/event6
> > =C2=A0name: =C2=A0 =C2=A0 "HID TOUCH HID Touch Panel"
> > =C2=A0events:
> > =C2=A0 =C2=A0SYN (0000): 0000 =C2=A00001 =C2=A00003 =C2=A00004
> > =C2=A0 =C2=A0KEY (0001): 0140 =C2=A0014a =C2=A0014b
> > =C2=A0 =C2=A0ABS (0003): 0000 =C2=A0value 0, min 0, max 4095, fuzz 0 fl=
at 0
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00001 =C2=A0value=
 0, min 0, max 4095, fuzz 0 flat 0
> > =C2=A0 =C2=A0MSC (0004): 0004
> >
> > Only event6 supports BTN_TOUCH, so it is detected
> > as the touch device. However, that's wrong --
> > event7 is the right touch device.
> >
> > By removing the check test_bit(BTN_TOUCH, key_bitmask),
> > event7 is correctly detected and touchscreen now works.
> >
> > But I still have questions:
> >
> > * Is it intended to NOT support BTN_TOUCH in event7?
> > * Why two devices are detected by the kernel,
> > =C2=A0while there is only one touchscreen?
>=20
> That's the MULTI_INPUT quirk purpose, when the generic hid layer is
> not able to understand the report descriptors, one way to handle the
> different collections (i.e. touches) that contains the same fields is
> to split the device in several ones, one per touch.
>=20
> Cheers,
> Benjamin
>=20
> PS: Chih-Wei and Cascardo, if you need a patch instead of my awful
> English, don't hesitate to ask... ;-)
>=20

Thanks, Benjamin. That clarifies a lot and points what the real fix
should be for this device.

Chih-Wei, could you send us the results of your tests? I don't have the
device available right now. I could get it next week, perhaps, if my
client still gets it.

Regards,
Cascardo.

>=20
> >
> > --
> > Chih-Wei
> > Android-x86 project
> > http://www.android-x86.org
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
> >

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJN73HVAAoJEEWxSg7udFZIgTQP/2B/4QGMeEIsqJTzJNfItdKt
uIJf7jJUv4entt33hu5Ar2RbtHneiyPE0r6EzxvZZ4jn8hq0jkaCN8phFkTLcl4H
EZQLTXzsD/8R/hEkgNd5mieEaGHFi6S0AWWeMDNb7j+qU+7w4B74IVm9jsPf1JuY
eYZ3q3P4rHLxsNfbnAoL6km0vwYn1+HrE0RsCMyKMoQnoWa2G1gAs7hsbfj17GoR
Qh4ACdaYrLH5PG+rPNHEIQrLkFAHPnP60v81RlQ9SuObW3v6gB3fuJtHYKWNcJbE
TT1SDzU/OkEOpsb5GMnIv3ASwlrUDASRHJafJg6Rl1g/8pDiDi/d60U3TtrklF6y
voE1LZwrKK7kfJEyn2Rs3YPIKpuHfdaI96dN7oku0+8vBagtG+UFcaVigJbUGmes
eCzBVZRK9Wx9cNIZ4bmFwSu2fbUloE8t4OMIhino+4zPuuBF0a6rFZr5Kg6GvjeC
wj3NXfhJPu6A9UZYMzBxyNxqXjnik3UFGcF9iNqntgzACq3rMZLdh1XbNqwRWobU
bW1HoBbMsMat6lun/fAqPWh4TUwhB3FBf5ejZUaEKiVzkdCPKYW4oqngSobG3voQ
RzzVI486Es7MziX8OpboR8w4CmpwhGMAC5pQLkPIb2cKrrk7+IiJHDZwwCs6L+wb
Opcpr8sYs4Ke0UgJfl9o
=+6iF
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
