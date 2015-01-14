From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v3 4/9] ARM: dts: sun7i: cubieboard2: add axp209
 regulator nodes
Date: Wed, 14 Jan 2015 20:30:08 +0100
Message-ID: <20150114193008.GD4891@lukather>
References: <1421037249-28461-1-git-send-email-wens@csie.org>
 <1421037249-28461-5-git-send-email-wens@csie.org>
 <20150112090603.GE4891@lukather>
 <CAGb2v66r6EG2F1-=Gaig7ZW58Z1KteQ5nDPfW5niisv7dCjY0Q@mail.gmail.com>
 <20150113094036.GR4891@lukather>
 <CAGb2v65=Jfr56Yb2udNVy=shA9+AOPK9yjHTAOJZ7TFh5idTHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cC4dCx2W6DcYPM7t"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:47405 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754236AbbANTfE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Jan 2015 14:35:04 -0500
Content-Disposition: inline
In-Reply-To: <CAGb2v65=Jfr56Yb2udNVy=shA9+AOPK9yjHTAOJZ7TFh5idTHA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Hans de Goede <hdegoede@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org


--cC4dCx2W6DcYPM7t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2015 at 06:30:51PM +0800, Chen-Yu Tsai wrote:
> >> You could probably chain the regulators in the DT via xxx-supply
> >> if it helps. But beyond that, it is hard to do anything meaningful
> >> at this point. Modeling them as fixed regulators beyond our control
> >> is simpler. We also do not have an IPSOUT regulator for the AXP.
> >>
> >> > Eventually, I think we would be able to remove
> >> > sunxi-common-regulators.dtsi, or at least, expose the proper regulat=
or
> >> > hierarchy.
> >>
> >> The USB and SATA regulators are just GPIO enabled switches (MOSFETs)
> >> or current limiters. I think these will always exist because of the
> >> reference designs. Or do you want to move them back into the board
> >> dts files? FWIW, I like it the way it is now. Not that I don't like
> >> it to be accurate.
> >
> > At least providing the right hierarchy at the board level would be
> > great. Adding the -supply property to all our fixed regulators
> > wouldn't take too much code, and would be enough to model properly the
> > regulator trees.
>=20
> These are all unrelated to axp209. You'd end up with
>=20
>     vin-supply =3D <&reg_vcc5v>;
>=20
> for the usb and sata power regulators. You could put these
> in sunxi-common-regulators, and override them for boards
> that actually have something controllable.

Ok. Fine then.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--cC4dCx2W6DcYPM7t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtsPAAAoJEBx+YmzsjxAgVsIQAKJQF/3Jugi/nlhA2hYvTekV
7BdfxtqgjtNNFT+P3ZOPj4/04jjAiGVnw+8T4p2UqQigFu/4U0B7UBHygHt8a3sm
VYwu8XQyFAvwdY8AKVQtelFTfX8YjnJcCoXKkEOEpwg5SBgmkpFpWEi7Z79gqOC8
KvGQLTi6jcKxTcTI8eIthHP+lD6V/Y4IUj8X/OB1tVmItafy2TrCZr+tw3nVtW9V
b2249hPpEGPyEQ225yEtigp+XCD0nafrv+5spcUfAA7JW9J2p0S3PTb4JHxmDGq5
u+JPfCSsFCV7q60szk0r2GvH245yIyugOpyJHpwXJSytZxlGZ0DSOKeRqbfyTIiH
i6/Tu4wXBH6vXbBolF4ky33CN+begrJ7wI/6vTC8fCSYKm2keGFeB1LxiKPGbq2u
72s14SX9UkpyUlQoDPZymilb8mvDWBgCySWitL/YQb+0qjLE5uEZzLV1oPcGvtr8
+QQkoGUKs0uLkD99F8Woag53wd45D667vyIHjIhG9xIlQniKA/UiJCpY5aLp4hkf
N5Dqq3a3ZqL6GPFCE6bCIMzA8h8sXqm+77R8sWoXh8trTA3f6+bf745Dnd1VGiAk
DOnt00LnPzbnRq+u2wo9wTbw6aEsHP9ulQPaxfnrsYPqcJ7AIX46/RTkhyW0y6EG
WZEVmucqiQ1KHlj34n4c
=4wTz
-----END PGP SIGNATURE-----

--cC4dCx2W6DcYPM7t--
