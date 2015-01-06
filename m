From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 02/17] clk: sunxi: Propagate rate changes to parent for
 mux clocks
Date: Tue, 6 Jan 2015 17:00:27 +0100
Message-ID: <20150106160027.GT7853@lukather>
References: <1420511727-8242-1-git-send-email-wens@csie.org>
 <1420511727-8242-3-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="53TzBEXPl5+8hjUY"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:45376 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753889AbbAFQFD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Jan 2015 11:05:03 -0500
Content-Disposition: inline
In-Reply-To: <1420511727-8242-3-git-send-email-wens@csie.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org


--53TzBEXPl5+8hjUY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2015 at 10:35:12AM +0800, Chen-Yu Tsai wrote:
> The cpu clock on sunxi machines is just a mux clock, which is normally
> fed by the main PLL, but can be muxed to the main or low power oscillator.
>=20
> Make the mux clock propagate rate changes to its parent, so we can
> change the clock rate of the PLL, and thus actually implement rate
> changing on the cpu clock.
>=20
> This patch also removes the no reparenting limit.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--53TzBEXPl5+8hjUY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUrAabAAoJEBx+YmzsjxAgFDkP/0Zwh/QN2Bou3hPVpYj0Pnbh
NBgWG9OHgM/20yi56wPenNMBvxa+XqlXD1yq6nAjSRJmVoLwKURLvtwMuvT9ruSx
s4fQEBkhGpLFM0jjn0QQnl7GZkpeZXQtNZb4d9kqtADShDkw/XelicImedzRD1Z/
3bDpZaLLBGm5Vh9qxWWK4Xy9wjf7kfC70yQE+jah4p9fC1eFbnTw43B8bztI4ugA
LkSbSV6CdtQKMFnRYn+dBR/mC2kzputARaIBITuX1XUYKHzIVqxSq3+8oe6F6+Na
YRRYLT8zGVgaDM0LIg/0XBxG4+tgx0grhW4zXaCmsUGLNdWq6/6Bsy5bz/fHV2PC
ndtrPWm12CUUBBQP7m+aU+F504/4dQxyoRuuftIRl8xa1dxJMFPfwQ9omLEnNN17
jKaq/pzjSKZ7UuDwh94M4Af1ai48LreCFGAcIVIuvk3VsmfydIlyy6rgCT1nm9Fq
yQ2Na5rUtj1/sNpwwX3IjPO3GoWC4QzdJBesr8iKde9Aw5rKe3lfQNXEU0aXf9kK
vi9tSkRZjUpPyWG/UcKihOsVtmynsWiEJj6PD11Mi4WsiZJ+Cwbn0YeUxNEOIePt
TjHEgcrYMXQCepr+LA1mBeTEl+IprNZNuJqw472X4c54zhlcX2ILwecTKnZvGgJu
RMXuSMBjWwQZpE4G7aV2
=me59
-----END PGP SIGNATURE-----

--53TzBEXPl5+8hjUY--
