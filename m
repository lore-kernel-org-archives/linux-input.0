From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Input: ALPS - Detect trackstick presence for v7 protocol
Date: Fri, 27 Mar 2015 21:08:57 +0100
Message-ID: <201503272108.57759@pali>
References: <1427031971-13018-1-git-send-email-pali.rohar@gmail.com> <201503271816.11723@pali> <CAPXTYCX13Y7FY7o9CPPQXchSVYiJ415o_yxOFruO-scTV=X27w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3396121.jyRSGceaLI";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:33118 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471AbbC0UJB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Mar 2015 16:09:01 -0400
In-Reply-To: <CAPXTYCX13Y7FY7o9CPPQXchSVYiJ415o_yxOFruO-scTV=X27w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Santiago Gala <sgala@apache.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

--nextPart3396121.jyRSGceaLI
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

there should no functional changes (e.g. acceleration speed,=20
etc.). And if yes, there is probably some side effect which=20
should be investigated.

Please can you provide output from dmesg (grep for psmouse or=20
input) and also output from lsinput?

That changed acceleration/speed sounds like psmouse fallbacks to=20
some ImPS/2 relative protocol and not ALPS...

On Friday 27 March 2015 20:46:59 Santiago Gala wrote:
> It works quite well! :)
>=20
> I got some issues: at first it didn't work after I mv'ed the
> original and put the unzipped new in its place. After reboot
> it failed exactly the same, but after I "sudo
> /etc/init.d/lightdm stop; sudo modprobe -r psmouse; sudo
> modprobe psmouse; sudo /etc/init.d/lightdm start" it worked.
> Then I remembered about the initrd.img which should contain
> it. So I did "sudo dpkg-reconfigure
> linux-image-4.0.0-040000rc5-generic", rebooted again and here
> I am.
>=20
>=20
> Things seem to work all right. The only thing I notice is that
> the old driver moved fast in console mode (with gpm) while
> the new one is rather slow, would need to tweak the
> acceleration configuration. even after adding
> "responsiveness=3D15" to the configuration, as the sample
> /etc/gpm.conf says, it is slower than the previous kernel
> with the stock configuration.
>=20
>=20
> Regards
>=20
> Santiago
>=20
>=20
> El vie., 27 de marzo de 2015 a las 18:17, Pali Roh=C3=A1r
> (<pali.rohar@gmail.com>) escribi=C3=B3:
>=20
> On Thursday 26 March 2015 16:33:13 you wrote:
> > El mar., 24 de marzo de 2015 a las 17:48, Pali Roh=C3=A1r
> > (<pali.rohar@gmail.com>)
> >=20
> > escribi=C3=B3:
> > > Hello, I can compile psmouse.ko module for you. Just let
> > > me know which ubuntu kernel (and from) are you using.
> >=20
> > This one could do:
> >=20
> > http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.0-rc5-vivid
> > /
> >=20
> > or at a choice any further one (they get published as they
> > are released)
> >=20
> > Regards
> > Santiago
>=20
> Hello, in attachment is gzipped psmouse.ko module compiled
> against above ubuntu kernel from linus git tree (3c435c1e)
> with additional patches:
>=20
> https://lkml.org/lkml/2015/3/21/282
> https://lkml.org/lkml/2015/3/22/93
> https://lkml.org/lkml/2015/3/22/94
>=20
> Test it and if everything works as expected, please send email
> to all all people and ML. Thanks.
>=20
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart3396121.jyRSGceaLI
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlUVuNkACgkQi/DJPQPkQ1LOkQCePtxr6YM8/oVYFz8xC8+dTRwq
878An2XSPZUQrpejmK2dshH7se4wqQ4t
=V8f5
-----END PGP SIGNATURE-----

--nextPart3396121.jyRSGceaLI--
