From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject: Re: Enable addition function keys
Date: Tue, 24 May 2011 15:03:00 -0300
Message-ID: <20110524180259.GG2622@nautilus.holoscopio.com>
References: <000001cc1403$1e0ede10$5a2c9a30$@com>
 <20110524062256.GA20829@core.coreip.homeip.net>
 <BANLkTinh4Ssnv16t9wp79D82XekiQMZguQ@mail.gmail.com>
 <BANLkTikFxR_xzZV6WNce+HBDVwc5QZc9yQ@mail.gmail.com>
 <20110524164931.GA16841@core.coreip.homeip.net>
 <BANLkTikH1kzGVqnqF=9uyZHRkWEK3ErURA@mail.gmail.com>
 <20110524175238.GA16908@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QXO0/MSS4VvK6f+D"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from liberdade2.minaslivre.org ([74.50.53.203]:46800 "EHLO
	liberdade.minaslivre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755496Ab1EXSJl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 May 2011 14:09:41 -0400
Content-Disposition: inline
In-Reply-To: <20110524175238.GA16908@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Christen <davidchristen@gmail.com>, linux-input@vger.kernel.org


--QXO0/MSS4VvK6f+D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 24, 2011 at 10:52:38AM -0700, Dmitry Torokhov wrote:
> On Tue, May 24, 2011 at 07:39:22PM +0200, David Christen wrote:
> >=20
> > Yes, you were right. Please find the corrected file attached.
> >=20
> > But it seems that the behavior is exactly the same.
> >=20
> > The kernel I use is 2.6.33 . It's a debian distro running on a risc pro=
cessor.
>=20
> I am afraid you need 2.6.38. Or you'll have to backport the following
> commits:
>=20
> 8613e4c Input: add support for large scancodes
> ab4e019 Input: define separate EVIOCGKEYCODE_V2/EVIOCSKEYCODE_V2
> de391d1 Input: fix typo in keycode validation supporting large scancodes
> a0bf0ea Input: hid-input - switch to using new keycode interface
> f5854fa Input: hid-input - allow mapping unknown usages
>=20
> --=20
> Dmitry

Perhaps, he could try using hidraw interface. Would it be OK for you,
David? Since you said you are only getting these key events and sending
them through a serial interface, and I'd say your device portability
does not include non-HID devices right now, this should solve the
problem without the need for a kernel upgrade.

Regards,
Cascardo.

--QXO0/MSS4VvK6f+D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJN2/LTAAoJEEWxSg7udFZI1TYQAOqk6Q/TZ/l86m4pPN8VKwpo
MPwC1nU3T3sBnAwsirJt029mKcQ0j7ZUp0KpnwNmKxWRCyFDmbr74y7MplMARbpU
jKNGMeIObLLed/xOhgSTD8qXE0m399Tlp4J90aMordhvZ/UhmJlFhdY0JP5EpcWG
2NhkyytuWBfLryBhTvq/6MzLmv8ATlz2D2VNKn3QF9E9QAFNg0W1DyOFIzmhJgMR
m0BjJkFR/i5eenZjAtZpH1hUGdWTl3Xu7C7ChFdo28/LsgFKUC0yAFrVtcP2DaHG
YIbi8Hv0GG+ouivCX+yCqNmugbBepscOx5HtEcjTm09R5actKXzBXd0sNxlB+3cx
invREZn/eLP7YWYXQUXzRPAM54032rClSkXunCPwIQvwF3zwtuZoFwCE6tDu5Veu
c5Wfki1igC0duvUlDoUFAEm0Q7EERHPrK/KKUy5XaUQvz56YhI6sE4ZHpVv1B4YZ
wfqWF6zl1N7Dzvt+niNE27qLXyHZBWM6JqH1FJ8TCKr5B2epIKo0XiCTUsnf1+g4
RdcQt1Hmb/zSR5/X42Kr0Gt3+7Y5Br29s8F0/FmecAZxhVPc2+Zze8QxCYSsCtLs
G6F0qs+UoVZUKBnhimRIrTU2YUcpONiWUECrSDYgpwlgMhc8njOBc2apDd8O4edS
zxRyEyj7D5ZGeEt5J/Zq
=GW4X
-----END PGP SIGNATURE-----

--QXO0/MSS4VvK6f+D--
