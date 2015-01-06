From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 01/17] ARM: sunxi: Register cpufreq-dt for sun[45678]i
Date: Tue, 6 Jan 2015 16:55:32 +0100
Message-ID: <20150106155532.GR7853@lukather>
References: <1420511727-8242-1-git-send-email-wens@csie.org>
 <1420511727-8242-2-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YkilVOb9qhI0mB+X"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:45311 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755400AbbAFQAD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Jan 2015 11:00:03 -0500
Content-Disposition: inline
In-Reply-To: <1420511727-8242-2-git-send-email-wens@csie.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org


--YkilVOb9qhI0mB+X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 06, 2015 at 10:35:11AM +0800, Chen-Yu Tsai wrote:
> On sun[45678]i, we have one cluster of identical cores sharing a
> clock, which is ideal for using cpufreq-dt. Register a platform
> device for cpufreq-dt.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

While I don't have anything against this patch, I seem to recall that
it was not necessary anymore, or that there was some work in the
direction of removing that kind of code, have you looked into that?

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--YkilVOb9qhI0mB+X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUrAV0AAoJEBx+YmzsjxAg/PcP/1D7nUV3pwQog0cJroxwgzUx
5oF5rm/AxgzRHo/Uq4ag8Z5AWvIwi25AJeL0SqWyhiUvAGH3CGNfH3gfHNFbVqcl
lDp7l+flWozRvyvSP2F/KZookZYlq8fX9HlOk2Y+7INK5bpK/448NLzaY2EYnaCg
JqSaUn+WbVUcU71Iq6fROG6PT1yMLquXL27mIFODZDWwO3E8jW5np1+etZ+vuuIJ
vgMgoJgjHNLH9BKi9jhthNRef7ZjoZsRzkjenoXX176mqL7D3txINf9/uEY+C4fM
bQwZXzX/j+hyrmxlVATd2OAx3LXTwZ2r+q0oyMII55KnyCWPfXnJRmehOx7wl0fW
dhv5S4WHu9SEAh6tspfSMuLtByZXMAcv5L1wxzSSD5UM1QRhzjAhuXzh3IIOMgIT
i25G20ouoEszhJi71apwLNIg4N9RKBFAm4dzVXqSJoN9UBznSpqmAihXdzjYU4Fx
RA0J+rN6gzNgytEkDVEjdnvJEHU6C5/WURQvOPDNujAMCNHJRuZxWkBh7zQBmHrk
wXxNEiH9e5YUZkSxegYaf34uHzRVJoga3m+krt/koqwd9GvbtcmSSawc7qn9QbWF
bprcrpR/10O8PdNJdvYkHgHnerjRPjP8XxBbcFuawxMLv9lzAFX5YjQkaidgOVB+
EgSZegQ1ndqcTA6YBqai
=Cirs
-----END PGP SIGNATURE-----

--YkilVOb9qhI0mB+X--
