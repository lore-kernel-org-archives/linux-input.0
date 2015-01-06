From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 06/17] ARM: dts: sun7i: Add cpu clock reference and
 operating points to dtsi
Date: Tue, 6 Jan 2015 17:07:50 +0100
Message-ID: <20150106160750.GU7853@lukather>
References: <1420511727-8242-1-git-send-email-wens@csie.org>
 <1420511727-8242-7-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ImSVV91IQg5ga+3z"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420511727-8242-7-git-send-email-wens@csie.org>
Sender: linux-pm-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--ImSVV91IQg5ga+3z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2015 at 10:35:16AM +0800, Chen-Yu Tsai wrote:
> The cpu core is clocked from the "cpu" clock. Add a reference to it
> in the first cpu node. Also add "cpu0" label to the node.
>=20
> The operating points were taken from the A20 FEX files in the
> sunxi-boards repository. Not all boards have the same settings. The
> settings in this patch are the most generic ones.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--ImSVV91IQg5ga+3z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUrAhWAAoJEBx+YmzsjxAggx0QAJXLobRB8ONog7BTo8GKkIn5
2zY4qioKasPbYClIq2rf4cTp/mcQPBEZcrV9qlIt6gTxtmBAczY1oUh1Vcd/HcqV
+LC5gFTZIsbr0bq5AwqruXHD73J1gwHoF0UQpah1GsqVowNLjPSIdzwCQwugEhpX
COS/ADw2bKJM+xG+QOwsLVSmVI/Rp1Eu3+/IlI0TixYog6N4NKjBlSF2bE3BiLVS
LrudPCI0rSRlUwu2ke2h2XFg8ub3OdDXMqSZ/w8rRSdXZpJLfFaXehzWD5NWPESe
Q6DmgglLSSMjOqwRdpDRshwmkxWB3XflpqUtjuZwXXZg3GR+BN4DaaC5ikMfGQRA
5ib17vg30lEAd67elnAhvL9YtnDjun6u5yUOT48OE1yu7Nag/rXYrJtccksxakFO
4vWzTR/gRpQmBkzH+/TIn6HhrXlQDAPuT7e7DqTb76g0q9Jf2TRYf8fGpXlwAMbN
OnjCxPD3nRhyahJOa450KpaOsNweb9mhV1MOjfJeBFI/leiTPS/ieG27gc5sfNuV
0mdUZE0BHQhwbF53tq4I0lKLrkifK9pMPd5CcxQoCr1rdRye1e0bWHK4jEYi1VRI
xonX0++Um4yreq3Bz0rwFxP+88q47TmEBT3xMJu2SdkLdFdf5enEwAzGzpiYAvx1
E5YPNGRWIg0ZfyF+BviC
=wYA3
-----END PGP SIGNATURE-----

--ImSVV91IQg5ga+3z--
