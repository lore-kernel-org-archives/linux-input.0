From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject: Re: ET1602 Touchscreen doesn't work
Date: Mon, 13 Jun 2011 12:09:44 -0300
Message-ID: <20110613150943.GE2597@nautilus.holoscopio.com>
References: <BANLkTimen=6OXOTww48CAn-ULaRVP_7zUw@mail.gmail.com>
 <20110603124428.GA2379@nautilus.holoscopio.com>
 <BANLkTimw2pV2Cv6pG2HJiD5AGrqJpOCXjw@mail.gmail.com>
 <BANLkTikiX4X2OEET5qmejdWhs1XY7e3HWw@mail.gmail.com>
 <20110608125758.GA2465@nautilus.holoscopio.com>
 <BANLkTin1YhxCE5J9suR93eWcWEtviFNLtg@mail.gmail.com>
 <20110608153146.GG2465@nautilus.holoscopio.com>
 <BANLkTin3MyXsDHOK+BgdXvKO5YBH=Cv5DA@mail.gmail.com>
 <20110609133943.GA2439@nautilus.holoscopio.com>
 <BANLkTinnGiu_qWnCTq-1peyEw4=xUdnAkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qOrJKOH36bD5yhNe"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from liberdade2.minaslivre.org ([74.50.53.203]:50946 "EHLO
	liberdade.minaslivre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158Ab1FMPJs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jun 2011 11:09:48 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTinnGiu_qWnCTq-1peyEw4=xUdnAkw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chih-Wei Huang <cwhuang@android-x86.org>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org


--qOrJKOH36bD5yhNe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 10, 2011 at 10:23:06AM +0800, Chih-Wei Huang wrote:
> 2011/6/9 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>:
> > Nice. That was one of the tests. But have you tested without the quirck
> > in hid-quirks and without the suggested change by Benjamin? Considering
> > the device would indicate it supports RX and Z axis, but not X and Y
> > axis, it should not work either in Android.
>=20
> Did you mean just remove this line in hid-quirks.c?
>=20
> { USB_VENDOR_ID_TOUCHPACK, USB_DEVICE_ID_TOUCHPACK_RTS, HID_QUIRK_MULTI_I=
NPUT },
>=20
> That's what I've tried (with and without Benjamin's change) .
> Yes, it works in Android 2.2.
>=20

Yes, that's what I meant. The problem is: without the patch, X.org won't
work with the drivers I've tested it with; with the patch, Android won't
work. I am curious, because the code you've sent only checked for X and
Y axis and without the patch, the single device would not send events in
these axis, IIRC. I will check if I have this particular device
available and do some tests with current Linux (2.6.39.1) and more
recent X.org drivers.

Regards,
Cascardo.

> --=20
> Chih-Wei
> Android-x86 project
> http://www.android-x86.org

--qOrJKOH36bD5yhNe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJN9ig3AAoJEEWxSg7udFZICZYP/jKCbiuSFUEqy0ejxRI0NSZy
PbmyplcxLlkTYKxOmMmtPPrjLkR+LbyXpSTwWxlOFOytApFe8Z0EypsjZE5jVNrM
2Vy05wb27RF5iSZtZXY8wc8PLDW6g1QMpz4ECkrqA1otMTDfMIb4MRefAavNlKxS
ZQdPM5E+0RLwJHIGyD1I9HjdpjmE1tsz3zz1NZJcf0hHWYXowE+61esZ/1MgP0dM
E94M0OH0ICqRX7OgQBXqfiPvhTHQsMlc9lL7aZJn44DPQzsik5ctS8ytOqcJ8Ts5
/autkUHbejE2IyKpUV2ZIxmWACw/6XjtdPAOb2uWTBTNyyRgBiLME59DlJksThWM
dDqBYQFm3qipq039M5RWmIb5qrl8bacCUhu1zorUL/SrEAvUNNxxL/5DJepNIZCZ
lutdnUmEcF+DtoMJliBIEmSIwOfk2lT2K5Fa5cC0INt/V0MFY+2dbmCruIxbz/8J
1WpMAnRqFm5MWPkj3u3QXJYerBHP3xROAW59rd1xrBfePIjR/1hE/Ds4xN0Dll9L
vNdwapnyqkJzgfH9zwc6STGh6jcLjF1iRvfgi5orWkxBOWcjj3D9OWGVXs3plvIk
bjvHCwpasU13icENxnqyLQX4y1n6r064e0H5bUm3h0UFjPENk0dLK0kGhsRRMg10
N8qDnLkp/0QNOjysisYw
=9Hod
-----END PGP SIGNATURE-----

--qOrJKOH36bD5yhNe--
