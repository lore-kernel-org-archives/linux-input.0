From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject: Re: ET1602 Touchscreen doesn't work
Date: Thu, 2 Jun 2011 11:41:47 -0300
Message-ID: <20110602144146.GB3508@nautilus.holoscopio.com>
References: <BANLkTikX9njth-jP6PpQuwL9sTUciu1nQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from liberdade2.minaslivre.org ([74.50.53.203]:56316 "EHLO
	liberdade.minaslivre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128Ab1FBOlz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 Jun 2011 10:41:55 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTikX9njth-jP6PpQuwL9sTUciu1nQA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chih-Wei Huang <cwhuang@android-x86.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 02, 2011 at 04:49:19PM +0800, Chih-Wei Huang wrote:
> Hi,
> I have an ASUS EeeTop ET1602, with touchscreen id (1bfd:1688).
> Originally it works fine with kernel 2.6.32,
> but now it doesn't work since kernel 2.6.35 (maybe?).
>=20
> I made some investigation.
> I think it's related to this patch:
>=20
> commit c2c3489c5b0fdb8fbf0f5e9424905c2994ab5660
> Author: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
> Date:   Thu Feb 4 13:36:24 2010 -0200
>=20
>     HID: use multi input quirk for TouchPack touchscreen
>=20
>     This device generates ABS_Z and ABS_RX events, while it should be
>     generating ABS_X and ABS_Y instead. Using the MULTI_INPUT quirk solves
>     this issue.
>=20
>=20
> Could you explain what's the patch intend to do,
> and how could I solve the problem?
>=20
> Regards,
> --=20
> Chih-Wei
> Android-x86 project
> http://www.android-x86.org

It depends on your userspace. It should work properly with X.org drivers
evdev and evtouch. Are you trying this with Android?

Regards,
Cascardo.

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJN56EpAAoJEEWxSg7udFZIbQ0P/0ZqO5jXSODQII6p0p2ujI3t
7obn4B4QJZSojni363eu9FiBdia6NOidb88QYqIxl278qm5SnxSmshJF3IJGqyt/
mI+qzMb/+OkReUiiW7i12ztPU02me3hcwPf0xLXGCGTEJLxaqbam/zejoEd/nb6h
H6H3OzwtZzRB6nVQ7DluUSYCnqWARal6TdipZkb6bvIn432QqnZI9IxYrQOFVwuD
1oZjuGiJI2V9K66wdXu5cdSrLPXmAY4qCPdqblFdlwwRVRCQCk7/T6J+VhZ3vxhi
95fW5Y4BL4Shpd+XMYyg65xkUMSG5dgkoq75+gMpkAxb3d6ix7JKNp1WJ08HzQBz
dzNLXxAhcUugK7xOZ3nF1Ev77equSlcP08kkwD15YEb6EoHH6FrsYOCaSugXXb/h
wbalk50lGBVYrCGZ5wEQw1hg4faCRv3hE0wakLS+NSN/HU8CzWbx79UV4Y5lKo8g
/UdaWgQo4tNrI2q0MfvDyInkfz6KDtMH1SGEx7qGICpf1HytXNDwh4HBZrNBgNTS
G0uKoHQ0Ne9wP2stqZiB7tlhif0WQAiDVVh3XnAs+XayxFYkM7v7xlB6Hg/oLh4q
rsPF6bdSUGy3fuISy/+YUFt+pcsy5+D0DGY8yZQ3DGcmjocRvmq4uDKTOgTInGUn
6T5phO5BG3oiy12sU0C8
=12ce
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
